import 'package:legumlex_customer/common/components/buttons/rounded_button.dart';
import 'package:legumlex_customer/common/components/divider/custom_divider.dart';
import 'package:legumlex_customer/core/helper/shared_preference_helper.dart';
import 'package:legumlex_customer/core/route/route.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/images.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardIntroScreen extends StatefulWidget {
  const OnBoardIntroScreen({super.key});

  @override
  State<OnBoardIntroScreen> createState() => _OnBoardIntroScreenState();
}

class _OnBoardIntroScreenState extends State<OnBoardIntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  var currentPageID = 0;

  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      bodyPadding: const EdgeInsets.only(top: Dimensions.space200),
      key: introKey,
      globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      allowImplicitScrolling: true,
      infiniteAutoScroll: false,
      skip: const Icon(Icons.skip_next),
      globalHeader: Align(
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(top: Dimensions.space50),
            child: Image.asset(
              MyImages.appLogo,
              height: Dimensions.space60,
            ),
          ),
        ),
      ),
      showSkipButton: false,
      dotsFlex: 1,
      showDoneButton: false,
      showBackButton: false,
      back: const Icon(Icons.arrow_back),
      next: const Icon(Icons.arrow_forward),
      showNextButton: false,
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(Dimensions.space15),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(Dimensions.space12)
          : const EdgeInsets.fromLTRB(Dimensions.space8, Dimensions.space3,
              Dimensions.space8, Dimensions.space10),
      dotsDecorator: const DotsDecorator(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(Dimensions.space3))),
        activeColor: ColorResources.primaryColor,
        size: Size(10.0, 5.0),
        color: ColorResources.hintColor,
        activeSize: Size(Dimensions.space20, Dimensions.space5),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimensions.space3)),
        ),
      ),
      onChange: (v) {
        debugPrint("Page Key $v");
        setState(() {
          currentPageID = v;
        });
      },
      pages: [
        PageViewModel(
          title: LocalStrings.onboardTitle1.tr,
          body: LocalStrings.onboardSubTitle1.tr,
          image: Image.asset(
            MyImages.onboardingOne,
          ),
          decoration: PageDecoration(
            titleTextStyle: semiBoldMediumLarge.copyWith(
                fontSize: Dimensions.space20,
                color: Theme.of(context).textTheme.bodyMedium!.color),
            titlePadding: const EdgeInsets.symmetric(
                vertical: Dimensions.space5, horizontal: Dimensions.space15),
            bodyPadding: const EdgeInsets.symmetric(
                vertical: Dimensions.space5, horizontal: Dimensions.space15),
            bodyTextStyle: regularLarge.copyWith(
                color: Theme.of(context).textTheme.bodyMedium!.color),
          ),
        ),
        PageViewModel(
          title: LocalStrings.onboardTitle2.tr,
          body: LocalStrings.onboardSubTitle2.tr,
          image: Image.asset(
            MyImages.onboardingTwo,
          ),
          decoration: PageDecoration(
            titleTextStyle: semiBoldMediumLarge.copyWith(
                fontSize: Dimensions.space20,
                color: Theme.of(context).textTheme.bodyMedium!.color),
            titlePadding: const EdgeInsets.symmetric(
                vertical: Dimensions.space5, horizontal: Dimensions.space15),
            bodyPadding: const EdgeInsets.symmetric(
                vertical: Dimensions.space5, horizontal: Dimensions.space15),
            bodyTextStyle: regularLarge.copyWith(
                color: Theme.of(context).textTheme.bodyMedium!.color),
          ),
        ),
        PageViewModel(
          title: LocalStrings.onboardTitle3.tr,
          body: LocalStrings.onboardSubTitle3.tr,
          image: Image.asset(
            MyImages.onboardingThree,
          ),
          decoration: PageDecoration(
            titleTextStyle: semiBoldMediumLarge.copyWith(
                fontSize: Dimensions.space20,
                color: Theme.of(context).textTheme.bodyMedium!.color),
            titlePadding: const EdgeInsets.symmetric(
                vertical: Dimensions.space5, horizontal: Dimensions.space15),
            bodyPadding: const EdgeInsets.symmetric(
                vertical: Dimensions.space5, horizontal: Dimensions.space15),
            bodyTextStyle: regularLarge.copyWith(
                color: Theme.of(context).textTheme.bodyMedium!.color),
          ),
        ),
      ],
      globalFooter: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space25),
            child: RoundedButton(
                text: (currentPageID + 1) ==
                        introKey.currentState?.getPagesLength()
                    ? LocalStrings.getStarted.tr
                    : LocalStrings.next.tr,
                cornerRadius: Dimensions.space10,
                press: () async {
                  if (introKey.currentState!.getCurrentPage() + 1 ==
                      introKey.currentState!.getPagesLength()) {
                    await Get.find<ApiClient>()
                        .sharedPreferences
                        .setBool(SharedPreferenceHelper.onboardKey, true)
                        .whenComplete(() {
                      Get.offAllNamed(RouteHelper.loginScreen);
                    });
                  } else {
                    introKey.currentState!.next();
                  }
                }),
          ),
          const SizedBox(height: Dimensions.space5),
          const CustomDivider()
        ],
      ),
    );
  }
}
