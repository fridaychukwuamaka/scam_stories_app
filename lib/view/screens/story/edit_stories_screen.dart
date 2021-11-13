import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:scam_stories_app/controller/story_controller.dart';
import 'package:scam_stories_app/model/story.dart';
import 'package:scam_stories_app/view/widgets/app_button.dart';

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({
    Key? key,
    required this.story,
  }) : super(key: key);

  final Story story;

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

CollectionReference news = FirebaseFirestore.instance.collection('news');

class _EditPostScreenState extends State<EditPostScreen> {
  final storyCont = Get.put(StoryController());

  @override
  void initState() {
    storyCont.getInitStory(widget.story);
    super.initState();
  }

  @override
  void dispose() {
    // scamTypes.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'Edit Story',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            FeatherIcons.chevronLeft,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 25).copyWith(top: 50),
        children: [
          Text(
            'Note:',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Please be assure that you information will not be displayed'),
          SizedBox(
            height: 30,
          ),
          Text(
            'Type of scam',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(() {
            return Wrap(
              spacing: 15,
              runSpacing: 15,
              children: List.generate(
                storyCont.scamTypes.length,
                (index) {
                  final scamType = storyCont.scamTypes[index];
                  return ChoiceChip(
                    selectedColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                      side: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    onSelected: (selected) {
                      storyCont.onSelectedTag(selected, index);
                    },
                    label: Text(
                      scamType.label,
                      style: TextStyle(
                        color: storyCont.selectedTag.value != index
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    selected: storyCont.selectedTag.value == index,
                  );
                },
              ),
            );
          }),
          SizedBox(
            height: 30,
          ),
          Text(
            'Title',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            cursorColor: Colors.black,
            // textAlign: TextAlign.justify,
            controller: storyCont.title,
            style: TextStyle(
              fontFamily: 'Montserrat',
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.black)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Describe Your experience',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            maxLines: 17,
            controller: storyCont.msg,
            cursorColor: Colors.black,
            // textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: 'Montserrat',
            ),
            decoration: InputDecoration(
              hintText:
                  'IT IS HELPFUL TO SHARE: \n1) HOW IT HAPPENED \n2) WHEN IT HAPPENED \n3) HOW MUCH WAS LOST.',
              hintStyle: TextStyle(height: 1.8),
              contentPadding: EdgeInsets.all(10),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.black)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Upload neccesary photo',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 29, vertical: 15),
                child: InkWell(
                    onTap: () async => await storyCont.getImage(),
                  child: Text(
                    'Upload',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
  SizedBox(
            height: 30,
          ),
          AppButton(
            onPressed: () async =>
                await storyCont.editStory(widget.story.reportId!),
            title: 'Update Story',
            titleStyle: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
            color: Colors.black,
          ),
          SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }
}
