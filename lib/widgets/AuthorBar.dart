import 'package:appnews/models/AuthModel.dart';
import 'package:appnews/models/PostModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class AuthorBar extends StatelessWidget {
  final PostModel post;

  const AuthorBar({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AuthorModel author = AuthorModel.fromMap(post.embed.author?.first);
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Container(
              height: 48,
              width: 48,
              child: CachedNetworkImage(
                imageUrl: author.avatar_urls["48"],
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle),
                ),
                placeholder: (context, url) => Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () =>
                  Navigator.of(context).pushNamed("/author", arguments: author),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ឈ្មោះ: ${author.name}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).accentColor
                      ),
                    ),
                    Text(
                      "ចំនាប់អារម្មណ៍: ${author.description ?? ""}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.share(post.link, subject: post.title);
              })
        ],
      ),
    );
  }
}
