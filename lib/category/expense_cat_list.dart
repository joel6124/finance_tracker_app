import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().expense_cat_list,
      builder: (context, updated_expense_list, child) {
        return ListView.separated(
            itemBuilder: (BuildContext ctx, int index) {
              final category = updated_expense_list[index];
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  elevation: 4,
                  child: ListTile(
                    title: Text(category.name),
                    trailing: IconButton(
                      color: Colors.red,
                      onPressed: () {
                        CategoryDB.instance.deletecategories(category.id);
                      },
                      icon: Icon(
                        Icons.delete,
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return Divider(
                thickness: 2,
              );
            },
            itemCount: updated_expense_list.length);
      },
    );
  }
}
