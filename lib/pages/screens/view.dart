import 'dart:math';

import 'package:app/core/design/navigator.dart';
import 'package:app/core/string.dart';
import 'package:app/pages/pages/contact_us.dart';
import 'package:app/pages/pages/log.dart';
import 'package:app/pages/pages/references.dart';
import 'package:app/pages/screens/details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewPage extends StatefulWidget {
  final int categoryNumber;

  const ViewPage({super.key, required this.categoryNumber});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  bool rowView = true;


  static const rowKey = 'app_view';


  @override
  void initState() {
    super.initState();
    loadMode();
  }


  Future<void> loadMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      rowView = prefs.getBool(rowKey) ?? true;
    });
  }

  Future<void> saveMode(bool newMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(rowKey, newMode);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            drawer: Drawer(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 24.w).copyWith(top: 50.h),
                child: ListView.separated(
                  itemCount: branchDrawer.length,
                  separatorBuilder: (context, index) => SizedBox(height: 24.h),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      if (index < 7) {
                        AppGoto(ViewPage(
                          categoryNumber: index,
                        ));
                      } else if (index == 7) {
                        AppGoto(EmailView());
                      } else if (index == 8) {
                        AppGoto(ReferencesView());
                      } else if (index == 9) {
                        AppGoto(LogView());
                      } else {
                        null;
                      }
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: SvgPicture.asset(
                            imagesDrawer[index],
                            colorFilter: ColorFilter.mode(
                                colorsDrawer[index], BlendMode.srcIn),
                          ),
                        ),
                        SizedBox(width: 24.w),
                        Text(
                          '${branchDrawer[index]}',
                          style: TextStyle(
                              fontFamily: 'title_font',
                              fontSize: 16,
                              color: colorsDrawer[index]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            appBar: AppBar(
              title: Text(branch[widget.categoryNumber],style: TextStyle(fontWeight: FontWeight.w500,fontFamily: 'title_font')),
              centerTitle: true,
              backgroundColor: Theme.of(context).colorScheme.primary,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(0.0).copyWith(left: 16),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        rowView = !rowView;
                        saveMode(rowView);

                      });
                    },
                    icon: Icon(Icons.view_cozy_outlined),
                    color: rowView ? null : Colors.green,
                    tooltip: 'اظهار نمط الشبكي',
                  ),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: SvgPicture.asset('assets/images/dont_know.svg'),
              onPressed: () {
                AppGoto(DetailsView(
                  itemNumber:
                      Random().nextInt(modelList[widget.categoryNumber].length),
                  categoryNumber: widget.categoryNumber,
                ));
              },
            ),
            body: rowView
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 8.w,
                      childAspectRatio: 200 / 70,
                      mainAxisSpacing: 8.h,
                    ),
                    padding: EdgeInsets.all(8.r),
                    itemCount: modelList[widget.categoryNumber].length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        AppGoto(DetailsView(
                            itemNumber: index,
                            categoryNumber: widget.categoryNumber));
                      },
                      child: Container(
                        height: 70.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                offset: const Offset(0, 4),
                                blurRadius: 4),
                          ],
                        ),
                        child: Row(
                          children: [
                            ///Container 01
                            Expanded(
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0.r)
                                        .copyWith(
                                            topRight: Radius.circular(8.r),
                                            bottomRight: Radius.circular(8.r))),
                                child: Image.asset(
                                  modelList[widget.categoryNumber][index]
                                      ['image'],
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                              ),
                            ),

                            ///Container 02
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.65,
                              child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            modelList[widget.categoryNumber]
                                                [index]['title_ar'],
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: 'font01',
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                modelList[widget.categoryNumber]
                                                        [index]
                                                    ['stats'] = !modelList[
                                                        widget.categoryNumber]
                                                    [index]['stats'];
                                              });
                                            },
                                            icon: Icon(
                                              !modelList[widget.categoryNumber]
                                                      [index]['stats']
                                                  ? Icons.favorite_border
                                                  : Icons.favorite,
                                              color: Colors.redAccent,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: _customContainer(
                                                txt:
                                                    'المستوي : ${modelList[widget.categoryNumber][index]['level']}'),
                                          ),
                                          const SizedBox(width: 9),
                                          Expanded(
                                            child: _customContainer(
                                                txt:
                                                    'مدة التحضير ${modelList[widget.categoryNumber][index]['prep_time']} د'),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.h),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: _customContainer(
                                                txt:
                                                    'عدد المقادير  ${(modelList[widget.categoryNumber][index]['ingredients'] as List?)?.length ?? 0}'),
                                          ),
                                          SizedBox(width: 9.w),
                                          Expanded(
                                            child: _customContainer(
                                                txt:
                                                    'مدة الطهو ${modelList[widget.categoryNumber][index]['cook_time']} د'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(16.h),
                    child: GridView.builder(
                      itemCount: modelList[widget.categoryNumber].length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 16.h,
                          childAspectRatio: 300.w / 400.h),
                      itemBuilder: (context, index) => InkWell(
                        enableFeedback: true,
                        autofocus: true,
                        onTap: () {
                          AppGoto(DetailsView(
                              itemNumber: index,
                              categoryNumber: widget.categoryNumber));
                        },
                        child: Container(
                          clipBehavior: Clip.antiAlias,
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
                          child: Stack(
                            clipBehavior: Clip.antiAlias,
                            alignment: Alignment.bottomLeft,
                            children: [
                              Image.asset(
                                modelList[widget.categoryNumber][index]
                                    ['image'],
                                fit: BoxFit.cover,
                                height: double.infinity,
                                width: double.infinity,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(),
                                      Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            modelList[widget.categoryNumber]
                                                [index]['stats'] = !modelList[
                                                    widget.categoryNumber]
                                                [index]['stats'];
                                          });
                                        },
                                        icon: Icon(
                                          !modelList[widget.categoryNumber]
                                                  [index]['stats']
                                              ? Icons.favorite_border
                                              : Icons.favorite,
                                          color: Colors.redAccent,
                                        ),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    color: Color(0xFFFFFFFF).withOpacity(0.5),
                                    height: 60,
                                    width: double.infinity,
                                    child: Center(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Text(
                                          modelList[widget.categoryNumber]
                                              [index]['title_ar'],
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'font01',
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )));
  }

  Widget _customContainer({required String txt}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.r),
      height: 20.h,
      width: 75.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Text(txt),
    );
  }


}
