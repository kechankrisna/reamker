class EmbedModel {
  List<Map<String, dynamic>> author;
  List<Map<String, dynamic>> wp_featuredmedia;
  List<Map<String, dynamic>> wp_term;

  EmbedModel({
    this.author: const [],
    this.wp_featuredmedia: const [],
    this.wp_term: const [],
  });

  factory EmbedModel.fromMap(Map<String, dynamic> map) {
    final _embedded = map['_embedded'];
    
    List wp_term = List.castFrom(_embedded['wp:term']).first;
    // List<Map> list = wp_term.map((e) => Map.castFrom(e)).toList();
    // print(list.runtimeType);
    return EmbedModel(
      author: List.castFrom(_embedded['author'] ?? []),
      wp_featuredmedia: List.castFrom(_embedded['wp:featuredmedia'] ?? []),
      wp_term: wp_term.map((e) => Map<String, dynamic>.from(e)).toList(),
    );
  }
}
