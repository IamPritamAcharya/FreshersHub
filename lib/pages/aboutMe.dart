import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'info.dart';

class AboutMe extends StatefulWidget {
  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> with SingleTickerProviderStateMixin {
  final String imageUrl =
      'lib/icons/background.png'; // Replace with your actual image path
  final String youtubeUrl =
      'https://youtube.com/shorts/ot-qgxr5qLk?feature=share'; // Replace with your actual YouTube video URL

  // Social links
  final String instagramUrl =
      'https://www.instagram.com/pritam.ach/'; // Replace with your actual Instagram URL
  final String linkedinUrl =
      'https://www.linkedin.com/in/pritamacharya/'; // Replace with your actual LinkedIn URL
  final String gmailUrl =
      'mailto:pritamach.exe@gmail.com'; // Replace with your actual Gmail URL

  late AnimationController _controller;
  TextEditingController _apiKeyController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat(reverse: true);
    _loadApiKey();
    _loadUserName();
  }

  @override
  void dispose() {
    _controller.dispose();
    _apiKeyController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  Future<void> _loadApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      api_key_input = prefs.getString('api_key_input') ?? '';
      _apiKeyController.text = api_key_input;
    });
    _updateUrl();
  }

  Future<void> _saveApiKey(String apiKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('api_key_input', apiKey);
    setState(() {
      api_key_input = apiKey;
    });
    _updateUrl();
  }

  void _updateUrl() {
    updateUrl();
    // This will update the URL whenever the API key is changed
    print(oururl);
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_name_input = prefs.getString('user_name_input') ?? '';
      _userNameController.text = user_name_input;
    });
  }

  Future<void> _saveUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name_input', userName);
    setState(() {
      user_name_input = userName;
    });
    updateUserName(userName);
    // Print the updated username
    print(user_name_input);
  }

  Future<void> _launchURL(String url) async {
    if (!await launch(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0), // Padding around the image
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(20), // Rounded corners
                      child: Stack(
                        children: [
                          Container(
                            height:
                                260, // Adjusted height for the image and gradient
                            width: double.infinity,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(1),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage(imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (BuildContext context, Widget? child) {
                              return Container(
                                height:
                                    260, // Adjusted height for the gradient container
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment
                                        .bottomCenter, // Start from bottom
                                    end: Alignment.topCenter, // End at top
                                    colors: [
                                      ColorTween(
                                              begin: Colors.blue,
                                              end: Colors.green)
                                          .animate(_controller)
                                          .value!
                                          .withOpacity(0.7),
                                      Colors.transparent,
                                    ],
                                    stops: [0.0, 1.0],
                                  ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 10,
                            left: 20,
                            right: 20,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Developed by',
                                    style: GoogleFonts.lato(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Pritam Acharya',
                                    style: GoogleFonts.lato(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '16th CSE (2023-27)',
                                        style: GoogleFonts.lato(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Image.asset(
                                              'lib/icons/assets/instagram.png',
                                              height: 20,
                                            ),
                                            iconSize: 20,
                                            onPressed: () =>
                                                _launchURL(instagramUrl),
                                          ),
                                          IconButton(
                                            icon: Image.asset(
                                              'lib/icons/assets/linkedin.png',
                                              height: 20,
                                            ),
                                            iconSize: 20,
                                            onPressed: () =>
                                                _launchURL(linkedinUrl),
                                          ),
                                          IconButton(
                                            icon: Image.asset(
                                              'lib/icons/assets/gmail.png',
                                              height: 20,
                                            ),
                                            iconSize: 20,
                                            onPressed: () =>
                                                _launchURL(gmailUrl),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (BuildContext context, Widget? child) {
                        return Center(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  ColorTween(
                                          begin: Colors.pink, end: Colors.green)
                                      .animate(_controller)
                                      .value!,
                                  Colors.blue,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Additional Info:',
                                  style: GoogleFonts.lato(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                    '''Hey there! 🎉 To see your favorite books updated in the Favorites section, just pull down from the top to refresh. It took a month and 5000+ lines of code to build this app while I was still interning, so there might be a few bugs or things I missed.

Big thanks to Jyotirmayee Sahoo, Subhasmita Nayak, Smrutirekha Moharana, Arif Hussain, Aadil Ahmad, our seniors, and everyone else who contributed their files!

To use the chatbot, please enter the API key below.''',
                                    style: GoogleFonts.lato()),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 35),
                    Center(
                      child: TextField(
                        controller: _apiKeyController,
                        onChanged: (value) {
                          _saveApiKey(value);
                        },
                        decoration: InputDecoration(
                          labelText: 'API Key',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: TextField(
                        controller: _userNameController,
                        onChanged: (value) {
                          _saveUserName(value);
                        },
                        decoration: InputDecoration(
                          labelText: 'Change User Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Text(
                        'You need to input the API key to use the chatbot.',
                        style: GoogleFonts.lato(
                            fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => _launchURL(youtubeUrl),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.teal,
                        ),
                        child: Text('Tutorial to get the API key',
                            style: GoogleFonts.lato()),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}
