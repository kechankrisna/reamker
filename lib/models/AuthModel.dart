class AuthorModel {
  final int id;
  final String name;
  final String url;
  final String description;
  final String link;
  final String slug;
  final Map<String, dynamic> avatar_urls;

  AuthorModel(
      {this.id,
      this.name,
      this.url,
      this.description,
      this.link,
      this.slug,
      this.avatar_urls});

  factory AuthorModel.fromMap(Map<String, dynamic> map) {
    return AuthorModel(
      id: map["id"],
      name: map["name"],
      description: map["description"],
      url: map["url"],
      link: map["link"],
      slug: map["slug"],
      avatar_urls: Map.castFrom(map["avatar_urls"]),
    );
  }
}