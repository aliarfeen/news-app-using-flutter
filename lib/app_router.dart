import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bussiness_logic/cubit/articles_cubit.dart';
import 'constants/strings.dart';
import 'data/repository/articles_repository..dart';
import 'data/web_services/articles_web_services.dart';
import 'presentation/screens/newsHomeScreen.dart';

class AppRouter {
  late ArticlesRepository articlesRepository;
  late ArticlesCubit articlesCubit;

  AppRouter() {
    articlesRepository = ArticlesRepository(ArticlesWebService());
    articlesCubit = ArticlesCubit(articlesRepository);
  }
  Route? generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case newsHomeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => articlesCubit,
            child: const NewsHomeScreen(),
          ),
        );
    }
    return null;
  }
}
