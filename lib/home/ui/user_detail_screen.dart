import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mashin_app/home/logic/user_profile.dart';

class UserDetailScreen extends StatelessWidget {
  final UserProfile profile;

  const UserDetailScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(profile.name),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white24,
              backgroundImage:
                  profile.imageUrl.isNotEmpty ? FileImage(File(profile.imageUrl)) : null,
              child: profile.imageUrl.isEmpty
                  ? Text(profile.name[0], style: const TextStyle(color: Colors.white, fontSize: 40))
                  : null,
            ),
            const SizedBox(height: 24),
            Text(profile.name, style: const TextStyle(fontSize: 24, color: Colors.white)),
            const SizedBox(height: 8),
            Text(profile.role, style: const TextStyle(fontSize: 18, color: Colors.white70)),
            const SizedBox(height: 8),
            Text(profile.phone, style: const TextStyle(fontSize: 16, color: Colors.white60)),
            const SizedBox(height: 16),
            Text(
              profile.bio,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
