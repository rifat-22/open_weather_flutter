import 'package:flutter/material.dart';

class ColorUtil {
  static final MaterialColor primary = MaterialColor(0xFF1C2B36, primarySwatch);
  static final MaterialColor primaryDark =
  MaterialColor(0xFF000010, primaryDarkSwatch);
  static final MaterialColor accent = MaterialColor(0xFF209E91, accentSwatch);

  static Map<int, Color> primarySwatch = {
    50: Color.fromRGBO(28, 43, 54, .1),
    100: Color.fromRGBO(28, 43, 54, .2),
    200: Color.fromRGBO(28, 43, 54, .3),
    300: Color.fromRGBO(28, 43, 54, .4),
    400: Color.fromRGBO(28, 43, 54, .5),
    500: Color.fromRGBO(28, 43, 54, .6),
    600: Color.fromRGBO(28, 43, 54, .7),
    700: Color.fromRGBO(28, 43, 54, .8),
    800: Color.fromRGBO(28, 43, 54, .9),
    900: Color.fromRGBO(28, 43, 54, 1),
  };

  static Map<int, Color> primaryDarkSwatch = {
    50: Color.fromRGBO(0, 0, 16, .1),
    100: Color.fromRGBO(0, 0, 16, .2),
    200: Color.fromRGBO(0, 0, 16, .3),
    300: Color.fromRGBO(0, 0, 16, .4),
    400: Color.fromRGBO(0, 0, 16, .5),
    500: Color.fromRGBO(0, 0, 16, .6),
    600: Color.fromRGBO(0, 0, 16, .7),
    700: Color.fromRGBO(0, 0, 16, .8),
    800: Color.fromRGBO(0, 0, 16, .9),
    900: Color.fromRGBO(0, 0, 16, 1),
  };

  static Map<int, Color> accentSwatch = {
    50: Color.fromRGBO(32, 158, 145, .1),
    100: Color.fromRGBO(32, 158, 145, .2),
    200: Color.fromRGBO(32, 158, 145, .3),
    300: Color.fromRGBO(32, 158, 145, .4),
    400: Color.fromRGBO(32, 158, 145, .5),
    500: Color.fromRGBO(32, 158, 145, .6),
    600: Color.fromRGBO(32, 158, 145, .7),
    700: Color.fromRGBO(32, 158, 145, .8),
    800: Color.fromRGBO(32, 158, 145, .9),
    900: Color.fromRGBO(32, 158, 145, 1),
  };

  static const Color bgTransperant = Colors.transparent;
  static const Color bgWhite = Colors.white;
  static const Color bgWhite2 = Color(0xFFFBFCFC);
  static const Color bgWhite3 = Color(0xFFFDFEFE);

  static const Color
  red = Colors.red;
  static const Color bgGrey = Color(0xFFF3F5F5);
  static const Color bgGreyDark = Color(0xFFDDE6E6);
  static const Color bgGreyLight = Color(0xFFFBFBFB);

  static const Color bgGreyLight2 = Color(0xFFF9F9F9);

  static const Color statusBar = Color(0xFF1C2A37);
  static const Color navigationBar = Color(0xFF1C2A37);

  static const Color navSelected = Color(0xFF209E91);
  static const Color navDeselected = Colors.grey;

  static const Color filterSelected = Color(0xFFCDDC39);
  static const Color filterDeselected = Color(0xFFF3F5F5);
  static const Color punchFingerIcon = Color(0xFFD286AE);
  static const Color imageBorder = Color(0xFFE8E8E8);

  static const Color button = Color(0xFF209E91);
  static const Color buttonDark = Color(0xFF14645c);

  static const Color buttonDisabled = Color(0x11000000);
  static const Color buttonEnabled = Color(0xFF43A047);
  static const Color punch_btn_1 = Color(0xFF86C388);
  static const Color punch_btn_2 = Color(0xFFC5E6C7);
  static const Color punch_btn_3 = Color(0xFFE5E5E3);
  static const Color punch_btn_progress = Color(0xFFFCB84D);

