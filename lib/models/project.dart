class Project {
  final String title;
  final String description;
  final String techStack;
  final String? githubUrl;

  Project({
    required this.title,
    required this.description,
    required this.techStack,
    this.githubUrl,
  });
}
