import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scam_stories_app/constants/constants.dart';
import 'package:scam_stories_app/controller/story_controller.dart';
import 'package:scam_stories_app/model/story.dart';

final CollectionReference _bookmark =
    FirebaseFirestore.instance.collection('bookmarks');

class NewsHorizonTile extends StatelessWidget {
  NewsHorizonTile({
    Key? key,
    required this.onPressed,
    this.isBookmarkIcon = true,
    required this.story,
  }) : super(key: key);

  final Function() onPressed;
  final Story story;
  final bool isBookmarkIcon;

  final StoryController storyCont = Get.put(StoryController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(bottom: 35, right: 0),
        child: Row(
          children: [
            story.img!.isNotEmpty
                ? Container(
                    height: 59,
                    width: 58,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                      image: story.img!.isNotEmpty
                          ? DecorationImage(
                              image: CachedNetworkImageProvider(story.img!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                  )
                : SizedBox.shrink(),
            SizedBox(
              width: story.img!.isNotEmpty ? 15 : 0,
            ),
            Expanded(
              child: SizedBox(
                // height: 59,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      story.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${story.author}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.69)),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '  ${DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(story.date))}',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.69)),
                        ),
                      ],
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ),
            SizedBox(
              width: isBookmarkIcon ? 15 : 0,
            ),
            isBookmarkIcon
                ? StreamBuilder<QuerySnapshot<Object?>>(
                    stream: _bookmark
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
                        child: Icon(icon, size: 25, color: Colors.black),
                      );
                    },
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
