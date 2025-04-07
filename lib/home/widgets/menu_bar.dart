import 'package:flutter/material.dart';
import 'package:flutter_mashin_app/home/ui/home_screen.dart';

class MenuScaffold extends StatefulWidget {
  const MenuScaffold({super.key});

  @override
  State<MenuScaffold> createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    Placeholder(), // 상품
    Placeholder(), // 장바구니
    Placeholder(), // 구매내역
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: '상품'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: '장바구니'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: '구매내역'),
        ],
      ),
    );
  }
}
