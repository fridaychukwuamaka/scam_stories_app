import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scam_stories_app/constants/constants.dart';
import 'package:scam_stories_app/model/scam_type.dart';
import 'package:scam_stories_app/model/story.dart';
import 'package:scam_stories_app/services/api_status.dart';
import 'package:scam_stories_app/services/my_pref.dart';
import 'package:scam_stories_app/services/story_services.dart';
import 'package:scam_stories_app/utils/image_utils.dart';

StoryServices _storyServices = StoryServices();

class StoryController extends GetxController {
  TextEditingController title = TextEditingController();
  TextEditingController msg = TextEditingController();

  var selectedTag = 0.obs;
  var scamTypes = [].obs;

  String img = '';

  get clearSlectedTag => selectedTag.value = 0;

  Future<void> writeStory(GlobalKey<FormState> formKey) async {
    final userId = MyPref.userId.val;
    var isValid = formKey.currentState!.validate();

    if (isValid) {
      Story newStory = Story(
        title: title.text,
        author: 'Anonymous',
        msg: msg.text,
        experience: 0,
        authorId: userId,
        img: img,
        tags: [
          'All',
          scamTypes[selectedTag.value].label,
        ],
        date: Timestamp.now().millisecondsSinceEpoch,
        type: 'story',
      );

      var result = await _storyServices.postStory(newStory);

      AppThemes.snackBar(result.msg, inverted: true);

      if (result.runtimeType == Success) {
        clearController();
      }
    }
  }

  Future<void> editStory(String docPath) async {
    final userId = MyPref.userId.val;
    Story newStory = Story(
      title: title.text,
      author: 'Anonymous',
      msg: msg.text,
      experience: 0,
      authorId: userId,
      img: img,
      tags: [
        'All',
        scamTypes[selectedTag.value].label,
      ],
      date: Timestamp.now().millisecondsSinceEpoch,
      type: 'story',
    );

    var result = await _storyServices.editStory(newStory, docPath);
    AppThemes.snackBar(result.msg, inverted: true);
  }

  toggleBookmark(
    List<QueryDocumentSnapshot<Object?>> bookmark,
    Story story,
  ) async {
    final userId = MyPref.userId.val;
    if (userId.isNotEmpty) {
      var result;
      if (bookmark.isEmpty) {
        result = await _storyServices.bookMarkStory(story);
      } else {
        result = await _storyServices.removeBookMark(bookmark.single.id);
      }
      AppThemes.snackBar(result.msg, inverted: true);
    } else {
      Get.toNamed(Routes.login);
    }
  }

  Future<void> deleteStory(String postId) async {
    var result = await _storyServices.deleteStory(postId);

    AppThemes.snackBar(result.msg, inverted: true);
  }

  getInitStory(Story story) {
    setTypes();
    title.text = story.title;
    msg.text = story.msg;
    selectedTag.value = scamTypes.indexWhere((e) => e.label == story.tags![1]);
    img = story.img!;
  }

  setTypes() {
    scamTypes.value = List.from(ScamType.kTypeOfScam);
    scamTypes.removeAt(0);
  }

  clearController() {
    title.clear();
    msg.clear();
    selectedTag.value = 0;
    img = '';
  }

  onSelectedTag(bool selected, int index) {
    if (selected) {
      selectedTag.value = index;
    }
  }

  Future<void> getImage() async {
    var image = await ImageUtils.selectImage();

    var url = await ImageUtils.uploadImage(image);

    img = url;
  }

  String? titleValidation(String? value) {
    if (value!.isNotEmpty) {
      return null;
    }
    return 'Please enter story title';
  }

  String? msgValidation(String? value) {
    if (value!.isNotEmpty) {
      return null;
    }
    return 'Please describe your exprience';
  }
}
