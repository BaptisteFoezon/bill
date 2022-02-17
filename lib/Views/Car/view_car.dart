import 'dart:ui';

import 'package:bill/models/user_app.dart';
import 'package:bill/Views/home/home_page.dart';
import 'package:bill/Views/nav_screen.dart';
import 'package:bill/Views/splash_screen.dart';
import 'package:bill/models/car.dart';
import 'package:bill/Views/widgets/facture_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class viewCarScreen extends StatelessWidget {
  UserApp user;
  Car car;
  viewCarScreen({Key? key, required this.user, required this.car})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavScreen(
                          user: user,
                          index: 0,
                        ),
                      ),
                    )
                  },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
      drawer: const Drawer(
        backgroundColor: Colors.black,
      ),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                car.marque.toUpperCase() +
                                    " " +
                                    car.modele.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 2,
                                width: double.infinity - 20,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "Marque: " + car.marque,
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        "N° immatriculation: " + car.numImmatriculation,
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        "Modéle: " + car.modele,
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        "Nbr km: " + car.nbKilometre,
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        "N° chassis: " + car.numChassi,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: Container(
              height: 50,
              width: 100,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 200,
            child: FactureList(user: user, car: car),
          ),
          SizedBox(
            child: TextButton.icon(
                style: TextButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavScreen(
                            user: user,
                            index: 2,
                          ),
                        ),
                      ),
                    },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: const Text(
                  "Ajouter une facture",
                  style: TextStyle(color: Colors.white),
                )),
          ),
          Container(
            color: Colors.black,
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60.0, vertical: 15),
                child: Column(
                  children: [
                    const Text(
                      "Documents",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 2,
                      width: double.infinity - 20,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => {
                              debugPrint("see carte grise"),
                            },
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.download,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Carte Grise",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => {
                              debugPrint(" See assurance"),
                            },
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.download,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Assurance",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
