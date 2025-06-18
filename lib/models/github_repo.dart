class GithubRepo {
  final String name;
  final String description;
  final String url;
  final int stars;

  GithubRepo({
    required this.name,
    required this.description,
    required this.url,
    required this.stars,
  });

  factory GithubRepo.fromJson(Map<String, dynamic> json) {
    return GithubRepo(
      name: json['name'] ?? '',
      description: json['description'] ?? 'No description',
      url: json['html_url'] ?? '',
      stars: json['stargazers_count'] ?? 0,
    );
  }
}
