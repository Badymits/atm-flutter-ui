import 'package:flutter/material.dart';

class WithdrawPage extends StatefulWidget {
  @override
  _WithdrawPageState createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final TextEditingController _amountController = TextEditingController();
  String _message = '';

  void _withdraw() {
    final amountText = _amountController.text;
    if (amountText.isEmpty) {
      setState(() {
        _message = 'Please enter an amount to withdraw.';
      });
      return;
    }
    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      setState(() {
        _message = 'Enter a valid withdrawal amount.';
      });
      return;
    }
    setState(() {
      _message =
          'You have withdrawn \$${amount.toStringAsFixed(2)} successfully!';
    });
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Withdraw')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Enter amount to withdraw',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _withdraw, child: Text('Withdraw')),
            SizedBox(height: 20),
            Text(_message, style: TextStyle(color: Colors.green, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
