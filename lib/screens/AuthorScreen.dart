import 'package:appnews/controllers/PostController.dart';
import 'package:appnews/models/AuthModel.dart';
import 'package:appnews/models/PostModel.dart';
import 'package:appnews/widgets/PostCard.dart';
import 'package:appnews/widgets/placholder.dart';
import 'package:flutter/material.dart';

class AuthorScreen extends StatefulWidget {
  final AuthorModel author;

  const AuthorScreen({Key key, @required this.author}) : super(key: key);
  @override
  _AuthorScreenState createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {
  PostController _controller;
  ScrollController _scroll;
  @override
  void initState() {
    _controller = PostController(author: [widget.author.id]);
    _controller?.init();
    _scroll = ScrollController();
    _scroll.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_scroll.offset >= (_scroll.position.maxScrollExtent - 500) &&
        !_scroll.position.outOfRange) {
      // print("reach the bottom");
      _controller?.loadMore();
    }
    if (_scroll.offset <= _scroll.position.minScrollExtent &&
        !_scroll.position.outOfRange) {
      // print("reach the top");
      _controller?.reset();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _scroll?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "អ្នករៀបរៀង: ${widget.author.name}",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      body: StreamBuilder(
        stream: _controller.stream,
        builder: (_, AsyncSnapshot<List<PostModel>> snapshots) {
          if (snapshots.hasData) {
            if (snapshots.data.length <= 0) {
              return Container(
                alignment: Alignment.center,
                child: Text("មិនមានទិន្នន័យ"),
              );
            }
            final List<PostModel> datas = snapshots.data;
            return ListView(
              controller: _scroll,
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              children: [
                ...datas
                    .map(
                      (post) => PostCard(post: post),
                    )
                    .toList(),
                if (_controller.page < _controller.totalpages)
                  Center(child: CircularProgressIndicator()),
              ],
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            itemBuilder: (_, __) {
              return PostCardPlaceHolder();
            },
            itemCount: 10,
          );
        },
      ),
    );
  }
}
