<div align="center">

# 📒 PrimeLedger

### A complete, offline-first business financial management app built with Flutter

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![SQLite](https://img.shields.io/badge/SQLite-Drift-003B57?style=for-the-badge&logo=sqlite&logoColor=white)](https://drift.simonbinder.eu)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Windows%20%7C%20Web-green?style=for-the-badge)](https://flutter.dev/multi-platform)

**PrimeLedger** is a feature-rich, offline-first business financial management application that empowers freelancers, small businesses, and service providers to manage their entire financial workflow — from client onboarding and product catalogues to invoicing, expense tracking, purchase orders, and double-entry bookkeeping — all in one place, on any platform, without an internet connection or monthly subscription.

</div>

---

## 🧩 The Problem PrimeLedger Solves

Small businesses, freelancers, and traders in many markets face critical operational challenges that expensive SaaS tools don't adequately address:

| Problem | How Most Businesses Cope | PrimeLedger's Solution |
|---|---|---|
| **No all-in-one tool** | Juggling Excel, WhatsApp, and paper receipts | One unified app for every financial workflow |
| **Cloud dependency** | Tools like Wave/QuickBooks require constant internet | Fully offline, SQLite-backed local database |
| **Subscription costs** | $30–$150/month for cloud accounting software | Free, open-source, self-hosted |
| **No PDF invoicing on mobile** | Printing from a PC or paying a service | Generate and share professional PDF invoices directly from phone |
| **Tracking unbilled expenses** | Forgetting to bill clients for costs incurred on their behalf | Billable expense tracking with automatic markup and linking to invoices |
| **Manual recurring billing** | Forgetting to send monthly retainer invoices | Auto-generates invoices from configurable recurring profiles |
| **No inventory management** | Separate stock-keeping in another tool | Built-in product catalogue with stock tracking and low-stock alerts |
| **No double-entry bookkeeping** | No visibility into cash flow or profitability | Full general ledger with per-client / per-supplier account views |
| **Tax complexity** | Manual calculations prone to error | Per-line-item tax, withholding tax, secondary tax, and discount support |
| **Data lock-in** | No way to export your own data | Full CSV export and JSON backup/restore |

---

## ✨ Features

### 📊 Financial Dashboard
- Real-time overview of **Revenue**, **Outstanding balance**, **Expenses**, and **Net Profit**
- **Stock Value** and active **Client** count at a glance
- Interactive **7-day revenue bar chart** (fl_chart)
- Inline **recent invoices** quick-access list
- Automatic **recurring invoice generation** on app launch
- Light/Dark mode toggle

### 🧾 Invoicing
- Create, edit, clone, and delete invoices with a rich form
- **Auto-incrementing invoice numbers** with configurable prefix (e.g., `INV-0001`)
- Multi-line items with per-item:
  - Product linkage from catalogue
  - Quantity, unit price, per-line discount (%), per-line tax (%)
- **Invoice-level discount** (percentage or flat amount)
- **Withholding tax** and **secondary tax (Tax 2)** support
- **Partial payment** tracking — invoice status auto-updates to `Partially Paid` / `Paid`
- **Import billable expenses** directly onto an invoice
- Statuses: `Draft`, `Sent`, `Partially Paid`, `Paid`, `Overdue`, `Cancelled`
- **PDF generation and sharing** (professional layout with company logo and bank details)
- CSV export of all invoices

### 📋 Estimates / Quotations
- Create professional estimates with the same line-item engine as invoices
- Convert estimates to invoices in one tap
- Track estimate status: `Draft`, `Sent`, `Accepted`, `Declined`

### 🔄 Recurring Invoices
- Define recurring billing profiles with custom **frequencies** (weekly, monthly, quarterly, etc.)
- Automatically generate draft invoices when the next billing date arrives
- Manage and view all recurring profiles from a dedicated screen

### 💰 Expenses
- Log internal and **billable client expenses**
- Configurable **markup percentage** on billable expenses
- Link expenses directly to invoices for reimbursement tracking
- Filter by billable / non-billable, category, and date range
- Tracks **unbilled billable expenses** in the outstanding balance calculation

### 🏦 General Ledger
- **Double-entry bookkeeping** view: income and expense transactions in chronological order
- Filter by **client**, **supplier**, or **date range**
- **Per-entity account views** — see the full transaction history for any client or supplier
- Running balance column
- Filter by entry type: Invoice, Payment, Expense, Purchase Order

### 🛒 Purchase Orders
- Issue purchase orders to suppliers with line items
- Track PO status: `Draft`, `Sent`, `Received`, `Cancelled`
- Supplier payment logging against purchase orders
- Full purchase order history per supplier

### 👥 Clients & Suppliers
- Maintain a client and supplier directory with contact details
- Quick-access to the ledger account for any contact
- Slide-to-delete with confirmation dialog

### 📦 Product Catalogue & Inventory
- Manage a product/service catalogue with:
  - **Cost price** and **selling price** (with configurable markup)
  - **Stock quantity** tracking
  - **Low-stock alert** threshold
  - Barcode scanning (via device camera)
- View **total stock value**
- Track **stock movements** (auto-updated on invoicing)
- Product search sheet with inline creation in invoice/estimate/PO forms

### ⏱️ Time Tracking
- Log billable time entries against clients
- Start/stop timer for live tracking
- Entries include description, duration, and hourly rate
- Import time entries onto invoices

### 💳 Payment History
- Full payment ledger with search and date filters
- View payments per client or globally
- Link each payment to its source invoice

### 📈 Reports
- Revenue and expense summaries
- Profit & loss overview
- Exportable data via CSV

### ⚙️ Settings & Customisation
- Company name, address, email, phone
- **Company logo** (uploaded from gallery, stored as Base64)
- Currency symbol and number format (**Millions** or **Lakhs/Indian** format)
- Default tax rate, tax registration number
- Invoice prefix and default payment terms (days)
- Bank details (printed on PDF invoices)
- PIN lock for app security
- **Full JSON backup and restore** (export all data, import on any device)
- Dark / Light theme preference

---

## 🗂️ Project Architecture

PrimeLedger follows a clean, layered architecture with a clear separation of concerns:

```
lib/
├── main.dart                   # App entry point, error handling, theme/router setup
├── theme.dart                  # Light & Dark AppTheme definitions (Material 3)
├── router.dart                 # GoRouter navigation with PIN lock guard
│
├── models/                     # Pure Dart data models (immutable value objects)
│   ├── client.dart
│   ├── invoice.dart
│   ├── estimate.dart
│   ├── expense.dart
│   ├── payment.dart
│   ├── product.dart
│   ├── purchase_order.dart
│   ├── recurring_profile.dart
│   ├── supplier.dart
│   ├── supplier_payment.dart
│   ├── time_entry.dart
│   ├── ledger_entry.dart
│   ├── stock_movement.dart
│   └── settings.dart
│
├── database/                   # Drift (SQLite) layer
│   ├── database.dart           # Table definitions + migrations
│   ├── database.g.dart         # Auto-generated Drift code
│   ├── database_provider.dart  # Riverpod providers for all DAOs
│   └── daos/                   # Data Access Objects per entity
│
├── providers/                  # Riverpod state management
│   ├── invoice_provider.dart
│   ├── expense_provider.dart
│   ├── ledger_provider.dart
│   ├── recurring_profile_provider.dart
│   ├── settings_provider.dart
│   ├── theme_provider.dart
│   └── ...
│
├── services/
│   ├── pdf_service.dart        # PDF generation (company logo, line items, taxes)
│   └── secure_storage_service.dart  # PIN storage via flutter_secure_storage
│
├── screens/                    # Feature screens (28 screens)
│   ├── dashboard_screen.dart
│   ├── invoice_form_screen.dart
│   ├── invoices_screen.dart
│   ├── ledger_screen.dart
│   ├── expense_form_screen.dart
│   ├── purchase_order_form_screen.dart
│   ├── settings_screen.dart
│   └── ...
│
└── widgets/                    # Reusable UI components
    ├── stat_card.dart
    ├── status_badge.dart
    ├── shimmer_loading.dart
    ├── empty_state.dart
    ├── confirm_dialog.dart
    ├── loading_overlay.dart
    └── product_search_sheet.dart
```

### State Management

PrimeLedger uses **Riverpod** (`flutter_riverpod`) for reactive, compile-safe state management. Each entity has its own `StateNotifier`-based provider backed by a Drift DAO, ensuring the UI always reflects the current database state without manual refreshes.

### Database

All data is stored locally using **Drift** (formerly Moor), a type-safe SQLite ORM for Flutter. The database includes:
- 15+ tables with proper foreign key relationships
- Incremental migrations for schema versioning
- DAOs per entity for clean data access

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| **Framework** | Flutter 3.x (Dart 3.x) |
| **State Management** | Riverpod 3.x (`flutter_riverpod`) |
| **Navigation** | GoRouter 17.x |
| **Database** | Drift (SQLite ORM) + `sqlite3_flutter_libs` |
| **PDF Generation** | `pdf` + `printing` packages |
| **Charts** | `fl_chart` |
| **Theming** | Google Fonts + Material 3 |
| **Security** | `flutter_secure_storage` (PIN lock) |
| **File I/O** | `file_picker`, `share_plus`, `path_provider` |
| **Image** | `image_picker` (logo upload) |
| **Barcode** | `simple_barcode_scanner` |
| **Utilities** | `uuid`, `intl`, `csv`, `package_info_plus` |

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** `>=3.9.2` — [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Dart SDK** `>=3.9.2` (bundled with Flutter)
- Android SDK / Xcode (for mobile targets) or a modern browser (for web)

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/PrimeLedger.git
cd PrimeLedger

# 2. Get dependencies
flutter pub get

# 3. Run on your target device
flutter run                        # Default connected device
flutter run -d android             # Android emulator/device
flutter run -d chrome              # Web browser
flutter run -d windows             # Windows desktop
```

### Regenerating Database Code

If you modify `lib/database/database.dart`, regenerate the Drift-generated code:

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## 📱 Platform Support

| Platform | Status |
|---|---|
| Android | ✅ Supported |
| iOS | ✅ Supported |
| Windows | ✅ Supported |
| Web | ✅ Supported (limited file I/O) |
| Linux | 🔧 Build-ready (untested) |
| macOS | 🔧 Build-ready (untested) |

---

## 🔒 Privacy & Data Security

PrimeLedger is designed with **privacy-first principles**:

- **All data is stored locally on your device** — no cloud sync, no telemetry, no account required.
- **PIN lock** protects app access using `flutter_secure_storage` (OS-level keychain/keystore).
- **No analytics or crash reporting** frameworks included.
- **Backup and restore** is done via a local JSON file that you control.

---

## 📤 Data Portability

- **Export invoices, expenses, and payment data as CSV** — compatible with Excel and Google Sheets.
- **Full JSON backup** — export all your business data to a single file for transfer or safekeeping.
- **JSON restore** — import your backup on any supported device to resume work instantly.
- **PDF sharing** — share professional invoices as PDFs via any installed share target (email, WhatsApp, Drive, etc.).

---

## 🗺️ Roadmap

- [ ] Multi-currency invoice support
- [ ] Sales tax groups (e.g., GST/HST/VAT with multiple rates)
- [ ] Custom invoice templates / themes
- [ ] Client portal (read-only web link for invoice viewing)
- [ ] Optional encrypted cloud backup (self-hosted or S3-compatible)
- [ ] Android widget for quick invoice creation
- [ ] Profit & Loss statement PDF export
- [ ] Item-level notes and attachments

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. **Fork** the repository
2. Create a **feature branch**: `git checkout -b feature/your-feature-name`
3. **Commit** your changes with a clear message: `git commit -m 'feat: add multi-currency support'`
4. **Push** to your branch: `git push origin feature/your-feature-name`
5. Open a **Pull Request** describing your changes

Please make sure your code:
- Passes `flutter analyze` with no errors
- Follows the existing code structure and naming conventions
- Includes any necessary Drift migration if schema changes are made

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

<div align="center">

Built with ❤️ using Flutter · Designed for businesses that just want software that works.

</div>
