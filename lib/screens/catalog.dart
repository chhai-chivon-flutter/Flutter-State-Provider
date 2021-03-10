import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state/models/cart.dart';
import 'package:state/models/catalog.dart';

class CatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _AppBar(),
          SliverToBoxAdapter(
              child: SizedBox(
            height: 12,
          )),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _ListItem(index)),
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Catalog', style: Theme.of(context).textTheme.headline1),
      floating: true,
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ],
    );
  }
}

class _ListItem extends StatelessWidget {
  final int index;

  _ListItem(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = context.select<CatalogModel, Item>(
      // Here, we are only interested in the item at [index]. We don't care
      // about any other change.
      (catalog) => catalog.getByPosition(index),
    );
    var textTheme = Theme.of(context).textTheme.headline6;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                // color: item.color,
                width: 200.0,
                height: 200.0,
                child: Image.network(
                  "https://s9.kh1.co/__image/w=175,h=245,fit=contain/37/370717b1e7b4cece6d90405aec281722d5efae09.jpg",
                  width: 200.0,
                  height: 200.0,
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Expanded(
                child: Text(
              item.name,
              style: textTheme,
            )),
            SizedBox(
              width: 24,
            ),
            _AddButton(item),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  _AddButton(this.item, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInCart = context.select<CartModel, bool>(
      // Here, we are only interested whether [item] is inside the cart.
      (cart) => cart.items.contains(item),
    );

    return TextButton(
        onPressed: isInCart
            ? null
            : () {
                var cart = context.read<CartModel>();
                cart.add(item);
              },
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          } else {
            return null;
          }
        })),
        child: isInCart
            ? Icon(
                Icons.check,
                semanticLabel: 'ADDED',
              )
            : Text("ADD"));
  }
}
