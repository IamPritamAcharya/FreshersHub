import 'package:flutter/material.dart';
import 'package:freshers/pages/personaltips.dart';
import 'package:freshers/theme/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class CGPAApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SGPA Calculator',
          theme: themeProvider.themeData,
          home: SemesterSelectionPage(),
        );
      },
    );
  }
}

class SemesterSelectionPage extends StatefulWidget {
  @override
  _SemesterSelectionPageState createState() => _SemesterSelectionPageState();
}

class _SemesterSelectionPageState extends State<SemesterSelectionPage> {
  String? selectedSemester;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Center(
          child: Text(
            'SGPA Calculator', 
            style: GoogleFonts.ptSans(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            )
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "For theory courses, 60 marks come from the semester exams, 30 from internal exams, and 10 from assignments and attendance. Lab grading varies by lab. SGPA is calculated from both lab and theory grades. For more details, refer to the credit system below.",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, 
                    backgroundColor: Colors.deepPurple, 
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () async {
                    const url = 'https://drive.google.com/file/d/1MpOBukzyyM4qUGhZUt0MzV6gmhaA1ppB/view?usp=sharing';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Text('Credit System', style: GoogleFonts.poppins(fontSize: 13)),
                ),
              ),
              // Add the new Personal Tips button here
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, 
                    backgroundColor: Colors.green, 
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonalTipsPage(),
                      ),
                    );
                  },
                  child: Text('Personal Tips', style: GoogleFonts.poppins(fontSize: 13)),
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: Text(
                  'Select Your Semester:',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: DropdownButton<String>(
                  value: selectedSemester,
                  hint: Text('Choose Semester', style: GoogleFonts.poppins(fontSize: 16)),
                  onChanged: (newValue) {
                    setState(() {
                      selectedSemester = newValue;
                    });
                  },
                  items: ['First', 'Second'].map((semester) {
                    return DropdownMenuItem<String>(
                      value: semester,
                      child: Text(semester, style: GoogleFonts.poppins(fontSize: 16)),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.deepPurple, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 6,
                  ),
                  onPressed: () {
                    if (selectedSemester != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GradeOrMarksSelectionPage(
                            selectedSemester: selectedSemester!,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text('Next', style: GoogleFonts.poppins(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GradeOrMarksSelectionPage extends StatelessWidget {
  final String selectedSemester;

  GradeOrMarksSelectionPage({required this.selectedSemester});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Semester: $selectedSemester',
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                elevation: 5,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubjectInputPage(
                      selectedSemester: selectedSemester,
                      isGradeInput: false,
                    ),
                  ),
                );
              },
              child: Text('Enter Marks', style: GoogleFonts.poppins(fontSize: 16)),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                elevation: 5,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubjectInputPage(
                      selectedSemester: selectedSemester,
                      isGradeInput: true,
                    ),
                  ),
                );
              },
              child: Text('Enter Grades', style: GoogleFonts.poppins(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectInputPage extends StatefulWidget {
  final String selectedSemester;
  final bool isGradeInput;

  SubjectInputPage({required this.selectedSemester, this.isGradeInput = false});

  @override
  _SubjectInputPageState createState() => _SubjectInputPageState();
}

class _SubjectInputPageState extends State<SubjectInputPage> {
  final List<String> firstSemesterSubjects = [
    'Mathematics-I',
    'Physics/Chemistry',
    'Basic Electrical Engineering/Basic Electronics Engineering',
    'Basic Civil Engineering/Basic Mechanical Engineering',
    'Communicative English/Programming Language using C',
    'Physics Lab/Chemistry Lab',
    'Basic Electrical Engg. Lab/Basic Electronics Engg. Lab',
    'Basic Civil Engg. Lab/Basic Mechanical Engg. Lab',
    'Communicative English Lab/Programming Language using C Lab',
    'Engineering Graphics & Design Lab/Workshop Practice',
  ];

  final List<String> secondSemesterSubjects = [
    'Mathematics-II',
    'Chemistry/Physics',
    'Basic Electronics Engineering/Basic Electrical Engineering',
    'Basic Mechanical Engineering/Basic Civil Engineering',
    'Programming Language using C/Communicative English',
    'Engineering Mechanics',
    'Chemistry Lab/Physics Lab',
    'Basic Electronics Engg. Lab/Basic Electrical Engg. Lab',
    'Basic Mechanical Engg. Lab/Basic Civil Engg. Lab',
    'Programming Language using C Lab/Communicative English Lab',
    'Workshop Practice/Engineering Graphics & Design Lab',
  ];

  final List<int> firstSemesterCredits = [3, 3, 2, 2, 3, 2, 1, 1, 1, 2];
  final List<int> secondSemesterCredits = [3, 3, 2, 2, 3, 3, 2, 1, 1, 1, 2];

  late List<String> subjects;
  late List<int> subjectCredits;
  final Map<String, String?> subjectMarks = {};

  @override
  void initState() {
    super.initState();
    if (widget.selectedSemester == 'First') {
      subjects = firstSemesterSubjects;
      subjectCredits = firstSemesterCredits;
    } else {
      subjects = secondSemesterSubjects;
      subjectCredits = secondSemesterCredits;
    }
    for (var subject in subjects) {
      subjectMarks[subject] = widget.isGradeInput ? null : '0';
    }
  }

  double calculateSGPA(Map<String, String?> subjectMarks, List<int> subjectCredits) {
    double totalGradePoints = 0.0;
    int totalCredits = 0;

    subjectMarks.forEach((subject, mark) {
      if (mark != null && mark != '') {
        int gradePoints;
        if (widget.isGradeInput) {
          gradePoints = getGradePoints(mark);
        } else {
          int marks = int.parse(mark);
          gradePoints = getGradePointsFromMarks(marks);
        }
        int subjectCredit = subjectCredits[subjectMarks.keys.toList().indexOf(subject)];
        totalGradePoints += gradePoints * subjectCredit;
        totalCredits += subjectCredit;
      }
    });

    if (totalCredits == 0) return 0;

    double sgpa = totalGradePoints / totalCredits;

    return sgpa.clamp(0.0, 10.0); // Clamp the SGPA between 0 and 10
  }

  int getGradePoints(String grade) {
    switch (grade) {
      case 'O':
        return 10;
      case 'E':
        return 9;
      case 'A':
        return 8;
      case 'B':
        return 7;
      case 'C':
        return 6;
      case 'D':
        return 5;
      case 'F':
        return 0;
      default:
        return 0;
    }
  }

  int getGradePointsFromMarks(int marks) {
    if (marks >= 90) {
      return 10;
    } else if (marks >= 80) {
      return 9;
    } else if (marks >= 70) {
      return 8;
    } else if (marks >= 60) {
      return 7;
    } else if (marks >= 50) {
      return 6;
    } else if (marks >= 40) {
      return 5;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Input ${widget.isGradeInput ? 'Grades' : 'Marks'}',
          style: GoogleFonts.ptSans(),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            for (var subject in subjects)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        subject,
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                    SizedBox(width: 10),
                    widget.isGradeInput
                        ? DropdownButton<String>(
                            value: subjectMarks[subject],
                            hint: Text('Select Grade', style: GoogleFonts.poppins()),
                            onChanged: (newValue) {
                              setState(() {
                                subjectMarks[subject] = newValue;
                              });
                            },
                            items: ['O', 'E', 'A', 'B', 'C', 'D', 'F'].map((grade) {
                              return DropdownMenuItem<String>(
                                value: grade,
                                child: Text(grade, style: GoogleFonts.poppins()),
                              );
                            }).toList(),
                          )
                        : Container(
                            width: 50,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (newValue) {
                                setState(() {
                                  subjectMarks[subject] = newValue;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Marks',
                                hintStyle: GoogleFonts.poppins(),
                              ),
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                  ],
                ),
              ),
            SizedBox(height: 20),
            Center(
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  elevation: 5,
                ),
                onPressed: () {
                  double sgpa = calculateSGPA(subjectMarks, subjectCredits);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        'SGPA Calculated',
                        style: GoogleFonts.poppins(),
                      ),
                      content: Text(
                        'Your SGPA is: ${sgpa.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'OK',
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  'Calculate SGPA',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }

}
