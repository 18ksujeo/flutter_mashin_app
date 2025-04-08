import 'package:flutter/material.dart';

class MashinAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool automaticallyImplyLeading;
  const MashinAppBar({super.key, this.automaticallyImplyLeading = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0.5,
      leading: automaticallyImplyLeading
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.redAccent),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            )
          : null,
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '마교',
              style: TextStyle(
                color: Colors.red,
                fontSize: 26, // increased from 22
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: ' 컬렉션',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
