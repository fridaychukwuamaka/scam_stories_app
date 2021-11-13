import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:scam_stories_app/controller/comment_controller.dart';
import 'package:scam_stories_app/model/comment.dart';
import 'package:scam_stories_app/view/widgets/comment_tile.dart';

final CollectionReference _comment =
    FirebaseFirestore.instance.collection('comment');

class CommentModal extends StatelessWidget {
  CommentModal({
    Key? key,
    required this.commentId,
  }) : super(key: key);

  final String commentId;

  final commentCont = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide(
      width: 1.2,
    ));
    print(commentId);
    return SafeArea(
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 17,
                ),
                Container(
                  height: 5,
                  width: 83,
                  decoration: BoxDecoration(
                      color: Color(0xFF707070).withOpacity(0.56),
                      borderRadius: BorderRadius.circular(30)),
                ),
                SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot<Object?>>(
                      stream: _comment
                          .where('reportId', isEqualTo: commentId)
                          .orderBy('date', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data!.docs.isNotEmpty) {
                          List<QueryDocumentSnapshot<Object?>> comments =
                              snapshot.data!.docs;
                          return ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              final String commenterId =
                                  comments[index].get('commenterId');
                              return FutureBuilder<
                                      DocumentSnapshot<Map<String, dynamic>>>(
                                  future: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(commenterId)
                                      .get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final commenter = snapshot.data;
                                      var comment = Comment(
                                        msg: comments[index].get('msg'),
                                        commenterId: commenterId,
                                        reportId:
                                            comments[index].get('reportId'),
                                        date: comments[index].get('date'),
                                        authorName: commenter!.get('name'),
                                      );
                                      return CommentTile(
                                        comment: comment,
                                        
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  });
                            },
                          );
                        } else if (snapshot.hasData &&
                            snapshot.data!.docs.isEmpty) {
                          return Text('Be the first to say something');
                        } else {
                          return SizedBox.expand(
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }
                      }),
                ),
                Container(
                  padding:
                      EdgeInsets.only(bottom: 14, left: 20, right: 20, top: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(-3, 6),
                          color: Colors.black.withOpacity(0.23),
                          blurRadius: 5,
                          spreadRadius: 4),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          cursorColor: Colors.black,
                          controller: commentCont.comment,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              top: 15,
                              bottom: 15,
                              left: 10,
                              right: 10,
                            ),
                            enabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                            hintText: 'Say something...',
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
                        onTap: () async => commentCont.postComment(commentId),
                        child: Container(
                          child: Icon(
                            FeatherIcons.send,
                            color: Colors.white,
                          ),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
