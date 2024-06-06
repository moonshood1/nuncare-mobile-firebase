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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                article.img,
                height: 100,
                width: 170,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          article.authorName,
                          style: const TextStyle(fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
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
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.favorite,
                      //       color: Colors.red.shade100,
                      //     ),
                      //     const SizedBox(
                      //       width: 5,
                      //     ),
                      //     Text(
                      //       article.likes!.length.toString(),
                      //       style: const TextStyle(
                      //         fontSize: 11,
                      //       ),
                      //     )
                      //   ],
                      // ),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
