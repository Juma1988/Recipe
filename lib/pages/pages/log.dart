import 'package:app/pages/models/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogView extends StatelessWidget {
  const LogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('السجل',style: TextStyle(fontWeight: FontWeight.w500,fontFamily: 'title_font'),),
        centerTitle: true,),
        body: ListView.separated(
          padding: EdgeInsets.all(16.r),
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemCount: log.length,
          itemBuilder: (context, index) => Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 5),
                  blurRadius: 10,
                )
              ],
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    _getStatusIcon(log[index]['status'] ?? 0),
                    height: 33.h,
                    width: 33.w,
                  ),
                  SizedBox(width: 5.w),
                  VerticalDivider(
                    color: Colors.grey,
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          log[index]['title'],
                          style: TextStyle(
                              fontFamily: 'title_font',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        log[index]['time'].toString().isEmpty
                            ? Text('غير معروف',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500))
                            : Text(log[index]['time'],
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500)),
                        log[index]['body'].toString().isEmpty
                            ? Text('-')
                            : Text(log[index]['body'],
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF989898))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getStatusIcon(int status) {
    if (status == 1) {
      return 'assets/svg/add.svg';
    } else if (status == -1) {
      return 'assets/svg/remove.svg';
    } else {
      return 'assets/svg/disable.svg';
    }
  }
}
