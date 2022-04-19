import 'package:bill/models/facture.dart';
import 'package:bill/Views/Car/add_car.dart';
import 'package:bill/Views/widgets/loading.dart';
import 'package:bill/models/car.dart';
import 'package:bill/models/user_app.dart';
import 'package:bill/services/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'facture_detail_screen.dart';

class FactureList extends StatelessWidget {
  UserApp user;
  Car car;
  FactureList({Key? key, required this.user, required this.car})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Facture>>(
        future: DataBase().getFactures(user, car),
        initialData: const <Facture>[],
        builder: (context, AsyncSnapshot<List<Facture>> factures) {
          debugPrint("LOG Factures for car " +
              car.carId +
              " has dat ? " +
              factures.hasData.toString());
          debugPrint(factures.data.toString());
          if (factures.hasData) {
            //depugPrint("factures has data");
            dynamic factureList = factures.data;
            return Scrollbar(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: factures.data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => {
                        //depugPrint("facture tap"),
                        index < factures.data!.length
                            ? Get.offAll(
                                () => FactureDetailScreen(
                                  facture: factureList[index],
                                  car: car,
                                  user: user,
                                ),
                              )
                            : Get.offAll(() => AddCarScreen(
                                  user: user,
                                ))
                      },
                      child: Card(
                        color: Colors.white,
                        margin: const EdgeInsets.all(5),
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  factures.data![index].date.day.toString() +
                                      "/" +
                                      factures.data![index].date.month
                                          .toString() +
                                      "/" +
                                      factures.data![index].date.year
                                          .toString(),
                                  style: const TextStyle(color: Colors.black),
                                ),
                                Text(
                                  factures.data![index].nom,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return const Loading(color: Colors.transparent);
          }
        });
  }
}
