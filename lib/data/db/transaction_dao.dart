import 'dart:developer';

import 'package:moneyappsqllite/data/db/db_helper.dart';
import 'package:moneyappsqllite/data/model/transaction.dart';

class TransactionDao {
  final dbHelper = DbHelper();

  Future<int> insertTransaction(Transaction transaction) async {
    final db = await dbHelper.database;
    return await db.insert('transactions', transaction.toMap());
  }

  Future<List<Transaction>> getAllTransaction() async {
    final db = await dbHelper.database;
    final result = await db.query('transactions');

    for (var map in result) {
      log('Transaction from DB: ${Transaction.fromMap(map).toJson()}');
    }
    return result.map((map) => Transaction.fromMap(map)).toList();
  }

  Future<double> getIncome() async {
    final db = await dbHelper.database;
    final incomeResult = await db.rawQuery(
      'SELECT SUM(amount) as total_income FROM transactions WHERE TYPE = ?',
      ['income'],
    );
    return (incomeResult.first['total_income'] as num?)?.toDouble() ?? 0.0;
  }

  Future<double> getExpense() async {
    final db = await dbHelper.database;
    final expenseResult = await db.rawQuery(
      'SELECT SUM(amount) as total_expense FROM transactions WHERE TYPE = ?',
      ['expense'],
    );
    return (expenseResult.first['total_expence'] as num?)?.toDouble() ?? 0.0;
  }

  Future<double> getBalance() async {
    final income = await getIncome();
    final expense = await getExpense();
    return income - expense;
  }

  Future<int> updateTransactions(int id, Transaction transaction) async {
    final db = await dbHelper.database;
    return await db.update(
      'transaction',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteTransaction(int id) async {
    final db = await dbHelper.database;
    return await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }
}
