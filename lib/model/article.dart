class Article {
  final String? author;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String content;
  String? category;

  Article({
    this.category,
    required this.content,
    this.author,
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        author: json['source']['name'] ?? 'No author',
        title: json['title'] ?? 'No title',
        description: json['description'] ?? 'No desc',
        url: json['url'] ?? 'No author',
        urlToImage: json['urlToImage'] ?? 'No image',
        publishedAt: json['publishedAt'] ?? 'No date',
        content: json['content'] ?? 'No content');
  }
}
