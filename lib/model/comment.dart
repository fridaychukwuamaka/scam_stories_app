class Comment {
  final String msg;
  final String commenterId;
  final String reportId;
  final String? authorName;
  final int date;

  Comment({
    required this.msg,
    required this.commenterId,
    required this.reportId,
    required this.date,
     this.authorName,
  });

  toJson() {
    return {
      'commenterId': commenterId,
      'msg': msg,
      'reportId': reportId,
      'date': date
    };
  }
}
