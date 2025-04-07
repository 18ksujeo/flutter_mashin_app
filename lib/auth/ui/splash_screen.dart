import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    _controller = VideoPlayerController.asset('assets/images/chunma.mov');

    try {
      await _controller.initialize();
      setState(() {}); // 영상 초기화 후 화면 갱신
      _controller.play();
      debugPrint('🎬 영상 재생 시작');

      _controller.addListener(() {
        if (_controller.value.isInitialized &&
            _controller.value.position >= _controller.value.duration &&
            !_navigated) {
          _navigated = true;
          debugPrint('✅ 영상 종료 → 로그인 화면으로 이동');
          _goToLogin();
        }
      });
    } catch (e) {
      debugPrint('❌ 영상 로딩 실패 → 로그인 화면으로 바로 이동');
      _goToLogin();
    }
  }

  void _goToLogin() {
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_goToLogin);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
          _controller.value.isInitialized
              ? Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              )
              : const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
    );
  }
}
