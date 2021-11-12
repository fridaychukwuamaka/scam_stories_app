import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scam_stories_app/constants/constants.dart';
import 'package:scam_stories_app/model/comment.dart';
import 'package:scam_stories_app/repository/comment_services.dart';

CommentServices _commentServices = CommentServices();

class CommentController extends GetxController {
  TextEditingController comment = TextEditingController();

  postComment(String reportId) async {
    if (comment.text.isNotEmpty) {
      Comment newComment = Comment(
        msg: comment.text,
        commenterId: userId,
        reportId: reportId,
        date: Timestamp.now().millisecondsSinceEpoch,
      );
      await _commentServices.postComment(newComment);

      comment.clear();
    }
  }
}
