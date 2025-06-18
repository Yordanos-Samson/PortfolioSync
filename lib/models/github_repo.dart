class GithubRepo {
  final String name;
  final String description;
  final String url;
  final int stars;
  final String? language;
  final List<String> topics;

  GithubRepo({
    required this.name,
    required this.description,
    required this.url,
    required this.stars,
    this.language,
    required this.topics,
  });

  factory GithubRepo.fromJson(Map<String, dynamic> json) {
    return GithubRepo(
      name: json['name'] ?? 'Unknown Repository',
      description: json['description'] ?? 'No description available',
      url: json['html_url'] ?? '',
      stars: json['stargazers_count'] ?? 0,
      language: json['language'], // This can be null, so we handle it properly
      topics:
          json['topics'] != null
              ? List<String>.from(json['topics'])
              : <String>[],
    );
  }
}
