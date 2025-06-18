import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/github_repo.dart';

class GithubService {
  Future<List<GithubRepo>> fetchRepos(String username) async {
    final response = await http.get(
      Uri.parse('https://api.github.com/users/$username/repos'),
      headers: {'Accept': 'application/vnd.github.v3+json'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => GithubRepo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load repositories');
    }
  }
}
