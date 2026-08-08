import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
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
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _scanBarcode() async {
    try {
      final res = await SimpleBarcodeScanner.scanBarcode(
        context,
        barcodeAppBar: const BarcodeAppBar(appBarTitle: 'Scan Product Barcode'),
        isShowFlashIcon: true,
        delayMillis: 500,
        cameraFace: CameraFace.back,
      );
      if (res != null && res != '-1' && res.isNotEmpty) {
        final match = widget.products.where((p) =>
          (p.barcode?.toLowerCase() == res.toLowerCase()) ||
          (p.sku?.toLowerCase() == res.toLowerCase()) ||
          p.name.toLowerCase() == res.toLowerCase()
        ).firstOrNull;

        if (match != null) {
          widget.onSelected(match);
          if (mounted) Navigator.pop(context);
        } else {
          setState(() {
            _query = res;
            _searchCtrl.text = res;
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('No exact barcode match for "$res". Showing search results.'),
                backgroundColor: const Color(0xFFF59E0B),
              ),
            );
          }
        }
      }
    } catch (e) {
      debugPrint('Barcode scan error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = widget.products.where((p) =>
      p.name.toLowerCase().contains(_query.toLowerCase()) ||
      (p.sku?.toLowerCase().contains(_query.toLowerCase()) ?? false) ||
      (p.barcode?.toLowerCase().contains(_query.toLowerCase()) ?? false)
    ).toList();
    final theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search product, SKU, or barcode...',
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (v) => setState(() => _query = v),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _scanBarcode,
                  icon: const Icon(Icons.qr_code_scanner),
                  tooltip: 'Scan Barcode',
                  style: IconButton.styleFrom(
                    backgroundColor: AppTheme.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inventory_2_outlined, size: 48, color: Colors.grey.withValues(alpha: 0.5)),
                        const SizedBox(height: 12),
                        Text('No products found matching "$_query"', style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (ctx, i) {
                      final product = filtered[i];
                      final isLow = product.isLowStock;
                      return Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: theme.dividerColor),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: CircleAvatar(
                            backgroundColor: AppTheme.indigo.withValues(alpha: 0.1),
                            child: const Icon(Icons.inventory_2, color: AppTheme.indigo),
                          ),
                          title: Row(
                            children: [
                              Expanded(child: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                              if (isLow)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                                  child: const Text('LOW STOCK', style: TextStyle(fontSize: 9, color: Colors.red, fontWeight: FontWeight.bold)),
                                ),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Row(
                              children: [
                                Text(product.sku != null && product.sku!.isNotEmpty ? 'SKU: ${product.sku}' : 'No SKU', style: const TextStyle(fontSize: 12)),
                                const SizedBox(width: 12),
                                Text(
                                  'Stock: ${product.quantity} ${product.unit}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isLow ? Colors.red : AppTheme.emerald,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: Text(
                            '${widget.currencySymbol}${product.sellingPrice.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppTheme.indigo),
                          ),
                          onTap: () {
                            widget.onSelected(product);
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
