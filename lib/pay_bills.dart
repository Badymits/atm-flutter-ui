import 'package:atm_ui_activity_2/globals.dart' as globals;

import 'package:flutter/material.dart';

class PayBillsPage extends StatefulWidget {
  const PayBillsPage({super.key});

  @override
  _PayBillsPageState createState() => _PayBillsPageState();
}

class _PayBillsPageState extends State<PayBillsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  String _biller = '';
  String _amount = '';
  String _selectedSource = 'Savings Account';

  // Example balances
  double _savingsBalance = globals.savings;
  double _balance = globals.balance;

  final List<String> _billers = [
    'Electricity',
    'Water',
    'Internet',
    'Credit Card',
    'Insurance',
  ];

  final List<String> _sources = ['Savings Account', 'Balance'];

  void _submitPayment() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      double amount = double.tryParse(_amount) ?? 0.0;
      bool sufficient = false;

      if (_selectedSource == 'Savings Account' && amount <= _savingsBalance) {
        globals.savings -= amount;
        sufficient = true;
      } else if (_selectedSource == 'Balance' && amount <= _balance) {
        globals.balance -= amount;
        sufficient = true;
      }

      if (sufficient) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Payment Successful'),
            content: Text(
              'You have paid $_amount to $_biller using $_selectedSource.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Payment Failed'),
            content: Text('Insufficient funds in $_selectedSource.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  bool get isAmountExceedingBalance {
    if (_amountController.text.isEmpty) return false;
    final enteredAmount = double.tryParse(_amountController.text);
    final currentAmount = _sources[0] == "Savings Account"
        ? globals.savings
        : globals.balance;

    return enteredAmount != null && enteredAmount > currentAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pay Bills',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Change the title color
          ),
        ),
        backgroundColor: Colors.blue[800],
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white, // Change the color of the back button
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Select Biller'),
                items: _billers
                    .map(
                      (biller) =>
                          DropdownMenuItem(value: biller, child: Text(biller)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _biller = value ?? '';
                  });
                },
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select a biller'
                    : null,
              ),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Select Source'),
                value: _selectedSource,
                items: _sources
                    .map(
                      (source) => DropdownMenuItem(
                        value: source,
                        child: Text(
                          source == 'Savings Account'
                              ? '$source (₱${_savingsBalance.toStringAsFixed(2)})'
                              : '$source (₱${_balance.toStringAsFixed(2)})',
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSource = value ?? 'Savings Account';
                  });
                },
              ),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _amount = value ?? '',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter amount' : null,
                onChanged: (_) => setState(() {}),
              ),
              Builder(
                builder: (context) {
                  if (_amountController.text.isNotEmpty) {
                    double? enteredAmount = double.tryParse(
                      _amountController.text,
                    );
                    double currentAmount = _sources[0] == "Savings Account"
                        ? globals.savings
                        : globals.balance;
                    if (enteredAmount != null &&
                        enteredAmount > currentAmount) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Amount cannot exceed your ${globals.selectedAccount.toLowerCase()} balance.",
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed:
                    (_amountController.text.isEmpty || isAmountExceedingBalance)
                    ? null
                    : _submitPayment,
                child: Text('Pay Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
