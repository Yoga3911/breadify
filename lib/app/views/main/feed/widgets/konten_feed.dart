import 'package:flutter/material.dart';
import 'package:project/app/models/feeds_models.dart';

import 'package:intl/intl.dart';
import 'package:project/app/models/user_model.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:provider/provider.dart';

//memanggil kerangka feed

class Feed extends StatelessWidget {
  const Feed({required this.feedModel, Key? key}) : super(key: key);

  final FeedModel feedModel;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(
          top: 0,
          left: 0,
          right: 0,
          bottom: 10), //pengganti container universal (pemisah antar konten)
      // color: Colors.blue.shade100,
      child: Column(
        children: <Widget>[
          //1) profile & username
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5, top: 2),
            height: MediaQuery.of(context).size.height * 0.08,
            // color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //a1) porfile & username
                FutureBuilder <UserModel>(
                    future: user.getUserById(feedModel.userId),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    snapshot.data!.imageUrl,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            //a2) username
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: (() {}),
                                  child: Text(
                                    snapshot.data!.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                      return const SizedBox();
                    }),
                //b) icon more
                const Icon(
                  Icons.more_horiz,
                  color: Colors.black,
                )
              ],
            ),
          ),
          //2) foto/konten feed
          Container(
            // margin: const EdgeInsets.only(top: 0),
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(feedModel.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //3) comment
          Container(
            margin: const EdgeInsets.fromLTRB(10, 2, 5, 0),
            // color: Colors.green,
            child: Column(
              children: [
                Text(
                  feedModel.caption,
                  style: const TextStyle(color: Colors.black),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        DateFormat("dd-MMM-yyyy").format(feedModel.date),
                        style: const TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Color(0xff7E7474),
                            fontSize: 12),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
