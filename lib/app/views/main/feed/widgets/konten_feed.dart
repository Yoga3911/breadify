import 'package:flutter/material.dart';

import '../../../../models/feeds_models.dart';
import '../feed.dart';

class Feed extends StatelessWidget {
  const Feed({required this.index, Key? key }) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
   
    return Container(
                  margin: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.width * 0.85,
                  color: Colors.blue.shade100,
                  child: Column(
                    children: <Widget>[
                      //1) profile & username
                      Container(
                        margin:
                            const EdgeInsets.only(left: 5, right: 5, top: 5),
                        height: MediaQuery.of(context).size.height * 0.08,
                        color: Colors.amber,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              //a1) porfile & username
                              SizedBox(
                                child: Row(children: <Widget>[
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                feedscontent[index]
                                                    .photoProfile),
                                            fit: BoxFit.cover)),
                                  ),
                                  //a2) username
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: (() {}),
                                          child: Text(
                                            feedscontent[index].username,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                  )
                                ]),
                              ),
                              //b) icon more
                              const Icon(
                                Icons.more_horiz,
                                color: Colors.black,
                              )
                            ]),
                      ),
                      //2) foto/konten feed
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    NetworkImage(feedscontent[index].content),
                                fit: BoxFit.cover)),
                      ),
                      //3) comment
                      Container(
                        margin: const EdgeInsets.all(5),
                        height: MediaQuery.of(context).size.height * 0.16,
                        color: Colors.green,
                        child: Column(
                          children: [
                            Text(feedscontent[index].comment),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(feedscontent[index].date)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
  }
}