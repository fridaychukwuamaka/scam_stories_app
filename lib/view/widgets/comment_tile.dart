import 'package:flutter/material.dart';
import 'package:scam_stories_app/model/comment.dart';
import 'package:scam_stories_app/utils/time_ago_utils.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 25,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black,
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFF000000).withOpacity(0.07),
                borderRadius: BorderRadius.circular(10).copyWith(
                  topLeft: Radius.circular(0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.authorName!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    TimeAgo.timeAgoSinceDate(comment.date),
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF473F3F),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    comment.msg,
                    style: TextStyle(
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
