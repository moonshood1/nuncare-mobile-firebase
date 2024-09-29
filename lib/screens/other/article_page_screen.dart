import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nuncare_mobile_firebase/components/my_comment_tile.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_textfield.dart';
import 'package:nuncare_mobile_firebase/models/article_model.dart';
import 'package:nuncare_mobile_firebase/models/comment_model.dart';
import 'package:nuncare_mobile_firebase/services/resource_service.dart';
import 'package:nuncare_mobile_firebase/services/user_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePageScreen extends StatefulWidget {
  const ArticlePageScreen({super.key, required this.article});

  final Article article;

  @override
  State<ArticlePageScreen> createState() => _ArticlePageScreenState();
}

class _ArticlePageScreenState extends State<ArticlePageScreen> {
  final ResourceService _resourceService = ResourceService();
  final TextEditingController _commentController = TextEditingController();
  final UserService _userService = UserService();

  List<Comment> comments = [];
  var _isLoading = false;
  var _commentSendingLoading = false;

  void likeOrUnlikeArticle() async {}

  void getCommentsForArticleFromStore() async {
    try {
      setState(() {
        _isLoading = true;
      });

      List<Comment> response = await _resourceService.getArticleComments(
        widget.article.id!,
      );

      setState(() {
        comments = response;
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  void writeComment() async {
    try {
      setState(() {
        _commentSendingLoading = true;
      });

      await _userService.commentArticle(
        widget.article.id!,
        _commentController.text.trim(),
      );

      _commentController.clear();
      getCommentsForArticleFromStore();

      setState(() {
        _commentSendingLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _commentSendingLoading = false;
      });
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);

    print(uri);

    try {
      if (await canLaunchUrl(uri)) {
        print('the url can be launch');
        await launchUrl(uri);
      } else {
        throw 'Impossible d\'ouvrir le lien $url';
      }
    } catch (e) {
      print("erreur lancement url $e");
    }
  }

  @override
  void initState() {
    getCommentsForArticleFromStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime inputDate = DateTime.parse(widget.article.createdAt);
    String formattedDate = DateFormat('dd-MM-yyyy').format(inputDate);

    Widget commentSectionWidget = Column(
      children: List.generate(
        comments.length,
        (index) {
          final comment = comments[index];

          return MyCommentTile(
            comment: comment.comment,
            authorName: comment.authorName,
            createdAt: comment.createdAt,
          );
        },
      ),
    );

    if (comments.isEmpty) {
      commentSectionWidget = const Center(
        child: Text(
          "Aucun commentaire pour l'instant ",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
        ),
      );
    }

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
          horizontal: 20,
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
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        widget.article.authorName,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                  // TextButton.icon(
                  //   onPressed: () {},
                  //   icon: Icon(
                  //     Icons.thumb_up_off_alt,
                  //     size: 32,
                  //     color: Colors.red.shade200,
                  //   ),
                  //   label: const Text(
                  //     "Aimer l'article",
                  //     style: TextStyle(
                  //       fontSize: 13,
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.w300,
                  //     ),
                  //   ),
                  // ),
                  // Expanded(
                  //   child: IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(
                  //       Icons.thumb_up_off_alt,
                  //       size: 20,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Image.network(
                widget.article.img,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
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
              const SizedBox(
                height: 20,
              ),
              widget.article.externalLink != ""
                  ? InkWell(
                      onTap: () => _launchURL(widget.article.externalLink!),
                      child: Text(
                        widget.article.externalLinkTitle != ""
                            ? widget.article.externalLinkTitle!
                            : widget.article.externalLink!,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Section commentaires",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _isLoading ? const MyLoadingCirle() : commentSectionWidget,
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: _commentController,
                      obscureText: false,
                      isHidden: false,
                      labelText: "Ecrivez votre commentaire",
                      validator: (value) {
                        return null;
                      },
                      autoCorrect: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 1,
                      icon: Icons.message,
                      textCapitalization: TextCapitalization.none,
                    ),
                  ),
                  IconButton(
                    onPressed: _commentSendingLoading
                        ? null
                        : () {
                            if (_commentController.text.trim().isNotEmpty) {
                              writeComment();
                            }
                          },
                    icon: Icon(
                      Icons.send,
                      color: _commentSendingLoading
                          ? Colors.grey.shade300
                          : Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
