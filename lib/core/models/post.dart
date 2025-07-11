final class Post {
  final String? id;
  final String? title;
  final String? content;
  final String? date;

  const Post({
    this.id,
    this.title,
    this.content,
    this.date,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      date: json['date'] as String?,
    );
  }
}