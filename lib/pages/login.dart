import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:freshers/util/hidden_drawer.dart';
import 'package:iconly/iconly.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'info.dart'; // Import the info.dart file to update the username
import 'welcome.dart'; // Import the WelcomePage

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController usernameController = TextEditingController();
  final FocusNode focusNodeUsername = FocusNode();
  bool isFocusedUsername = false;
  String? selectedBranch;
  String? usernameError;

  late AnimationController _controller;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;
  late Animation<Color?> _colorAnimation3;

  final List<List<Color>> _gradients = [
    [Colors.green.withOpacity(0.6), Colors.purple.withOpacity(0.6), Colors.blue.withOpacity(0.6)],
    [const Color.fromARGB(255, 244, 54, 200).withOpacity(0.6), Colors.orange.withOpacity(0.6), Colors.yellow.withOpacity(0.6)],
    [Color.fromARGB(255, 0, 236, 177).withOpacity(0.6), Color.fromARGB(255, 110, 6, 238).withOpacity(0.6), Colors.teal.withOpacity(0.6)],
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
    _setupAnimations();
    focusNodeUsername.addListener(() {
      setState(() {
        isFocusedUsername = focusNodeUsername.hasFocus;
      });
    });
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

  void validateAndSignIn() async {
    if (usernameController.text.isEmpty) {
      setState(() {
        usernameError = 'Username is required';
      });
    } else {
      setState(() {
        usernameError = null;
      });
      updateUserName(usernameController.text);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', usernameController.text);
      await prefs.setBool('signedIn', true); // Set sign-in flag
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HiddenDrawer()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent resizing of the layout
      body: Stack(
        children: [
          // Gradient animation background
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
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5.h),
                          FadeInDown(
                            delay: const Duration(milliseconds: 300),
                            duration: const Duration(milliseconds: 500),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => WelcomePage()),
                                  (Route<dynamic> route) => false, // Remove all routes
                                );
                              },
                              icon: Icon(
                                IconlyBroken.arrow_left,
                                size: 3.6.h,
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          FadeInDown(
                            delay: const Duration(milliseconds: 200),
                            duration: const Duration(milliseconds: 400),
                            child: Text(
                              'Let\'s Sign You In',
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          FadeInDown(
                            delay: const Duration(milliseconds: 150),
                            duration: const Duration(milliseconds: 350),
                            child: Text(
                              'FRESHERSHub Awaits!',
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          FadeInDown(
                            delay: const Duration(milliseconds: 100),
                            duration: const Duration(milliseconds: 300),
                            child: const Text(
                              'Username',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          FadeInDown(
                            delay: const Duration(milliseconds: 50),
                            duration: const Duration(milliseconds: 250),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 0.8.h),
                              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: .3.h),
                              decoration: BoxDecoration(
                                color: isFocusedUsername ? Colors.white.withOpacity(0.5) : const Color(0xFFF1F0F5).withOpacity(0.5),
                                border: Border.all(width: 1, color: const Color(0xFFD2D2D4)),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  if (isFocusedUsername)
                                    BoxShadow(
                                      color: const Color(0xFF835DF1).withOpacity(.3),
                                      blurRadius: 4.0,
                                      spreadRadius: 2.0,
                                    ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    controller: usernameController,
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Your Username',
                                    ),
                                    focusNode: focusNodeUsername,
                                  ),
                                  if (usernameError != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        usernameError!,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          FadeInDown(
                            delay: const Duration(milliseconds: 0),
                            duration: const Duration(milliseconds: 200),
                            child: const Text(
                              'Branch',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          FadeInDown(
                            delay: const Duration(milliseconds: 0),
                            duration: const Duration(milliseconds: 200),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 0.8.h),
                              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: .3.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F0F5).withOpacity(0.5),
                                border: Border.all(width: 1, color: const Color(0xFFD2D2D4)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: selectedBranch,
                                hint: const Text('Select Branch'),
                                items: [
                                  'Computer Science',
                                  'Electronics And Telecommunication',
                                  'Civil',
                                  'Mechanical',
                                  'Electrical',
                                  'Chemical',
                                  'Production',
                                  'Metallurgy and Materials',
                                  'Other'
                                ].map((branch) {
                                  return DropdownMenuItem<String>(
                                    value: branch,
                                    child: Text(branch),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedBranch = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h), // Adjust this value for spacing
                          FadeInDown(
                            delay: const Duration(milliseconds: 0),
                            duration: const Duration(milliseconds: 200),
                            child: const Text(
                              'Note: Please refer to the tutorial in the About page to enable the chatbot.',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                              )
                            ),
                          ),
                          SizedBox(height: 5.h), // Adjust this value to move the button up or down
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    duration: const Duration(milliseconds: 500),
                    child: SizedBox(
                      width: double.infinity, // Set button width to match screen width
                      child: ElevatedButton(
                        onPressed: validateAndSignIn,
                        child: const Text('Get Started'),
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: const Color.fromARGB(255, 255, 255, 255).withAlpha(200),
                          foregroundColor: Colors.black.withAlpha(150),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
