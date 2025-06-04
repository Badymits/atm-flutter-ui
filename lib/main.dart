import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

double balance = 35000.0; // Example balance

final formattedBalance = NumberFormat.currency(
  locale: 'en_PH',
  symbol: '₱',
).format(balance);
// Initial balance

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _username = '';
  String _password = '';

  // Function to validate login credentials
  void _login() {
    setState(() {
      _username = _usernameController.text;
      _password = _passwordController.text;

      if (_username == 'usergary' && _password == 'pass143') {
        // Credentials match, show modal dialog
        _showLoginSuccessDialog();
      } else {
        // Credentials do not match, show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Invalid Username/Password!\nUsername: $_username\nPassword: $_password',
            ),
          ),
        );
      }
    });
  }

  // Function to show a modal dialog for login success
  void _showLoginSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Successful'),
          content: const Text('You have successfully logged in!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Navigate to the next screen (HomePage)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 200,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to the left
                children: [
                  Text(
                    'ODB Banking App',
                    style: TextStyle(fontSize: 52, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Secure. Fast. Reliable.',
                    style: TextStyle(fontSize: 28, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Login to Your Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ), // Center the text
            ), // Space at the top
            const SizedBox(height: 20), // Space between title and text fields
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(
                  fontSize: 18,
                  color: const Color.fromARGB(255, 95, 94, 94),
                ),
                hintText: 'Enter your username',
                hintStyle: TextStyle(color: Colors.blueGrey),
                filled: true,
                fillColor: const Color.fromARGB(
                  255,
                  227,
                  234,
                  240,
                ), // background color of the field
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),

                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                prefixIcon: Icon(Icons.person),
              ),
              // Ensure the text field expands to fill the available width
            ),
            SizedBox(height: 20), // Space between username and password fields

            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(fontSize: 18, color: Colors.blueGrey),
                hintText: 'Enter your password',
                hintStyle: TextStyle(color: Colors.grey),

                filled: true,
                fillColor: const Color.fromARGB(
                  255,
                  227,
                  234,
                  240,
                ), // background color of the field
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                prefixIcon: Icon(Icons.person),
              ),

              obscureText: true, // Hide the password input
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _login,

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Background color
                foregroundColor: Colors.white, // Text (foreground) color
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Login', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
        title: const Text(
          'ODB Banking',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Balance Card with hover and click
            Card(
              child: Center(
                child: FractionallySizedBox(
                  widthFactor: 1, // 90% of the parent/screen width
                  child: Card(
                    color: Colors.blue[800],
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 28,
                        horizontal: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Available Balance',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                formattedBalance,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[600],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 24,
                                  ),
                                ),
                                onPressed: () =>
                                    _navigateTo(context, const BalancePage()),
                                child: Wrap(
                                  children: [
                                    Icon(Icons.add, color: Colors.white),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Cash In',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Quick Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _QuickAction(
                        icon: Icons.account_balance,
                        label: 'Deposit',
                        color: const Color(0xFF81C784),
                        onTap: () => _navigateTo(context, const DepositPage()),
                      ),

                      _QuickAction(
                        icon: Icons.receipt_long,
                        label: 'Pay Bills',
                        color: Colors.orange[700]!,
                        onTap: () => _navigateTo(context, const PayBillsPage()),
                      ),

                      _QuickAction(
                        icon: Icons.attach_money,
                        label: 'Withdraw',
                        color: const Color(0xFFE57373),
                        onTap: () => _navigateTo(context, const WithdrawPage()),
                      ),
                      _QuickAction(
                        icon: Icons.more_horiz,
                        label: 'More',
                        color: Colors.grey[600]!,
                        onTap: () =>
                            _navigateTo(context, const MoreActionsPage()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Services Grid with hover and click
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _ServiceIcon(
                        icon: Icons.phone_android,
                        label: 'Load',
                        color: const Color(0xFF4FC3F7),
                        onTap: () => _navigateTo(context, const LoadPage()),
                      ),
                      _ServiceIcon(
                        icon: Icons.credit_card,
                        label: 'Bank Transfer',
                        color: const Color(0xFF9575CD),
                        onTap: () =>
                            _navigateTo(context, const BankTransferPage()),
                      ),
                      _ServiceIcon(
                        icon: Icons.qr_code_scanner,
                        label: 'Scan QR',
                        color: const Color(0xFFFFB74D),
                        onTap: () => _navigateTo(context, const ScanQRPage()),
                      ),
                      _ServiceIcon(
                        icon: Icons.account_balance_wallet,
                        label: 'Cash In',
                        color: Colors.blue[700]!,
                        onTap: () => _navigateTo(context, const CashInPage()),
                      ),
                      _ServiceIcon(
                        icon: Icons.shopping_cart,
                        label: 'Shop',
                        color: const Color(0xFFBA68C8),
                        onTap: () => _navigateTo(context, const ShopPage()),
                      ),
                      _ServiceIcon(
                        icon: Icons.send,
                        label: 'Send Money',
                        color: Colors.green[600]!,
                        onTap: () =>
                            _navigateTo(context, const SendMoneyPage()),
                      ),
                      _ServiceIcon(
                        icon: Icons.security,
                        label: 'Insurance',
                        color: const Color(0xFF64B5F6),
                        onTap: () =>
                            _navigateTo(context, const InsurancePage()),
                      ),
                      _ServiceIcon(
                        icon: Icons.more_horiz,
                        label: 'More',
                        color: const Color(0xFFBDBDBD),
                        onTap: () =>
                            _navigateTo(context, const MoreServicesPage()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Recent Transactions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    _TransactionTile(
                      icon: Icons.arrow_downward,
                      label: 'Received from John',
                      amount: '+₱2,000.00',
                      color: Colors.green,
                      date: 'Jun 10',
                      onTap: () =>
                          _navigateTo(context, const TransactionDetailPage()),
                    ),
                    const Divider(height: 1),
                    _TransactionTile(
                      icon: Icons.arrow_upward,
                      label: 'Sent to Jane',
                      amount: '-₱1,500.00',
                      color: Colors.red,
                      date: 'Jun 9',
                      onTap: () =>
                          _navigateTo(context, const TransactionDetailPage()),
                    ),
                    const Divider(height: 1),
                    _TransactionTile(
                      icon: Icons.receipt,
                      label: 'Paid Electric Bill',
                      amount: '-₱800.00',
                      color: Colors.orange,
                      date: 'Jun 8',
                      onTap: () =>
                          _navigateTo(context, const TransactionDetailPage()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Hoverable Card Widget
class _HoverableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const _HoverableCard({required this.child, this.onTap});

  @override
  State<_HoverableCard> createState() => _HoverableCardState();
}

class _HoverableCardState extends State<_HoverableCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovering ? 1.01 : 1.0,
          duration: const Duration(milliseconds: 120),
          child: widget.child,
        ),
      ),
    );
  }
}

// Modified QuickAction to support hover and tap
class _QuickAction extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  State<_QuickAction> createState() => _QuickActionState();
}

class _QuickActionState extends State<_QuickAction> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovering ? 1.08 : 1.0,
          duration: const Duration(milliseconds: 120),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: widget.color,
                radius: 24,
                child: Icon(widget.icon, color: Colors.white, size: 28),
              ),
              const SizedBox(height: 8),
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Modified ServiceIcon to support hover and tap
class _ServiceIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _ServiceIcon({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  State<_ServiceIcon> createState() => _ServiceIconState();
}

class _ServiceIconState extends State<_ServiceIcon> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovering ? 1.10 : 1.0,
          duration: const Duration(milliseconds: 120),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: widget.color,
                radius: 20,
                child: Icon(widget.icon, color: Colors.white, size: 22),
              ),
              const SizedBox(height: 6),
              Text(
                widget.label,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Modified TransactionTile to support hover and tap
class _TransactionTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final String amount;
  final Color color;
  final String date;
  final VoidCallback? onTap;

  const _TransactionTile({
    required this.icon,
    required this.label,
    required this.amount,
    required this.color,
    required this.date,
    this.onTap,
  });

  @override
  State<_TransactionTile> createState() => _TransactionTileState();
}

class _TransactionTileState extends State<_TransactionTile> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          color: _hovering ? Colors.grey.withOpacity(0.08) : Colors.transparent,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: widget.color.withOpacity(0.15),
              child: Icon(widget.icon, color: widget.color),
            ),
            title: Text(
              widget.label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(widget.date),
            trailing: Text(
              widget.amount,
              style: TextStyle(
                color: widget.color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Dummy pages for navigation
class BalancePage extends StatelessWidget {
  const BalancePage({super.key});
  @override
  Widget build(BuildContext context) => _SimplePage(title: 'Balance Details');
}

class CashInPage extends StatelessWidget {
  const CashInPage({super.key});
  @override
  Widget build(BuildContext context) => _SimplePage(title: 'Cash In');
}

class SendMoneyPage extends StatelessWidget {
  const SendMoneyPage({super.key});
  @override
  Widget build(BuildContext context) => _SimplePage(title: 'Send Money');
}

class PayBillsPage extends StatelessWidget {
  const PayBillsPage({super.key});
  @override
  Widget build(BuildContext context) => _SimplePage(title: 'Pay Bills');
}

class MoreActionsPage extends StatelessWidget {
  const MoreActionsPage({super.key});
  @override
  Widget build(BuildContext context) => _SimplePage(title: 'More Actions');
}

class LoadPage extends StatelessWidget {
  const LoadPage({super.key});
  @override
  Widget build(BuildContext context) => _SimplePage(title: 'Load');
}

class BankTransferPage extends StatelessWidget {
  const BankTransferPage({super.key});
  @override
  Widget build(BuildContext context) => _SimplePage(title: 'Bank Transfer');
}

class ScanQRPage extends StatelessWidget {
  const ScanQRPage({super.key});
  @override
  Widget build(BuildContext context) => _SimplePage(title: 'Scan QR');
}

class DepositPage extends StatelessWidget {
  const DepositPage({super.key});
  @override
  Widget build(BuildContext context) => _SimplePage(title: 'Deposit');
}

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});
  @override
  Widget build(BuildContext context) => _SimplePage(title: 'Shop');
}

class WithdrawPage extends StatelessWidget {
  const WithdrawPage({super.key});
  @override
  Widget build(BuildContext context) => _SimplePage(title: 'Withdraw');
}

class InsurancePage extends StatelessWidget {
  const InsurancePage({super.key});
  @override
  Widget build(BuildContext context) => _SimplePage(title: 'Insurance');
}

class MoreServicesPage extends StatelessWidget {
  const MoreServicesPage({super.key});
  @override
  Widget build(BuildContext context) => _SimplePage(title: 'More Services');
}

class TransactionDetailPage extends StatelessWidget {
  const TransactionDetailPage({super.key});
  @override
  Widget build(BuildContext context) =>
      _SimplePage(title: 'Transaction Details');
}

// Simple placeholder page
class _SimplePage extends StatelessWidget {
  final String title;
  const _SimplePage({required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title, style: const TextStyle(fontSize: 28))),
    );
  }
}

