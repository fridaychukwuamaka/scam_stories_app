class Story {
  Story({
    required this.title,
    required this.author,
    required this.msg,
    required this.experience,
    required this.authorId,
    this.tags,
    required this.date,
    required this.type,
    this.img,
    this.reportId,
  });

  final String title;
  final String author;
  final String? reportId;
  final String msg;
  final int experience;
  final String authorId;
  final List? tags;
  final String? img;
  final String type;
  final int date;

  toJson() {
    return {
      'title': title,
      'author': author,
      'msg': msg,
      'date': date,
      'img': img,
      'experience': experience,
      'authorId': authorId,
      'type': type,
      'tags': tags
    };
  }

  static fromJson(story) {
    return Story(
      title: story.get('title'),
      author: story.get('author'),
      msg: story.get('msg'),
      experience: story.get('experience'),
      reportId: story.id,
      authorId: story.get('authorId'),
      tags: story.get('tags'),
      date: story.get('date'),
      img: story.get('img'),
      type: story.get('type'),
    );
  }
}
