import 'package:flutter/material.dart';
import 'package:money_management_app/home/welcome.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: WelcomePage.selectedind,
      builder: (context, updatedInd, child) {
        return BottomNavigationBar(
          currentIndex: updatedInd,
          selectedItemColor: Colors.pink,
          unselectedItemColor: const Color.fromARGB(179, 4, 0, 0),
          onTap: (ind) {
            WelcomePage.selectedind.value = ind;
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Category',
            )
          ],
        );
      },
    );
  }
}
