import 'package:legumlex_customer/common/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorResources {
  // Legum Lex Brand Colors
  static const Color primaryColor = Color(0xFFD9FF6E);
  static const Color secondaryColor = Color(0xFFDBF889);
  static const Color accentColor = Color(0xFF9EB952);
  
  // UI Colors
  static const Color screenBgColor = Color(0xFFE9E8E6);
  static const Color screenBgColorDark = Color(0xFF26293c);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color cardColorDark = Color(0xff2e344e);
  static const Color hintColor = Color(0xFF92A5C6);
  static const Color hintColorDark = Color(0xff555555);
  static Color secondaryScreenBgColor = primaryColor.withValues(alpha: 0.4);
  
  // Text Colors
  static const Color primaryTextColor = Color(0xFF000000);
  static const Color contentTextColor = Color(0xFF000000);
  static const Color bodyTextColor = Color(0xB3000000); // rgba(0, 0, 0, 0.7)
  
  // System Colors
  static const Color primaryStatusBarColor = primaryColor;
  static const Color underlineTextColor = primaryColor;
  static const Color lineColor = Color(0xFFE6E4DF);
  static const Color borderColor = Color(0xFFE6E4DF);
  static const Color inputColor = Color(0xFFE9E8E6);
  static const Color inputColorDark = Color(0xff1F1F1F);

  // Additional Brand Colors
  static const Color lightBackgroundColor = Color(0xFFE9E8E6);
  static const Color darkColor = Color(0xFF000000);
  static const Color lightColor = Color(0xFFE9E8E6);
  static const Color whiteColor = Color(0xFFFFFFFF);
  
  // Legacy colors for compatibility
  static const Color textDarkColor = Color(0xFF000000);
  static const Color blueGreyColor = Color(0xFF92A5C6);
  static const Color lightBlueGreyColor = Color(0xFFE6E4DF);
  static const Color blueColor = Color(0xFF9EB952);
  static const Color redColor = Colors.redAccent;
  static const Color greenColor = Color(0xFF9EB952);
  static const Color yellowColor = Colors.orange;
  static const Color purpleColor = Colors.purple;

  // app bar
  static const Color appBarColor = primaryColor;
  static const Color appBarContentColor = darkColor;

  // text field
  static Color labelTextColor = darkColor.withValues(alpha: 0.6);
  static const Color textFieldDisableBorderColor = Color(0xFFE6E4DF);
  static const Color textFieldEnableBorderColor = primaryColor;
  static const Color hintTextColor = Color(0xB3000000);

  // button
  static const Color primaryButtonColor = primaryColor;
  static const Color primaryButtonTextColor = darkColor;
  static const Color secondaryButtonColor = whiteColor;
  static const Color secondaryButtonTextColor = darkColor;

  // icon
  static const Color iconColor = Color(0xFF000000);
  static const Color filterEnableIconColor = primaryColor;
  static const Color filterIconColor = iconColor;
  static const Color searchEnableIconColor = accentColor;
  static const Color searchIconColor = iconColor;
  static const Color bottomSheetCloseIconColor = darkColor;

  // Standard colors with Legum Lex branding
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorBlack = Color(0xFF000000);
  static const Color colorGreen = Color(0xFF9EB952);
  static const Color colorGreen100 = Color(0xFFDBF889);
  static const Color colorOrange = Color(0xffFF9F43);
  static const Color colorOrange100 = Color(0xffFFECD9);
  static const Color colorRed = Color(0xffEA5455);
  static const Color colorRed100 = Color(0xffFCE9E9);
  static const Color colorGrey = Color(0xB3000000);
  static const Color lightGray = Color(0xFFE9E8E6);
  static const Color colorlighterGrey = Color(0xFF8A8281);
  static const Color colorLightGrey = Color(0xFFE6E4DF);
  static const Color transparentColor = Colors.transparent;

  // screen-bg & primary color
  static Color getPrimaryColor() {
    return primaryColor;
  }

  static Color getScreenBgColor() {
    return Get.find<ThemeController>().darkTheme ? cardColorDark : screenBgColor;
  }

  static Color projectStatusColor(String state) {
    Color color = ColorResources.blueColor;
    switch (state) {
      case '1':
        color = ColorResources.darkColor;
        break;
      case '2':
        color = ColorResources.blueColor;
        break;
      case '3':
        color = ColorResources.yellowColor;
        break;
      case '4':
        color = ColorResources.greenColor;
        break;
      case '5':
        color = ColorResources.redColor;
        break;
    }
    return color;
  }

  static Color taskStatusColor(String state) {
    Color color = ColorResources.blueColor;
    switch (state) {
      case '1':
        color = ColorResources.darkColor;
        break;
      case '2':
        color = ColorResources.blueColor;
        break;
      case '3':
        color = ColorResources.yellowColor;
        break;
      case '4':
        color = ColorResources.redColor;
        break;
      case '5':
        color = ColorResources.greenColor;
        break;
    }
    return color;
  }

  static Color invoiceStatusColor(String state) {
    Color color = ColorResources.blueColor;
    switch (state) {
      case '1': // Unpaid
        color = ColorResources.redColor;
        break;
      case '2': // Paid
        color = ColorResources.greenColor;
        break;
      case '3': // Partialy Paid
        color = ColorResources.blueColor;
        break;
      case '4': // Overdue
        color = ColorResources.redColor;
        break;
      case '5':
        color = ColorResources.redColor;
        break;
      case '6':
        color = ColorResources.darkColor;
        break;
    }
    return color;
  }

  static Color contractStatusColor(String state) {
    Color color = ColorResources.blueColor;
    switch (state) {
      case '0':
        color = ColorResources.blueColor;
        break;
      case '1':
        color = ColorResources.greenColor;
        break;
      case '2':
        color = ColorResources.redColor;
        break;
      case '3':
        color = ColorResources.yellowColor;
        break;
      case '4':
        color = ColorResources.darkColor;
        break;
    }
    return color;
  }

  static Color estimateStatusColor(String state) {
    Color color = ColorResources.blueColor;
    switch (state) {
      case '1': //
        color = ColorResources.darkColor;
        break;
      case '2': //
        color = ColorResources.blueColor;
        break;
      case '3': //
        color = ColorResources.redColor;
        break;
      case '4': //
        color = ColorResources.greenColor;
        break;
      case '5': // Expired
        color = ColorResources.redColor;
        break;
    }
    return color;
  }

  static Color ticketStatusColor(String state) {
    Color color = ColorResources.blueColor;
    switch (state) {
      case '1': // Open
        color = ColorResources.blueColor;
        break;
      case '2': // In Progress
        color = ColorResources.yellowColor;
        break;
      case '3': // Answered
        color = ColorResources.greenColor;
        break;
      case '4': // On Hold
        color = ColorResources.redColor;
        break;
      case '5': // Closed
        color = ColorResources.darkColor;
        break;
    }
    return color;
  }

  static Color ticketPriorityColor(String state) {
    Color color = ColorResources.blueColor;
    switch (state) {
      case '1': // Low
        color = ColorResources.greenColor;
        break;
      case '2': // Medium
        color = ColorResources.yellowColor;
        break;
      case '3': // High
        color = ColorResources.redColor;
        break;
    }
    return color;
  }

  static Color proposalStatusColor(String state) {
    Color color = ColorResources.blueColor;
    switch (state) {
      case '1': // Open
        color = ColorResources.blueColor;
        break;
      case '2': // Declined
        color = ColorResources.redColor;
        break;
      case '3': // Accepted
        color = ColorResources.greenColor;
        break;
      case '4': // Sent
        color = ColorResources.colorOrange;
        break;
      case '5': // Revised
        color = ColorResources.blueColor;
        break;
      case '6': // Draft
        color = ColorResources.colorGrey;
        break;
    }
    return color;
  }

  static Color getGreyText() {
    return ColorResources.colorBlack.withValues(alpha: 0.5);
  }

  static Color getSecondaryScreenBgColor() {
    return secondaryScreenBgColor;
  }

  // appbar color
  static Color getAppBarColor() {
    return appBarColor;
  }

  static Color getAppBarContentColor() {
    return appBarContentColor;
  }

  // text color
  static Color getHeadingTextColor() {
    return primaryTextColor;
  }

  static Color getContentTextColor() {
    return bodyTextColor;
  }

  // text-field color
  static Color getLabelTextColor() {
    return labelTextColor;
  }

  static Color getHintTextColor() {
    return hintTextColor;
  }

  static Color getTextFieldDisableBorder() {
    return textFieldDisableBorderColor;
  }

  static Color getTextFieldEnableBorder() {
    return textFieldEnableBorderColor;
  }

  // button color
  static Color getPrimaryButtonColor() {
    return primaryButtonColor;
  }

  static Color getPrimaryButtonTextColor() {
    return primaryButtonTextColor;
  }

  static Color getSecondaryButtonColor() {
    return secondaryButtonColor;
  }

  static Color getSecondaryButtonTextColor() {
    return secondaryButtonTextColor;
  }

  // icon color
  static Color getIconColor() {
    return iconColor;
  }

  static Color getFilterDisableIconColor() {
    return filterIconColor;
  }

  static Color getFilterEnableIconColor() {
    return filterEnableIconColor;
  }

  static Color getSearchIconColor() {
    return searchIconColor;
  }

  static Color getSearchEnableIconColor() {
    return colorRed;
  }

  static Color getUnselectedIconColor() {
    return Get.find<ThemeController>().darkTheme
        ? colorWhite
        : colorGrey.withValues(alpha: 0.6);
  }

  static Color getSelectedIconColor() {
    return Get.find<ThemeController>().darkTheme
        ? getTextColor()
        : getTextColor();
  }

  // transparent color
  static Color getTransparentColor() {
    return transparentColor;
  }

  // text color
  static Color getTextColor() {
    return colorBlack;
  }

  static Color getCardBgColor() {
    return cardColor;
  }
}
