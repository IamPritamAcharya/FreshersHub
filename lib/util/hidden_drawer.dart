import 'package:flutter/material.dart';
import 'package:freshers/pages/aiChat.dart';
import 'package:freshers/pages/cgpa.dart';
import 'package:freshers/pages/quickLinks.dart';
import 'package:freshers/pages/roadmap.dart';
import 'package:freshers/pages/travelGuide.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:freshers/pages/aboutMe.dart';
import 'package:freshers/pages/mainNavigation.dart';
import 'package:freshers/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:freshers/theme/theme2.dart';  // Import the theme2

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];
  int _currentIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final myTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Theme.of(context).colorScheme.primary.withAlpha(80),
    );
    final myTextStyle1 = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Theme.of(context).colorScheme.primary,
    );

    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Home",
          baseStyle: myTextStyle,
          selectedStyle: myTextStyle1,
          colorLineSelected: Theme.of(context).colorScheme.primary,
          onTap: () {
            setState(() {
              _currentIndex = 0;
            });
          },
        ),
        MainNavigation(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "About",
          baseStyle: myTextStyle,
          selectedStyle: myTextStyle1,
          colorLineSelected: Theme.of(context).colorScheme.primary,
          onTap: () {
            setState(() {
              _currentIndex = 1;
            });
          },
        ),
        AboutMe(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "AI Chatbot",
          baseStyle: myTextStyle,
          selectedStyle: myTextStyle1,
          colorLineSelected: Theme.of(context).colorScheme.primary,
          onTap: () {
            setState(() {
              _currentIndex = 2;
            });
          },
        ),
        AiChat(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Roadmaps",
          baseStyle: myTextStyle,
          selectedStyle: myTextStyle1,
          colorLineSelected: Theme.of(context).colorScheme.primary,
          onTap: () {
            setState(() {
              _currentIndex = 3; // Fixed index here
            });
          },
        ),
        RoadmapPage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Amenities",
          baseStyle: myTextStyle,
          selectedStyle: myTextStyle1,
          colorLineSelected: Theme.of(context).colorScheme.primary,
          onTap: () {
            setState(() {
              _currentIndex = 4; // Fixed index here
            });
          },
        ),
        TravelPage()
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Quick Links",
          baseStyle: myTextStyle,
          selectedStyle: myTextStyle1,
          colorLineSelected: Theme.of(context).colorScheme.primary,
          onTap: () {
            setState(() {
              _currentIndex = 5; // Fixed index here
            });
          },
        ),
        QuickLinksPage()
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "SGPA",
          baseStyle: myTextStyle,
          selectedStyle: myTextStyle1,
          colorLineSelected: Theme.of(context).colorScheme.primary,
          onTap: () {
            setState(() {
              _currentIndex = 6; // Fixed index here
            });
          },
        ),
        CGPAApp()
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isTheme2 = Theme.of(context).colorScheme.surface == theme2.colorScheme.surface;
    final appBarBackgroundColor = (_currentIndex == 3)
        ? Color.fromARGB(255, 25, 12, 40)
        : Theme.of(context).colorScheme.surface;

    final themeChangerColor = (_currentIndex == 3) ? Colors.purple.shade400: Theme.of(context).colorScheme.primary;

    return HiddenDrawerMenu(
      elevationAppBar: 0,
      withAutoTittleName: false,
      leadingAppBar: Image.asset(
        'lib/icons/menu.png',
        height: 45,
        color: (_currentIndex == 3) ? Colors.purple.shade400 : Theme.of(context).colorScheme.primary,
      ),
      backgroundColorMenu: Theme.of(context).colorScheme.surface,
      screens: _pages,
      initPositionSelected: 0,
      slidePercent: 40,
      contentCornerRadius: 30,
      enableScaleAnimation: true,
      enableCornerAnimation: true,
      backgroundColorAppBar: appBarBackgroundColor,
      withShadow: true,
      actionsAppBar: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: IconButton(
            icon: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: themeChangerColor,
                  size: 40,
                );
              },
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ),
      ],
    );
  }
}
