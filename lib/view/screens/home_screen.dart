import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:scam_stories_app/constants/constants.dart';
import 'package:scam_stories_app/controller/app_bar_controller.dart';
import 'package:scam_stories_app/model/story.dart';
import 'package:scam_stories_app/view/screens/story/more_stories_screen.dart';
import 'package:scam_stories_app/view/screens/news_screen.dart';
import 'package:scam_stories_app/view/widgets/app_bottom_bar.dart';
import 'package:scam_stories_app/view/widgets/news_horizontal_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

CollectionReference _news = FirebaseFirestore.instance.collection('news');

final appBarCont = Get.put(AppBarController());

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _horizontalScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appBarCont.initController();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: appBarSection(),
      ),
      bottomNavigationBar: AppBottomBar(),
      body: ListView(
        padding: EdgeInsets.only(left: 20),
        controller: appBarCont.verticalScrollController,
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Text(
                  'Scam News',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => MoreStoriesScreen(
                            title: 'Scam News',
                            collection: _news,
                            type: 'news',
                          ),
                        );
                      },
                      child: Text(
                        'More',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 18,
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          scamNewsSection(context),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Text(
                'Popular Stories',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => MoreStoriesScreen(
                            title: 'Popular Stories',
                            collection: _news,
                            type: 'story',
                          ),
                        );
                      },
                      child: Text(
                        'More',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 18,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          popularStoriesSection(),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                'Recent Stories',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => MoreStoriesScreen(
                            title: 'Recent Stories',
                            collection: _news,
                            type: 'story',
                          ),
                        );
                      },
                      child: Text(
                        'More',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 18,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          recentStories(),
        ],
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> recentStories() {
    return StreamBuilder<QuerySnapshot<Object?>>(
      stream: _news
          .where(
            'type',
            isEqualTo: 'story',
          )
          .orderBy('experience', descending: false)
          .limit(4)
          .snapshots(),
      builder: (context, snapshot) {
        final List<QueryDocumentSnapshot<Object?>> news;
        if (snapshot.connectionState == ConnectionState.active &&
            snapshot.hasData) {
          news = snapshot.data!.docs;
          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(right: 20),
            physics: NeverScrollableScrollPhysics(),
            itemCount: news.length > 5 ? 4 : news.length,
            itemBuilder: (context, index) {
              final singleNews = news[index];

              return NewsHorizonTile(
                onPressed: () {
                  Get.to(
                    () => NewsScreen(
                      story: Story.fromJson(singleNews),
                      isStory: true,
                    ),
                  );
                },
                story: Story.fromJson(singleNews),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              strokeWidth: 2,
            ),
          );
        }
      },
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> popularStoriesSection() {
    return StreamBuilder<QuerySnapshot<Object?>>(
      stream: _news
          .where('type', isEqualTo: 'story')
          .orderBy('experience', descending: true)
          .limit(4)
          .snapshots(),
      builder: (context, snapshot) {
        final List<QueryDocumentSnapshot<Object?>> news;
        if (snapshot.connectionState == ConnectionState.active &&
            snapshot.hasData) {
          news = snapshot.data!.docs;
          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(right: 20),
            physics: NeverScrollableScrollPhysics(),
            itemCount: news.length > 5 ? 4 : news.length,
            itemBuilder: (context, index) {
              final singleNews = news[index];
              return NewsHorizonTile(
                onPressed: () {
                  Get.to(
                    () => NewsScreen(
                      story: Story.fromJson(singleNews),
                      isStory: true,
                    ),
                  );
                },
                story: Story.fromJson(singleNews),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              strokeWidth: 2,
            ),
          );
        }
      },
    );
  }

  SizedBox scamNewsSection(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.width * 0.56) + 34,
      width: double.infinity,
      child: Stack(
        children: [
          StreamBuilder<QuerySnapshot<Object?>>(
              stream:
                  _news.where('type', isEqualTo: 'news').limit(7).snapshots(),
              builder: (context, snapshot) {
                final List<QueryDocumentSnapshot<Object?>> news;
                if (snapshot.connectionState == ConnectionState.active &&
                    snapshot.hasData) {
                  news = snapshot.data!.docs;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: news.length,
                    controller: _horizontalScrollController,
                    itemBuilder: (context, index) => SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                            () => NewsScreen(
                              story: Story.fromJson(news[index]),
                              isStory: false,
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: (MediaQuery.of(context).size.width - 75) *
                                  0.56,
                              width: double.infinity,
                              margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    news[index].get('img'),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                news[index].get('title'),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 21,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2,
                    ),
                  );
                }
              }),
          Positioned(
            top: ((MediaQuery.of(context).size.width - 75) * 0.56) / 2.6,
            right: 25,
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                var nextPosition = MediaQuery.of(context).size.width - 75;
                _horizontalScrollController.animateTo(
                  _horizontalScrollController.offset + nextPosition,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: CircleAvatar(
                radius: 22.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Icon(
                    FeatherIcons.chevronRight,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Obx appBarSection() {
    return Obx(() {
      return AppBar(
        elevation: appBarCont.appBarElevationNotifier.value,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            'SCAM STORIES',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          InkWell(
            onTap: () => Get.toNamed(Routes.profile),
            child: Icon(
              FeatherIcons.user,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 25,
          ),
        ],
      );
    });
  }
}
