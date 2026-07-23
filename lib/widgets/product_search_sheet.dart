import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../theme.dart';

class ProductSearchSheet extends StatefulWidget {
  final List<Product> products;
  final String currencySymbol;
  final Function(Product) onSelected;

  const ProductSearchSheet({
    super.key,
    required this.products,
    required this.currencySymbol,
    required this.onSelected,
  });

  @override
  State<ProductSearchSheet> createState() => _ProductSearchSheetState();
}

class _ProductSearchSheetState extends State<ProductSearchSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.products.where((p) =>
      p.name.toLowerCase().contains(_query.toLowerCase()) ||
      (p.sku?.toLowerCase().contains(_query.toLowerCase()) ?? false)
    ).toList();
    final theme = Theme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 12),
            height: 5,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search products by name or SKU...',
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (ctx, i) {
                final product = filtered[i];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.indigo.withValues(alpha: 0.1),
                    child: const Icon(Icons.inventory_2, color: AppTheme.indigo),
                  ),
                  title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(product.sku != null ? 'SKU: ${product.sku}' : 'No SKU'),
                  trailing: Text(
                    '${widget.currencySymbol}${product.sellingPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.indigo),
                  ),
                  onTap: () {
                    widget.onSelected(product);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
