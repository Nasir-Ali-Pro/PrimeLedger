import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/loading_overlay.dart';
import '../utils/error_handler.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ProductFormScreen extends ConsumerStatefulWidget {
  final String? id;
  const ProductFormScreen({super.key, this.id});

  @override
  ConsumerState<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends ConsumerState<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _skuCtrl = TextEditingController();
  final _barcodeCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _costCtrl = TextEditingController(text: '0');
  final _sellCtrl = TextEditingController(text: '0');
  final _qtyCtrl = TextEditingController(text: '0');
  final _reorderCtrl = TextEditingController(text: '10');
  String _category = Product.defaultCategories.first;
  String _unit = Product.units.first;
  Product? _existing;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final products = ref.read(productsProvider);
        try {
          _existing = products.firstWhere((p) => p.id == widget.id);
          _nameCtrl.text = _existing!.name;
          _skuCtrl.text = _existing!.sku ?? '';
          _barcodeCtrl.text = _existing!.barcode ?? '';
          _descCtrl.text = _existing!.description ?? '';
          _costCtrl.text = _existing!.costPrice.toString();
          _sellCtrl.text = _existing!.sellingPrice.toString();
          _qtyCtrl.text = _existing!.quantity.toString();
          _reorderCtrl.text = _existing!.reorderLevel.toString();
          _category = _existing!.category;
          _unit = _existing!.unit;
          setState(() {});
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose(); _skuCtrl.dispose(); _barcodeCtrl.dispose();
    _descCtrl.dispose(); _costCtrl.dispose(); _sellCtrl.dispose();
    _qtyCtrl.dispose(); _reorderCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.id != null;
    final settings = ref.watch(settingsProvider);
    final cost = double.tryParse(_costCtrl.text) ?? 0;
    final sell = double.tryParse(_sellCtrl.text) ?? 0;
    final margin = cost > 0 ? ((sell - cost) / cost * 100) : 0;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Product' : 'Add Product')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'Product Name', prefixIcon: Icon(Icons.inventory_2)), validator: (v) => v!.isEmpty ? 'Required' : null),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 600;
                  if (isMobile) {
                    return Column(
                      children: [
                        TextFormField(controller: _skuCtrl, decoration: const InputDecoration(labelText: 'SKU', prefixIcon: Icon(Icons.qr_code))),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _barcodeCtrl,
                          decoration: InputDecoration(
                            labelText: 'Barcode',
                            prefixIcon: const Icon(Icons.barcode_reader),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.camera_alt),
                              onPressed: () async {
                                final res = await SimpleBarcodeScanner.scanBarcode(
                                  context,
                                  barcodeAppBar: const BarcodeAppBar(
                                    appBarTitle: 'Scan Barcode',
                                    centerTitle: false,
                                    enableBackButton: true,
                                  ),
                                  isShowFlashIcon: true,
                                  delayMillis: 2000,
                                  cameraFace: CameraFace.back,
                                );
                                if (res != null && res != '-1' && res.isNotEmpty) {
                                  setState(() => _barcodeCtrl.text = res);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Row(children: [
                    Expanded(child: TextFormField(controller: _skuCtrl, decoration: const InputDecoration(labelText: 'SKU', prefixIcon: Icon(Icons.qr_code)))),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _barcodeCtrl,
                        decoration: InputDecoration(
                          labelText: 'Barcode',
                          prefixIcon: const Icon(Icons.barcode_reader),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.camera_alt),
                             onPressed: () async {
                               final res = await SimpleBarcodeScanner.scanBarcode(
                                 context,
                                 barcodeAppBar: const BarcodeAppBar(
                                   appBarTitle: 'Scan Barcode',
                                   centerTitle: false,
                                   enableBackButton: true,
                                 ),
                                 isShowFlashIcon: true,
                                 delayMillis: 2000,
                                 cameraFace: CameraFace.back,
                               );
                               if (res != null && res != '-1' && res.isNotEmpty) {
                                 setState(() => _barcodeCtrl.text = res);
                               }
                             },
                          ),
                        ),
                      ),
                    ),
                  ]);
                }
              ),
              const SizedBox(height: 16),
              TextFormField(controller: _descCtrl, maxLines: 2, decoration: const InputDecoration(labelText: 'Description', prefixIcon: Icon(Icons.description))),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 600;
                  if (isMobile) {
                    return Column(
                      children: [
                        DropdownButtonFormField<String>(isExpanded: true, value: _category, items: Product.defaultCategories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(), onChanged: (v) => setState(() => _category = v!), decoration: const InputDecoration(labelText: 'Category')),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(isExpanded: true, value: _unit, items: Product.units.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(), onChanged: (v) => setState(() => _unit = v!), decoration: const InputDecoration(labelText: 'Unit')),
                      ],
                    );
                  }
                  return Row(children: [
                    Expanded(child: DropdownButtonFormField<String>(isExpanded: true, value: _category, items: Product.defaultCategories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(), onChanged: (v) => setState(() => _category = v!), decoration: const InputDecoration(labelText: 'Category'))),
                    const SizedBox(width: 16),
                    Expanded(child: DropdownButtonFormField<String>(isExpanded: true, value: _unit, items: Product.units.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(), onChanged: (v) => setState(() => _unit = v!), decoration: const InputDecoration(labelText: 'Unit'))),
                  ]);
                }
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 600;
                  if (isMobile) {
                    return Column(
                      children: [
                        TextFormField(controller: _costCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Cost Price', prefixText: settings.currencySymbol, prefixIcon: const Icon(Icons.money_off)), onChanged: (_) => setState(() {}), validator: (v) { if (v!.isEmpty) return 'Required'; if (double.tryParse(v) == null || double.parse(v) < 0) return 'Enter a valid price'; return null; }),
                        const SizedBox(height: 16),
                        TextFormField(controller: _sellCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Sell Price', prefixText: settings.currencySymbol, prefixIcon: const Icon(Icons.attach_money)), onChanged: (_) => setState(() {}), validator: (v) { if (v!.isEmpty) return 'Required'; if (double.tryParse(v) == null || double.parse(v) < 0) return 'Enter a valid price'; return null; }),
                      ],
                    );
                  }
                  return Row(children: [
                    Expanded(child: TextFormField(controller: _costCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Cost Price', prefixText: settings.currencySymbol, prefixIcon: const Icon(Icons.money_off)), onChanged: (_) => setState(() {}), validator: (v) { if (v!.isEmpty) return 'Required'; if (double.tryParse(v) == null || double.parse(v) < 0) return 'Enter a valid price'; return null; })),
                    const SizedBox(width: 16),
                    Expanded(child: TextFormField(controller: _sellCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Sell Price', prefixText: settings.currencySymbol, prefixIcon: const Icon(Icons.attach_money)), onChanged: (_) => setState(() {}), validator: (v) { if (v!.isEmpty) return 'Required'; if (double.tryParse(v) == null || double.parse(v) < 0) return 'Enter a valid price'; return null; })),
                  ]);
                }
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: margin > 0 ? const Color(0xFF10B981).withValues(alpha: 0.1) : const Color(0xFFEF4444).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                child: Text('Profit Margin: ${margin.toStringAsFixed(1)}%', style: TextStyle(fontWeight: FontWeight.bold, color: margin > 0 ? const Color(0xFF10B981) : const Color(0xFFEF4444))),
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 600;
                  if (isMobile) {
                    return Column(
                      children: [
                        TextFormField(controller: _qtyCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Quantity', prefixIcon: Icon(Icons.format_list_numbered)), validator: (v) { if (v!.isEmpty) return 'Required'; if (int.tryParse(v) == null || int.parse(v) < 0) return 'Enter a valid quantity'; return null; }),
                        const SizedBox(height: 16),
                        TextFormField(controller: _reorderCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Reorder Level', prefixIcon: Icon(Icons.notifications_active)), validator: (v) { if (v!.isEmpty) return 'Required'; if (int.tryParse(v) == null || int.parse(v) < 0) return 'Enter a valid quantity'; return null; }),
                      ],
                    );
                  }
                  return Row(children: [
                    Expanded(child: TextFormField(controller: _qtyCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Quantity', prefixIcon: Icon(Icons.format_list_numbered)), validator: (v) { if (v!.isEmpty) return 'Required'; if (int.tryParse(v) == null || int.parse(v) < 0) return 'Enter a valid quantity'; return null; })),
                    const SizedBox(width: 16),
                    Expanded(child: TextFormField(controller: _reorderCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Reorder Level', prefixIcon: Icon(Icons.notifications_active)), validator: (v) { if (v!.isEmpty) return 'Required'; if (int.tryParse(v) == null || int.parse(v) < 0) return 'Enter a valid quantity'; return null; })),
                  ]);
                }
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final product = Product(
                        id: isEditing ? _existing!.id : const Uuid().v4(),
                        name: _nameCtrl.text,
                        sku: _skuCtrl.text.isEmpty ? null : _skuCtrl.text,
                        barcode: _barcodeCtrl.text.isEmpty ? null : _barcodeCtrl.text,
                        description: _descCtrl.text.isEmpty ? null : _descCtrl.text,
                        category: _category,
                        costPrice: double.tryParse(_costCtrl.text) ?? 0,
                        sellingPrice: double.tryParse(_sellCtrl.text) ?? 0,
                        quantity: int.tryParse(_qtyCtrl.text) ?? 0,
                        reorderLevel: int.tryParse(_reorderCtrl.text) ?? 10,
                        unit: _unit,
                        createdAt: isEditing ? _existing!.createdAt : DateTime.now(),
                        updatedAt: DateTime.now(),
                      );
                      LoadingOverlay.show(context, message: isEditing ? 'Updating...' : 'Saving...');
                      try {
                        if (isEditing) {
                          await ref.read(productsProvider.notifier).updateProduct(product);
                        } else {
                          await ref.read(productsProvider.notifier).addProduct(product);
                        }
                        LoadingOverlay.hide();
                        if (context.mounted) {
                          AppErrorHandler.showSuccessSnackBar(context, isEditing ? 'Product updated successfully' : 'Product added successfully');
                          context.pop();
                        }
                      } catch (e) {
                        LoadingOverlay.hide();
                        if (context.mounted) {
                          AppErrorHandler.showErrorSnackBar(context, e, prefix: 'Failed to save product');
                        }
                      }
                    }
                  },
                  child: Text(isEditing ? 'Update Product' : 'Save Product'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
