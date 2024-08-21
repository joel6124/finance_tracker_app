import 'package:flutter/material.dart';

import '../db/category/category_db.dart';

class IncomeList extends StatelessWidget {
  const IncomeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().income_cat_list,
      builder: (context, updated_income_list, child) {
        return ListView.separated(
            itemBuilder: (BuildContext ctx, int index) {
              final category = updated_income_list[index];
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
            itemCount: updated_income_list.length);
      },
    );
  }
}
