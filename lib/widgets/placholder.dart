import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostCardPlaceHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                color: Colors.white,
                height: 250,
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                margin: EdgeInsets.all(10),
                height: 20,
                color: Colors.white,
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                margin: EdgeInsets.all(10),
                height: 30,
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Icon(Icons.date_range),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 20,
                      width: 100,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 20,
                      width: 100,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostGridPlaceHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _width = (MediaQuery.of(context).size.width / 3);
    return Card(
      child: Container(
        width: _width,
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                color: Colors.white,
                width: _width,
                height: 100,
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                margin: EdgeInsets.all(10),
                height: 15,
                width: _width,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListTilePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      itemBuilder: (_, __) {
        return Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 25.0,
            ));
      },
      itemCount: 10,
    );
  }
}

class PostListTilePlaceHolder extends StatelessWidget {
  const PostListTilePlaceHolder({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 30,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(Icons.date_range),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          child: Container(
                            margin: EdgeInsets.all(10),
                            height: 20,
                            width: 80,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                        Spacer(),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          child: Container(
                            margin: EdgeInsets.all(10),
                            height: 20,
                            width: 80,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: 125,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
