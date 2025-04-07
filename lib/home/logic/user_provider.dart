import 'package:flutter/material.dart';
import 'package:flutter_mashin_app/home/logic/user_profile.dart';

class UserProvider with ChangeNotifier {
  final List<UserProfile> _profiles = [];

  List<UserProfile> get profiles => _profiles;

  void addProfile(UserProfile profile) {
    _profiles.add(profile);
    notifyListeners();
  }

  void removeProfile(int index) {
    _profiles.removeAt(index);
    notifyListeners();
  }

  void replaceProfile(UserProfile updatedProfile) {
    final index = _profiles.indexWhere((p) => p.id == updatedProfile.id);
    if (index != -1) {
      _profiles[index] = updatedProfile;
      notifyListeners();
    }
  }
}