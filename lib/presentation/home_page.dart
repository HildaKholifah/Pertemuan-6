import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:moneyappsqllite/data/model/transaction.dart';
import 'package:moneyappsqllite/data/repository/transaction_repository.dart';
import 'package:moneyappsqllite/presentation/insert_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  double? _balance;
  double? _income;
  double? _expense;
  final _repo = TransactionRepository();
  List<Transaction> _transaction = [];

  @override
  void initState() {
    super.initState();
    _getAllTransactions();
    _loadBalance();
    _loadIncome();
    _loadExpense();
  }

  void _getAllTransactions() async {
    try {
      final txs = await _repo.getAllTransaction();
      setState(() => _transaction = txs);
    } catch (e) {
      debugPrint('Failed to load transaction: $e');
    }
  }

  void _loadBalance() async {
    try {
      final b = await _repo.getBalance();
      setState(() => _balance = b);
    } catch (e) {
      log('Gagal mengambil balance: $e');
    }
  }

  void _loadIncome() async {
    try {
      final i = await _repo.getIncome();
      setState(() => _income = i);
    } catch (e) {
      log('Gagal mengambil income: $e');
    }
  }

  void _loadExpense() async {
    try {
      final e = await _repo.getExpense();
      setState(() => _income = e);
    } catch (e) {
      log('Gagal mengambil expense: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Text(
                      "Balance",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),

                    Text(
                      _balance == null
                          ? "Rp0.0"
                          : "Rp${_balance!.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 16.0),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Income:",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  _income == null
                                      ? "Rp0.0"
                                      : "Rp${_income!.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(width: 16.0),

                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 16.0),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Expense:",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  _expense == null
                                      ? "Rp0.0"
                                      : "Rp${_expense!.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),
              Text("Transactions will be listed here."),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _transaction.length,
                  itemBuilder: (context, index) {
                    final tx = _transaction[index];
                    return ListTile(
                      shape: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                      style: ListTileStyle.list,
                      title: Text(tx.description),
                      subtitle: Text(
                        tx.type == 'income' ? 'Income' : 'Expense',
                        style: TextStyle(
                          color: tx.type == 'income'
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      leading: Icon(
                        tx.type == 'income'
                            ? Icons.arrow_circle_up
                            : Icons.arrow_circle_down,
                        color: tx.type == 'income' ? Colors.green : Colors.red,
                      ),

                      trailing: Text(
                        "Rp${tx.amount.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          color: tx.type == 'income'
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to insert page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InsertPage()),
          ).then((_) {
            _loadBalance();
            _loadExpense();
            _loadIncome();
            _getAllTransactions();
          });
        },
        tooltip: 'Add Transaction',
        child: const Icon(Icons.add),
      ),
    );
  }
}
