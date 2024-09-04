import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/constants/secret.dart';
import 'package:news_app/model/article.dart';

class ArticleProvider extends ChangeNotifier {
  final List<Article> _articles = [];
  bool _isLoading = false;
  final String _apiKey = SecretKey.apiKey;
  int _categoryIndex = 1;

  int get categoryIndex => _categoryIndex;
  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;

  /// Fetch articles from the server and update the list
  Future<void> fetchArticles() async {
    // Return early if already loading
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(
            "https://newsapi.org/v2/everything?q=trending&apiKey=$_apiKey"),
      );

      if (response.statusCode == 200) {
        // Decode JSON response and map it to a list of ArticleModel
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> jsonData = json['articles'];
        final List<Article> fetchedArticles = jsonData
            .map((articleJson) => Article.fromJson(articleJson))
            .toList();

        // Update the article list and notify listeners
        _articles.clear();
        _articles.addAll(fetchedArticles);
        notifyListeners();
      } else {
        // Handle non-200 responses
        throw Exception(
            'Failed to load articles. Status Code: ${response.body}');
      }
    } catch (error) {
      print('Error fetching articles: $error');
      // You can also notify listeners or show error messages in the UI
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh articles to provide a way to reload data manually
  Future<void> refreshArticles() async {
    await fetchArticles();
  }

  String helperFunction(String category) {
    switch (category) {
      case "Trending":
        return "top";
      case "World":
        return "world";
      case "Sports":
        return "sports";
      case "Entertainment":
        return "entertainment";
      case "Business":
        return "business";
      case "Other":
        return "other";
      default:
        return "top";
    }
    return "";
  }

  void setCategoryIndex(int index) {
    _categoryIndex = index;
  }

  /// Get an article by its ID (Optional method)
  Article getArticleByTitle(String title) {
    return _articles.firstWhere(
      (article) => article.title == title,
    );
  }

  void findArticleByCategory(String category) async {
    String categories = helperFunction(category);
    try {
      final response = await http.get(
        Uri.parse(
            "https://newsapi.org/v2/everything?q=$category&apiKey=$_apiKey"),
      );

      if (response.statusCode == 200) {
        // Decode JSON response and map it to a list of ArticleModel
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> jsonData = json['articles'];
        // final Map<String, dynamic> json = jsonDecode(response.body);
        // List<dynamic> jsonData = json['articles'];
        final List<Article> fetchedArticles = jsonData
            .map((articleJson) => Article.fromJson(articleJson))
            .toList();
        fetchedArticles.removeWhere((article) => article.title == "[Removed]");
        // Update the article list and notify listeners
        _articles.clear();
        _articles.addAll(fetchedArticles);
        notifyListeners();
      } else {
        // Handle non-200 responses
        throw Exception(
            'Failed to load articles. Status Code: ${response.body}');
      }
    } catch (error) {
      print('Error fetching articles: $error');
      // You can also notify listeners or show error messages in the UI
    } finally {
      notifyListeners();
    }
  }
}
