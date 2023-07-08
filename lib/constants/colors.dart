import 'package:flutter/material.dart';

List<Color> backgroundColors = [
  const Color(0xFFCCE5FF), // light blue
  const Color(0xFFD7F9E9), // pale green
  const Color(0xFFFFF8E1), // pale yellow
  const Color(0xFFF5E6CC), // beige
  const Color(0xFFFFD6D6), // light pink
  const Color(0xFFE5E5E5), // light grey
  const Color(0xFFFFF0F0), // pale pink
  const Color(0xFFE6F9FF), // pale blue
  const Color(0xFFD4EDDA), // mint green
  const Color(0xFFFFF3CD), // pale orange
];

const kPrimaryColor = Color(0xFF1B383A);
const kSecondaryColor = Color(0xFF59706F);
const kDarkGreyColor = Color(0xFFA8A8A8);
const kWhiteColor = Color(0xFFFFFFFF);
const kZambeziColor = Color(0xFF5B5B5B);
const kBlackColor = Color(0xFF272726);
const kTextFieldColor = Color(0xFF979797);

const kDefaultPadding = EdgeInsets.symmetric(horizontal: 30);

TextStyle titleText = const TextStyle(
    color: kPrimaryColor, fontSize: 32, fontWeight: FontWeight.w700);
TextStyle subTitle = const TextStyle(
    color: kSecondaryColor, fontSize: 18, fontWeight: FontWeight.w500);
TextStyle textButton = const TextStyle(
  color: kPrimaryColor,
  fontSize: 18,
  fontWeight: FontWeight.w700,
);
