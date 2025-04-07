import 'package:flutter/material.dart';
import 'package:flutter_mashin_app/add/ui/add_product_screen.dart'; // Added import
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imagePicker = ImagePicker();
  File? _selectedImage;
  String? _errorText;

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _errorText = null;
        });
      }
    } catch (e) {
      setState(() {
        _errorText = '이미지 선택 중 오류가 발생했습니다.';
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _handleUpload() async {
    final name = _nameController.text.trim();
    final price = _priceController.text.trim();
    final desc = _descriptionController.text.trim();

    if (name.isEmpty || price.isEmpty) {
      setState(() {
        _errorText = '상품명과 가격은 필수 입력사항입니다.';
      });
      return;
    }

    if (_selectedImage == null) {
      setState(() {
        _errorText = '상품 이미지를 선택해주세요.';
      });
      return;
    }

    setState(() {
      _errorText = null;
    });

    Navigator.pop(context, {
      'name': name,
      'price': price,
      'type': '신도', // 기본 타입 또는 선택값으로 바꿀 수 있음
      'image': _selectedImage!.path,
    });
  }

  Widget buildInput({
    required String hint,
    required TextEditingController controller,
    TextInputType? inputType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '장바구니 담기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Container(color: Colors.black), // Full black background
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 이미지 선택 영역
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey[600]!,
                            width: 2,
                          ),
                        ),
                        child: _selectedImage == null
                            ? const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '상품 이미지를 선택하세요',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (_errorText != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          _errorText!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    buildInput(hint: "상품명", controller: _nameController),
                    const SizedBox(height: 12),
                    buildInput(
                      hint: "가격 (₩)",
                      controller: _priceController,
                      inputType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    buildInput(
                      hint: "상품 설명 (선택)",
                      controller: _descriptionController,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _handleUpload,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          elevation: 5,
                          shadowColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          '상품 등록',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.black,
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
