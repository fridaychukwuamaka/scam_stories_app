import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:scam_stories_app/controller/story_controller.dart';
import 'package:scam_stories_app/model/story.dart';
import 'package:scam_stories_app/view/screens/story/edit_stories_screen.dart';

final CollectionReference stories =
    FirebaseFirestore.instance.collection('news');

class MyStoriesTile extends StatelessWidget {
  final Function() onPressed;

  final Story story;

  MyStoriesTile({
    Key? key,
    required this.onPressed,
    required this.story,
  }) : super(key: key);

  final storyCont = Get.put(StoryController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 45, right: 25),
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
                            story.author,
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
                          'June 2, 2017',
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
              width: 15,
            ),
            SizedBox(
              width: 15,
              child: PopupMenuButton(
                icon: Icon(FeatherIcons.moreVertical),
                padding: EdgeInsets.only(),
                itemBuilder: (context) {
                  return <PopupMenuEntry>[
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            FeatherIcons.edit,
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Edit',
                            textScaleFactor: 0.9,
                          ),
                        ],
                      ),
                      value: 0,
                    ),
                    PopupMenuDivider(),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            FeatherIcons.trash,
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Delete',
                            textScaleFactor: 0.9,
                          ),
                        ],
                      ),
                      value: 1,
                    ),
                  ];
                },
                onSelected: (value) async {
                  switch (value) {
                    case 0:
                      await Get.to(
                        () => EditPostScreen(
                          story: story,
                        ),
                      );
                      break;
                    case 1:
                      storyCont.deleteStory(story.reportId!);
                      break;
                    default:
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
