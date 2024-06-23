import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/models/article_model.dart';
import 'package:nuncare_mobile_firebase/screens/other/article_page_screen.dart';
import 'package:intl/intl.dart';

class MyArticleRow extends StatelessWidget {
  const MyArticleRow({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    DateTime inputDate = DateTime.parse(article.createdAt);
    String formattedDate = DateFormat('dd-MM-yyyy').format(inputDate);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => ArticlePageScreen(article: article),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        article.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    article.img,
                    height: 100,
                    width: 100,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      article.authorName,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ecrit le : $formattedDate",
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
