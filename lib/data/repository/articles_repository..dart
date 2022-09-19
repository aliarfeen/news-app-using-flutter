import '../models/article.dart';
import '../web_services/articles_web_services.dart';

class ArticlesRepository {
  final ArticlesWebService articlesWebService;

  ArticlesRepository(this.articlesWebService);

  Future<List<Article>> getAllArticles() async {
    final articles = await articlesWebService.getAllArticles();
    return articles.map((article) => Article.fromJson(article)).toList();
  }
}
