import 'package:appnews/core/app.dart';
import 'package:appnews/models/CategoryModel.dart';
import 'package:appnews/models/PostModel.dart';
import 'package:appnews/widgets/AuthorBar.dart';
import 'package:appnews/widgets/RelatedPost.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:appnews/core/extension.dart';

class PostScreen extends StatelessWidget {
  final PostModel post;

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  const PostScreen({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("$app_name"),
          actions: [
            IconButton(
                icon: Icon(Icons.bookmark),
                onPressed: () {
                  //
                })
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
                child: CachedNetworkImage(
                  imageUrl: post.image,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  "${post.title}".onlyText,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              Html(
                onImageTap: (url) {
                  print(url);
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) {
                        return Container(
                          constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height - 27),
                          child: Scaffold(
                            appBar: AppBar(
                              actions: [
                                FlatButton.icon(
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                    label: Text("close"))
                              ],
                            ),
                            body: PhotoView(
                              imageProvider: NetworkImage(url),
                            ),
                          ),
                        );
                      });
                },
                data: post.content,
                onLinkTap: (url) => _launchURL("$url"),
              ),
              Wrap(
                alignment: WrapAlignment.start,
                runSpacing: 5,
                spacing: 5,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "ប្រភេទអត្ថបទ:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  ...post.embed.wp_term
                      // .where((term) =>
                      //     category.taxonomy == "category" ||
                      //     category.taxonomy == "post_tag")
                      .map((Map term) => GestureDetector(
                            onTap: () {
                              CategoryModel category =
                                  CategoryModel.fromMap(term);
                              Navigator.of(context)
                                  .pushNamed("/category", arguments: category);
                            },
                            child: Chip(
                              label: Text("${term['name']}"),
                            ),
                          ))
                      .toList()
                ],
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "អ្នករៀបរៀង:",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              AuthorBar(post: post),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "អ្នកប្រហែលជាចូលចូល: ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                child: RelatedPost(
                  post: post,
                  exclude: [post.id],
                ),
              )
            ],
          ),
        ),
        // bottomNavigationBar: BottomAppBar(
        //   child: Bar,
        // ),
      ),
    );
  }
}

class ImageViewer extends StatelessWidget {
  final String url;

  const ImageViewer({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        imageProvider: NetworkImage(url),
      ),
    );
  }
}
