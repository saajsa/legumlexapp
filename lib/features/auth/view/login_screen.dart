import 'package:legumlex_customer/common/components/buttons/rounded_button.dart';
import 'package:legumlex_customer/common/components/buttons/rounded_loading_button.dart';
import 'package:legumlex_customer/common/components/text-form-field/custom_text_field.dart';
import 'package:legumlex_customer/common/components/text/default_text.dart';
import 'package:legumlex_customer/common/components/will_pop_widget.dart';
import 'package:legumlex_customer/core/route/route.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/images.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:legumlex_customer/features/auth/controller/login_controller.dart';
import 'package:legumlex_customer/features/auth/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> 
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(AuthRepo(apiClient: Get.find()));
    Get.put(LoginController(loginRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<LoginController>().remember = false;
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: GetBuilder<LoginController>(
          builder: (controller) => SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: ColorResources.appBarColor,
                    image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: AssetImage(MyImages.login),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 140.0, bottom: 30.0),
                        child: Center(
                          child: Column(
                            children: [
                              Image.asset(MyImages.appLogo,
                                  color: ColorResources.colorWhite, height: 80),
                              const SizedBox(height: 10),
                              Text(
                                'Legum Lex',
                                style: TextStyle(
                                  color: ColorResources.colorWhite,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.space20,
                              vertical: Dimensions.space30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocalStrings.login.tr,
                                style: mediumOverLarge.copyWith(
                                    fontSize: Dimensions.fontMegaLarge + 4,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                LocalStrings.loginDesc.tr,
                                style: regularDefault.copyWith(
                                    fontSize: Dimensions.fontDefault + 2,
                                    color: Colors.white.withOpacity(0.9),
                                    height: 1.4),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 20,
                                    offset: const Offset(0, -4),
                                  ),
                                ]),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: Dimensions.space30),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomTextField(
                                controller: controller.emailController,
                                labelText: LocalStrings.email.tr,
                                onChanged: (value) {},
                                focusNode: controller.emailFocusNode,
                                nextFocus: controller.passwordFocusNode,
                                textInputType: TextInputType.emailAddress,
                                inputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'fieldErrorMsg'.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(height: Dimensions.space20),
                              CustomTextField(
                                labelText: LocalStrings.password.tr,
                                controller: controller.passwordController,
                                focusNode: controller.passwordFocusNode,
                                onChanged: (value) {},
                                isShowSuffixIcon: true,
                                isPassword: true,
                                textInputType: TextInputType.text,
                                inputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return LocalStrings.fieldErrorMsg.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(height: Dimensions.space20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: Checkbox(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .defaultRadius)),
                                            activeColor:
                                                ColorResources.primaryColor,
                                            checkColor:
                                                ColorResources.colorWhite,
                                            value: controller.remember,
                                            side: WidgetStateBorderSide
                                                .resolveWith(
                                              (states) => BorderSide(
                                                  width: 1.0,
                                                  color: controller.remember
                                                      ? ColorResources
                                                          .getTextFieldEnableBorder()
                                                      : ColorResources
                                                          .getTextFieldDisableBorder()),
                                            ),
                                            onChanged: (value) {
                                              controller.changeRememberMe();
                                            }),
                                      ),
                                      const SizedBox(width: 8),
                                      DefaultText(
                                          text: LocalStrings.rememberMe.tr,
                                          textColor: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .color!
                                              .withValues(alpha: 0.5))
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.clearTextField();
                                      //Get.toNamed(RouteHelper.forgotPasswordScreen);
                                    },
                                    child: DefaultText(
                                        text: LocalStrings.forgotPassword.tr,
                                        textColor:
                                            ColorResources.secondaryColor),
                                  )
                                ],
                              ),
                              const SizedBox(height: Dimensions.space30),
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: controller.isSubmitLoading
                                    ? Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              ColorResources.primaryColor.withOpacity(0.8),
                                              ColorResources.primaryColor,
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      )
                                    : ElevatedButton(
                                        onPressed: () {
                                          if (formKey.currentState!.validate()) {
                                            controller.loginUser();
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                        ).copyWith(
                                          backgroundColor: WidgetStateProperty.all(Colors.transparent),
                                        ),
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                ColorResources.primaryColor,
                                                ColorResources.accentColor,
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              LocalStrings.signIn.tr,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                              const SizedBox(height: Dimensions.space30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(LocalStrings.doNotHaveAccount.tr,
                                      overflow: TextOverflow.ellipsis,
                                      style: regularLarge.copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .color!
                                              .withValues(alpha: 0.5),
                                          fontWeight: FontWeight.w400)),
                                  TextButton(
                                    onPressed: () {
                                      Get.offAndToNamed(
                                          RouteHelper.registrationScreen);
                                    },
                                    child: Text(LocalStrings.createAnAccount.tr,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: regularLarge.copyWith(
                                            color:
                                                ColorResources.secondaryColor)),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
