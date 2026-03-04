import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/architecture/achitecture.dart';
import 'package:flutter_shopping_cart_mvvm/features/cart/view/cart_page.dart';
import 'package:flutter_shopping_cart_mvvm/features/cart/view_model/cart_view_model.dart';
import 'package:flutter_shopping_cart_mvvm/features/home/view/home_page.dart';
import 'package:flutter_shopping_cart_mvvm/features/products/products_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/checkout/checkout_page.dart';
import 'features/checkout/view_model/checkout_view_model.dart';
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

  final CartViewModel cartViewModel = CartViewModel(
    CartService(LocalStorage(prefs)),
  )..loadCart();

  final ProductsViewModel productsViewModel = ProductsViewModel(
    GetItemsUsecase(itemRepository),
    CartService(LocalStorage(prefs)),
  )..loadItems();

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
          create: (_) => productsViewModel,
        ),
        ChangeNotifierProvider(
          create: (_) => cartViewModel,
        ),
        ChangeNotifierProvider(
          create: (_) => CheckoutViewModel(
            cartManager: CartService(LocalStorage(prefs)),
            doCheckoutUseCase: DoCheckoutUseCase(
              CheckoutRepositoryImpl(
                CheckoutRemoteDataSource(),
              ),
            ),
            cartViewModel: cartViewModel,
          )..getCart(),
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
        '/checkout': (context) => const CheckoutPage(),
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
