//** myfeed.dart = khusus sbg SELLER utk fitur feeds

import 'package:flutter/material.dart';
import 'package:project/app/constant/glow.dart';
import 'package:project/app/routes/route.dart';
import 'package:project/app/view_model/feed_provider.dart';
import 'package:provider/provider.dart';

//utk konten feed
import 'package:project/app/views/main/feed/widgets/konten_feed.dart';

import '../../../view_model/user_prodvider.dart';

// final List<FeedsContent> feedscontent = [
//   FeedsContent(
//       photoProfile:
//           "https://images.unsplash.com/photo-1577219491135-ce391730fb2c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=377&q=80",
//       username: "liandri_bakery",
//       content:
//           "https://images.unsplash.com/photo-1563778084459-859099e48677?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
//       comment:
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
//       date: "13 March 2022"),
//   FeedsContent(
//       photoProfile:
//           "https://images.unsplash.com/photo-1614436163996-25cee5f54290?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=742&q=80",
//       username: "beatric_patisserie",
//       content:
//           "https://images.unsplash.com/photo-1525203135335-74d272fc8d9c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
//       comment:
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
//       date: "12 March 2022"),
//   FeedsContent(
//     photoProfile:
//         "https://images.unsplash.com/photo-1583394293214-28ded15ee548?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
//     username: "sean_bakery",
//     content:
//         "https://images.unsplash.com/photo-1474045326708-cdc78c2487cb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
//     comment:
//         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut \n\nenim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
//     date: "10 March 2022",
//   ),
// ];

class MyFeedPage extends StatefulWidget {
  const MyFeedPage({Key? key}) : super(key: key);

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  @override
  Widget build(BuildContext context) {
    final feed = Provider.of<FeedProvider>(context);
    final user = Provider.of<UserProvider>(context, listen: false);

    return ScrollConfiguration(
      behavior: NoGlow(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            Navigator.pushNamed(context, Routes.addfeed).then((value) {
              setState(() {});
            });
          },
          tooltip: 'add feed',
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xffFFD635),
          leading: GestureDetector(
            onTap: () {
              return Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
          title: const Text(
            "My Feed",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: FutureBuilder(
            future: feed.getAllById(userId: user.getUser.id),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: feed.getMyData.length,
                  itemBuilder: (context, index) => Feed(
                      isMyFeed: true,
                      feedModel: feed.getMyData[
                          index]), //manggil konten class Feed() utk isi kontem dr folder widgets
                );
              }
              return const SizedBox();
            }),
      ),
    );
  }
}