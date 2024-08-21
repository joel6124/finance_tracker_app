import 'package:flutter/material.dart';
import 'package:money_management_app/category/cat_addpopup.dart';
import 'package:money_management_app/category/category.dart';

import 'package:money_management_app/home/widgets.dart';
import 'package:money_management_app/transactions/transaction_add_page.dart';

import 'package:money_management_app/transactions/transactions.dart';

class WelcomePage extends StatelessWidget {
  //welcome is home page
  WelcomePage({super.key});

  static ValueNotifier<int> selectedind = ValueNotifier(0);

  final List _pages = [TransactionsScreen(), CategoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Money Manager'),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: selectedind,
        builder: (context, updated_val, child) {
          return _pages[updated_val];
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedind.value == 0) {
            print('Transaction page');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return AddTransactionPage();
                },
              ),
            );
          } else {
            print('Categories page');
            ShowCatAddPopUp(context);
          }

          // final sample = CategoryModel(
          //   id: DateTime.now().millisecondsSinceEpoch.toString(),
          //   name: 'TRAVEL',
          //   type: CategoryType.income,
          // );
          // CategoryDB().insertcategories(sample);
        },
        child: Icon(Icons.add_alert),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
