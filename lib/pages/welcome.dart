import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:freshers/pages/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;
  late Animation<Color?> _colorAnimation3;

  List<List<Color>> _gradients = [
    [Colors.green.withOpacity(0.6), Colors.purple.withOpacity(0.6), Colors.blue.withOpacity(0.6)],
    [const Color.fromARGB(255, 244, 54, 200).withOpacity(0.6), Colors.orange.withOpacity(0.6), Colors.yellow.withOpacity(0.6)],
    [Color.fromARGB(255, 0, 236, 177).withOpacity(0.6), Color.fromARGB(255, 110, 6, 238).withOpacity(0.6), Colors.teal.withOpacity(0.6)],
  ];

  @override
  void initState() {
    super.initState();
    _setHasSeenWelcome();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat(reverse: true);
    _setupAnimations();
  }

  Future<void> _setHasSeenWelcome() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenWelcome', true);
  }

  void _setupAnimations() {
    _colorAnimation1 = ColorTween(
      begin: _gradients[0][0],
      end: _gradients[1][0],
    ).animate(_controller);
    _colorAnimation2 = ColorTween(
      begin: _gradients[0][1],
      end: _gradients[1][1],
    ).animate(_controller);
    _colorAnimation3 = ColorTween(
      begin: _gradients[0][2],
      end: _gradients[1][2],
    ).animate(_controller);

    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (_controller.status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Prevents going back to this page
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              // Background image
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  "lib/icons/loginImage.png",
                  fit: BoxFit.cover,
                ),
              ),
              // Gradient overlay with animation
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget? child) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            _colorAnimation1.value!,
                            _colorAnimation2.value!,
                            _colorAnimation3.value!,
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Content
              Column(
                children: [
                  Spacer(flex: 3),
                  FadeInDown(
                    delay: const Duration(milliseconds: 600),
                    duration: const Duration(milliseconds: 600),
                    child: Center(
                      child: Text(
                        "FRESHERSHub",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 700),
                    duration: const Duration(milliseconds: 800),
                    child: Text(
                      'Navigate Your Freshman Year with Ease!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Spacer(flex: 3),
                  FadeInUp(
                    delay: const Duration(milliseconds: 800),
                    duration: const Duration(milliseconds: 900),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Continue",
                          style: TextStyle(color: Colors.black.withAlpha(150)),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Color.fromARGB(255, 255, 255, 255).withAlpha(200),
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
