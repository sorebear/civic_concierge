class PostModel {
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
  final Map<String, dynamic> excerpt;
  final int author;
  final int featuredMedia;
  final String commentStatus;
  final String pingStatus;
  final String template;
  final String format;
  final List<dynamic> meta;
  final List<dynamic> categories;
  final List<dynamic> tags;
  final Map<String, dynamic> links;

  PostModel.fromJson(Map<String, dynamic> json)
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
      excerpt = json['excerpt'],
      author = json['author'],
      featuredMedia = json['featured_media'],
      commentStatus = json['comment_status'],
      pingStatus = json['ping_status'],
      template = json['template'],
      format = json['format'],
      meta = json['meta'],
      categories = json['categories'],
      tags = json['tags'],
      links = json['links'];
}