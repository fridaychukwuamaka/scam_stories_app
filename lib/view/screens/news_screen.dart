import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scam_stories_app/constants/constants.dart';
import 'package:scam_stories_app/controller/story_controller.dart';
import 'package:scam_stories_app/model/story.dart';
import 'package:scam_stories_app/services/my_pref.dart';
import 'package:scam_stories_app/view/widgets/commentModal.dart';

final CollectionReference bookmark =
    FirebaseFirestore.instance.collection('bookmarks');

final CollectionReference news = FirebaseFirestore.instance.collection('news');
final StoryController storyCont = Get.put(StoryController());

class NewsScreen extends StatefulWidget {
  const NewsScreen({
    Key? key,
    required this.story,
    this.isStory = false,
  }) : super(key: key);

  final Story story;
  final bool isStory;

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  ScrollController _scrollController = ScrollController();
     final userId = MyPref.userId.val;
  double _scrollOfset = 0;
  List scamTypes = [];

  @override
  void initState() {
    addScrollListner();
    super.initState();
  }

  onBookMark(List<QueryDocumentSnapshot<Object?>> bookMark) {
    if (bookMark.isEmpty) {
      bookmark.doc().set({
        'userId': userId,
        'postId': widget.story.reportId,
      });
    } else {
      bookmark.doc(bookMark.single.id).delete();
    }
  }

  Future<void> onIncreaseAlert() async {
    var val = await news.doc(widget.story.reportId).get();
  }

  addScrollListner() {
    _scrollController.addListener(() {
      setState(() {
        _scrollOfset = _scrollController.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Story story = widget.story;
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: story.img!.isNotEmpty
                ? MediaQuery.of(context).size.height * 0.35
                : 0,
            shadowColor: Colors.black.withOpacity(0.28),
            automaticallyImplyLeading: true,
            backgroundColor:
                story.img!.isNotEmpty ? Colors.white : Colors.black,
            backwardsCompatibility: false,
            elevation: 10,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                FeatherIcons.chevronLeft,
                color: _scrollOfset >= 212 && story.img!.isNotEmpty
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            actions: [
              StreamBuilder<QuerySnapshot<Object?>>(
                stream: bookmark
                    .where('postId', isEqualTo: story.reportId)
                    .where('userId', isEqualTo: userId)
                    .snapshots(),
                builder: (context, snapshot) {
                  IconData icon = FeatherIcons.bookmark;
                  List<QueryDocumentSnapshot<Object?>> bookMark = [];

                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    bookMark = snapshot.data!.docs;
                    icon = Icons.bookmark;
                  }
                  return InkWell(
                    onTap: () => storyCont.toggleBookmark(bookMark, story),
                    child: Icon(
                      icon,
                      size: 25,
                      color: _scrollOfset >= 212 && story.img!.isNotEmpty
                          ? Colors.black
                          : Colors.white,
                    ),
                  );
                },
              ),
              SizedBox(
                width: 20,
              ),
            ],
            pinned: true,
            flexibleSpace: story.img!.isNotEmpty
                ? FlexibleSpaceBar(
                    title: null,
                    background: story.img!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: story.img!,
                            fit: BoxFit.cover,
                          )
                        : null,
                  )
                : null,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    story.title,
                    style: TextStyle(
                      fontSize: 25.5,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: story.tags!.isNotEmpty ? 5 : 0,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 10,
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black,
                    ),
                    title: Text(
                      story.author,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Icon(
                      FeatherIcons.share2,
                      color: Colors.black,
                      size: 27,
                    ),
                    subtitle: Text(
                      'Author, ${DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(story.date))}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.58),
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    story.msg,
                    style: TextStyle(
                      fontSize: 16,
                      height: 2.3,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: navBar(context, story),
    );
  }

  Widget navBar(BuildContext context, Story story) {
    return Container(
      height: 65,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: Offset(-3, 6),
            color: Colors.black.withOpacity(0.09),
            blurRadius: 5,
            spreadRadius: 4),
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () async {
              await onIncreaseAlert();
            },
            child: Icon(
              FeatherIcons.alertCircle,
              size: 27,
            ),
          ),
          widget.isStory
              ? IconButton(
                  onPressed: () {
                    showGeneralDialog(
                      barrierColor: Colors.transparent,
                      context: context,
                      pageBuilder: (context, an, ani) => CommentModal(
                        commentId: story.reportId!,
                      ),
                    );
                  },
                  icon: Icon(
                    FeatherIcons.messageSquare,
                    size: 27,
                  ),
                )
              : SizedBox.shrink(),
          Icon(
            FeatherIcons.flag,
            size: 27,
          ),
        ],
      ),
    );
  }
}
