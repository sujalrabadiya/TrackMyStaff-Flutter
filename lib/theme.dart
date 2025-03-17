import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF1B383A);
const kSecondaryColor = Color(0xFF59706F);
const kDarkGreyColor = Color(0xFFA8A8A8);
const kWhiteColor = Color(0xFFFFFFFF);
const kZambeziColor = Color(0xFF5B5B5B);
const kBlackColor = Color(0xFF272726);
const kTextFieldColor = Color(0xFF979797);
const kBackgroundColor = Color.fromARGB(255, 235, 232, 219);
const kSenderColor = Color(0xFFC8E6C9);
const kReceiverColor = Color(0xFFEEEEEE);
const kTransparentColor = Colors.transparent;
const List<Color> kGradientColors = [
  kPrimaryColor,
  kSecondaryColor,
  kDarkGreyColor
];

const kDefaultPadding = EdgeInsets.symmetric(horizontal: 30);
const kDefaultPadding2 = EdgeInsets.only(top: 10,left: 10,right: 10);

int layoutIndex = 2;

TextStyle titleText =
    TextStyle(color: kPrimaryColor, fontSize: 32, fontWeight: FontWeight.w700);
TextStyle appbarText = TextStyle(
    color: kBackgroundColor, fontSize: 17, fontWeight: FontWeight.w600);
TextStyle pageTitle =
    TextStyle(color: kPrimaryColor, fontSize: 20, fontWeight: FontWeight.w600);
TextStyle subTitle = TextStyle(
    color: kSecondaryColor, fontSize: 16, fontWeight: FontWeight.w500);
TextStyle subTitle2 = TextStyle(
    color: kSecondaryColor, fontSize: 15, fontWeight: FontWeight.w500);
TextStyle detailText = TextStyle(
    color: kSecondaryColor, fontSize: 12, fontWeight: FontWeight.w500);
TextStyle textButton = TextStyle(
  color: kPrimaryColor, fontSize: 18, fontWeight: FontWeight.w700,
);
TextStyle listTileText = TextStyle(color: kBlackColor, fontSize: 14);
