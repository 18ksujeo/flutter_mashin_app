import 'package:flutter/material.dart';
import 'package:flutter_mashin_app/home/logic/user_provider.dart';
import 'package:flutter_mashin_app/home/ui/home_screen.dart';
import 'package:flutter_mashin_app/home/widgets/menu_bar.dart';
import 'package:provider/provider.dart';
import 'auth/logic/auth_provider.dart';


// ⚠️ 클래스 이름 충돌 방지: splash_screen.dart에 정의된 SplashScreen만 import
import 'auth/ui/splash_screen.dart';
import 'auth/ui/signup_screen.dart';

// 💡 만약 login_screen.dart에도 SplashScreen이 있다면 다음과 같이 prefix 붙이기
import 'auth/ui/login_screen.dart' as login;

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()), // ✅ 추가된 Provider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '마교 쇼핑몰',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(), // ✅ 변경된 초기 경로
        '/login': (context) => const login.LoginScreen(), // ✅ prefix 사용
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const MenuScaffold(), // ✅ 변경된 /home 경로
      },
    );
  }
}
