import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/color.dart';
import 'package:project/app/routes/route.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pushNamed(context, Routes.home),
          icon: Icon(Icons.arrow_back_ios_new),
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
                decoration: BoxDecoration(color: MyColor.yellow),
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
                      margin: EdgeInsets.only(top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: TextStyle(
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
                              child: Center(child: Text("Customer"))),
                          Text("Saldo : Rp100.000",
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
                title: Text("Set Photo Profile"),
              ),
            ),
            Container(
              height: 5,
              decoration: BoxDecoration(color: Colors.white),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: ListTile(
                leading: Icon(Icons.request_page_outlined, size: 30, color: Colors.yellow[600],),
                title: Text("Request To Be A Seller"),
              ),
            ),
            Container(
              height: 5,
              decoration: BoxDecoration(color: Colors.white),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: ListTile(
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
                title: Text("Privacy and Security"),
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
                leading: Icon(Icons.logout_outlined, size: 30, color: Colors.yellow[600],),
                title: Text("Logout"),
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
                title: Text("Help Center"),
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
    );
  }
}
