import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/home/home_screen.dart';
import 'blocs/category/category_cubit.dart';
import 'blocs/vendor/vendor_cubit.dart';

void main() {
  runApp(const CravingApp());
}

class CravingApp extends StatelessWidget {
  const CravingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CategoryCubit()..fetchCategories()),
        BlocProvider(create: (_) => VendorCubit()..fetchVendors()),
      ],
      child: MaterialApp(
        title: 'Craving',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'ProductSans',
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
