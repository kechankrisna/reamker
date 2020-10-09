import 'dart:async';
import 'package:appnews/core/lib.dart';
import 'package:appnews/models/PostModel.dart';
import 'package:dio/dio.dart';

class PostController {
  int _total;
  int _totalpages = 0;
  int _per_page;
  int _page;
  String search;
  String _orderby;
  String _order;
  List<int> categories;
  List<int> exclude;
  List<int> author;
  bool _isLoading = false;

  int get total => this._total;
  int get per_page => this._per_page;
  int get totalpages => this._totalpages;
  int get page => this._page;
  bool get isLoading => this._isLoading;

  List<PostModel> _lists = List<PostModel>();
  List<PostModel> get lists => this._lists;
  StreamController<List<PostModel>> _controller =
      StreamController<List<PostModel>>();
  Stream<List<PostModel>> get stream => this._controller.stream;
  StreamSink<List<PostModel>> get _streamSink => this._controller.sink;

  PostController({
    int total: 0,
    int page: 1,
    int per_page: 10,
    String search: "",
    String orderby: 'date',
    String order: 'desc',
    List<int> categories: const [],
    List<int> exclude: const [],
    List<int> author: const [],
  }) {
    this._total = total;
    this._page = page;
    this._per_page = per_page;
    this.search = search;
    this._orderby = orderby;
    this._order = order;
    this.categories = categories;
    this.exclude = exclude;
    this.author = author;
  }

  Future<bool> init() async {
    var result = await load(isAdd: false);

    return result;
  }

  Future<bool> load({bool isAdd: true}) async {
    this._isLoading = true;
    try {
      Map<String, dynamic> queryParameters = Map();
      queryParameters['per_page'] = _per_page;
      queryParameters['page'] = _page;
      queryParameters['search'] = search;
      queryParameters['orderby'] = _orderby;
      queryParameters['order'] = _order;
      if (categories.length > 0) {
        queryParameters['categories'] = categories;
      }
      if (exclude.length > 0) {
        queryParameters['exclude'] = exclude;
      }
      if (author.length > 0) {
        queryParameters['author'] = author;
      }
      // await Future.delayed(Duration(minutes: 10));
      Response response = await getDio().get("/posts?_embed", queryParameters: queryParameters);
      Map header = response.headers.map;
      if (response.statusCode == 200) {
        List<dynamic> datas = response.data;
        List<PostModel> _posts =
            datas.cast().map((map) => PostModel.fromMap(map)).toList();
        _total = int.parse(List.castFrom(header['x-wp-total'])?.first ?? 0);
        _totalpages =
            int.parse(List.castFrom(header['x-wp-totalpages'])?.first ?? 0);

        if (isAdd) {
          _lists.addAll(_posts);
        } else {
          _lists = _posts;
        }
        _streamSink.add(_lists);
      }
      this._isLoading = false;
      return true;
    } catch (e) {
      print("load() method got error $e");
    }
    this._isLoading = false;
    return false;
  }

  resetData() {
    _streamSink.add([]);
  }

  reset() {
    _page = 1;
    load(isAdd: false);
  }

  loadMore() {
    if (_page < _totalpages && !_isLoading) {
      _page += 1;
      print(_page);
      load();
    }
  }

  dispose() {
    _controller?.close();
    _streamSink?.close();
  }
}
