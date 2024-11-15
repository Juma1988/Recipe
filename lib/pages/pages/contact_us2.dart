import 'package:app/core/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailView extends StatefulWidget {
  const EmailView({super.key});

  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  final Uri _whatsAppurl = Uri.parse('https://wa.me/201508454471');
  final Uri _emailLaunchUri =
      Uri(scheme: 'mailto', path: 'recipe.reply1988@gmail.com');

  Future<void> _launchWhatsApp() async {
    if (!await launchUrl(_whatsAppurl)) {
      throw Exception('Could not launch $_whatsAppurl');
    }
  }

  Future<void> _launchEmailApp() async {
    if (!await launchUrl(_emailLaunchUri)) {
      throw Exception('Could not launch $_emailLaunchUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'التواصل',
            style: TextStyle(
                fontWeight: FontWeight.w500, fontFamily: 'title_font'),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Lottie.network(
                  'https://assets5.lottiefiles.com/packages/lf20_u25cckyh.json',
                  width: 240,
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 24.h),
              Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    contactUsMsg,
                    style: TextStyle(
                        fontFamily: 'title_font',
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 42),
                      Row(
                        children: [
                          Expanded(
                              child: _inkwill(
                                  image: 'assets/images/gmail.png',
                                  onTap: () {
                                    _launchEmailApp();
                                  },
                                  width: 120,
                                  height: 120)),
                          Expanded(
                              child: _inkwill(
                                  image: 'assets/images/whatsapp.png',
                                  onTap: () {
                                    _launchWhatsApp();
                                  },
                                  width: 100,
                                  height: 100)),
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _inkwill(
      {required String image,
      void Function()? onTap,
      required double height,
      required double width}) {
    return Column(
      children: [
        InkWell(
            onTap: onTap,
            child: Expanded(
              child: Image.asset(
                image,
                height: height,
                width: width,
                fit: BoxFit.cover,
              ),
            )),
      ],
    );
  }
}
