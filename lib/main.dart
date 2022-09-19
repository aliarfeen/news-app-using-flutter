import 'package:flutter/material.dart';
import 'app_router.dart';

void main() {
  runApp(NewsApp(appRouter: AppRouter()));
}

class NewsApp extends StatelessWidget {
  final AppRouter appRouter;
  const NewsApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRouter,
      title: 'News App using Bloc by Arfeen',
      theme: ThemeData(
        backgroundColor: Colors.white,
        fontFamily: 'Kufi',
      ),
    );
  }
}
