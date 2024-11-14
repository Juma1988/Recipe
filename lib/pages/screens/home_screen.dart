import 'dart:math';

import 'package:app/core/design/navigator.dart';
import 'package:app/core/design/show_msg.dart';
import 'package:app/core/string.dart';
import 'package:app/pages/screens/details_view.dart';
import 'package:app/pages/screens/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final int categoryNumber;
  late final int xIndex;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            title: Center(
          child: Row(
            children: [
              Text('هناكل ايه'),
              Spacer(),
              IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () {
                  appShowMsg('يمكن الضغط مرتين لعمل اختيار عشوائي');
                },
              )
            ],
          ),
        )),
        body: Padding(
          padding: EdgeInsets.all(16.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16),
                _Grid1(),
                SizedBox(height: 16),
                _Grid2(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Grid1 extends StatelessWidget {
  const _Grid1();

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
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
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
                colorFilter:
                    ColorFilter.mode(colorsDrawer[index], BlendMode.srcIn),
              ),
              SizedBox(height: 12.h),
              Text(
                branch[index],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 21,
                  fontFamily: 'font',
                  color: colorsDrawer[index],
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
  const _Grid2();

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
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
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
                colorFilter:
                    ColorFilter.mode(colorsDrawer[index + 1], BlendMode.srcIn),
              ),
              SizedBox(height: 12.h),
              Text(
                branch[index + 1],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 21,
                  fontFamily: 'font',
                  color: colorsDrawer[index + 1],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
