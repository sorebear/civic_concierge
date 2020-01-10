class ServiceModel {
  final int id;
  final String date;
  final String dateGmt;
  final Map<String, dynamic> guid;
  final String modified;
  final String modifiedGmt;
  final String slug;
  final String status;
  final String type;
  final String link;
  final Map<String, dynamic> title;
  final Map<String, dynamic> content;
  final int author;
  final int featuredMedia;
  final String template;
  final List<dynamic> meta;
  final String generatedSlug;
  final String links;

  ServiceModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      date = json['date'],
      dateGmt = json['date_gmt'],
      guid = json['guid'],
      modified = json['modified'],
      modifiedGmt = json['modified_gmt'],
      slug = json['slug'],
      status = json['status'],
      type = json['type'],
      link = json['link'],
      title = json['title'],
      content = json['content'],
      author = json['author'],
      featuredMedia = json['featured_media'],
      template = json['template'],
      meta = json['meta'],
      generatedSlug = json['generated_slug'],
      links = json['links'];
}