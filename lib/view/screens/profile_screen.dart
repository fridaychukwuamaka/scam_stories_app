import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:scam_stories_app/constants/constants.dart';
import 'package:scam_stories_app/controller/auth_controller.dart';
import 'package:scam_stories_app/controller/profile_controller.dart';
import 'package:scam_stories_app/view/screens/bookmark_screen.dart';
import 'package:scam_stories_app/view/screens/story/my_story.dart';
import 'package:scam_stories_app/view/screens/story/write_post_screen.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('users');

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final authCont = Get.put(AuthController());
  final profileCont = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        centerTitle: true,
        title: Text(
          'Profile',
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            FeatherIcons.chevronLeft,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          InkWell(
            onTap: () => Get.toNamed(Routes.settingsScreen),
            child: Icon(
              FeatherIcons.settings,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(
            height: 38,
          ),
          StreamBuilder<DocumentSnapshot<Object?>>(
              stream: users.doc(userId).snapshots(),
              builder: (context, snapshot) {
                String img = '';
                if (snapshot.hasData) {
                  var val = snapshot.data!.data() as Map;

                  img = val['img'];
                }
                return Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          image: img.isNotEmpty
                              ? DecorationImage(
                                  image: CachedNetworkImageProvider(img),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(3, 6),
                              blurRadius: 5,
                              color: Colors.black.withOpacity(0.16),
                            ),
                          ],
                        ),
                        child: img.isEmpty
                            ? Icon(
                                FeatherIcons.user,
                                size: 35,
                                color: Colors.white,
                              )
                            : SizedBox.shrink(),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 18,
                          child: InkWell(
                            onTap: () async => profileCont.uploadImage(),
                            child: Icon(
                              FeatherIcons.camera,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          SizedBox(
            height: 48,
          ),
          StreamBuilder<DocumentSnapshot<Object?>>(
              stream: users.doc(userId).snapshots(),
              builder: (context, snapshot) {
                String email = '....';
                String name = '....';
                if (snapshot.hasData) {
                  email = snapshot.data!.get('email');
                  name = snapshot.data!.get('name');
                }
                return Column(
                  children: [
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      email,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                );
              }),
          SizedBox(
            height: 50,
          ),
          ProfileScreenLink(
            title: 'Bookmarks',
            icon: FeatherIcons.bookmark,
            onTap: () {
              Get.to(() => BookMarkScreen());
            },
          ),
          SizedBox(
            height: 32,
          ),
          ProfileScreenLink(
            title: 'My Story',
            icon: FeatherIcons.bookOpen,
            onTap: () {
              Get.to(
                () => MyStories(),
              );
            },
          ),
          SizedBox(
            height: 32,
          ),
          ProfileScreenLink(
            title: 'Write Story',
            icon: FeatherIcons.edit,
            onTap: () {
              Get.to(() => WritePostScreen());
            },
          ),
          /* SizedBox(
            height: 32,
          ),
          ProfileScreenLink(
            title: 'Offline',
            icon: FeatherIcons.flag,
          ), */
          SizedBox(
            height: 100,
          ),
          Row(
            children: [
              Spacer(),
              InkWell(
                onTap: authCont.logout,
                child: Row(
                  children: [
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(FeatherIcons.logOut),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

class ProfileScreenLink extends StatelessWidget {
  const ProfileScreenLink({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
            color: Color(0xFF060000).withOpacity(0.06),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Icon(icon),
            SizedBox(
              width: 17.5,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