  static const Color title = Color(0xFF2E2E2E);
  static const Color infoTitle = Color(0xFF7F8080);
  static const Color subTitleLight = Color(0xFF6D6D6D);
  static const Color subTitleDark = Color(0xFF616262);
  static const Color divider = Color(0xFF2E2E2E);

  static const Color defaultText = Color(0xFF616262);
  static const Color simpleText = Colors.grey;
  static const Color okText = Color(0xFF209E91);
  static const Color warningText = Color(0xFFD50000);

  static const Color chartPresent = Color(0xFF299D91);
  static const Color chartLate = Color(0xFFE1BE47);
  static const Color chartAbsent = Color(0xFFE65759);
  static const Color chartLeave = Color(0xFF91B723);

  static const Color enrollStartBg = Color(0xFF1B8278);
  static const Color enrollStartBorder = Color(0xFF5fA7A0);
  static const Color enrollStopBg = Color(0xFFF01010);
  static const Color enrollStopBorder = Color(0xFFF56666);

  static const Color resultSuccessfull = Color(0xFF33BC7C);
  static const Color resultSuccessfullBtn = Color(0xFF1B8278);
  static const Color resultFailed = Color(0xFFF01010);

  static const Color attCalOk = Color(0xFFF3F3F3);
  static const Color attCalWarning = Color(0xFFFFEBEB);

  static const Color allocate = Color(0xFF33BC7C);
  static const Color revoke = Color(0xFFF01010);

  static const Color dashboardAttOntime = Color(0xFF33BC7C);
  static const Color dashboardAttLate = Color(0xFFFFB300);
  static const Color dashboardAttTotalHour = Color(0xFF1C2B36);

  static const Color loginDarkBackground = Color(0xFF1C2A37);

  static const Color manualPageHour = Color(0xFFD0E8E8);
  static const Color manualPageMinute = Color(0xFFF1F5F6);
  static const Color manualPageAMBorder = Color(0xFFC5C5C5);

  static const Color reasonTextBorder = Color(0xFFDFDFDF);
  static const Color reasonTextHint = Color(0xFF5E5E5E);
  static const Color leavePageContainerBorder = Color(0xFFD6D6D6);
  static const Color leavePageFileBackground = Color(0xFFF1F5F6);
  static const Color leavePageJPG = Color(0xFF808588);
  static const Color leavePageHollowCircle = Color(0xFF5E5E5E);

  static const Color widgetEncloseBorder = Color(0xFFDFDFDF);

  static const Color pending = Color(0xFFFFA500);
  static const Color accepted = Color(0xFF209E91);
  static const Color rejected = Color(0xFFF01010);
  static const Color pagerSelected = Color(0xFF3D3D3D);
  static const Color pagerUnselected = Color(0xFF989999);

  static const Color logout = Colors.red;
  static const Color collapsiblePageDivider = Color(0xFFDDE6E6);

  static const Color cardButton = Color(0xFFF8FFFF);
  static const Color cardButtonBorder = Color(0xFFE0F1F0);

  static const Color adminCreateSuccessBackground = Color(0xFF01CB7B);
  static const Color takeFingerHandSelect = Color(0xFFEDF7F6);
  static const Color takeFingerSuccess = Color(0xFF2EB87C);
  static const Color warning = Color(0xFFFE7200);

  static const Color profileBlueBackground = Color(0xFFE8F2F3);
  static const Color profileBlueLine = Color(0xFFDFEBEB);
  static const Color onBoardFirstFingerprint = Color(0xFF00CB7A);

  static const Color newButtonPunchCentre = Colors.white;
  static const Color newButtonPunchBorder = Color(0xFFDDE6E6);
  static const Color newButtonProgress = Color(0xFF01CB7B);

  static const Color punchButtonBackground = Color(0xFF1C2A37);


}
