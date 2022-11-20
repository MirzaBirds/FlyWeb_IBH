import 'package:flutter/material.dart';
import 'package:flyweb/src/models/setting.dart';
import 'package:flyweb/src/models/settings.dart';
import 'package:flyweb/src/services/theme_manager.dart';
import 'package:provider/provider.dart';

import 'HexColor.dart';

class DialogUtils {
  static generic(context,
      {required Function onPositive,
      required Function onNegative,
      title,
      message,
      Settings? settings}) {
    var themeProvider = Provider.of<ThemeNotifier>(context, listen: false);

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        clipBehavior: Clip.antiAlias,
        contentPadding: EdgeInsets.all(0),
        backgroundColor: Colors.white,
        //title: new Text(title ?? 'Warning!'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[

                    themeProvider.isLightTheme
                        ? HexColor(Setting.getValue(
                        settings!.setting!, "firstColor"))
                        : themeProvider.darkTheme.primaryColor,
                    themeProvider.isLightTheme
                        ? HexColor(Setting.getValue(
                        settings!.setting!, "secondColor"))
                        : themeProvider.darkTheme.primaryColor,


                  ],
                ),
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Icon(
                  Icons.add_location_alt,
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: new Text(message ??
                  'Abbiamo bisogno di conoscere la tua posizione attuale per consentire l\'utilizzo dei nostri servizi. \nLa tua posizione non verrà condivisa con nessuno utente non verrà salvata sui nostri server.'),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
              child: new Text(
                "Annulla",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              onPressed: onNegative as void Function()
                  ),
          FlatButton(
              child: new Text(
                "OK",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              onPressed: () {
                if (onPositive != null) {
                  onPositive();
                }
                return Navigator.of(context).pop(true);
              }),
        ],
      ),
    );
  }
}
