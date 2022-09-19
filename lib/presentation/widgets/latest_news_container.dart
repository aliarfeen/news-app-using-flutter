import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/article.dart';

class LatestNewsContainer extends StatelessWidget {
  final Article article;
  const LatestNewsContainer({super.key, required this.article});

  Future<void> _launchInBrowser(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return article.urlToImage.toString().isNotEmpty
        ? Container(
            margin: const EdgeInsets.only(top: 6),
            height: MediaQuery.of(context).size.height * .4,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                image: DecorationImage(
                    colorFilter: const ColorFilter.mode(
                        Color.fromARGB(151, 3, 3, 3), BlendMode.softLight),
                    image: NetworkImage('${article.urlToImage}'),
                    fit: BoxFit.cover)),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${article.title}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    textDirection: TextDirection.rtl,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        shadows: [],
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 1.25,
                        color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () {
                        _launchInBrowser(article.url.toString());
                      },
                      child: Text(
                        'المزيد....',
                        textDirection: TextDirection.rtl,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white),
                      ))
                ],
              ),
            ),
          )
        : Container(
            height: MediaQuery.of(context).size.height * .4,
            child: Image.asset('assets/images/alt.jpg'),
          );
  }
}
