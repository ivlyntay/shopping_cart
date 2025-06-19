import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/catalog.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _ProductRow(index),
                childCount: context.select<CatalogModel, int>(
                  (catalog) => catalog.items.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductRow extends StatelessWidget {
  final int index;
  const _ProductRow(this.index);

  @override
  Widget build(BuildContext context) {
    var item = context.select<CatalogModel, Item>(
      (catalog) => catalog.getByPosition(index),
    );

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(item.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text('\$${item.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          )),
                ],
              ),
            ),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({required this.item});

  @override
  Widget build(BuildContext context) {
    var isInCart = context.select<CartModel, bool>(
      (cart) => cart.items.contains(item),
    );

    return Align(
      alignment: Alignment.centerRight,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        radius: 20,
        child: IconButton(
          icon: Icon(
            isInCart ? Icons.check : Icons.add,
            color: Colors.white,
          ),
          onPressed: isInCart
              ? null
              : () {
                  var cart = context.read<CartModel>();
                  cart.add(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item.name} added to cart'),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
        ),
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Catalog', style: Theme.of(context).textTheme.displayLarge),
      floating: true,
      actions: [
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => context.go('/cart'),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Consumer<CartModel>(
                builder: (context, cart, child) {
                  if (cart.items.isEmpty) return const SizedBox();
                  return Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cart.items.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }
} 