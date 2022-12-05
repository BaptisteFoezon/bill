import 'package:bill/src/auth/auth_util.dart';
import 'package:bill/src/bill/bill_theme.dart';
import 'package:bill/src/bill/bill_util.dart';
import 'package:flutter/material.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  ProfilScreenState createState() => ProfilScreenState();
}

class ProfilScreenState extends State<ProfilScreen>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var lightMode =
        Theme.of(context).brightness == Brightness.light ? true : false;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: BillTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: const Color(0xFF00A3FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                    child: AuthUserStreamWidget(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.network(
                          "https://picsum.photos/seed/1/200",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: AuthUserStreamWidget(
                    child: Text(
                      currentUserDisplayName,
                      style: BillTheme.of(context).title3.override(
                            fontFamily: 'Outfit',
                            color: BillTheme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: Text(
                    currentUserEmail,
                    style: BillTheme.of(context).subtitle2.override(
                          fontFamily: 'Outfit',
                          color: BillTheme.of(context).primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                //FlutterShare.share(title: 'Share UID'),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: Text(
                    currentUserUid,
                    style: BillTheme.of(context).subtitle2.override(
                          fontFamily: 'Outfit',
                          color: BillTheme.of(context).primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                const Divider(
                  height: 10,
                  thickness: 2,
                  indent: 100,
                  endIndent: 100,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
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
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(8, 12, 8, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.dark_mode,
                                color: BillTheme.of(context).textBtnColor,
                                size: 24,
                              ),
                              Text(
                                'Mode Sombre',
                                style: BillTheme.of(context).bodyText2.override(
                                      fontFamily: 'Outfit',
                                      color: BillTheme.of(context).textBtnColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              Switch(
                                value: lightMode,
                                onChanged: (bool value) {
                                  if (lightMode) {
                                    BillTheme.saveThemeMode(ThemeMode.dark);
                                    setDarkModeSetting(context, ThemeMode.dark);
                                  } else {
                                    BillTheme.saveThemeMode(ThemeMode.light);
                                    setDarkModeSetting(
                                        context, ThemeMode.light);
                                  }
                                  setState(() {
                                    lightMode = !value;
                                  });
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const EditProfilWidget(),
                const AccountSettingWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AccountSettingWidget extends StatelessWidget {
  const AccountSettingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
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
                  Icons.settings_outlined,
                  color: BillTheme.of(context).textBtnColor,
                  size: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                child: Text(
                  'Réglages',
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
    );
  }
}

class EditProfilWidget extends StatelessWidget {
  const EditProfilWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
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
                  Icons.account_circle_outlined,
                  color: BillTheme.of(context).textBtnColor,
                  size: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                child: Text(
                  'Modifier mon profil',
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
    );
  }
}
