import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/models/article.dart';

class NewsTile extends StatelessWidget {
  final Article article;
  const NewsTile({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .15,
      width: MediaQuery.of(context).size.width * .6,
      padding: const EdgeInsets.all(2),
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.topRight,
            child: Text(
              '${article.title}',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
          ),
          Text(
            "${article.publishedAt}".substring(0, 10),
            style: const TextStyle(
                fontSize: 8, color: Color.fromARGB(255, 71, 71, 71)),
          ),
          Text(
            "${article.publishedAt}".substring(11, 16),
            style: const TextStyle(
                fontSize: 8, color: Color.fromARGB(255, 71, 71, 71)),
          ),
        ],
      ),
    );
  }
}
