import 'package:app/pages/models/drinks.dart';
import 'package:app/pages/models/late_night.dart';
import 'package:app/pages/models/lunch.dart';
import 'package:app/pages/models/salad.dart';
import 'package:app/pages/models/sauces.dart';
import 'package:app/pages/models/soup.dart';
import 'package:app/pages/models/sweets.dart';
import 'package:flutter/material.dart';

final List<String> referencesList = [
  'اصوات مصرية',
  'شيماء شربي ',
  'مطبخ شيرين',
  'هند المغربي',
  'I thank ',
];
final List<String> referencesUrl = [
  'https://www.facebook.com/Gehadd.Hassann',
  'https://www.facebook.com/profile.php?id=61565498805414',
  'https://www.facebook.com/profile.php?id=100064057717311',
  'https://www.facebook.com/profile.php?id=100090153194027',
  'https://www.facebook.com/profile.php?id=100089528084456',
];
final List<String> referencesProfileImage = [
  'https://scontent.fcai22-4.fna.fbcdn.net/v/t39.30808-6/461747479_905458671442628_1282770399515837123_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=5BmjuCu_xc4Q7kNvgG_H06m&_nc_zt=23&_nc_ht=scontent.fcai22-4.fna&_nc_gid=AiLIkD6Sriijvv38i1-50Aw&oh=00_AYAz4uZ0Uxb5Q6rg0ULjgpETZHu2epTu7X0x_C7zwA5f_Q&oe=67271643',
  'https://scontent.fcai22-1.fna.fbcdn.net/v/t39.30808-6/459988036_122106269702516626_8136793535164989031_n.jpg?_nc_cat=1&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=Gq6H__uIMuYQ7kNvgEQdCGm&_nc_zt=23&_nc_ht=scontent.fcai22-1.fna&_nc_gid=AHghcaFbrP1-Yeg9RrkgrZM&oh=00_AYB_-_8SRnuS2ka_s7v1EMOeFUEpBdzEN_eQtHxZrzZI4w&oe=672D65EC',
  'https://scontent.fcai22-4.fna.fbcdn.net/v/t39.30808-6/426179602_788853966593187_3486882243457960243_n.jpg?_nc_cat=1&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=NtOvrQ1L63oQ7kNvgHrF6VL&_nc_zt=23&_nc_ht=scontent.fcai22-4.fna&_nc_gid=AisVHVbCMuaL86v2FZJ07pz&oh=00_AYDrXA2BCGbRgxRc0-Y6IvT1AlUsUsYR91moVUMZXqi0GA&oe=67313A3B',
  'https://scontent.fcai22-1.fna.fbcdn.net/v/t39.30808-6/457255198_472669202414849_7098652276444547531_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=uMlwJ6gxX6wQ7kNvgHiEgwM&_nc_zt=23&_nc_ht=scontent.fcai22-1.fna&_nc_gid=AUgc5rnsIxmQVSCF5a8SFfR&oh=00_AYCT26xUqLlmxtIgaGVVvz2aP7Z_PV3P_y667TycQ82BrA&oe=67313E3E',
  'https://scontent.fcai22-1.fna.fbcdn.net/v/t39.30808-6/392758041_255875594073375_6831372787029295562_n.jpg',
];

final List<List> modelList = [
  lunch,
  soup,
  salad,
  sauces,
  sweets,
  drinks,
  lateSnack,
];
final List<String> branch = [
  'وجبات رئيسية',
  'شوربا',
  'سلطات',
  'الصلصات',
  'حلويات',
  'مشروبات',
  'الليل و اخره'
];
final List<String> images = [
  'assets/svg/lunch.svg',
  'assets/svg/soup.svg',
  'assets/svg/salad.svg',
  'assets/svg/sauces.svg',
  'assets/svg/sweet.svg',
  'assets/svg/drinks.svg',
  'assets/svg/moon.svg',
];

final List<Color> colorsDrawer = [
  Colors.cyan,
  Colors.pinkAccent,
  Colors.purple,
  Colors.orange,
  Colors.teal,
  Colors.green,
  Colors.amber,
  Colors.deepPurple,
  Colors.redAccent,
  Colors.deepOrange,
  Colors.redAccent
];
final List<String> branchDrawer = [
  'وجبات رئيسية',
  'شوربا',
  'سلطات',
  'الصلصات',
  'حلويات',
  'مشروبات',
  'الليل و اخره',
  'للتواصل و للاضافة و التعديل',
  'مصادر',
];

final List<String> imagesDrawer = [
  'assets/svg/lunch.svg',
  'assets/svg/soup.svg',
  'assets/svg/salad.svg',
  'assets/svg/sauces.svg',
  'assets/svg/sweet.svg',
  'assets/svg/drinks.svg',
  'assets/svg/moon.svg',
  'assets/svg/request.svg',
  'assets/svg/source.svg',
];
