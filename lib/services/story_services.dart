import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:scam_stories_app/constants/constants.dart';
import 'package:scam_stories_app/model/story.dart';
import 'package:scam_stories_app/services/my_pref.dart';

import 'api_status.dart';

CollectionReference _news = FirebaseFirestore.instance.collection('news');

CollectionReference _bookmark =
    FirebaseFirestore.instance.collection('bookmarks');

class StoryServices {
  postStory(Story story) async {
    try {
      await _news.doc().set(story.toJson());
    } catch (e) {
      FirebaseException? error;
      error = e as FirebaseException?;
      return Failure(msg: error!.message!);
    }

    return Success(
      msg: 'Story Shared Succesfully',
    );
  }

  editStory(Story story, String docPath) async {
    try {
      await _news.doc(docPath).set(story.toJson());
    } catch (e) {
      FirebaseException? error;
      error = e as FirebaseException?;
      return Failure(msg: error!.message!);
    }

    return Success(
      msg: 'Story Edited Succesfully',
    );
  }

  deleteStory(String postId) async {
    try {
      await _news.doc(postId).delete();
    } catch (e) {
      FirebaseException? error;
      error = e as FirebaseException?;
      return Failure(msg: error!.message!);
    }

    return Success(
      msg: 'Story deleted succesfully',
    );
  }

  bookMarkStory(Story story) async {
     var userId = MyPref.userId.val;
    if (userId.isNotEmpty) {
      try {
        await _bookmark.doc().set({
          'userId': userId,
          'postId': story.reportId,
        });
      } catch (e) {
        FirebaseException? error;
        error = e as FirebaseException?;
        return Failure(msg: error!.message!);
      }
      return Success(
        msg: 'Bookmarked succesfully',
      );
    } else {
      Get.toNamed(Routes.login);
    }
  }

  removeBookMark(String bookMarkId) async {
    try {
      await _bookmark.doc(bookMarkId).delete();
    } catch (e) {
      FirebaseException? error;
      error = e as FirebaseException?;
      return Failure(msg: error!.message!);
    }
    return Success(
      msg: 'Bookmark removed succesfully',
    );
  }
}
