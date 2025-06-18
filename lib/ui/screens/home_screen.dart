import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/theme/theme_bloc.dart';
import '../../blocs/theme/theme_event.dart';
import 'projects_screen.dart';
import 'skills_screen.dart';
import 'github_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isWeb = screenWidth > 600; // Treat as web if width > 600px

    return Scaffold(
      appBar: AppBar(
        title: const Text('PortfolioSync'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleThemeEvent());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Responsive profile image
              CircleAvatar(
                radius: isWeb ? 80 : 60,
                backgroundImage: const NetworkImage(
                  'https://avatars.githubusercontent.com/Yordanos-Samson',
                ),
              ),
              SizedBox(height: isWeb ? 30 : 20),
              Text(
                'Yordanos Samson',
                style: TextStyle(
                  fontSize: isWeb ? 32 : 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Senior Flutter Developer',
                style: TextStyle(fontSize: isWeb ? 20 : 16, color: Colors.grey),
              ),
              SizedBox(height: isWeb ? 40 : 30),
              // Navigation buttons
              SizedBox(
                width: isWeb ? 400 : screenWidth * 0.8, // Limit width on web
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProjectsScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, isWeb ? 60 : 50),
                      ),
                      child: Text(
                        'View Projects',
                        style: TextStyle(fontSize: isWeb ? 18 : 16),
                      ),
                    ),
                    SizedBox(height: isWeb ? 20 : 15),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SkillsScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, isWeb ? 60 : 50),
                      ),
                      child: Text(
                        'View Skills',
                        style: TextStyle(fontSize: isWeb ? 18 : 16),
                      ),
                    ),
                    SizedBox(height: isWeb ? 20 : 15),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GithubScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, isWeb ? 60 : 50),
                      ),
                      child: Text(
                        'View GitHub Repos',
                        style: TextStyle(fontSize: isWeb ? 18 : 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: isWeb ? 40 : 30),
            ],
          ),
        ),
      ),
    );
  }
}
