import 'dart:math';

import 'package:app/core/design/navigator.dart';
import 'package:app/core/design/show_msg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/core/string.dart';
import 'package:app/pages/screens/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'details_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final int categoryNumber;
  late final int xIndex;
  late bool mode = true;

  static const String modeKey = 'app_mode';


  @override
  void initState() {
    super.initState();
    loadMode();
  }


  Future<void> loadMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      mode = prefs.getBool(modeKey) ?? true;
    });
  }

  Future<void> saveMode(bool newMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(modeKey, newMode);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('هناكل ايه',style: TextStyle(fontWeight: FontWeight.w500,fontFamily: 'title_font')),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  mode = !mode;
                  saveMode(mode);
                });
              },
              child: Text(
                'Mode',
                style: TextStyle(color: Colors.black, fontFamily: 'font2'),
              ),
            ),
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                appShowMsg('يمكن الضغط مرتين لعمل اختيار عشوائي');
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16),
                _Grid1(mode),
                SizedBox(height: 16),
                _Grid2(mode),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Grid1 extends StatelessWidget {
  final bool mode;

  const _Grid1(this.mode);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: MediaQuery.of(context).size.width.w /
            MediaQuery.of(context).size.width /
            0.4.h,
      ),
      itemBuilder: (context, index) => InkWell(
        enableFeedback: true,
        autofocus: true,
        focusColor: colorsDrawer[index],
        onTap: () {
          AppGoto(
            ViewPage(
              categoryNumber: index,
            ),
          );
        },
        onDoubleTap: () {
          AppGoto(DetailsView(
            itemNumber: Random().nextInt(modelList[index].length),
            categoryNumber: index,
          ));
        },
        child: Container(
          decoration: BoxDecoration(
            color: mode ? Colors.white : colorsDrawer[index],
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                // color: Colors.black.withOpacity(0.25),
                color: colorsDrawer[index].withOpacity(0.25),
                offset: Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                images[index],
                width: 60.w,
                height: 60.h,
                colorFilter: mode
                    ? ColorFilter.mode(colorsDrawer[index], BlendMode.srcIn)
                    : ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn),
              ),
              SizedBox(height: 12.h),
              Text(
                branch[index],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 21,
                  fontFamily: 'font',
                  color: mode ? colorsDrawer[index] : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Grid2 extends StatelessWidget {
  final bool mode;

  const _Grid2(this.mode);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: branch.length - 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 300.w / 300.h),
      itemBuilder: (context, index) => InkWell(
        enableFeedback: true,
        autofocus: true,
        focusColor: colorsDrawer[index + 1],
        onTap: () {
          AppGoto(
            ViewPage(
              categoryNumber: index + 1,
            ),
          );
        },
        onDoubleTap: () {
          AppGoto(DetailsView(
            itemNumber: Random().nextInt(modelList[index].length),
            categoryNumber: index - 1,
          ));
        },
        child: Container(
          decoration: BoxDecoration(
            color: mode ? Colors.white : colorsDrawer[index + 1],
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                // color: Colors.black.withOpacity(0.25),
                color: mode? colorsDrawer[index + 1].withOpacity(0.25): Colors.white.withOpacity(0.25),
                offset: Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                images[index + 1],
                width: 60.w,
                height: 60.h,
                colorFilter: mode ?
                    ColorFilter.mode(colorsDrawer[index + 1], BlendMode.srcIn): ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn),
              ),
              SizedBox(height: 12.h),
              Text(
                branch[index + 1],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 21,
                  fontFamily: 'font',
                  color:mode? colorsDrawer[index + 1]: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
