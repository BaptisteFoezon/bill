import 'package:bill/src/bill/bill_theme.dart';
import 'package:bill/src/views/screens/actions/transfert_car/transfert_car.dart';
import 'package:flutter/material.dart';

class TransfertCarButtonWidget extends StatelessWidget {
  const TransfertCarButtonWidget({
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
              builder: (context) => const TransfertCarScreen(),
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
                    Icons.transfer_within_a_station,
                    color: BillTheme.of(context).textBtnColor,
                    size: 24,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                  child: Text(
                    'Transferer un véhicule',
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
