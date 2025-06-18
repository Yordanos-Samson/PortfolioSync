import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFService {
  // CV Data
  static const String personalInfo = '''
YORDANOS SAMSON
Email: developerjb72@gmail.com
GitHub: github.com/Yordanos-Samson
LinkedIn: linkedin.com/in/yordanos-samson
Address: Betel, Addis Ababa, Ethiopia
Phone: +251944082479
''';

  static const String summary = '''
A passionate Flutter developer from Ethiopia, dedicated to crafting efficient and high-quality mobile applications. With experience in building cross-platform apps using Flutter and Android Studio, I am committed to staying updated on the latest technologies to bring innovation and functionality to every project. My path profile also includes projects in web development and programming languages such as Python and C++, showcasing my versatility and eagerness to learn. I have hands-on experience integrating backend technologies like PostgreSQL, Firebase, Supabase, and RESTful APIs, ensuring seamless user experiences across Android and iOS platforms.
''';

  // Academic Transcript Data
  static const List<Map<String, String>> academicCourses = [
    // Year 1 - Semester 1
    {
      'code': 'Psyc1011',
      'name': 'General Psychology',
      'credits': '5',
      'type': 'Common Course',
      'year': 'Year 1 - Semester 1',
    },
    {
      'code': 'Math1011',
      'name': 'Mathematics for Natural Sciences',
      'credits': '5',
      'type': 'Common Course',
      'year': 'Year 1 - Semester 1',
    },
    {
      'code': 'GeES1011',
      'name': 'Geography of Ethiopia and the Horn',
      'credits': '5',
      'type': 'Common Course',
      'year': 'Year 1 - Semester 1',
    },
    {
      'code': 'Phys1011',
      'name': 'General Physics',
      'credits': '5',
      'type': 'Common Course',
      'year': 'Year 1 - Semester 1',
    },
    {
      'code': 'LoCT1011',
      'name': 'Critical Thinking',
      'credits': '5',
      'type': 'Common Course',
      'year': 'Year 1 - Semester 1',
    },
    {
      'code': 'SpSc1011',
      'name': 'Physical Fitness',
      'credits': '0',
      'type': 'Common Course',
      'year': 'Year 1 - Semester 1',
    },
    {
      'code': 'FLEn1011',
      'name': 'Communicative English Language Skills I',
      'credits': '5',
      'type': 'Common Course',
      'year': 'Year 1 - Semester 1',
    },

    // Year 1 - Semester 2
    {
      'code': 'Math1041',
      'name': 'Applied Mathematics I',
      'credits': '6',
      'type': 'Common Course',
      'year': 'Year 1 - Semester 2',
    },
    {
      'code': 'EmTe1012',
      'name': 'Introduction to Emerging Technologies',
      'credits': '5',
      'type': 'Common Course',
      'year': 'Year 1 - Semester 2',
    },
    {
      'code': 'GlTr1012',
      'name': 'Global Trends',
      'credits': '4',
      'type': 'Common Course',
      'year': 'Year 1 - Semester 2',
    },
    {
      'code': 'Anth1012',
      'name': 'Social Anthropology',
      'credits': '4',
      'type': 'Common Course',
      'year': 'Year 1 - Semester 2',
    },
    {
      'code': 'FLEn1012',
      'name': 'Communicative English Language Skills II',
      'credits': '5',
      'type': 'Common Course',
      'year': 'Year 1 - Semester 2',
    },
    {
      'code': 'ECEg1052',
      'name': 'Computer Programming',
      'credits': '5',
      'type': 'Common Course',
      'year': 'Year 1 - Semester 2',
    },
    {
      'code': 'MCiE1012',
      'name': 'Moral and Civic Education',
      'credits': '4',
      'type': 'Common Course',
      'year': 'Year 1 - Semester 2',
    },

    // Year 2 - Semester 1
    {
      'code': 'Incl2011',
      'name': 'Inclusiveness',
      'credits': '4',
      'type': 'Common Course',
      'year': 'Year 2 - Semester 1',
    },
    {
      'code': 'InSy2021',
      'name': 'Introduction to Information Systems and Society',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 2 - Semester 1',
    },
    {
      'code': 'InSy2061',
      'name': 'Fundamentals of System Analysis and Design',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 2 - Semester 1',
    },
    {
      'code': 'MgMt2025',
      'name': 'Introduction to Management',
      'credits': '4',
      'type': 'Supporting Course',
      'year': 'Year 2 - Semester 1',
    },
    {
      'code': 'InSy2031',
      'name': 'Fundamentals of programming II',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 2 - Semester 1',
    },
    {
      'code': 'Math2031',
      'name': 'Discrete Mathematics and Combinatory',
      'credits': '4',
      'type': 'Common Course',
      'year': 'Year 2 - Semester 1',
    },
    {
      'code': 'Econ2013',
      'name': 'Economics',
      'credits': '5',
      'type': 'Common Course',
      'year': 'Year 2 - Semester 1',
    },

    // Year 3 - Semester 1
    {
      'code': 'InSy3101',
      'name': 'Introduction to Artificial Intelligence',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 3 - Semester 1',
    },
    {
      'code': 'InSy3061',
      'name': 'Research Methods in Information Systems',
      'credits': '3',
      'type': 'Supporting Course',
      'year': 'Year 3 - Semester 1',
    },
    {
      'code': 'InSy3043',
      'name': 'Event Driven Programming',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 3 - Semester 1',
    },
    {
      'code': 'InSy3041',
      'name': 'Data Structures and Algorithms',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 3 - Semester 1',
    },
    {
      'code': 'InSy3051',
      'name': 'Operating Systems',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 3 - Semester 1',
    },
    {
      'code': 'InSy3071',
      'name': 'Advanced Database Systems',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 3 - Semester 1',
    },
    {
      'code': 'InSy3091',
      'name': 'Internet Programming',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 3 - Semester 1',
    },

    // Year 3 - Semester 2
    {
      'code': 'InSy3072',
      'name': 'Introduction to Information Storage and Retrieval',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 3 - Semester 2',
    },
    {
      'code': 'InSy3124',
      'name': 'Mobile Application Development',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 3 - Semester 2',
    },
    {
      'code': 'InSy3122',
      'name': 'Multimedia Information Systems',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 3 - Semester 2',
    },
    {
      'code': 'InSy3112',
      'name': 'Information Systems Project Management',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 3 - Semester 2',
    },
    {
      'code': 'InSy3102',
      'name': 'Expert Systems',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 3 - Semester 2',
    },
    {
      'code': 'InSy3114',
      'name': 'Enterprise Systems',
      'credits': '4',
      'type': 'Major Course',
      'year': 'Year 3 - Semester 2',
    },
    {
      'code': 'InSy3082',
      'name': 'System and Network Administration',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 3 - Semester 2',
    },

    // Year 4 - Semester 1
    {
      'code': 'InSy4101',
      'name': 'Data Mining and Warehousing',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 4 - Semester 1',
    },
    {
      'code': 'InSy4081',
      'name': 'Information System Security',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 4 - Semester 1',
    },
    {
      'code': 'InSy4123',
      'name': 'Human Computer Interaction',
      'credits': '3',
      'type': 'Major Course',
      'year': 'Year 4 - Semester 1',
    },
    {
      'code': 'InSy4133',
      'name': 'Final Year Project I',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 4 - Semester 1',
    },
    {
      'code': 'Hist1012',
      'name': 'History of Ethiopia and the Horn',
      'credits': '5',
      'type': 'Common Course',
      'year': 'Year 4 - Semester 1',
    },
    {
      'code': 'InSy4103',
      'name': 'Knowledge Management',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 4 - Semester 1',
    },
    {
      'code': 'InSy4131',
      'name': 'Internship',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 4 - Semester 1',
    },

    // Year 4 - Semester 2
    {
      'code': 'InSy4112',
      'name': 'Management of Information Systems and Services',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 4 - Semester 2',
    },
    {
      'code': 'InSy4142',
      'name': 'Computer Maintenance and Troubleshooting',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 4 - Semester 2',
    },
    {
      'code': 'InSy4143',
      'name': 'E-Commerce',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 4 - Semester 2',
    },
    {
      'code': 'InSy4144',
      'name': 'Geographical Information System (GIS) and Remote Sensing',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 4 - Semester 2',
    },
    {
      'code': 'InSy4145',
      'name': 'Wireless Networking',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 4 - Semester 2',
    },
    {
      'code': 'MgMt4012',
      'name': 'Entrepreneurship',
      'credits': '4',
      'type': 'Common Course',
      'year': 'Year 4 - Semester 2',
    },
    {
      'code': 'InSy4134',
      'name': 'Seminar in Information System',
      'credits': '1',
      'type': 'Major Course',
      'year': 'Year 4 - Semester 2',
    },
    {
      'code': 'MgMt4114',
      'name': 'Organizational Behavior',
      'credits': '4',
      'type': 'Major Course',
      'year': 'Year 4 - Semester 2',
    },
    {
      'code': 'InSy4132',
      'name': 'Final Year Project II',
      'credits': '5',
      'type': 'Major Course',
      'year': 'Year 4 - Semester 2',
    },
  ];

  static Future<void> downloadCV(BuildContext context) async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => const AlertDialog(
              content: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16),
                  Text('Generating CV PDF...'),
                ],
              ),
            ),
      );

      // Generate PDF
      final pdf = await _generateCVPDF();

      // Close loading dialog
      Navigator.of(context).pop();

      // Download the file
      _downloadFile(pdf, 'Yordanos_Samson_CV.pdf');

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 16),
              Text('CV downloaded successfully!'),
            ],
          ),
          backgroundColor: Color(0xFF059669),
        ),
      );
    } catch (e) {
      // Close loading dialog if open
      Navigator.of(context).pop();
      rethrow;
    }
  }

  static Future<void> downloadTranscript(BuildContext context) async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => const AlertDialog(
              content: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16),
                  Text('Generating Academic Transcript PDF...'),
                ],
              ),
            ),
      );

      // Generate PDF
      final pdf = await _generateTranscriptPDF();

      // Close loading dialog
      Navigator.of(context).pop();

      // Download the file
      _downloadFile(pdf, 'Yordanos_Samson_Academic_Transcript.pdf');

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 16),
              Text('Academic Transcript downloaded successfully!'),
            ],
          ),
          backgroundColor: Color(0xFF059669),
        ),
      );
    } catch (e) {
      // Close loading dialog if open
      Navigator.of(context).pop();
      rethrow;
    }
  }

  static Future<Uint8List> _generateCVPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            // Header
            pw.Container(
              padding: const pw.EdgeInsets.only(bottom: 20),
              decoration: const pw.BoxDecoration(
                border: pw.Border(bottom: pw.BorderSide(width: 2)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'YORDANOS SAMSON',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    'Dedicated Flutter Developer | Cross-Platform Solution Architect',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 12),
                  pw.Text('Email: developerjb72@gmail.com'),
                  pw.Text('GitHub: github.com/Yordanos-Samson'),
                  pw.Text('LinkedIn: linkedin.com/in/yordanos-samson'),
                  pw.Text('Address: Betel, Addis Ababa, Ethiopia'),
                  pw.Text('Phone: +251944082479'),
                ],
              ),
            ),

            pw.SizedBox(height: 20),

            // Summary
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'PROFESSIONAL SUMMARY',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  summary,
                  style: const pw.TextStyle(fontSize: 12),
                  textAlign: pw.TextAlign.justify,
                ),
              ],
            ),

            pw.SizedBox(height: 20),

            // Work Experience
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'WORK EXPERIENCE',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'Internship at Information Network Security Agency (INSA)',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  'Jul 2024 - Oct 2024',
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.SizedBox(height: 4),
                pw.Bullet(
                  text:
                      'Developed a Credential Verification App using Flutter, PostgreSQL, and Dart Frog',
                ),
                pw.Bullet(
                  text:
                      'Implemented QR code scanning for secure credential verification',
                ),
                pw.Bullet(
                  text:
                      'Integrated API backend for secure data storage and retrieval',
                ),
                pw.Bullet(
                  text: 'Utilized JSON parsing for handling credentials',
                ),
              ],
            ),

            pw.SizedBox(height: 20),

            // Education
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'EDUCATION',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'Bachelor of Information Systems',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  'University of Bahir Dar • May 2022 - Jun 2025',
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.Text(
                  'Final Year Student',
                  style: const pw.TextStyle(fontSize: 12),
                ),
              ],
            ),

            pw.SizedBox(height: 20),

            // Technical Skills
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'TECHNICAL SKILLS',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Bullet(
                  text:
                      'Programming Languages: Dart, C++, C#, Python, JavaScript, Prolog',
                ),
                pw.Bullet(text: 'Mobile Development: Flutter, Android Studio'),
                pw.Bullet(
                  text: 'Web Development: HTML, CSS, React, Vite, Node.js',
                ),
                pw.Bullet(
                  text:
                      'Databases: PostgreSQL, Microsoft SQL Server, Firebase, Supabase',
                ),
                pw.Bullet(text: 'Tools: Git, Linux, REST APIs'),
                pw.Bullet(
                  text:
                      'Specialized: Algorithm Design, System Analysis, Data Structures',
                ),
              ],
            ),

            pw.SizedBox(height: 20),

            // Projects
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'KEY PROJECTS',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Bullet(
                  text:
                      'CareSync Healthcare Platform - Full-stack healthcare system (Final Year Project)',
                ),
                pw.Bullet(
                  text:
                      'Mood-based Music Recommender using Google\'s Gemini API',
                ),
                pw.Bullet(text: 'C++ Management Systems Collection'),
                pw.Bullet(text: 'E-commerce Website using React and Node.js'),
                pw.Bullet(text: 'Python Console Quiz Application'),
              ],
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  static Future<Uint8List> _generateTranscriptPDF() async {
    final pdf = pw.Document();

    // Group courses by year
    final Map<String, List<Map<String, String>>> coursesByYear = {};
    for (final course in academicCourses) {
      final year = course['year']!;
      if (!coursesByYear.containsKey(year)) {
        coursesByYear[year] = [];
      }
      coursesByYear[year]!.add(course);
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            // Header
            pw.Container(
              padding: const pw.EdgeInsets.only(bottom: 20),
              decoration: const pw.BoxDecoration(
                border: pw.Border(bottom: pw.BorderSide(width: 2)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text(
                    'ACADEMIC TRANSCRIPT',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    'YORDANOS SAMSON',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text('Bachelor of Information Systems'),
                  pw.Text('University of Bahir Dar'),
                  pw.Text('May 2022 - Jun 2025'),
                ],
              ),
            ),

            pw.SizedBox(height: 20),

            // Courses by year
            ...coursesByYear.entries.map((entry) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    entry.key,
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Table(
                    border: pw.TableBorder.all(),
                    columnWidths: {
                      0: const pw.FixedColumnWidth(80),
                      1: const pw.FlexColumnWidth(3),
                      2: const pw.FixedColumnWidth(50),
                      3: const pw.FlexColumnWidth(1.5),
                    },
                    children: [
                      // Header row
                      pw.TableRow(
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.grey300,
                        ),
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text(
                              'Code',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text(
                              'Course Name',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text(
                              'Credits',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text(
                              'Type',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Course rows
                      ...entry.value.map((course) {
                        return pw.TableRow(
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(4),
                              child: pw.Text(
                                course['code']!,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(4),
                              child: pw.Text(
                                course['name']!,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(4),
                              child: pw.Text(
                                course['credits']!,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(4),
                              child: pw.Text(
                                course['type']!,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                  pw.SizedBox(height: 16),
                ],
              );
            }).toList(),
          ];
        },
      ),
    );

    return pdf.save();
  }

  static void _downloadFile(Uint8List bytes, String fileName) {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor =
        html.document.createElement('a') as html.AnchorElement
          ..href = url
          ..style.display = 'none'
          ..download = fileName;
    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}
