import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nuncare_mobile_firebase/models/article_model.dart';

class ArticlePageScreen extends StatefulWidget {
  const ArticlePageScreen({super.key, required this.article});

  final Article article;

  @override
  State<ArticlePageScreen> createState() => _ArticlePageScreenState();
}

class _ArticlePageScreenState extends State<ArticlePageScreen> {
  void likeOrUnlikeArticle() async {}
  @override
  Widget build(BuildContext context) {
    DateTime inputDate = DateTime.parse(widget.article.createdAt);
    String formattedDate = DateFormat('dd-MM-yyyy').format(inputDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.article.title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.article.authorName,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Row(
              //         children: [
              //           IconButton(
              //             onPressed: () {},
              //             icon: Icon(
              //               Icons.favorite,
              //               color: Colors.red.shade100,
              //               size: 32,
              //             ),
              //           ),
              //           const SizedBox(
              //             width: 5,
              //           ),
              //           Text(
              //             widget.article.likes!.length.toString(),
              //           )
              //         ],
              //       ),
              //     ),
              //     Expanded(
              //       child: Row(
              //         children: [
              //           IconButton(
              //             onPressed: () {},
              //             icon: const Icon(
              //               Icons.share,
              //               size: 32,
              //             ),
              //           ),
              //           const SizedBox(
              //             width: 5,
              //           ),
              //           const Text(
              //             "Partager l'article",
              //             style: TextStyle(
              //               fontWeight: FontWeight.w300,
              //               fontSize: 12,
              //             ),
              //           )
              //         ],
              //       ),
              //     )
              //   ],
              // ),
              const SizedBox(
                height: 15,
              ),
              Image.network(
                widget.article.img,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.article.description,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.article.content,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
