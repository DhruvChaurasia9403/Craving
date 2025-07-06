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
} //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403`

class _HomeScreenState extends State<HomeScreen> {
  List _lastCategories = [];
  List _lastVendors = [];
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _vendorKeys = {};

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().fetchCategories();
    context.read<VendorCubit>().fetchVendors();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
      // After setState, scroll to first filtered vendor if any
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final filtered = _filterVendors(_lastVendors);
        if (filtered.isNotEmpty) {
          final key = _vendorKeys[filtered.first.id];
          if (key != null && key.currentContext != null) {
            Scrollable.ensureVisible(
              key.currentContext!,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
        }
      });
    });
  } //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List _filterVendors(List vendors) {
    if (_searchQuery.isEmpty) return vendors;
    return vendors.where((vendor) {
      final name = vendor.name.toString().toLowerCase();
      final location = vendor.location.toString().toLowerCase();
      return name.contains(_searchQuery) || location.contains(_searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.22, //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/header.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: screenHeight * 0.065),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await Future.wait([
                        context.read<CategoryCubit>().fetchCategories(),
                        context.read<VendorCubit>().fetchVendors(),
                      ]);
                    },
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                      .toList(), //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403
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
                          // Inside your home screen's build method, where you display vendors:
                          BlocBuilder<VendorCubit, VendorState>(
                            builder: (context, state) {
                              if (state is VendorLoading) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (state is VendorLoaded) {
                                final vendors = state.vendors;
                                return ListView.builder(
                                  shrinkWrap: true, // If inside another scrollable, else remove
                                  physics: const NeverScrollableScrollPhysics(), // If inside another scrollable, else remove
                                  itemCount: vendors.length,
                                  itemBuilder: (context, index) {
                                    return VendorTile(vendor: vendors[index]);
                                  },
                                );
                              } else if (state is VendorError) {
                                return Center(child: Text('Error: ${state.message}'));
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
            // ... rest of your code (search bar, header, etc.) ...
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
            Positioned(
              top: screenHeight * 0.18,
              left: 16,
              right: 16,
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(12),
                child: TextField(
                  controller: _searchController,
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
              ), //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403
            ),
          ],
        ),
      ),
    );
  }
}