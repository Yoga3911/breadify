// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project/app/models/feeds_models.dart';

import 'package:intl/intl.dart';
import 'package:project/app/models/user_model.dart';
import 'package:project/app/view_model/feed_provider.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:provider/provider.dart';

import '../../../../routes/route.dart';
import '../../../../widgets/custom_loading.dart';

//memanggil kerangka feed

class Feed extends StatelessWidget {
  const Feed({
    required this.feedModel,
    required this.isMyFeed,
    Key? key,
  }) : super(key: key);

  final FeedModel feedModel;
  final bool isMyFeed;
  @override
  Widget build(BuildContext context) {
    final feed = Provider.of<FeedProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(
          top: 0,
          left: 0,
          right: 0,
          bottom: 10), //pengganti container universal (pemisah antar konten)
      // color: Colors.blue.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                FutureBuilder<UserModel>(
                    future: user.getUserById(feedModel.userId),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Row(
                          children: <Widget>[
                            Container(
                              width: 40,
                              height: 40,
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
                (isMyFeed)
                    ? PopupMenuButton(
                        onSelected: (val) {
                          if (val == 1) {
                            Navigator.pushNamed(context, Routes.editFeed, arguments: {
                              "feed": feedModel
                            });
                          } else if (val == 2) {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text("Perhatian"),
                                content: Text(
                                    "Apakah anda yakin ingin menghapus feed ini?"),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Batal")),
                                  ElevatedButton(
                                      child: Text("Ya"),
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          builder: (_) => const CustomLoading(),
                                        );
                                        await feed
                                            .deleteData(
                                                feedId: feedModel.idFeed)
                                            .then(
                                          (_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                duration: Duration(seconds: 3),
                                                content: Text(
                                                  "Feed berhasil dihapus",
                                                ),
                                                backgroundColor: Color.fromARGB(
                                                    255, 255, 74, 80),
                                              ),
                                            );
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                        );
                                      })
                                ],
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.more_horiz_rounded),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Icon(
                                  Icons.edit_rounded,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Edit"),
                              ],
                            ),
                            value: 1,
                          ),
                          PopupMenuItem(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Icon(
                                  Icons.delete_rounded,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Delete"),
                              ],
                            ),
                            value: 2,
                          )
                        ],
                      )
                    : const SizedBox()
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
              crossAxisAlignment: CrossAxisAlignment.start,
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