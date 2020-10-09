import 'package:appnews/controllers/PostController.dart';
import 'package:appnews/models/PostModel.dart';
import 'package:appnews/widgets/PostGrid.dart';
import 'package:appnews/widgets/placholder.dart';
import 'package:flutter/material.dart';

class RelatedPost extends StatefulWidget {
  final PostModel post;
  final List<int> exclude;

  const RelatedPost({Key key, this.post, this.exclude: const []})
      : super(key: key);
  @override
  _RelatedPostState createState() => _RelatedPostState();
}

class _RelatedPostState extends State<RelatedPost> {
  PostController _controller;
  ScrollController _scroll = ScrollController();

  @override
  void initState() {
    _controller = PostController(categories: widget.post.categories, exclude: [widget.post.id], per_page: 4);
    _controller?.load();

    super.initState();
    _scroll.addListener(_scrollListener);
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
    return StreamBuilder(
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
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scroll,
            child: Row(
              children: [
                ...datas.map((post) => PostGrid(post: post)).toList(),
                if (_controller.page < _controller.totalpages)
                  Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.filled(10, PostGridPlaceHolder()),
          ),
        );
      },
    );
  }
}
