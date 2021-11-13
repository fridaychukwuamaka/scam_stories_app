import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:scam_stories_app/controller/story_controller.dart';
import 'package:scam_stories_app/model/scam_type.dart';
import 'package:scam_stories_app/model/story.dart';
import 'package:scam_stories_app/view/screens/news_screen.dart';
import 'package:scam_stories_app/view/widgets/news_horizontal_tile.dart';

class MoreStoriesScreen extends StatelessWidget {
  MoreStoriesScreen({
    Key? key,
    this.title = '',
    required this.collection,
    this.type = 'News',
  }) : super(key: key);
  final String title;
  final String type;
  final CollectionReference collection;

  final storyCont = Get.put(StoryController());

  @override
  Widget build(BuildContext context) {
    storyCont.clearSlectedTag;
    ThemeData theme = Get.theme;
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            FeatherIcons.chevronLeft,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 50,
          bottom: 50,
        ),
        children: [
          Obx(
             () {
              return Wrap(
                spacing: 15,
                runSpacing: 15,
                children: List.generate(
                  ScamType.kTypeOfScam.length,
                  (index) {
                    final scamType = ScamType.kTypeOfScam[index];

                    return ChoiceChip(
                      selectedColor: Colors.black,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                        side: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      onSelected: (selected) =>
                          storyCont.onSelectedTag(selected, index),
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
            }
          ),
          Obx(
            () {
              return StreamBuilder<QuerySnapshot<Object?>>(
                  stream: collection
                      .where(
                        'tags',
                        arrayContains:
                            ScamType.kTypeOfScam[storyCont.selectedTag.value].label,
                      )
                      .where(
                        'type',
                        isEqualTo: type,
                      )
                      .orderBy(
                        title == 'Popular Stories' ? 'experience' : 'date',
                        descending: title == 'Recent Stories' ? false : true,
                      )
                      .snapshots(),
                  builder: (context, snapshot) {
                    final List<QueryDocumentSnapshot<Object?>> news;
                    print(snapshot.connectionState);
                    if (snapshot.connectionState == ConnectionState.active &&
                        snapshot.hasData &&
                        snapshot.data!.docs.isNotEmpty) {
                      news = snapshot.data!.docs;
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                          top: 40,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: news.length > 5 ? 4 : news.length,
                        itemBuilder: (context, index) {
                          final singleNews = news[index];

                          return NewsHorizonTile(
                            onPressed: () {
                              Get.to(
                                () => NewsScreen(
                                  story: Story.fromJson(singleNews),
                                  isStory: type == 'story',
                                ),
                              );
                            },
                            story: Story.fromJson(singleNews),
                          );
                        },
                      );
                    } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Sorry no $type available',
                            style: theme.textTheme.headline6,
                          ),
                        ],
                      );
                    } else {
                      return Container(
                        padding: EdgeInsets.only(top: 50),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    }
                  });
            }
          ),
        ],
      ),
    );
  }
}
