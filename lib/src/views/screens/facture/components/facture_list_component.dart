import 'package:bill/src/backend/backend.dart';
import 'package:bill/src/bill/bill_theme.dart';
import 'package:bill/src/views/screens/facture/facture_detail_screen.dart';
import 'package:flutter/material.dart';

class ListFactureWidget extends StatelessWidget {
  const ListFactureWidget({
    Key? key,
    required this.car,
  }) : super(key: key);

  final CarsRecord car;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: StreamBuilder<List<FacturesRecord>>(
          stream: queryFacturesRecord(
            queryBuilder: (facturesRecord) =>
                facturesRecord.where('car_id', isEqualTo: car.car_id),
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: BillTheme.of(context).primaryColor,
                ),
              );
            }
            List<FacturesRecord> facturesRecordList = snapshot.data!;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: facturesRecordList.length,
              itemBuilder: (context, listViewIndex) {
                final listViewFacturesRecord =
                    facturesRecordList[listViewIndex];
                return InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FactureDetailScreen(
                          facture: facturesRecordList,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(listViewFacturesRecord.name!),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
