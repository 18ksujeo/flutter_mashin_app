import 'package:flutter/material.dart';
import 'package:flutter_mashin_app/home/logic/user_provider.dart';
import 'package:flutter_mashin_app/home/logic/user_profile.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPageScreen extends StatefulWidget {
  final UserProfile? profileToEdit;

  const MyPageScreen({super.key, this.profileToEdit});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProfile();
    });
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    _nameController.text = prefs.getString('name') ?? '';
    _roleController.text = prefs.getString('role') ?? '';
    _phoneController.text = prefs.getString('phone') ?? '';
    _bioController.text = prefs.getString('bio') ?? '';
    _imagePath = prefs.getString('imageUrl') ?? '';
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imagePath = picked.path;
      });
    }
  }

  void _saveProfile() async {
    final uuid = Uuid();
    final profile = UserProfile(
      id: widget.profileToEdit?.id ?? uuid.v4(),
      name: _nameController.text,
      role: _roleController.text,
      phone: _phoneController.text,
      bio: _bioController.text,
      imageUrl: _imagePath ?? '',
    );

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (widget.profileToEdit != null) {
      userProvider.replaceProfile(profile);
    } else {
      userProvider.addProfile(profile);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', profile.name);
    await prefs.setString('role', profile.role);
    await prefs.setString('phone', profile.phone);
    await prefs.setString('bio', profile.bio);
    await prefs.setString('imageUrl', profile.imageUrl);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('마이페이지'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white24,
                  backgroundImage: _imagePath != null ? FileImage(File(_imagePath!)) : null,
                  child: _imagePath == null
                      ? const Icon(Icons.add_a_photo, size: 30, color: Colors.white)
                      : null,
                ),
              ),
            ),
            SizedBox(height: 24),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: '이름',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _roleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: '역할',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: '전화번호',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _bioController,
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: '자기소개',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('프로필 저장'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
