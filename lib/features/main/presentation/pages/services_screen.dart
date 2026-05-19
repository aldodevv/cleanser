import 'package:auto_route/auto_route.dart';
import 'package:cleanser/features/general/persentation/widgets/background_image_scaffold.dart';
import 'package:cleanser/infrastructure/assets/assets.gen.dart';
import 'package:cleanser/infrastructure/assets/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Defines the layout slot for a single card in the staggered grid.
class _LayoutSlot {
  /// Number of columns this card spans (out of crossAxisCount).
  final int crossAxisCellCount;

  /// Fixed height for this card.
  final double height;

  const _LayoutSlot(this.crossAxisCellCount, this.height);
}

/// Repeating layout pattern (5 slots per cycle):
///
/// Row 1: 2 cards — 3/4 width + 1/4 width
/// Row 2: 1 card  — full width
/// Row 3: 2 cards — 1/2 width + 1/2 width
const _layoutPattern = [
  _LayoutSlot(6, 220), // Row 1 left  — 3/4
  _LayoutSlot(4, 220), // Row 1 right — 1/4
  _LayoutSlot(10, 160), // Row 2       — full width
  _LayoutSlot(5, 160), // Row 3 left  — 1/2
  _LayoutSlot(5, 160), // Row 3 right — 1/2
];

class FeatureData {
  final String title;
  final Color? color;
  final double imageScale;
  final double imageRight;
  final double imageBottom;

  const FeatureData({
    required this.title,
    this.color,
    this.imageScale = 0.8,
    this.imageRight = 10.0,
    this.imageBottom = 10.0,
  });
}

@RoutePage()
class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<FeatureData> _allFeatures = [
    const FeatureData(
      title: 'Pricing Plan',
      imageScale: 0.65,
      imageRight: 0,
      imageBottom: 0,
    ),
    const FeatureData(title: 'complain', imageScale: 0.5),
    const FeatureData(
      title: 'Event',
      imageScale: 0.8,
      imageRight: 10,
      imageBottom: 0,
    ),
    const FeatureData(
      title: 'News',
      imageScale: 0.7,
      imageRight: 0,
      imageBottom: 0,
    ),
    const FeatureData(
      title: 'Earn',
      imageScale: 0.6,
      imageRight: -10,
      imageBottom: 10,
    ),
    const FeatureData(title: 'Impacts', imageScale: 0.6),
    const FeatureData(
      title: 'Soon',
      color: Color(0xFFC0B8CE),
      imageScale: 0.6,
      imageRight: 5,
      imageBottom: 5,
    ),
    const FeatureData(
      title: 'Soon',
      color: Color(0xFFC0B8CE),
      imageScale: 0.6,
      imageRight: 5,
      imageBottom: 5,
    ),
  ];

  List<FeatureData> _filteredFeatures = [];

  @override
  void initState() {
    super.initState();
    _filteredFeatures = _allFeatures;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredFeatures = _allFeatures.where((feature) {
        return feature.title.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: ColorName.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: ColorName.textSecondary),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: ColorName.textSecondary,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          // Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'All of Features :',
              style: TextStyle(
                color: ColorName.textInverse,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Grid
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12.0),
              child: StaggeredGrid.count(
                crossAxisCount: 10,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: List.generate(_filteredFeatures.length, (index) {
                  final feature = _filteredFeatures[index];
                  final slot = _layoutPattern[index % _layoutPattern.length];

                  return StaggeredGridTile.extent(
                    crossAxisCellCount: slot.crossAxisCellCount,
                    mainAxisExtent: slot.height,
                    child: _buildFeatureCard(feature, slot.height),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(FeatureData feature, double height) {
    return Container(
      decoration: BoxDecoration(
        color: feature.color ?? Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                feature.title,
                style: const TextStyle(
                  color: ColorName.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Positioned(
              right: feature.imageRight,
              bottom: feature.imageBottom,
              child: SvgPicture.asset(
                _getSvgAssetForFeature(feature.title),
                height: height * feature.imageScale,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getSvgAssetForFeature(String title) {
    switch (title.toLowerCase()) {
      case 'complain':
        return Assets.icons.icComplain;
      case 'pricing plan':
        return Assets.icons.icPlan;
      case 'event':
        return Assets.icons.icSocial; // using icSocial for Event
      case 'news':
        return Assets.icons.icNews;
      case 'earn':
        return Assets.icons.icMoney; // using icMoney for Earn
      case 'impacts':
        return Assets.icons.icImpact;
      case 'soon':
        return Assets.icons.icSoon;
      default:
        return Assets.icons.icSoon; // default fallback
    }
  }
}
