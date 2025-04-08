import 'package:flutter/material.dart';

class ProductImageSection extends StatelessWidget {
  final String imageUrl;

  const ProductImageSection({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      width: double.infinity,
      height: 200,
      child: imageUrl.isNotEmpty
          ? (imageUrl.startsWith('http')
              ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        '이미지를 불러올 수 없습니다',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                )
              : Image.asset(
                  imageUrl, // Loading from assets
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        '이미지를 불러올 수 없습니다',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ))
          : const Center(
              child: Text(
                'Image',
                style: TextStyle(color: Colors.white),
              ),
            ),
    );
  }
}
