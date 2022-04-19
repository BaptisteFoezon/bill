import 'package:bill/Views/home/widget/emptycard.dart';
import 'package:bill/models/car.dart';
import 'package:bill/models/user_app.dart';
import 'package:bill/Views/Car/add_car.dart';
import 'package:bill/Views/Car/view_car.dart';
import 'package:bill/services/database.dart';
import 'package:flutter/material.dart';

class CarList extends StatelessWidget {
  UserApp userApp;
  CarList({Key? key, required this.userApp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: FutureBuilder<List<Car>>(
          future: DataBase().getCars(userApp),
          initialData: const <Car>[],
          builder: (context, AsyncSnapshot<List<Car>> cars) {
            //depugPrint("LOG Car List has dat ? " + cars.hasData.toString());
            //depugPrint(cars.data.toString());
            if (cars.hasData) {
              //depugPrint("cars has data");
              dynamic carsList = cars.data;
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cars.data!.length + 1,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => {
                        //depugPrint("card tap"),
                        index < cars.data!.length
                            ? Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return viewCarScreen(
                                      user: userApp,
                                      car: carsList[index],
                                    );
                                  },
                                ),
                              )
                            : Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AddCarScreen(user: userApp);
                                  },
                                ),
                              ),
                      },
                      child: Card(
                        color: Colors.black,
                        margin: const EdgeInsets.all(5),
                        child: SizedBox(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: index < cars.data!.length
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        cars.data![index].marque,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Container(
                                        height: 3,
                                        width: 35,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        cars.data![index].modele,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ],
                                  )
                                : const SizedBox(
                                    width: 100,
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              double maxwidth = (MediaQuery.of(context).size.width - 80) / 3;
              return Row(
                children: [
                  CardEmpty(
                    height: maxwidth,
                    width: maxwidth,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  CardEmpty(
                    height: maxwidth,
                    width: maxwidth,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  CardEmpty(
                    height: maxwidth,
                    width: maxwidth,
                  ),
                ],
              );
            }
          }),
    );
  }
}
