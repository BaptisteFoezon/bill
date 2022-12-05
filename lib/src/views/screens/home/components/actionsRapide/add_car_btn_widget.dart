import 'package:bill/src/bill/bill_theme.dart';
import 'package:bill/src/views/screens/actions/add_car/add_car_screen.dart';
import 'package:flutter/material.dart';

class AddCarButtonWidget extends StatelessWidget {
  const AddCarButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCarScreen(),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: BillTheme.of(context).backgroundBtnColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: BillTheme.of(context).borderBtnColor,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 8, 12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                  child: Icon(
                    Icons.car_rental,
                    color: BillTheme.of(context).textBtnColor,
                    size: 24,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                  child: Text(
                    'Ajouter un véhicule',
                    style: BillTheme.of(context).bodyText2.override(
                          fontFamily: 'Outfit',
                          color: BillTheme.of(context).textBtnColor,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
