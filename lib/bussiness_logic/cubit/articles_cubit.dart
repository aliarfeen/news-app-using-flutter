import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../data/models/article.dart';
import '../../data/repository/articles_repository..dart';
part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  final ArticlesRepository articlesRepository;
  List<Article> articles = [];
  //late made a problem

  ArticlesCubit(this.articlesRepository) : super(ArticlesInitial());

  List<Article> getAllArticles() {
    articlesRepository.getAllArticles().then((articles) {
      emit(ArticlesLoaded(articles));
      this.articles = articles;
    });

    return articles;
  }
}
