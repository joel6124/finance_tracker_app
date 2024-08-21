import 'package:flutter/material.dart';
import 'package:money_management_app/category/expense_cat_list.dart';
import 'package:money_management_app/category/income_cat_lsit.dart';
import 'package:money_management_app/db/category/category_db.dart';

class CategoryScreen extends StatefulWidget {
  //tab bar always requires a stateful widgwet
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  //for using vsync
  late TabController _tabController;

  @override
  void initState() {
    //initially set the tab controller length and the animation(vsync)
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.pink,
          dividerColor: Colors.black,
          unselectedLabelColor: Colors.black,
          tabs: [
            Tab(
              text: 'INCOME',
              icon: Icon(Icons.input),
            ),
            Tab(
              text: 'EXPENSE',
              icon: Icon(Icons.output),
            ),
          ],
        ),
        Expanded(
          //must be expanded to utilze the full space below the tab bar
          child: TabBarView(
            controller: _tabController,
            children: [
              IncomeList(),
              ExpenseList(),
            ],
          ),
        )
      ],
    );
  }
}
