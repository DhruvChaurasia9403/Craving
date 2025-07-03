// lib/main.dart
//By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/category/category_cubit.dart';
import 'blocs/vendor/vendor_cubit.dart';
import 'blocs/product/product_cubit.dart';
import 'blocs/cart/cart_cubit.dart'; // <-- Add this import
import 'repositories/category_repository.dart';
import 'repositories/vendor_repository.dart';
import 'repositories/product_repository.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CategoryCubit(CategoryRepository()),
        ),
        BlocProvider(
          create: (_) => VendorCubit(VendorRepository()),
        ),
        BlocProvider(
          create: (_) => ProductCubit(ProductRepository()),
        ),
        BlocProvider( // <-- Add this
          create: (_) => CartCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vendor App',
        theme: ThemeData(
          fontFamily: 'ProductSans',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
} //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403