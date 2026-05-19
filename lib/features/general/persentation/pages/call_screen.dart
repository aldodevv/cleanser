import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cleanser/infrastructure/assets/assets.gen.dart';
import 'package:cleanser/infrastructure/assets/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

enum CallState { calling, connected, connectedRecording, ended }

@RoutePage()
class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen>
    with SingleTickerProviderStateMixin {
  CallState _callState = CallState.calling;

  late AnimationController _rippleController;
  late AudioPlayer _audioPlayer;

  int _secondsElapsed = 0;
  Timer? _timer;
  Timer? _vibrationTimer;

  bool _isMuted = false;
  bool _isSpeakerOn = false;

  @override
  void initState() {
    super.initState();
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _audioPlayer = AudioPlayer();

    // Enable wakelock — keep screen on during call
    WakelockPlus.enable();

    // Set immersive call UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _startTimer();
    _enterCallingState();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_callState == CallState.connected ||
          _callState == CallState.connectedRecording) {
        setState(() {
          _secondsElapsed++;
        });
      }
    });
  }

  // ── State transitions ──────────────────────────────────────────────

  void _enterCallingState() {
    _rippleController.repeat();
    FlutterRingtonePlayer().playRingtone(looping: true);
    _startVibration();
  }

  void _enterConnectedState() {
    // Stop ringing & vibration
    _rippleController.stop();
    FlutterRingtonePlayer().stop();
    _stopVibration();

    // Reset timer for the connected call duration
    _secondsElapsed = 0;
  }

  void _enterEndedState() {
    _rippleController.stop();
    FlutterRingtonePlayer().stop();
    _stopVibration();
    _timer?.cancel();
  }

  void _changeState(CallState newState) {
    setState(() {
      _callState = newState;
    });

    switch (newState) {
      case CallState.calling:
        _enterCallingState();
        break;
      case CallState.connected:
        _enterConnectedState();
        break;
      case CallState.connectedRecording:
        // No special audio change, just UI indicator
        break;
      case CallState.ended:
        _enterEndedState();
        // Pop after a brief delay so user sees "Call Ended"
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) context.router.maybePop();
        });
        break;
    }
  }

  // ── Vibration ──────────────────────────────────────────────────────

  void _startVibration() {
    _vibrationTimer?.cancel();
    HapticFeedback.vibrate();
    _vibrationTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      HapticFeedback.vibrate();
    });
  }

  void _stopVibration() {
    _vibrationTimer?.cancel();
  }

  // ── Lifecycle ──────────────────────────────────────────────────────

  @override
  void dispose() {
    _rippleController.dispose();
    _timer?.cancel();
    _vibrationTimer?.cancel();
    FlutterRingtonePlayer().stop();
    _audioPlayer.dispose();

    // Disable wakelock
    WakelockPlus.disable();

    // Restore system UI
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    super.dispose();
  }

  // ── Helpers ────────────────────────────────────────────────────────

  String get _formattedTime {
    final minutes = (_secondsElapsed ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsElapsed % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  // Temporary function to simulate answering the call (tap logo)
  void _simulateAnswer() {
    if (_callState == CallState.calling) {
      _changeState(CallState.connected);
    }
  }

  void _endCall() {
    _changeState(CallState.ended);
  }

  void _toggleRecording() {
    if (_callState == CallState.connected) {
      _changeState(CallState.connectedRecording);
    } else if (_callState == CallState.connectedRecording) {
      _changeState(CallState.connected);
    }
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
  }

  void _toggleSpeaker() {
    setState(() {
      _isSpeakerOn = !_isSpeakerOn;
    });
  }

  // ── Build ──────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.primary,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Ripple Animation Background — only during calling
                  if (_callState == CallState.calling)
                    AnimatedBuilder(
                      animation: _rippleController,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: RipplePainter(
                            animationValue: _rippleController.value,
                            color: Colors.white,
                          ),
                          size: const Size(double.infinity, double.infinity),
                        );
                      },
                    ),
                  // Logo (Tap to simulate answering during calling state)
                  GestureDetector(
                    onTap: _callState == CallState.calling
                        ? _simulateAnswer
                        : null,
                    child: SvgPicture.asset(
                      Assets.icons.logoW,
                      width: 90,
                      height: 90,
                    ),
                  ),
                ],
              ),
            ),

            // Status Text Below Logo
            Container(
              height: 40,
              alignment: Alignment.topCenter,
              child: _buildStatusText(),
            ),

            // Bottom Action Buttons
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
              child: _buildActionButtons(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusText() {
    switch (_callState) {
      case CallState.calling:
        return const Text(
          'Calling....',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        );
      case CallState.ended:
        return const Text(
          'Call Ended',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        );
      case CallState.connected:
      case CallState.connectedRecording:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formattedTime,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (_callState == CallState.connectedRecording) ...[
              const SizedBox(width: 6),
              const Icon(Icons.circle, color: Colors.red, size: 10),
            ],
          ],
        );
    }
  }

  Widget _buildActionButtons() {
    if (_callState == CallState.calling) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildActionButton(
              icon: Icons.call_end,
              iconColor: Colors.red,
              backgroundColor: const Color(0xFFFFA5B5),
              onTap: _endCall,
            ),
            _buildActionButton(
              icon: CupertinoIcons.volume_up,
              iconColor: ColorName.primary,
              backgroundColor: Colors.white,
              onTap: _toggleSpeaker,
            ),
          ],
        ),
      );
    }

    if (_callState == CallState.ended) {
      return const SizedBox.shrink();
    }

    // Connected or ConnectedRecording states
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionButton(
              icon: _isMuted
                  ? CupertinoIcons.mic_off
                  : CupertinoIcons.mic,
              iconColor: _isMuted ? Colors.red : Colors.grey.shade700,
              onTap: _toggleMute,
            ),
            _buildActionButton(
              icon: CupertinoIcons.video_camera,
              iconColor: Colors.grey.shade700,
            ),
            _buildActionButton(
              icon: Icons.radio_button_checked,
              iconColor: _callState == CallState.connectedRecording
                  ? Colors.red
                  : Colors.grey.shade700,
              onTap: _toggleRecording,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionButton(
              icon: _isSpeakerOn
                  ? CupertinoIcons.volume_up
                  : CupertinoIcons.volume_off,
              iconColor:
                  _isSpeakerOn ? ColorName.primary : Colors.grey.shade700,
              onTap: _toggleSpeaker,
            ),
            _buildActionButton(
              icon: CupertinoIcons.chat_bubble_text,
              iconColor: Colors.grey.shade700,
            ),
            _buildActionButton(
              icon: CupertinoIcons.back,
              iconColor: Colors.grey.shade700,
              onTap: () => context.router.maybePop(),
            ),
          ],
        ),
        const SizedBox(height: 40),
        _buildActionButton(
          icon: Icons.call_end,
          iconColor: Colors.red,
          backgroundColor: const Color(0xFFFFA5B5),
          onTap: _endCall,
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color iconColor,
    Color backgroundColor = Colors.white,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withValues(alpha: 0.5),
              blurRadius: 16,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(icon, color: iconColor, size: 28),
      ),
    );
  }
}

class RipplePainter extends CustomPainter {
  final double animationValue;
  final Color color;

  RipplePainter({required this.animationValue, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    // Circles expand out to take up most of the available width
    final maxRadius = size.width * 0.8;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    // Draw 3 concentric expanding rings
    for (int i = 0; i < 3; i++) {
      // Offset the phase so the rings are evenly spaced
      double progress = (animationValue + (i / 3.0)) % 1.0;

      // Opacity fades out as ring expands outward
      double opacity = (1.0 - progress).clamp(0.0, 1.0);

      // Maximum opacity is 0.5 to keep it looking subtle
      paint.color = color.withValues(alpha: opacity * 0.9);

      // Minimum radius roughly matches the logo radius (~45)
      double radius = 50.0 + (maxRadius - 50.0) * progress;

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant RipplePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
