import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/color.dart';
import 'package:project/app/constant/glow.dart';
import 'package:project/app/routes/route.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:provider/provider.dart';

import '../main/home/widgets/alert.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.main),
            icon: const Icon(Icons.arrow_back_ios_new),
            color: Colors.white,
          ),
          title: const Text("Profile", style: TextStyle(color: Colors.white)),
          actions: const [
            Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ],
          elevation: 0,
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: const BoxDecoration(color: MyColor.yellow),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                      ),
                      CircleAvatar(
                        radius: 40,
                        child: CachedNetworkImage(
                          imageUrl: user.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Container(
                                width: 80,
                                height: 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white),
                                child: const Center(child: Text("Customer"))),
                            const Text("Saldo : Rp100.000",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: ListTile(
                  leading: Icon(Icons.camera_alt_outlined, size: 30, color: Colors.yellow[600],),
                  title: const Text("Set Photo Profile"),
                ),
              ),
              Container(
                height: 5,
                decoration: const BoxDecoration(color: Colors.white),
              ),
              GestureDetector(
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: ListTile(
                    leading: Icon(Icons.request_page_outlined, size: 30, color: Colors.yellow[600],),
                    title: const Text("Request To Be A Seller"),
                  ),
                ),
              ),
              Container(
                height: 5,
                decoration: const BoxDecoration(color: Colors.white),
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: const ListTile(
                  title: Text("Settings"),
                ),
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(color: Colors.grey[800]),
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: ListTile(
                  leading: Icon(Icons.lock_outline_sharp, size: 30, color: Colors.yellow[600],),
                  title: const Text("Privacy and Security"),
                ),
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(color: Colors.grey[800]),
              ),
              GestureDetector(
                onTap: () => showDialog(
                    context: context, builder: (_) => const LogOutDialog()),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: ListTile(
                    leading: Icon(Icons.logout_outlined, size: 30, color: Colors.yellow[600],),
                    title: const Text("Logout"),
                  ),
                ),
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(color: Colors.grey[800]),
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: ListTile(
                  leading: Icon(Icons.help_outline, size: 30, color: Colors.yellow[600],),
                  title: const Text("Help Center"),
                ),
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(color: Colors.grey[800]),
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(color: Colors.grey[200]),
              ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
