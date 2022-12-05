import 'package:bill/src/auth/auth_util.dart';
import 'package:bill/src/backend/backend.dart';
import 'package:bill/src/bill/bill_theme.dart';
import 'package:bill/src/views/screens/home/car_detail_screen.dart';
import 'package:flutter/material.dart';

class ListCarWidget extends StatelessWidget {
  const ListCarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double cardWidth = 190.0;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
      child: SizedBox(
        height: cardWidth,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: StreamBuilder<List<CarsRecord>>(
            stream: queryCarsRecord(
              queryBuilder: (carsRecord) =>
                  carsRecord.where('user_id', isEqualTo: currentUserUid),
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    color: BillTheme.of(context).primaryColor,
                  ),
                );
              }
              List<CarsRecord> carsRecordList = snapshot.data!;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: carsRecordList.length,
                itemBuilder: (context, listViewIndex) {
                  final listViewCarsRecord = carsRecordList[listViewIndex];
                  return InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CarDetailScreen(
                            car: listViewCarsRecord,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: SizedBox(
                        height: cardWidth,
                        width: cardWidth,
                        child: Center(
                          child: Text(listViewCarsRecord.name!),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
