import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:scam_stories_app/constants/constants.dart';
import 'package:scam_stories_app/model/story.dart';
import 'package:scam_stories_app/view/screens/news_screen.dart';
import 'package:scam_stories_app/view/widgets/news_horizontal_tile.dart';

CollectionReference _bookmarks =
    FirebaseFirestore.instance.collection('bookmarks');

CollectionReference _reports = FirebaseFirestore.instance.collection('news');

class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'Bookmarks',
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
          stream: _bookmarks.where('userId', isEqualTo: userId) .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              print(snapshot.data!.docs[0].data());
              final bookmarks = snapshot.data!.docs;
              return ListView.builder(
                padding: EdgeInsets.only(left: 20, right: 20, top: 50),
                itemCount: bookmarks.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<DocumentSnapshot<Object?>>(
                      future:
                          _reports.doc(bookmarks[index].get('postId')).get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.exists) {
                          final bookmark = snapshot.data;
                          return NewsHorizonTile(
                            onPressed: () {
                              Get.to(
                                () => NewsScreen(
                                  story: Story.fromJson(bookmark),
                                  isStory: false,
                                ),
                              );
                            },
                            story: Story.fromJson(bookmark),
                            isBookmarkIcon: false,
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      });
                },
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              return SizedBox(
                child: Center(
                  child: Text('No bookmarked yet'),
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
