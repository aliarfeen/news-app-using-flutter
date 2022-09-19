// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:omar_ahmed_tut/presentation/screens/offline_screen.dart';
import '../../presentation/widgets/latest_news_container.dart';
import '../../bussiness_logic/cubit/articles_cubit.dart';
import '../../data/models/article.dart';
import '../widgets/newsConatiner.dart';

class NewsHomeScreen extends StatefulWidget {
  const NewsHomeScreen({Key? key}) : super(key: key);

  @override
  State<NewsHomeScreen> createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  late List<Article> allArticles = [];
  late List<Article> searchedArticles = allArticles;
  final _searchTextController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    allArticles = BlocProvider.of<ArticlesCubit>(context).getAllArticles();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<ArticlesCubit, ArticlesState>(builder: (context, state) {
      if (state is ArticlesLoaded) {
        allArticles = (state).articles;
        return buildLoadedListWidgets();
      } else {
        return loadingScreen();
      }
    });
  }

  Widget loadingScreen() {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: Image.asset('assets/images/loading.gif')));
  }

  Widget buildLoadedListWidgets() {
    return
        // Directionality(
        //     textDirection: TextDirection.rtl,
        // child:
        Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: newsAppBar(),
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero),
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
            color: Colors.blueGrey[100],
          ),
          child: SingleChildScrollView(
              child: Column(
            children: [
              _isSearching
                  ? const SizedBox(
                      height: 5,
                    )
                  : LatestNewsContainer(
                      article: allArticles[0],
                    ),
              buildArticlesList()
            ],
          )),
        ),
      ),
      // ),
    );
  }

  OutlineInputBorder searchBarBorderOutLine() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(
          color: Colors.blueGrey.shade100,
          width: 1,
        ));
  }

  AppBar newsAppBar() {
    return AppBar(
        backgroundColor: Colors.blueGrey[800],
        elevation: 0,
        toolbarHeight: 55,
        title: _isSearching
            ? Container(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .65,
                      height: 50,
                      child: TextField(
                        textDirection: TextDirection.rtl,
                        controller: _searchTextController,
                        cursorColor: Colors.blueGrey[100],
                        decoration: InputDecoration(
                            enabledBorder: searchBarBorderOutLine(),
                            focusedBorder: searchBarBorderOutLine(),
                            hintText: 'عن ماذا تبحث...؟',
                            hintTextDirection: TextDirection.rtl,
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Colors.blueGrey[100], fontSize: 12)),
                        style: TextStyle(
                            color: Colors.blueGrey[100], fontSize: 12),
                        onChanged: (searchedTopic) {
                          addSearchedForItemsToList(searchedTopic);
                        },
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _isSearching = false;
                            _searchTextController.clear();
                            searchedArticles = [];
                          });
                        },
                        icon: Icon(
                          Icons.clear,
                          color: Colors.blueGrey[100],
                        )),
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 35,
                        ),
                        const Text(
                          'Scene',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _isSearching = true;
                          });
                        },
                        icon: Icon(
                          Icons.search_sharp,
                          color: Colors.blueGrey[100],
                        )),
                  ],
                ),
              ));
  }

  void addSearchedForItemsToList(String searchedTopic) {
    searchedArticles = allArticles.where((article) {
      return article.title!.toLowerCase().contains(searchedTopic);
    }).toList();
    setState(() {});
  }

  Widget buildArticlesList() {
    return ListView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount:
            _isSearching ? searchedArticles.length : allArticles.length - 1,
        itemBuilder: (ctx, index) {
          return _isSearching
              ? NewsContainer(article: searchedArticles[index])
              : NewsContainer(article: allArticles[index + 1]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return buildBlocWidget();
        } else {
          return const OffLineScreen();
        }
      },
      child: Center(child: loadingScreen()),
    ));
  }
}
