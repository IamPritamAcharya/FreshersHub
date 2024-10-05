import 'package:flutter/material.dart';

class SmartDeviceBox extends StatelessWidget {
  final String smartDeviceName;
  final IconData iconData;
  final bool powerOn;
  final Widget page;

  const SmartDeviceBox({
    super.key,
    required this.smartDeviceName,
    required this.iconData,
    required this.powerOn,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0), // Reduced padding
        child: Container(
          width: 115, // Specify a fixed width for each item
          height: 115, // Specify a fixed height for each item
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(40), // Adjusted border radius
          ),
          padding: const EdgeInsets.symmetric(vertical: 15), // Reduced padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // icon
              Icon(
                iconData,
                size: 60, // Reduced icon size
                color: Theme.of(context).colorScheme.surface,
              ),
              // smart device name
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0), // Adjusted padding
                      child: Text(
                        smartDeviceName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17, // Reduced font size
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
