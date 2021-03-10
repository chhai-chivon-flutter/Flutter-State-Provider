import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state/common/theme.dart';
import 'package:state/models/cart.dart';
import 'package:state/models/catalog.dart';
import 'package:state/screens/cart.dart';
import 'package:state/screens/catalog.dart';
import 'package:state/screens/login.dart';

void main() {
  runApp(app);
}

Widget get app {
  return MultiProvider(
    providers: [
      Provider(
        create: (context) => CatalogModel(),
      ),
      ChangeNotifierProxyProvider<CatalogModel, CartModel>(
        create: (context) => CartModel(),
        update: (context, catalog, cart) {
          if (cart == null) throw ArgumentError.notNull('cart');
          cart.catalog = catalog;
          return cart;
        },
      ),
    ],
    child: MaterialApp(
      title: 'Flutter State Demo',
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/catalog': (context) => CatalogScreen(),
        '/cart': (context) => CartScreen(),
      },
    ),
  );
}
