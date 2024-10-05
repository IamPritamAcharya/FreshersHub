import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class PersonalTipsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Personal Tips',
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'These aren’t just generic tips; they’re lessons I learned during my first year.',
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildTip('1. Don’t Focus Too Much on CGPA/SGPA', 
              'Try to aim for a score above 8.5 or 9. Some teachers will give you marks easily, while others may cut marks for no apparent reason. Study on the side because that’s what’s going to help you in the long run.'),
            SizedBox(height: 10),
            _buildTip('2. Connections Matter', 
              'Having a good connection with your teachers can greatly benefit you. Make sure your branch representatives also have strong connections with them. Attend classes regularly and complete assignments on time, as it may benefit you later.'),
            SizedBox(height: 10),
            _buildTip('3. Notes and Previous Years’ Questions Are Key', 
              'Most questions will come from your notes and previous years’ question papers, so study them carefully if SGPA matters to you.'),
            SizedBox(height: 10),
            _buildTip('4. Use Your Free Time Wisely', 
              'You’ll have a lot of free time. Use it to learn and explore rather than wasting it. You might regret it later.'),
            SizedBox(height: 10),
            _buildTip('5. Participate in Clubs', 
              'Joining clubs can be a great way to meet new people and develop skills outside of academics. Engaging in club activities can also help you build a network and make the most of your college experience.'),
            SizedBox(height: 10),
            _buildTip('6. Choose Your Friends Carefully', 
              'In your first semester, you’ll meet many new people, but by the 2nd or 3rd semester, you’ll understand whom to trust.'),
            SizedBox(height: 10),
            _buildTip('7. Be Civil and Respectful', 
              'Don’t disrespect your seniors. Talk to them nicely, and they’ll do the same. Those who don’t might not be good people to be around.'),
            SizedBox(height: 10),
            _buildTip('8. Don’t Judge Too Quickly', 
              'Don’t judge anyone unless you’ve talked to them yourself. Avoid making decisions based solely on what others say.'),
            SizedBox(height: 10),
            _buildTip('9. Be Diplomatic', 
              'Rather than choosing sides, you’re better off being a diplomat here. It can help you navigate various social dynamics.'),
            _buildTip('10. Enjoy College, But Stay Balanced', 
              'Make the most of your college life—it’s a time you’ll never get back. But remember, balance is key. While it’s important to have fun, don’t neglect your studies. Don’t expect good placements from here, so work hard towards your goals.'),
            SizedBox(height: 10),
            _buildTip('11. Value Trust and Integrity', 
              'Never break anyone’s trust or use people for your own benefit. Trust is one of the most valuable things you can lose, and compromising it is one of the worst things you can do as a human being.'),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTip(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          description,
          style: GoogleFonts.poppins(fontSize: 14),
        ),
      ],
    );
  }
}
