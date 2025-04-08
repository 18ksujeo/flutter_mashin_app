import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatPrice(int price) {
  return NumberFormat('#,###').format(price);
}

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {'name': 'Item#1', 'price': 10000},
    {'name': 'Item#2', 'price': 5000},
    {'name': 'Item#3', 'price': 30000},
    {'name': 'Item#4', 'price': 40000},
    {'name': 'Item#5', 'price': 50000},
    {'name': 'Item#6', 'price': 60000},
    {'name': 'Item#7', 'price': 30000},
    {'name': 'Item#8', 'price': 20000},
    {'name': 'Item#9', 'price': 10000},
    {'name': 'Item#10', 'price': 140000},
    {'name': 'Item#11', 'price': 150000},
    {'name': 'Item#12', 'price': 50000},
    {'name': 'Item#13', 'price': 150000},
    {'name': 'Item#14', 'price': 170000},
    {'name': 'Item#15', 'price': 200000},
    {'name': 'Item#16', 'price': 300000},
  ];

  int getTotalPrice() {
    return items.fold(
      0,
      (sum, item) => sum + (item['price'] as int),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int totalPrice = getTotalPrice();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 50,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'For Running',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: ListView(
                children: items.map(
                  (item) => Column(
                    children: [
                      MagyoListItem(
                        item['name'],
                        item['price'],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ).toList(),
              ),
            ),
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    Text(
                      '총 가격',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    Text(
                      formatPrice(totalPrice),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 80),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text(
                          '정말로 결제할 건가요?',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        content: Text(
                          '구매한 아이템 목록',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        actions: [
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('취소', style: TextStyle(color: Color(0xFF409c74))),
                          ),
                          CupertinoDialogAction(
                            isDestructiveAction: true,
                            onPressed: () {},
                            child: Text('확인', style: TextStyle(color: Color(0xFF409c74))),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // Text color
                  backgroundColor: Color(0xFF409c74), // Button background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // More rounded corners
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shadowColor: Colors.black.withOpacity(0.3), // Add shadow
                  elevation: 8, // Elevation for 3D effect
                ),
                child: Text(
                  '결제 하기',
                  style: TextStyle(
                    fontSize: 18, // Adjusted font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MagyoListItem extends StatelessWidget {
  MagyoListItem(this.itemName, this.itemPrice);

  final String itemName;
  final int itemPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              itemName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              formatPrice(itemPrice),
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
