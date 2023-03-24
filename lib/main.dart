// ignore_for_file: override_on_non_overriding_member, non_constant_identifier_names
import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeAppState createState() => _HomeAppState();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _HomeAppState extends State<HomeApp> {
  int sec = 0, min = 0, hour = 0;
  String digsec = "00", digmin = "00", dighour = "00";
  Timer? time;
  bool start = false;

  List lap = [];

  //Timer Function
  void stop() {
    time!.cancel();
    setState(() {
      start = false;
    });
  }

  //Reset Function
  void reset() {
    time!.cancel();
    setState(() {
      sec = 0;
      min = 0;
      hour = 0;
      digsec = "00";
      digmin = "00";
      dighour = "00";
      start = false;
    });
  }

  //Lap Function
  void lap_add() {
    String lap_function = "$dighour:$digmin:$digsec";
    setState(() {
      lap.add(lap_function);
    });
  }

  // Start Function
  void started() {
    start = true;
    time = Timer.periodic(const Duration(seconds: 1), (timer) {
      int locseconds = sec + 1;
      int locmin = min;
      int lochour = hour;
      if (locseconds > 59) {
        if (locmin > 59) {
          lochour++;
          locmin = 0;
        } else {
          locmin++;
          locseconds = 0;
        }
      }
      setState(() {
        sec = locseconds;
        min = locmin;
        hour = lochour;
        digsec = (sec >= 10) ? "$sec" : "0$sec";
        digmin = (min >= 10) ? "$min" : "0$min";
        dighour = (hour >= 10) ? "$hour" : "0$hour";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 235, 235, 239),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    "OASIS STOPWATCH",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text("$dighour:$digmin:$digsec",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 70.0,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                Container(
                  height: 400.0,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 104, 124, 53),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListView.builder(
                      itemCount: lap.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Lap -> ${index + 1}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                              Text(
                                "${lap[index]}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RawMaterialButton(
                        onPressed: () {
                          (!start) ? started() : stop();
                        },
                        shape: const StadiumBorder(
                            side: BorderSide(color: Colors.black)),
                        child: Text(
                          (!start) ? "Start" : "Pause",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    IconButton(
                      color: Colors.red,
                      onPressed: () {
                        lap_add();
                      },
                      icon: const Icon(Icons.flag),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                        child: RawMaterialButton(
                      onPressed: () {
                        reset();
                        lap.clear();
                      },
                      fillColor: const Color.fromARGB(255, 61, 16, 160),
                      shape: const StadiumBorder(),
                      child: const Text(
                        "Reset",
                        style: TextStyle(color: Colors.white),
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
