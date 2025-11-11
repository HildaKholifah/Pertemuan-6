import 'package:flutter/material.dart';
import 'package:moneyappsqllite/data/model/transaction.dart';
import 'package:moneyappsqllite/data/repository/transaction_repository.dart';
import 'package:moneyappsqllite/presentation/edit_page.dart';
import 'package:moneyappsqllite/presentation/home_page.dart';

class DetailPage extends StatelessWidget {
  final Transaction ts;
  DetailPage({super.key, required this.ts});

  final _repo = TransactionRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Page")),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text("Category = ${ts.category}"),
            Text("Amount = ${ts.amount}"),
            Text("Deskripsi = ${ts.description}"),
            Text("Date = ${ts.date}"),
            Text("Type = ${ts.type}"),
            Row(
              spacing: 10,
              children: [
                SizedBox(
                  width: 167,
                  child: ElevatedButton(
                    onPressed: () {
                      _repo.deleteTransaction(ts.id!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Berhasil dihapus"),
                          backgroundColor: Colors.blue,
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: Text("Delete"),
                  ),
                ),

                SizedBox(
                  width: 167,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPage(ts: ts),
                        ),
                      );
                    },
                    child: Text("Update"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
