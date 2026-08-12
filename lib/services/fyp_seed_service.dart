import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/client.dart';
import '../models/supplier.dart';
import '../models/product.dart';
import '../models/invoice.dart';
import '../models/estimate.dart';
import '../models/expense.dart';
import '../models/payment.dart';
import '../models/purchase_order.dart';
import '../models/supplier_payment.dart';
import '../models/time_entry.dart';
import '../models/recurring_profile.dart';
import '../models/settings.dart';
import '../database/database_provider.dart';
import '../providers/client_provider.dart';
import '../providers/supplier_provider.dart';
import '../providers/product_provider.dart';
import '../providers/invoice_provider.dart';
import '../providers/estimate_provider.dart';
import '../providers/expense_provider.dart';
import '../providers/payment_provider.dart';
import '../providers/purchase_order_provider.dart';
import '../providers/supplier_payment_provider.dart';
import '../providers/time_entry_provider.dart';
import '../providers/recurring_profile_provider.dart';
import '../providers/settings_provider.dart';
import '../utils/error_handler.dart';

class FypSeedService {
  static Future<void> seedFypThesisData(WidgetRef ref, BuildContext context) async {
    const uuid = Uuid();
    final now = DateTime.now();

    try {
      final db = ref.read(databaseProvider);
      await db.clearAll();

      // 1. App Settings
      final fypSettings = AppSettings(
        companyName: 'PrimeLedger Tech Solutions',
        companyAddress: 'Maluk Abad Mingora Swat, Khyber Pakhtunkhwa',
        companyEmail: 'info@primeledger.pk',
        companyPhone: '+92 345 9001122',
        currencySymbol: 'Rs',
        defaultTaxPercent: 16.0,
        taxRegistrationNumber: 'NTN-786112-9',
        invoicePrefix: 'INV-SWAT-',
        bankDetails: 'Meezan Bank Ltd, Mingora Branch\nAccount: 0102-0103040506\nIBAN: PK36MEZN0001020103040506',
        defaultPaymentTermsDays: 14,
        productMarkupPercent: 25.0,
        numberFormat: 'millions',
      );
      await ref.read(settingsDaoProvider).saveSettings(fypSettings);

      // 2. Clients (Shahid Khan, Haider Ali, Raja Ali)
      final clientShahid = Client(
        id: 'client-shahid-khan',
        name: 'Shahid Khan',
        email: 'shahid.khan@gmail.com',
        phone: '+92 345 1234567',
        address: 'House #12, St #4, Maluk Abad Mingora Swat',
        contactPerson: 'Shahid Khan',
        taxNumber: 'NTN-345001-A',
        paymentTermsDays: 14,
        creditLimit: 500000.0,
        createdAt: now.subtract(const Duration(days: 30)),
      );

      final clientHaider = Client(
        id: 'client-haider-ali',
        name: 'Haider Ali',
        email: 'haider.ali@hotmail.com',
        phone: '+92 346 9876543',
        address: 'Main Commercial Plaza, Maluk Abad Mingora Swat',
        contactPerson: 'Haider Ali',
        taxNumber: 'NTN-346002-B',
        paymentTermsDays: 30,
        creditLimit: 750000.0,
        createdAt: now.subtract(const Duration(days: 25)),
      );

      final clientRaja = Client(
        id: 'client-raja-ali',
        name: 'Raja Ali',
        email: 'raja.ali@yahoo.com',
        phone: '+92 347 5551234',
        address: 'Bypass Road Near Green Chowk, Maluk Abad Mingora Swat',
        contactPerson: 'Raja Ali',
        taxNumber: 'NTN-347003-C',
        paymentTermsDays: 15,
        creditLimit: 1000000.0,
        createdAt: now.subtract(const Duration(days: 20)),
      );

      final clientDao = ref.read(clientDaoProvider);
      await clientDao.insert(clientShahid);
      await clientDao.insert(clientHaider);
      await clientDao.insert(clientRaja);

      // 3. Suppliers
      final supplierKhyber = Supplier(
        id: 'supplier-khyber-tech',
        name: 'Khyber Tech Wholesale Swat',
        email: 'supply@khybertech.pk',
        phone: '+92 348 7778899',
        address: 'Subhan Plaza, Maluk Abad Mingora Swat',
        contactPerson: 'Sardar Ahmed',
        createdAt: now.subtract(const Duration(days: 40)),
      );

      final supplierMingora = Supplier(
        id: 'supplier-mingora-elec',
        name: 'Mingora Electricals & Hardware',
        email: 'sales@mingoraelec.pk',
        phone: '+92 345 4443322',
        address: 'New Bus Stand Road, Maluk Abad Mingora Swat',
        contactPerson: 'Bilal Khan',
        createdAt: now.subtract(const Duration(days: 35)),
      );

      final supplierDao = ref.read(supplierDaoProvider);
      await supplierDao.insert(supplierKhyber);
      await supplierDao.insert(supplierMingora);

      // 4. Products
      final prod1 = Product(
        id: 'prod-dell-i7',
        name: 'Dell Latitude 5420 Core i7 (16GB / 512GB SSD)',
        sku: 'LAP-DELL-i7',
        category: 'Electronics',
        unit: 'Unit',
        sellingPrice: 165000.0,
        costPrice: 135000.0,
        quantity: 15,
        reorderLevel: 5,
        createdAt: now.subtract(const Duration(days: 30)),
        updatedAt: now.subtract(const Duration(days: 30)),
      );

      final prod2 = Product(
        id: 'prod-hp-printer',
        name: 'HP LaserJet Pro M404dn Enterprise Printer',
        sku: 'PRN-HP-M404',
        category: 'Office Equipment',
        unit: 'Unit',
        sellingPrice: 75000.0,
        costPrice: 58000.0,
        quantity: 8,
        reorderLevel: 3,
        createdAt: now.subtract(const Duration(days: 28)),
        updatedAt: now.subtract(const Duration(days: 28)),
      );

      final prod3 = Product(
        id: 'prod-cisco-switch',
        name: 'Cisco CBS250 24-Port Gigabit Smart Managed Switch',
        sku: 'NET-CSCO-24P',
        category: 'Networking',
        unit: 'Unit',
        sellingPrice: 48000.0,
        costPrice: 36000.0,
        quantity: 20,
        reorderLevel: 5,
        createdAt: now.subtract(const Duration(days: 25)),
        updatedAt: now.subtract(const Duration(days: 25)),
      );

      final prod4 = Product(
        id: 'prod-hik-camera',
        name: 'Hikvision 4K Outdoor Dome IP Security Camera',
        sku: 'CAM-HIK-4K',
        category: 'Security',
        unit: 'Unit',
        sellingPrice: 22500.0,
        costPrice: 16500.0,
        quantity: 25,
        reorderLevel: 8,
        createdAt: now.subtract(const Duration(days: 22)),
        updatedAt: now.subtract(const Duration(days: 22)),
      );

      final prod5 = Product(
        id: 'prod-logi-combo',
        name: 'Logitech MK345 Wireless Keyboard & Mouse Combo',
        sku: 'ACC-LOG-MK345',
        category: 'Accessories',
        unit: 'Set',
        sellingPrice: 9500.0,
        costPrice: 6800.0,
        quantity: 35,
        reorderLevel: 10,
        createdAt: now.subtract(const Duration(days: 20)),
        updatedAt: now.subtract(const Duration(days: 20)),
      );

      final productDao = ref.read(productDaoProvider);
      await productDao.insert(prod1);
      await productDao.insert(prod2);
      await productDao.insert(prod3);
      await productDao.insert(prod4);
      await productDao.insert(prod5);

      // 5. Invoices
      final invoiceDao = ref.read(invoiceDaoProvider);

      // Invoice 1: Paid (Shahid Khan)
      final inv1Date = now.subtract(const Duration(days: 12));
      final inv1 = Invoice(
        id: 'inv-1001',
        clientId: clientShahid.id,
        invoiceNumber: 'INV-SWAT-1001',
        issueDate: inv1Date,
        dueDate: inv1Date.add(const Duration(days: 14)),
        subTotal: 349000.0,
        taxTotal: 55840.0,
        totalAmount: 404840.0,
        status: 'Paid',
        notes: 'Thank you for your business!',
        createdAt: inv1Date,
        items: [
          InvoiceItem(
            id: uuid.v4(),
            productId: prod1.id,
            description: '${prod1.name} (SKU: ${prod1.sku})',
            quantity: 2,
            rate: 165000.0,
            taxPercent: 16.0,
            taxAmount: 52800.0,
            total: 382800.0,
          ),
          InvoiceItem(
            id: uuid.v4(),
            productId: prod5.id,
            description: '${prod5.name} (SKU: ${prod5.sku})',
            quantity: 2,
            rate: 9500.0,
            taxPercent: 16.0,
            taxAmount: 3040.0,
            total: 22040.0,
          ),
        ],
      );
      await invoiceDao.insert(inv1);

      // Payment for Inv 1
      final pay1 = Payment(
        id: uuid.v4(),
        invoiceId: inv1.id,
        clientId: clientShahid.id,
        amount: 404840.0,
        date: inv1Date.add(const Duration(days: 2)),
        paymentMethod: 'Bank Transfer',
        referenceNumber: 'MEZN-PAY-991122',
        notes: 'Full payment received via Meezan Bank Online',
        createdAt: inv1Date.add(const Duration(days: 2)),
      );
      await ref.read(paymentDaoProvider).insert(pay1);

      // Invoice 2: Partially Paid (Haider Ali)
      final inv2Date = now.subtract(const Duration(days: 8));
      final inv2 = Invoice(
        id: 'inv-1002',
        clientId: clientHaider.id,
        invoiceNumber: 'INV-SWAT-1002',
        issueDate: inv2Date,
        dueDate: inv2Date.add(const Duration(days: 30)),
        subTotal: 261000.0,
        taxTotal: 41760.0,
        totalAmount: 302760.0,
        status: 'Partially Paid',
        notes: 'Partial advance received',
        createdAt: inv2Date,
        items: [
          InvoiceItem(
            id: uuid.v4(),
            productId: prod2.id,
            description: '${prod2.name} (SKU: ${prod2.sku})',
            quantity: 1,
            rate: 75000.0,
            taxPercent: 16.0,
            taxAmount: 12000.0,
            total: 87000.0,
          ),
          InvoiceItem(
            id: uuid.v4(),
            productId: prod3.id,
            description: '${prod3.name} (SKU: ${prod3.sku})',
            quantity: 2,
            rate: 48000.0,
            taxPercent: 16.0,
            taxAmount: 15360.0,
            total: 111360.0,
          ),
          InvoiceItem(
            id: uuid.v4(),
            productId: prod4.id,
            description: '${prod4.name} (SKU: ${prod4.sku})',
            quantity: 4,
            rate: 22500.0,
            taxPercent: 16.0,
            taxAmount: 14400.0,
            total: 104400.0,
          ),
        ],
      );
      await invoiceDao.insert(inv2);

      // Partial Payment for Inv 2
      final pay2 = Payment(
        id: uuid.v4(),
        invoiceId: inv2.id,
        clientId: clientHaider.id,
        amount: 150000.0,
        date: inv2Date.add(const Duration(days: 1)),
        paymentMethod: 'Bank Transfer',
        referenceNumber: 'HBL-ADV-445566',
        notes: 'Initial 50% advance deposit received',
        createdAt: inv2Date.add(const Duration(days: 1)),
      );
      await ref.read(paymentDaoProvider).insert(pay2);

      // Invoice 3: Unpaid (Raja Ali)
      final inv3Date = now.subtract(const Duration(days: 4));
      final inv3 = Invoice(
        id: 'inv-1003',
        clientId: clientRaja.id,
        invoiceNumber: 'INV-SWAT-1003',
        issueDate: inv3Date,
        dueDate: inv3Date.add(const Duration(days: 15)),
        subTotal: 258000.0,
        taxTotal: 41280.0,
        totalAmount: 299280.0,
        status: 'Unpaid',
        notes: 'Net 15 days credit terms',
        createdAt: inv3Date,
        items: [
          InvoiceItem(
            id: uuid.v4(),
            productId: prod1.id,
            description: '${prod1.name} (SKU: ${prod1.sku})',
            quantity: 1,
            rate: 165000.0,
            taxPercent: 16.0,
            taxAmount: 26400.0,
            total: 191400.0,
          ),
          InvoiceItem(
            id: uuid.v4(),
            productId: prod3.id,
            description: '${prod3.name} (SKU: ${prod3.sku})',
            quantity: 1,
            rate: 48000.0,
            taxPercent: 16.0,
            taxAmount: 7680.0,
            total: 55680.0,
          ),
          InvoiceItem(
            id: uuid.v4(),
            productId: prod4.id,
            description: '${prod4.name} (SKU: ${prod4.sku})',
            quantity: 2,
            rate: 22500.0,
            taxPercent: 16.0,
            taxAmount: 7200.0,
            total: 52200.0,
          ),
        ],
      );
      await invoiceDao.insert(inv3);

      // Invoice 4: Overdue (Shahid Khan)
      final inv4Date = now.subtract(const Duration(days: 25));
      final inv4 = Invoice(
        id: 'inv-1004',
        clientId: clientShahid.id,
        invoiceNumber: 'INV-SWAT-1004',
        issueDate: inv4Date,
        dueDate: inv4Date.add(const Duration(days: 10)),
        subTotal: 122500.0,
        taxTotal: 19600.0,
        totalAmount: 142100.0,
        status: 'Overdue',
        notes: 'Payment reminder sent',
        createdAt: inv4Date,
        items: [
          InvoiceItem(
            id: uuid.v4(),
            productId: prod2.id,
            description: '${prod2.name} (SKU: ${prod2.sku})',
            quantity: 1,
            rate: 75000.0,
            taxPercent: 16.0,
            taxAmount: 12000.0,
            total: 87000.0,
          ),
          InvoiceItem(
            id: uuid.v4(),
            productId: prod5.id,
            description: '${prod5.name} (SKU: ${prod5.sku})',
            quantity: 5,
            rate: 9500.0,
            taxPercent: 16.0,
            taxAmount: 7600.0,
            total: 55100.0,
          ),
        ],
      );
      await invoiceDao.insert(inv4);

      // 6. Estimates
      final estimateDao = ref.read(estimateDaoProvider);

      final est1 = Estimate(
        id: uuid.v4(),
        clientId: clientHaider.id,
        estimateNumber: 'EST-SWAT-2001',
        issueDate: now.subtract(const Duration(days: 10)),
        expiryDate: now.add(const Duration(days: 20)),
        subTotal: 372000.0,
        taxTotal: 59520.0,
        totalAmount: 431520.0,
        status: 'Accepted',
        notes: 'Quotation accepted by client',
        createdAt: now.subtract(const Duration(days: 10)),
        items: [
          EstimateItem(
            id: uuid.v4(),
            productId: prod3.id,
            description: '${prod3.name} (SKU: ${prod3.sku})',
            quantity: 4,
            rate: 48000.0,
            taxPercent: 16.0,
            taxAmount: 30720.0,
            total: 222720.0,
          ),
          EstimateItem(
            id: uuid.v4(),
            productId: prod4.id,
            description: '${prod4.name} (SKU: ${prod4.sku})',
            quantity: 8,
            rate: 22500.0,
            taxPercent: 16.0,
            taxAmount: 28800.0,
            total: 208800.0,
          ),
        ],
      );
      await estimateDao.insert(est1);

      final est2 = Estimate(
        id: uuid.v4(),
        clientId: clientRaja.id,
        estimateNumber: 'EST-SWAT-2002',
        issueDate: now.subtract(const Duration(days: 3)),
        expiryDate: now.add(const Duration(days: 12)),
        subTotal: 495000.0,
        taxTotal: 79200.0,
        totalAmount: 574200.0,
        status: 'Sent',
        notes: 'Pending client review',
        createdAt: now.subtract(const Duration(days: 3)),
        items: [
          EstimateItem(
            id: uuid.v4(),
            productId: prod1.id,
            description: '${prod1.name} (SKU: ${prod1.sku})',
            quantity: 3,
            rate: 165000.0,
            taxPercent: 16.0,
            taxAmount: 79200.0,
            total: 574200.0,
          ),
        ],
      );
      await estimateDao.insert(est2);

      // 7. Expenses
      final expenseDao = ref.read(expenseDaoProvider);

      final exp1 = Expense(
        id: uuid.v4(),
        category: 'Rent',
        amount: 65000.0,
        date: now.subtract(const Duration(days: 15)),
        description: 'Office Branch Rent - Maluk Abad Branch',
        clientId: null,
        isBillable: false,
        markupPercent: 0.0,
        invoiceId: null,
        receiptPath: null,
        createdAt: now.subtract(const Duration(days: 15)),
      );
      await expenseDao.insert(exp1);

      final exp2 = Expense(
        id: uuid.v4(),
        category: 'Utilities',
        amount: 12500.0,
        date: now.subtract(const Duration(days: 10)),
        description: 'PTCL High Speed Fiber Optics Internet Swat',
        clientId: null,
        isBillable: false,
        markupPercent: 0.0,
        invoiceId: null,
        receiptPath: null,
        createdAt: now.subtract(const Duration(days: 10)),
      );
      await expenseDao.insert(exp2);

      final exp3 = Expense(
        id: uuid.v4(),
        category: 'Office Supplies',
        amount: 24000.0,
        date: now.subtract(const Duration(days: 5)),
        description: 'Network Cat6 Cables & Patch Cord Trunks',
        clientId: clientHaider.id,
        isBillable: true,
        markupPercent: 20.0,
        invoiceId: null,
        receiptPath: null,
        createdAt: now.subtract(const Duration(days: 5)),
      );
      await expenseDao.insert(exp3);

      // 8. Purchase Orders
      final poDao = ref.read(purchaseOrderDaoProvider);

      final po1 = PurchaseOrder(
        id: uuid.v4(),
        supplierId: supplierKhyber.id,
        poNumber: 'PO-SWAT-3001',
        issueDate: now.subtract(const Duration(days: 20)),
        expectedDate: now.subtract(const Duration(days: 10)),
        subTotal: 965000.0,
        taxTotal: 0.0,
        totalAmount: 965000.0,
        status: 'Received',
        notes: 'Stock received in good condition',
        createdAt: now.subtract(const Duration(days: 20)),
        items: [
          PurchaseOrderItem(
            id: uuid.v4(),
            productId: prod1.id,
            description: prod1.name,
            quantity: 5,
            unitPrice: 135000.0,
            total: 675000.0,
          ),
          PurchaseOrderItem(
            id: uuid.v4(),
            productId: prod2.id,
            description: prod2.name,
            quantity: 5,
            unitPrice: 58000.0,
            total: 290000.0,
          ),
        ],
      );
      await poDao.insert(po1);

      // Supplier Payment for PO 1
      await ref.read(supplierPaymentDaoProvider).insert(
        SupplierPayment(
          id: uuid.v4(),
          purchaseOrderId: po1.id,
          supplierId: supplierKhyber.id,
          amount: 965000.0,
          date: now.subtract(const Duration(days: 18)),
          paymentMethod: 'Bank Transfer',
          referenceNumber: 'MEZN-PO-778899',
          notes: 'Full payment cleared to Khyber Tech',
          createdAt: now.subtract(const Duration(days: 18)),
        ),
      );

      final po2 = PurchaseOrder(
        id: uuid.v4(),
        supplierId: supplierMingora.id,
        poNumber: 'PO-SWAT-3002',
        issueDate: now.subtract(const Duration(days: 6)),
        expectedDate: now.add(const Duration(days: 5)),
        subTotal: 607500.0,
        taxTotal: 0.0,
        totalAmount: 607500.0,
        status: 'Ordered',
        notes: 'Dispatched via Swat Express Cargo',
        createdAt: now.subtract(const Duration(days: 6)),
        items: [
          PurchaseOrderItem(
            id: uuid.v4(),
            productId: prod3.id,
            description: prod3.name,
            quantity: 10,
            unitPrice: 36000.0,
            total: 360000.0,
          ),
          PurchaseOrderItem(
            id: uuid.v4(),
            productId: prod4.id,
            description: prod4.name,
            quantity: 15,
            unitPrice: 16500.0,
            total: 247500.0,
          ),
        ],
      );
      await poDao.insert(po2);

      // 9. Time Tracker Entries
      final timeDao = ref.read(timeEntryDaoProvider);

      final tt1 = TimeEntry(
        id: uuid.v4(),
        clientId: clientHaider.id,
        taskName: 'Enterprise Network Setup & Router Config',
        description: 'Configured Cisco switches and IP VLAN routing at Maluk Abad plaza',
        date: now.subtract(const Duration(days: 7)),
        hours: 14.5,
        rate: 2500.0,
        isBillable: true,
        isInvoiced: false,
        createdAt: now.subtract(const Duration(days: 7)),
      );
      await timeDao.insert(tt1);

      final tt2 = TimeEntry(
        id: uuid.v4(),
        clientId: clientShahid.id,
        taskName: 'Software System Deployment & User Training',
        description: 'Installed database server and conducted staff training',
        date: now.subtract(const Duration(days: 14)),
        hours: 18.0,
        rate: 3000.0,
        isBillable: true,
        isInvoiced: true,
        createdAt: now.subtract(const Duration(days: 14)),
      );
      await timeDao.insert(tt2);

      final tt3 = TimeEntry(
        id: uuid.v4(),
        clientId: clientRaja.id,
        taskName: 'CCTV Surveillance Infrastructure Survey',
        description: 'Site inspection and camera positioning plan for Bypass Road site',
        date: now.subtract(const Duration(days: 3)),
        hours: 10.0,
        rate: 2000.0,
        isBillable: true,
        isInvoiced: false,
        createdAt: now.subtract(const Duration(days: 3)),
      );
      await timeDao.insert(tt3);

      // 10. Recurring Profiles
      final recDao = ref.read(recurringProfileDaoProvider);

      final rec1 = RecurringProfile(
        id: uuid.v4(),
        clientId: clientShahid.id,
        description: 'Monthly IT Infrastructure & SLA Support Agreement',
        amount: 50000.0,
        frequency: 'Monthly',
        startDate: DateTime(now.year, now.month, 1),
        endDate: null,
        nextIssueDate: DateTime(now.year, now.month + 1, 1),
        isActive: true,
        createdAt: now.subtract(const Duration(days: 20)),
      );
      await recDao.insert(rec1);

      // Refresh all Riverpod state providers
      ref.invalidate(invoicesProvider);
      ref.invalidate(expensesProvider);
      ref.invalidate(paymentsProvider);
      ref.invalidate(productsProvider);
      ref.invalidate(estimatesProvider);
      ref.invalidate(clientsProvider);
      ref.invalidate(suppliersProvider);
      ref.invalidate(purchaseOrdersProvider);
      ref.invalidate(timeEntriesProvider);
      ref.invalidate(recurringProfilesProvider);
      ref.invalidate(settingsProvider);

      if (context.mounted) {
        AppErrorHandler.showSuccessSnackBar(
          context,
          'Thesis Demo Data Loaded! (Shahid Khan, Haider Ali, Raja Ali - Swat)',
        );
      }
    } catch (e) {
      debugPrint('Error seeding FYP thesis data: $e');
      if (context.mounted) {
        AppErrorHandler.showErrorSnackBar(context, e, prefix: 'Seeding failed');
      }
    }
  }
}
