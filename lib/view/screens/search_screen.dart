import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:scam_stories_app/model/story.dart';
import 'package:scam_stories_app/view/widgets/news_horizontal_tile.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide(
      width: 1.2,
    ));
    CollectionReference searchedItems =
        FirebaseFirestore.instance.collection('news');
    TextEditingController _searchController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20).copyWith(top: 40),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.black,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      controller: _searchController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          top: 15,
                          bottom: 15,
                          left: 10,
                          right: 10,
                        ),
                        enabledBorder: outlineInputBorder,
                        focusedBorder: outlineInputBorder,
                        suffixIcon: Icon(
                          FeatherIcons.xCircle,
                          color: Colors.black,
                        ),
                        hintText: 'Search something...',
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  InkWell(
                    onTap: () {
                      print(_searchController.text);
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      child: Icon(
                        FeatherIcons.search,
                        color: Colors.white,
                      ),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Object?>>(
                  stream: searchedItems.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data!.docs[0].data());
                    } else {}
                    return ListView.builder(
                      padding: EdgeInsets.only(left: 25),
                      itemBuilder: (context, index) => NewsHorizonTile(
                        onPressed: () {},
                        isBookmarkIcon: false,
                        story: Story(
                          title: 'title',
                          author: 'author',
                          msg: 'msg',
                          experience: 0,
                          authorId: 'authorId',
                          date: 10000,
                          type: 'type',
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
