// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/product_item_widget.dart';

enum FilterOptions { favorites, all }

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context, listen: false);
    final product =
        _showOnlyFavorites ? productData.favoriteItems : productData.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop App'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              itemBuilder: (_) => [
                    const PopupMenuItem(
                        value: FilterOptions.favorites,
                        child: Text('Only Favourite')),
                    const PopupMenuItem(
                        value: FilterOptions.all, child: Text('Show All')),
                  ]),
          Consumer<Cart>(
            builder: (context, cart, child) => Badge(
                alignment: Alignment.topRight,
                offset: const Offset(-5, 5),
                label: Text(cart.itemCount.toString()),
                child: child),
            child: IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, CartScreen.routeName),
                icon: const Icon(Icons.shopping_cart)),
          )
        ],
      ),
      body: GridView.builder(
        itemCount: product.length,
        padding: const EdgeInsets.all(20),
        itemBuilder: (_, index) => ChangeNotifierProvider.value(
          value: product[index],
          child: const ProductItem(),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
      ),
    );
  }
}
