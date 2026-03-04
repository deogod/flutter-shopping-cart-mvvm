import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/architecture/achitecture.dart';
import 'package:flutter_shopping_cart_mvvm/features/cart/view/cart_page.dart';
import 'package:flutter_shopping_cart_mvvm/features/cart/view_model/cart_view_model.dart';
import 'package:flutter_shopping_cart_mvvm/features/home/view/home_page.dart';
import 'package:flutter_shopping_cart_mvvm/features/products/products_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/home/view_model/home_view_model.dart';
import 'package:flutter_shopping_cart_mvvm/features/products/view_model/products_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  final userRepository = UserRepositoryImpl(
    localDataSource: UserLocalDataSource(localStorage: LocalStorage(prefs)),
  );

  final itemRepository = ItemRepositoryImpl(
    ItemRemoteDataSource(),
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<LocalStorage>(
          create: (_) => LocalStorage(prefs),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(
            addUserUsecase: AddUserUsecase(userRepository),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsViewModel(
            GetItemsUsecase(itemRepository),
            CartService(LocalStorage(prefs)),
          )..loadItems(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartViewModel(
            CartService(LocalStorage(prefs)),
          )..loadCart(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartService(LocalStorage(prefs))..loadCart(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/products': (context) => const ProductsPage(),
        '/cart': (context) => const CartPage(),
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
