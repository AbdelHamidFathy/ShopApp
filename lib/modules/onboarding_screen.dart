import 'package:flutter/material.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onboardingModel{
  final String image;
  final String title;
  final String description;

  onboardingModel({
    required this.image,
    required this.description,
    required this.title,
});
}

class OnboardingScreen extends StatefulWidget {

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List <onboardingModel>onboardingItems=[
    onboardingModel(
      image: 'assets/images/onboarding_1.png',
      title: 'Oboarding Title 1',
      description: 'onboarding Description 1',
    ),
    onboardingModel(
      image: 'assets/images/onboarding_2.png',
      title: 'Oboarding Title 2',
      description: 'onboarding Description 2',
    ),
    onboardingModel(
      image: 'assets/images/onboarding_3.png',
      title: 'Oboarding Title 3',
      description: 'onboarding Description 3',
    ),
  ];

  var controller =PageController();

  bool isLast=false;
  bool isDark=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          defaultTextButton(
            text: 'Skip', 
            onPressed: (){
              Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(
                  builder: (context)=>LoginScreen()
                ), 
                (route) => false
              );
              AppCubit.get(context).closeOnboard();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: 
          [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (index){
                  if (index==onboardingItems.length-1) {
                    setState(() {
                      isLast=true;
                    });
                  }
                  else{
                    setState(() {
                      isLast=false;
                    });
                  }
                },
                controller: controller,
                itemBuilder: (context, index){
                  return buildOnboardingItem(onboardingItems[index]);
                },
                itemCount: onboardingItems.length,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            SmoothPageIndicator(
              controller: controller, 
              count: onboardingItems.length,
              effect: ExpandingDotsEffect(
                dotColor: Colors.grey,
                activeDotColor: defaultColor,
                dotHeight: 10.0,
                dotWidth: 10.0,
                spacing: 5.0,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Row(
              children: [
                Spacer(),
                TextButton.icon(
                  onPressed: (){
                    if (isLast) {
                      AppCubit.get(context).closeOnboard();
                      Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context)=>LoginScreen()), 
                        (route) => false
                      );
                    }
                    else{
                      controller.nextPage(
                        duration:Duration(microseconds: 750) , 
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  }, 
                  icon: Icon(
                    Icons.arrow_right,
                    color: Colors.grey,
                  ), 
                  label: Text(
                    'Next',
                    style: TextStyle(
                      color: defaultColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnboardingItem(onboardingModel model){
    return Column(
      children: 
      [
        Expanded(
          child: Image(
            image: AssetImage(
              '${model.image}',
            ),
          ),
        ),
        SizedBox(
          height: 50.0,
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          '${model.description}',
        ),
      ],
    );
  }
}