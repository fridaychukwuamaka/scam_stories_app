import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:scam_stories_app/constants/constants.dart';
import 'package:scam_stories_app/model/story.dart';
import 'package:scam_stories_app/services/my_pref.dart';
import 'package:scam_stories_app/view/screens/news_screen.dart';
import 'package:scam_stories_app/view/widgets/my_stories_tile.dart';

CollectionReference bookmarks =
    FirebaseFirestore.instance.collection('bookmarks');

CollectionReference reports = FirebaseFirestore.instance.collection('news');

class MyStories extends StatelessWidget {
  const MyStories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
       final userId = MyPref.userId.val;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'My Stories',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            FeatherIcons.chevronLeft,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
          stream: reports
              .where('authorId', isEqualTo: userId)
              .where('type', isEqualTo: 'story')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              final stories = snapshot.data!.docs;
              return ListView.builder(
                padding: EdgeInsets.only(left: 25, top: 50),
                itemCount: stories.length,
                itemBuilder: (context, index) {
                  final story = stories[index];
                  return MyStoriesTile(
                    story: Story.fromJson(story),
                    onPressed: () {
                      Get.to(
                        () => NewsScreen(
                          story: Story.fromJson(story),
                          isStory: false,
                        ),
                      );
                    },
                  );
                },
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              return SizedBox(
                child: Center(
                  child: Text('No shared story yet'),
                ),
              );
            } else {
              return SizedBox.expand(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 2,
                  ),
                ),
              );
            }
          }),
    );
  }
}