// class _QuickAction extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color color;

//   const _QuickAction({
//     required this.icon,
//     required this.label,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CircleAvatar(
//           backgroundColor: color,
//           radius: 24,
//           child: Icon(icon, color: Colors.white, size: 28),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           label,
//           style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
//         ),
//       ],
//     );
//   }
// }

// class _ServiceIcon extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color color;

//   const _ServiceIcon({
//     required this.icon,
//     required this.label,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         CircleAvatar(
//           backgroundColor: color,
//           radius: 20,
//           child: Icon(icon, color: Colors.white, size: 22),
//         ),
//         const SizedBox(height: 6),
//         Text(
//           label,
//           style: const TextStyle(fontSize: 12),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }
// }

// class _TransactionTile extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String amount;
//   final Color color;
//   final String date;

//   const _TransactionTile({
//     required this.icon,
//     required this.label,
//     required this.amount,
//     required this.color,
//     required this.date,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundColor: color.withOpacity(0.15),
//         child: Icon(icon, color: color),
//       ),
//       title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
//       subtitle: Text(date),
//       trailing: Text(
//         amount,
//         style: TextStyle(
//           color: color,
//           fontWeight: FontWeight.bold,
//           fontSize: 16,
//         ),
//       ),
//     );
//   }
// }
