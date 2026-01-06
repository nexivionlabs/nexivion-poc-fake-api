
import 'package:flutter/material.dart';

import '../extension/context_extension.dart';




// Onboard Const

// Month Name Map
Map<int, String> monthNameMap = {
  1: "Ocak",
  2: "Şubat",
  3: "Mart",
  4: "Nisan",
  5: "Mayıs",
  6: "Haziran",
  7: "Temmuz",
  8: "Ağustos",
  9: "Eylül",
  10: "Ekim",
  11: "Kasım",
  12: "Aralık",
};

final List<String> cityDistricts=[
  "İlçe Seçiniz",
  "Adalar",
  "Bağcılar",
  "Bahçelievler",
  "Bakırköy",
  "Beşiktaş",
  "Beykoz",
  "Beyoğlu",
  "Büyükçekmece",
  "Çatalca",
  "Eminönü",
  "Esenler",
  "Eyüp",
  "Fatih",
  "Gaziosmanpaşa",
  "Güngören",
  "Kadıköy",
  "Kağıthane",
  "Kartal",
  "Küçükçekmece",
  "Maltepe",
  "Pendik",
  "Sarıyer",
  "Silivri",
  "Şile",
  "Şişli",
  "Sultanbeyli",
  "Tuzla",
  "Ümraniye",
  "Üsküdar",
  "Zeytinburnu"
];

// Weekday Name Map
Map<int, String> weekdayNameMap = {
  1: "Pzt",
  2: "SL",
  3: "Çrş",
  4: "Prş",
  5: "Cum",
  6: "Cmt",
  7: "Pzr",
};

/// Custom Height
SizedBox heightCustomPer(
    {required BuildContext context, required double percent}) {
  return SizedBox(
    height: context.screenWidth * percent,
  );
}

/// Screen-height %1
SizedBox height1Per({required BuildContext context}) {
  return SizedBox(
    height: context.screenWidth * 0.02,
  );
}

/// Screen-height %2
SizedBox height2Per({required BuildContext context}) {
  return SizedBox(
    height: context.screenWidth * 0.02,
  );
}

/// Screen-height %3
SizedBox height3Per({required BuildContext context}) {
  return SizedBox(
    height: context.screenWidth * 0.03,
  );
}

/// Screen-height %4
SizedBox height4Per({required BuildContext context}) {
  return SizedBox(
    height: context.screenWidth * 0.02,
  );
}

/// Screen-height %5
SizedBox height5Per({required BuildContext context}) {
  return SizedBox(
    height: context.screenWidth * 0.05,
  );
}

/// Screen-height %7
SizedBox height7Per({required BuildContext context}) {
  return SizedBox(
    height: context.screenWidth * 0.07,
  );
}

/// Screen-height %10
SizedBox height10Per({required BuildContext context}) {
  return SizedBox(
    height: context.screenWidth * 0.1,
  );
}

/// Screen-height %15
SizedBox height15Per({required BuildContext context}) {
  return SizedBox(
    height: context.screenWidth * 0.15,
  );
}

/// Screen-height %20
SizedBox height20Per({required BuildContext context}) {
  return SizedBox(
    height: context.screenWidth * 0.2,
  );
}

/// Screen-height %25
SizedBox height25Per({required BuildContext context}) {
  return SizedBox(
    height: context.screenWidth * 0.25,
  );
}

/// Screen-height %30
SizedBox height30Per({required BuildContext context}) {
  return SizedBox(
    height: context.screenWidth * 0.3,
  );
}

/// Screen-height %40
SizedBox height40Per({required BuildContext context}) {
  return SizedBox(
    height: context.screenWidth * 0.4,
  );
}

/// Screen-height %50
SizedBox height50Per({required BuildContext context}) {
  return SizedBox(
    height: context.screenWidth * 0.5,
  );
}

// Widths

// Custom Width
SizedBox widthCustomPer(
    {required BuildContext context, required double percent}) {
  return SizedBox(
    width: context.screenWidth * percent,
  );
}

/// Screen-width %1
SizedBox width1Per({required BuildContext context}) {
  return SizedBox(
    width: context.screenWidth * 0.01,
  );
}

/// Screen-width %2
SizedBox width2Per({required BuildContext context}) {
  return SizedBox(
    width: context.screenWidth * 0.02,
  );
}

/// Screen-width %3
SizedBox width3Per({required BuildContext context}) {
  return SizedBox(
    width: context.screenWidth * 0.03,
  );
}

/// Screen-width %4
SizedBox width4Per({required BuildContext context}) {
  return SizedBox(
    width: context.screenWidth * 0.04,
  );
}

/// Screen-width %5
SizedBox width5Per({required BuildContext context}) {
  return SizedBox(
    width: context.screenWidth * 0.05,
  );
}

/// Screen-width %7
SizedBox width7Per({required BuildContext context}) {
  return SizedBox(
    width: context.screenWidth * 0.07,
  );
}

/// Screen-width %10
SizedBox width10Per({required BuildContext context}) {
  return SizedBox(
    width: context.screenWidth * 0.1,
  );
}

/// Screen-width %15
SizedBox width15Per({required BuildContext context}) {
  return SizedBox(
    width: context.screenWidth * 0.15,
  );
}

/// Screen-width %20
SizedBox width20Per({required BuildContext context}) {
  return SizedBox(
    width: context.screenWidth * 0.2,
  );
}

/// Screen-width %25
SizedBox width25Per({required BuildContext context}) {
  return SizedBox(
    width: context.screenWidth * 0.25,
  );
}

/// Screen-width %30
SizedBox width30Per({required BuildContext context}) {
  return SizedBox(
    width: context.screenWidth * 0.3,
  );
}

/// Screen-width %40
SizedBox width40Per({required BuildContext context}) {
  return SizedBox(
    width: context.screenWidth * 0.4,
  );
}

/// Screen-width %50
SizedBox width50Per({required BuildContext context}) {
  return SizedBox(
    width: context.screenWidth * 0.5,
  );
}

