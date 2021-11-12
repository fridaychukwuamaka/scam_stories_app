import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scam_stories_app/model/comment.dart';
import 'package:scam_stories_app/repository/api_status.dart';

final CollectionReference _comment =
    FirebaseFirestore.instance.collection('comment');

class CommentServices {
  postComment(Comment comment) async {
    try {
      await _comment.doc().set(comment.toJson());
    } catch (e) {
      FirebaseException? error;
      error = e as FirebaseException?;
      return Failure(msg: error!.message!);
    }

    return Success(
      msg: 'Story Shared Succesfully',
    );
  }
}
