import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:findmyspot/src/constants/text_strings.dart';
import 'package:findmyspot/src/view/getStarted_screen/getStarted.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constants/image_strings.dart';


class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final controller = PageController();
  int currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
    'image':welcomeScreen1,
      'caption': getRfidCard,
      'description': discriptionScreen1,
    },
    {
      'image':welcomeScreen2 ,
      'caption': getTracking,
      'description': discriptionScreen2,
    },
    {
      'image': welcomeScreen3,
      'caption': InstantPay,
      'description': discriptionScreen3
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(32, 40, 32, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        _pages[index]['image'],
                        height: 400,
                        width: 500
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Stack(
            children: [
              Image.asset(
                  welcomeCurve,
                  // height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  ),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 70, 60, 0),
                child: Column(
                  children: [
                    Text(
                      _pages[currentPage]['caption'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      _pages[currentPage]['description'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 70.0),
                    SmoothPageIndicator(
                      controller: controller,
                      count: _pages.length,
                      effect: JumpingDotEffect(
                          spacing: 10,
                          dotColor: Colors.grey,
                          activeDotColor: Colors.white
                      ),

                    ),
                  ],
                ),
              )
            ],
          )

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (currentPage == _pages.length - 1) {
            Get.to(getStarted());
          } else {
            // Move to the next page
            controller.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        },
        child: Icon(currentPage == _pages.length - 1 ? Icons.done : Icons.arrow_forward),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}