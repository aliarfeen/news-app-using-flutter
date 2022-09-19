import '../../data/models/source.dart';

class Article {
  Source? source;
  String? url;
  String? urlToImage;
  String? author;
  String? title;
  String? description;
  String? publishedAt;
  Article({
    this.source,
    this.url,
    this.urlToImage,
    this.author,
    this.title,
    this.description,
    this.publishedAt,
  });

  Article.fromJson(Map<String, dynamic> json) {
    source = Source.fromJson(json['source']);
    url = json['url'];
    urlToImage = json['urlToImage'];
    author = json['author'];
    title = json['title'];
    description = json['description'];
    publishedAt = json['publishedAt'];
  }
}
