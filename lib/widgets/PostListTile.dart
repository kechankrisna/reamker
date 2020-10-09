import 'package:appnews/models/PostModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:appnews/core/extension.dart';

class PostListTile extends StatelessWidget {
  final PostModel post;

  const PostListTile({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed("/post", arguments: this.post),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "${post.title}".onlyText,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Icon(Icons.date_range),
                          Text(
                            " ${DateFormat.yMMMd().format(post.date)}",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Spacer(),
                          Text(
                            " ${post.embed.author.first['name']}",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 125,
                height: 100,
                child: CachedNetworkImage(
                  imageUrl: post.thumbnail,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}