import 'dart:async';
import 'package:appnews/core/config.dart';
import 'package:appnews/core/lib.dart';
import 'package:appnews/models/CategoryModel.dart';
import 'package:dio/dio.dart';

class CategoryController {
  int _total;
  int _totalpages = 0;
  int _page;
  String search;
  String _orderby;
  String _order;

  int get total => this._total;
  int get totalpages => this._totalpages;
  int get page => this._page;

  List<CategoryModel> _lists = List<CategoryModel>();
  List<CategoryModel> get lists => this._lists;
  StreamController<List<CategoryModel>> _controller =
      StreamController<List<CategoryModel>>();
  Stream<List<CategoryModel>> get stream => this._controller.stream;
  StreamSink<List<CategoryModel>> get _streamSink => this._controller.sink;

  CategoryController({
    int total: 0,
    int page: 1,
    String search: "",
    String orderby: 'count',
    String order: 'desc',
  }) {
    this._total = total;
    this._page = page;
    this.search = search;
    this._orderby = orderby;
    this._order = order;
  }

  Future<bool> init() async {
    return await load(isAdd: false);
  }

  Future<bool> load({bool isAdd: true}) async {
    try {
      Map<String, dynamic> queryParameters = Map();
      queryParameters['per_page'] = per_page;
      queryParameters['page'] = _page;
      queryParameters['search'] = search;
      queryParameters['orderby'] = _orderby;
      queryParameters['order'] = _order;
      // await Future.delayed(Duration(minutes: 2));
      Response response = await getDio().get("/categories?_embed", queryParameters: queryParameters);
      Map header = response.headers.map;
      if (response.statusCode == 200) {
        List<dynamic> datas = response.data;
        List<CategoryModel> _posts =
            datas.cast().map((json) => CategoryModel.fromMap(json)).toList();
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
      return true;
    } catch (e) {
      print("load() method got error $e");
      return false;
    }
  }

  reset() {
    _page = 1;
    load(isAdd: false);
  }

  loadMore() {
    if (_page < _totalpages) {
      _page += 1;
      load();
    }
  }

  dispose() {
    _controller?.close();
    _streamSink?.close();
  }
}
