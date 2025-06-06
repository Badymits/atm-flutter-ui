import 'package:flutter/material.dart';
import 'package:atm_ui_activity_2/globals.dart' as globals;

class TransferMoneyPage extends StatefulWidget {
  @override
  _TransferMoneyPageState createState() => _TransferMoneyPageState();
}

class _TransferMoneyPageState extends State<TransferMoneyPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedUserAccountName = '';
  String? _selectedAccount;
  String _amount = '';
  bool _isTransactionSuccessful = false;
  String _selectedSource = 'Savings Account';

  void _transferMoney() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      double? amount = double.tryParse(_amount) ?? 0.0;
      setState(() {
        if (_selectedAccount == 'Balance') {
          if (globals.balance >= amount) {
            globals.balance -= amount;
            _isTransactionSuccessful = true;
          }
        } else if (_selectedAccount == 'Savings') {
          if (globals.savings >= amount) {
            globals.savings -= amount;
            _isTransactionSuccessful = true;
          }
        }
      });
    }
    if (_isTransactionSuccessful) {
      _formKey.currentState!.reset();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Payment Successful'),
          content: Text('Successfully transferred ₱$_amount!!'),
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
      _selectedAccount = null;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transfer Money',
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
        child: Column(
          children: [
            Card(
              color: Colors.blue[700],
              elevation: 4,
              child: ListTile(
                title: Text(
                  'Balance: ₱${globals.balance.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'Savings: ₱${globals.savings.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: null,
                    hint: Text('Transfer to User Account'),
                    items: globals.userAccounts
                        .map<DropdownMenuItem<String>>(
                          (account) => DropdownMenuItem<String>(
                            value: account
                                .userName, // assuming UserAccount has a 'name' property
                            child: Text(
                              '${account.userName} (${account.accountNumber})',
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      // Handle user account selection here
                      // You can store the selected user account in a variable if needed
                      print("account name: $value");
                      _selectedUserAccountName = value;
                      setState(() {});
                    },
                    validator: (value) =>
                        value == null ? 'Please select a user account' : null,
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedAccount,
                    hint: Text('Transfer Using Account'),
                    items: [
                      DropdownMenuItem(
                        value: 'Balance',
                        child: Text('Balance'),
                      ),
                      DropdownMenuItem(
                        value: 'Savings',
                        child: Text('Savings'),
                      ),
                    ],
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _selectedAccount = value;
                        _selectedSource = value == "Savings"
                            ? "Savings"
                            : "Balance";
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please select an account' : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter an amount';
                      }
                      final amount = double.tryParse(value);
                      if (amount == null || amount <= 0) {
                        return 'Enter a valid amount';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _amount = value!;
                    },
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _transferMoney,
                    child: Text('Transfer'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
