import 'package:appnews/controllers/PostController.dart';
import 'package:appnews/models/PostModel.dart';
import 'package:appnews/widgets/PostListTile.dart';
import 'package:appnews/widgets/placholder.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  PostController _controller = PostController();
  ScrollController _scroll;
  @override
  void initState() {
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
      appBar: SearchBar(
        onClear: () {
          _controller.resetData();
        },
        onSearch: (value) {
          // print("hello");
          _controller.search = value;
          _controller.load(
            isAdd: false,
          );
        },
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
                      (post) => PostListTile(post: post),
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
              return PostListTilePlaceHolder();
            },
            itemCount: 10,
          );
        },
      ),
    );
  }
}

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  final Size preferredSize;
  final Function(String value) onSearch;
  final Function() onClear;
  final Duration delay;

  const SearchBar({
    Key key,
    this.preferredSize: const Size.fromHeight(50.0),
    this.onClear,
    this.onSearch,
    this.delay: const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String _search;
  TextEditingController _searchController;

  @override
  void initState() {
    _search = "";
    _searchController =
        TextEditingController.fromValue(TextEditingValue(text: _search));
    super.initState();
  }

  @override
  void dispose() {
    _searchController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: _search.length > 0
          ? IconButton(
              color: Colors.black,
              icon: Icon(Icons.cancel),
              onPressed: () {
                setState(() {
                  _search = "";
                  _searchController.clear();
                });
                if (widget.onClear != null) {
                  widget.onClear();
                }
              },
            )
          : IconButton(
              color: Colors.black,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
      title: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: TextField(
          keyboardType: TextInputType.text,
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _search = value;
            });
            if (_search != null && _search.isNotEmpty) {
              if (widget.onSearch != null) {
                Future.delayed(widget.delay).then((value) {
                  widget.onSearch(_search);
                });
              }
            } else {
              if (widget.onClear != null) {
                widget.onClear();
              }
            }
          },
          autofocus: true,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: null,
            ),
          ),
        ),
      ),
    );
  }
}
