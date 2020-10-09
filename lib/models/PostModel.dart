import 'package:appnews/core/app.dart';
import 'package:appnews/models/EmbedModel.dart';

class PostModel {
  final int id;
  final DateTime date;
  final DateTime date_gmt;
  final String guid;
  final DateTime modified;
  final DateTime modified_gmt;
  final String slug;
  final String status;
  final String type;
  final String link;
  final String title;
  final String excerpt;
  final String content;
  final int feature_media;
  final String thumbnail;
  final String image;
  final String comment_status;
  final String ping_status;
  final bool sticky;
  final String template;
  final String format;
  final List<int> categories;
  final List<int> tags;
  final int author;
  final EmbedModel embed;

  PostModel({
    this.id,
    this.date,
    this.date_gmt,
    this.guid,
    this.modified,
    this.modified_gmt,
    this.slug,
    this.status,
    this.type,
    this.link,
    this.title,
    this.excerpt,
    this.content,
    this.author,
    this.feature_media,
    this.thumbnail,
    this.image,
    this.comment_status,
    this.ping_status,
    this.sticky,
    this.template,
    this.format,
    this.categories,
    this.embed,
    this.tags,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    EmbedModel embed = EmbedModel.fromMap(map);

    // print(embed.wp_featuredmedia?.first['source_url']);
    assert(map != null);
    return PostModel(
      id: int.parse("${map['id']}"),
      date: DateTime.parse(map['date']),
      date_gmt: DateTime.parse(map['date_gmt']),
      guid: map['guid.rendered'],
      modified: DateTime.parse(map['modified']),
      modified_gmt: DateTime.parse(map['modified_gmt']),
      slug: map['slug'],
      status: map['status'],
      type: map['type'],
      link: map['link'],
      title: map['title']['rendered'],
      excerpt: map['excerpt']['rendered'],
      content: map['content']['rendered'],
      author: map['auth'],
      feature_media: map['feature_media'],
      embed: embed,
      thumbnail: embed.wp_featuredmedia?.first['source_url'] ?? app_thumbnail,
      image: embed.wp_featuredmedia?.first['source_url'] ?? app_thumbnail,
      comment_status: map['comment_status'],
      ping_status: map['ping_status'],
      sticky: map['sticky'],
      template: map['template'],
      format: map['format'],
      categories: List.castFrom(map['categories']),
      tags: List.castFrom(map['tags']),
    );
  }
}
