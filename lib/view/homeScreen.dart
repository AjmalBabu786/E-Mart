import 'dart:developer';

import 'package:flutter/material.dart';

import '../controller/networkService.dart';
import '../modal/prodect_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  bool isLoading = true;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "E Mart",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: const [
            Icon(
              Icons.shopping_bag,
              color: Colors.black,
            )
          ],
        ),
        body: FutureBuilder(
            future: NetWorkService.fetchdata(),
            builder: (context, snapshot) {
              final datalist = snapshot.data;
              if (snapshot.hasError) {
                return Center(child: Text("error"));
              } else if (snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(
                        child: GridView.count(
                            shrinkWrap: true,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: (150 / 180),
                            crossAxisCount: 2,
                            children: List.generate(
                              datalist!.length,
                              (index) => Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 10,
                                      ),
                                    ]),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Icon(
                                            Icons.star_rate,
                                            color: Colors.amber,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(datalist[index]
                                              .rating
                                              .rate
                                              .toString()),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 100,
                                      width: 100,
                                      color: Colors.white,
                                      child:
                                          Image.network(datalist[index].image),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Text(
                                        datalist[index].title,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        datalist[index].category.name,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            // datalist[index].price.toString(),
                                            "\$ ${datalist[index].price.toString()}",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              datalist[index].id.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 18),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ))),
                  ],
                );
              } else {
                return Text("no data");
              }
            }));
  }
}
