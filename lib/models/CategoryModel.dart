class CategoryModel {
  final int id;
  final int count;
  final String description;
  final String link;
  final String name;
  final String slug;
  final String taxonomy;
  final int parent;

  CategoryModel({
    this.id,
    this.count,
    this.description,
    this.link,
    this.name,
    this.slug,
    this.taxonomy: "category",
    this.parent: 0,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      count: map['count'] != null ? int.tryParse("${map['count']}") : 0,
      description: map['description'],
      link: map['link'],
      name: map['name'],
      slug: map['slug'],
      taxonomy: map['taxonomy'],
      parent: map['parent'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "count": this.count,
      "description": this.description,
      "link": this.link,
      "name": this.name,
      "slug": this.slug,
      "taxonomy": this.taxonomy,
      "parent": this.parent,
    };
  }
}
