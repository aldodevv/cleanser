import 'package:auto_route/auto_route.dart';
import 'package:cleanser/infrastructure/assets/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FeatureData {
  final String title;
  final int crossAxisCellCount;
  final double height;
  final Color? color;

  FeatureData({
    required this.title,
    this.crossAxisCellCount = 1,
    required this.height,
    this.color,
  });
}

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<FeatureData> _allFeatures = [
    FeatureData(title: 'Complain', height: 180),
    FeatureData(title: 'Pricing Plan', height: 180),
    FeatureData(title: 'Event', crossAxisCellCount: 2, height: 140),
    FeatureData(title: 'News', height: 160),
    FeatureData(title: 'Earn', height: 280),
    FeatureData(title: 'Impacts', height: 160),
    FeatureData(title: 'Soon', height: 140, color: const Color(0xFFC0B8CE)),
    FeatureData(title: 'Soon', height: 140, color: const Color(0xFFC0B8CE)),
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
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;
    if (screenWidth >= 600) {
      crossAxisCount = 4;
    }
    if (screenWidth >= 900) {
      crossAxisCount = 6;
    }

    return Scaffold(
      backgroundColor: ColorName.primary,
      body: SafeArea(
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
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
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
              padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 8.0,
                ),
                child: StaggeredGrid.count(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: _filteredFeatures.map((feature) {
                    int cellCount = feature.crossAxisCellCount;
                    if (crossAxisCount == 4) cellCount *= 2;
                    if (crossAxisCount == 6) cellCount *= 3;

                    if (cellCount > crossAxisCount) cellCount = crossAxisCount;

                    return StaggeredGridTile.fit(
                      crossAxisCellCount: cellCount,
                      child: _buildFeatureCard(feature),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(FeatureData feature) {
    return Container(
      height: feature.height,
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
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        children: [
          Text(
            feature.title,
            style: const TextStyle(
              color: ColorName.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          Positioned(
            right: -10,
            bottom: -10,
            child: Icon(
              _getIconForFeature(feature.title),
              size: 80,
              color: ColorName.primary.withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForFeature(String title) {
    switch (title.toLowerCase()) {
      case 'complain':
        return Icons.edit_document;
      case 'pricing plan':
        return Icons.price_check;
      case 'event':
        return Icons.event;
      case 'news':
        return Icons.newspaper;
      case 'earn':
        return Icons.monetization_on;
      case 'impacts':
        return Icons.nature_people;
      case 'soon':
        return Icons.hourglass_empty;
      default:
        return Icons.widgets;
    }
  }
}
