import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:housing/models/user.dart';
import 'package:housing/providers/user_provider.dart';
import 'package:housing/resources/firestore_methods.dart';
import 'package:housing/screens/comment_screen.dart';
import 'package:housing/utils/colors.dart';
import 'package:housing/utils/utils.dart';
import 'package:housing/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_launch/flutter_launch.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentlen = 0;
  @override
  void initState() {
    super.initState();
    getComments();
  }

  void getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();

      commentlen = snap.docs.length;
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      color: fourdColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          //Header section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(widget.snap['profImage']),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap['username'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shrinkWrap: true,
                          children: ["delet"]
                              .map(
                                (e) => InkWell(
                                  onTap: () async {
                                    FirestoreMethods()
                                        .deletePost(widget.snap['postId']);
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    child: Text(e),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          //Image section
          ////
          Material(
            borderRadius: BorderRadius.circular(40),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: blueColor,
            elevation: 8,
            child: InkWell(
              splashColor: thirdColor,
              /////
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return Material(
                  borderRadius: BorderRadius.circular(40),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: fourdColor,
                  elevation: 8,
                  child: SizedBox(
                      child: ListView(
                    children: [
                      Image.network(
                        widget.snap["postUrl"],
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                        filterQuality: FilterQuality.high,
                      ),
                      const Divider(
                        thickness: 2.5,
                        color: thirdColor,
                      ),
                      //
                      Image.network(
                        widget.snap["postUrl2"],
                        fit: BoxFit.cover,
                      ),
                      const Divider(
                        thickness: 2.5,
                        color: thirdColor,
                      ),
                      //
                      Image.network(
                        widget.snap["postUrl3"],
                        fit: BoxFit.cover,
                      ),
                      const Divider(
                        thickness: 2.5,
                        color: thirdColor,
                      ),
                      //
                      Image.network(
                        widget.snap["postUrl4"],
                        fit: BoxFit.cover,
                      ),
                    ],
                  )),
                );
              })),
              /////
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Image.network(
                  widget.snap['postUrl'],
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          ),
////
          //Like comment section
          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                  onPressed: () async {
                    await FirestoreMethods().likePost(
                      widget.snap['postId'],
                      user.uid,
                      widget.snap['likes'],
                    );
                  },
                  icon: widget.snap['likes'].contains(user.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border,
                        ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CommentsScreen(
                    postId: widget.snap['postId'].toString(),
                  ),
                )),
                icon: const Icon(
                  Icons.comment_outlined,
                ),
              ),
              IconButton(
                  onPressed: () async {
                    await FlutterLaunch.launchWhatsapp(
                        phone: "+2${widget.snap['number']}",
                        message:
                            "بكلم حضرتك بخصوص الشق المعروضع علي برنامج hosing");
                  },
                  icon: Image.asset('assets/images/7.png')),
              //
              IconButton(
                onPressed: () async {
                  await FlutterPhoneDirectCaller.callNumber(
                      widget.snap['number']);
                },
                icon: const Icon(
                  Icons.phone,
                ),
              ),
              /* Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bookmark_border,
                    ),
                  ),
                ),
              ), */
              //
            ],
          ),
          //Description and number of comments
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    "${widget.snap['likes'].length} likes",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: mobileBackgroundColor),
                      children: [
                        TextSpan(
                          text: "الوصف:" " ${widget.snap["description"]} ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: mobileBackgroundColor),
                      children: [
                        TextSpan(
                          text: "الحي:" ' ${widget.snap["neighborhood"]}\t\t ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: "المجاوره:" " ${widget.snap["adjacent"]}\n ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: "العماره:" " ${widget.snap['building']} \t\t",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: "الشقه:" " ${widget.snap['apartment']} \n",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: "السعر:" " ${widget.snap["price"]} ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                //
                InkWell(
                  onTap: () {},
                  child: Text(
                    "view all $commentlen comments",
                    style: const TextStyle(
                        fontSize: 16, color: mobileBackgroundColor),
                  ),
                ),
                Text(
                  DateFormat.yMMMd()
                      .format(widget.snap['datePublished'].toDate()),
                  style: const TextStyle(
                      fontSize: 16, color: mobileBackgroundColor),
                ),
              ],
            ),
          ),
          const Divider(
            color: thirdColor,
            height: 20,
            thickness: 2.5,
          )
        ],
      ),
    );
  }
}
