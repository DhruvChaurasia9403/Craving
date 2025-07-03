import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import '../blocs/product/product_cubit.dart';
import '../blocs/product/product_state.dart';
import '../blocs/cart/cart_cubit.dart';
import '../blocs/cart/cart_state.dart';
import '../models/product_model.dart';
import '../models/vendor_model.dart';

class ProductScreen extends StatefulWidget {
  final Vendor vendor;

  const ProductScreen({super.key, required this.vendor});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _categoryKeys = {};
  String? _expandedCategory;
  bool _isFabExpanded = false;
  late AnimationController _fabController;

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProducts(widget.vendor.id);
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  void _scrollToCategory(String category) {
    final key = _categoryKeys[category];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildExpandableFab(List<String> categories) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: !_isFabExpanded
          ? SizedBox(
        key: const ValueKey('fab'),
        width: 160,
        height: 56,
        child: FloatingActionButton.extended(
          heroTag: 'menu_fab',
          backgroundColor: Colors.black,
          onPressed: () {
            setState(() => _isFabExpanded = true);
          },
          icon: const Icon(Icons.restaurant_menu, color: Colors.white),
          label: const Text("Menu", style: TextStyle(color: Colors.white)),
        ),
      )
          : Container(
        key: const ValueKey('fab_expanded'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...categories.map((cat) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: SizedBox(
                width: 160,
                child: FloatingActionButton.extended(
                  heroTag: cat,
                  backgroundColor: Colors.white,
                  icon: const Icon(Icons.arrow_right, color: Colors.black),
                  label: Text(cat, style: const TextStyle(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      _isFabExpanded = false;
                      if (_expandedCategory == cat) {
                        _expandedCategory = null;
                      } else {
                        _expandedCategory = cat;
                        _scrollToCategory(cat);
                      }
                    });
                  },
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: 160,
                height: 48,
                child: FloatingActionButton(
                  heroTag: 'close_fab',
                  backgroundColor: Colors.black,
                  onPressed: () {
                    setState(() => _isFabExpanded = false);
                  },
                  child: const Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.vendor.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 2),
            Text(
              widget.vendor.location,
              style: const TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.green),
                    const SizedBox(width: 4),
                    Text('${widget.vendor.rating} ratings'),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.pedal_bike, color: Colors.green),
                    const SizedBox(width: 4),
                    Text('Prepare in ${widget.vendor.time} mins'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            final List<Product> products = state.products;
            final Map<String, List<Product>> categorized = {};
            for (var product in products) {
              categorized.putIfAbsent(product.category, () => []).add(product);
            }
            for (var cat in categorized.keys) {
              _categoryKeys.putIfAbsent(cat, () => GlobalKey());
            }

            return SingleChildScrollView(
              controller: _scrollController,
              child: ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    final key = categorized.keys.elementAt(index);
                    if (_expandedCategory == key) {
                      _expandedCategory = null;
                    } else {
                      _expandedCategory = key;
                      _scrollToCategory(key);
                    }
                  });
                },
                children: categorized.entries.mapIndexed((index, entry) {
                  final category = entry.key;
                  final items = entry.value;
                  return ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        key: _categoryKeys[category],
                        title: Text(category, style: const TextStyle(fontWeight: FontWeight.bold)),
                      );
                    },
                    isExpanded: _expandedCategory == category,
                    body: Column(
                      children: items.map((product) {
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product.image,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(product.name),
                          subtitle: Text('₹ ${product.price.toStringAsFixed(2)}'),
                          trailing: SizedBox(
                            width: 110,
                            child: BlocBuilder<CartCubit, CartState>(
                              builder: (context, cartState) {
                                final cartCubit = context.read<CartCubit>();
                                final qty = cartCubit.getQuantity(product);

                                if (qty == 0) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      cartCubit.addToCart(product);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(color: Colors.green),
                                      foregroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Text("Add"),
                                  );
                                } else {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove, color: Colors.green),
                                          onPressed: () {
                                            cartCubit.removeFromCart(product);
                                          },
                                        ),
                                        Text(
                                          '$qty',
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.add, color: Colors.green),
                                          onPressed: () {
                                            cartCubit.addToCart(product);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }).toList(),
              ),
            );
          } else if (state is ProductError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoaded) {
            final categories = state.products.map((p) => p.category).toSet().toList();
            return _buildExpandableFab(categories);
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, cartState) {
          if (cartState.items.isEmpty) return const SizedBox.shrink();
          return Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.green[700],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${cartState.items.length} item${cartState.items.length > 1 ? 's' : ''} | ₹${cartState.total.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                  child: const Text('Go to Cart', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}