// ignore: file_names
import 'package:flutter/material.dart';
import 'package:atm_ui_activity_2/main.dart' as main;
import 'package:atm_ui_activity_2/globals.dart' as globals;

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  final TextEditingController _amountController = TextEditingController();

  bool _isAmountConfirmed = false;

  void addAmountToBalance(double amount) {
    print("Adding $amount to balance");
    globals.balance += amount;
  }

  void addAmountToSavings(double amount) {
    globals.savings += amount;
  }

  void showDepositDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Deposit"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Deposit Page',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Center(
                child: Card(
                  color: Colors.blue[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Balance: ${globals.selectedAccount == "Balance" ? main.formattedBalance : main.formattedSavings}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Change the text color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            DropdownButton<String>(
              value: globals.selectedAccount,
              items: ['Balance', 'Savings'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) =>
                  setState(() => globals.selectedAccount = newValue!),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter amount",
                contentPadding: const EdgeInsets.all(16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),

            Row(
              children: [
                Checkbox(
                  value: _isAmountConfirmed,
                  onChanged: (bool? value) {
                    setState(() {
                      _isAmountConfirmed = value ?? false;
                    });
                  },
                ),
                const Text("The amount that I entered is correct"),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isAmountConfirmed
                    ? () {
                        // Deposit logic here
                        if (globals.selectedAccount == "Balance") {
                          addAmountToBalance(
                            double.parse(_amountController.text),
                          );
                        } else if (globals.selectedAccount == "Savings") {
                          addAmountToSavings(
                            double.parse(_amountController.text),
                          );
                        }
                        showDepositDialog("Deposit successful!");
                        _amountController.clear();
                        setState(() {});
                      }
                    : null,
                child: const Text("Deposit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
