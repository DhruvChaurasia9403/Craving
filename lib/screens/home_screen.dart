import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:craving/blocs/category/category_cubit.dart';
import 'package:craving/blocs/category/category_state.dart';
import 'package:craving/blocs/vendor/vendor_cubit.dart';
import 'package:craving/blocs/vendor/vendor_state.dart';
import 'package:craving/widgets/category_tile.dart';
import 'package:craving/widgets/vendor_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _lastCategories = [];
  List _lastVendors = [];

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().fetchCategories();
    context.read<VendorCubit>().fetchVendors();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Full Body
            Column(
              children: [
                // Header Image
                SizedBox(
                  height: screenHeight * 0.22,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/header.jpg',
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(height: screenHeight * 0.065), // Leave space for search bar

                // Main Scrollable Area
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await Future.wait([
                        context.read<CategoryCubit>().fetchCategories(),
                        context.read<VendorCubit>().fetchVendors(),
                      ]);
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category Grid
                          BlocBuilder<CategoryCubit, CategoryState>(
                            builder: (context, state) {
                              if (state is CategoryLoaded) {
                                _lastCategories = state.categories;
                                return GridView.count(
                                  physics: const NeverScrollableScrollPhysics(),
                                  crossAxisCount: 3,
                                  shrinkWrap: true,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 1,
                                  children: state.categories
                                      .map((category) => CategoryTile(category: category))
                                      .toList(),
                                );
                              } else if (state is CategoryLoading) {
                                if (_lastCategories.isNotEmpty) {
                                  return GridView.count(
                                    physics: const NeverScrollableScrollPhysics(),
                                    crossAxisCount: 3,
                                    shrinkWrap: true,
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: 12,
                                    childAspectRatio: 1,
                                    children: _lastCategories
                                        .map((category) => CategoryTile(category: category))
                                        .toList(),
                                  );
                                }
                                return const Center(child: CircularProgressIndicator());
                              } else if (state is CategoryError) {
                                return Text('Error: ${state.message}');
                              }
                              return const SizedBox.shrink();
                            },
                          ),

                          const SizedBox(height: 20),

                          const Text(
                            'Restaurants Nearby',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Vendor List
                          BlocBuilder<VendorCubit, VendorState>(
                            builder: (context, state) {
                              if (state is VendorLoaded) {
                                _lastVendors = state.vendors;
                                return Column(
                                  children: state.vendors
                                      .map((vendor) => VendorTile(vendor: vendor))
                                      .toList(),
                                );
                              } else if (state is VendorLoading) {
                                if (_lastVendors.isNotEmpty) {
                                  return Column(
                                    children: _lastVendors
                                        .map((vendor) => VendorTile(vendor: vendor))
                                        .toList(),
                                  );
                                }
                                return const Center(child: CircularProgressIndicator());
                              } else if (state is VendorError) {
                                return Text('Error: ${state.message}');
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Back button & Title
            Positioned(
              top: screenHeight * 0.015,
              left: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      'Food',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.035,
                        fontWeight: FontWeight.bold,
                        shadows: const [
                          Shadow(
                            blurRadius: 6,
                            color: Colors.black54,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Overlapping Search Bar
            Positioned(
              top: screenHeight * 0.18,
              left: 16,
              right: 16,
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(12),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}