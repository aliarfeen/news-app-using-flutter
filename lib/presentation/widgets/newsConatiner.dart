import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/article.dart';
import 'newsTile.dart';

class NewsContainer extends StatelessWidget {
  final Article article;

  const NewsContainer({Key? key, required this.article}) : super(key: key);

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
    return InkWell(
      onTap: () => _launchInBrowser(article.url.toString()),
      child: Container(
        alignment: Alignment.topCenter,
        height: MediaQuery.of(context).size.height * .22,
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NewsTile(
                  article: article,
                ),
                Container(
                    margin: const EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height * .16,
                    width: MediaQuery.of(context).size.height * .15,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: article.urlToImage.toString().isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage.assetNetwork(
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset('assets/images/alt.jpg');
                                },
                                fit: BoxFit.fitHeight,
                                placeholder: 'assets/images/loader.gif',
                                image: article.urlToImage.toString()))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset('assets/images/alt.jpg'))),
              ],
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              thickness: 1,
              color: Colors.blueGrey.shade700,
            ),
          ],
        ),
      ),
    );
  }
}
