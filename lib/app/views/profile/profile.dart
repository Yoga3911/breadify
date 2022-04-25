import 'package:flutter/material.dart';

void main() {
  runApp(const ProfilePage());
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.yellow[600]),
              width: double.infinity,
              height: 50,
            ),
            Container(
              height: 55,
              decoration: BoxDecoration(color: Colors.yellow[600]),
              child: Row(
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white),
                    height: 39,
                    width: 39,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  const Text(
                    "Profile",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(
                    flex: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white),
                    height: 39,
                    width: 39,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert_outlined),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.yellow[600]),
              width: double.infinity,
              height: 100,
              child: Row(
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white),
                    height: 80,
                    width: 80,
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Pakdhe",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Container(
                            width: 70,
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
                  ),
                  const Spacer(
                    flex: 20,
                  ),
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
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: ListTile(
                leading: Icon(Icons.request_page_outlined, size: 30, color: Colors.yellow[600],),
                title: const Text("Request To Be A Seller"),
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
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: ListTile(
                leading: Icon(Icons.logout_outlined, size: 30, color: Colors.yellow[600],),
                title: const Text("Logout"),
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
        ),
      ),
    );
  }
}
