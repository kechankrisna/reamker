import 'package:appnews/controllers/CategoryController.dart';
import 'package:appnews/models/CategoryModel.dart';
import 'package:appnews/widgets/placholder.dart';
import 'package:flutter/material.dart';

class CategoryListTile extends StatefulWidget {
  @override
  _CategoryListTileState createState() => _CategoryListTileState();
}

class _CategoryListTileState extends State<CategoryListTile> {
  CategoryController _controller = CategoryController();
  ScrollController _scroll;
  @override
  void initState() {
    _controller?.init();
    _scroll = ScrollController();
    _scroll.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_scroll.offset >= _scroll.position.maxScrollExtent &&
        !_scroll.position.outOfRange) {
      print("reach the bottom");
    }
    if (_scroll.offset <= _scroll.position.minScrollExtent &&
        !_scroll.position.outOfRange) {
      print("reach the top");
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
      builder: (_, AsyncSnapshot<List<CategoryModel>> snapshots) {
        if (snapshots.hasData) {
          if (snapshots.data.length <= 0) {
            return Container(
              alignment: Alignment.center,
              child: Text("មិនមានទិន្នន័យ"),
            );
          }
          final List<CategoryModel> datas = snapshots.data;
          return ListView(
            controller: _scroll,
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text("ទំព័រដើម"),
                onTap: () {
                  Navigator.of(context).pushNamed("/");
                },
              ),
              ...datas
                  .map(
                    (category) => ListTile(
                      title: Text("${category.name}"),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed("/category", arguments: category);
                      },
                    ),
                  )
                  .toList(),
            ],
          );
        }
        return ListTilePlaceholder();
      },
    );
  }
}
