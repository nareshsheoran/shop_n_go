// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_n_go/account_dir/page/about_us_page.dart';
import 'package:shop_n_go/account_dir/page/account_page.dart';
import 'package:shop_n_go/account_dir/page/address_page.dart';
import 'package:shop_n_go/account_dir/page/cancel_refund_page.dart';
import 'package:shop_n_go/account_dir/page/help_page.dart';
import 'package:shop_n_go/account_dir/page/order_page.dart';
import 'package:shop_n_go/account_dir/page/payment_page.dart';
import 'package:shop_n_go/account_dir/page/privacy_policy_page.dart';
import 'package:shop_n_go/account_dir/page/profile_page.dart';
import 'package:shop_n_go/account_dir/page/reward_page.dart';
import 'package:shop_n_go/account_dir/page/setting_page.dart';
import 'package:shop_n_go/account_dir/page/term_condition_page.dart';
import 'package:shop_n_go/cart_dir/page/cart_details_page.dart';
import 'package:shop_n_go/cart_dir/page/cart_page.dart';
import 'package:shop_n_go/home_page_dir/page/all_bestSeller_product.dart';
import 'package:shop_n_go/home_page_dir/page/all_category_search.dart';
import 'package:shop_n_go/home_page_dir/page/all_product_page.dart';
import 'package:shop_n_go/home_page_dir/page/categories_details_page.dart';
import 'package:shop_n_go/home_page_dir/page/category_name_page.dart';
import 'package:shop_n_go/home_page_dir/map_dir/page/map_search_page.dart';
import 'package:shop_n_go/home_page_dir/map_dir/page/map_store_details.dart';
import 'package:shop_n_go/home_page_dir/page/home_page.dart';
import 'package:shop_n_go/login_dir/page/confirm_otp_page.dart';
import 'package:shop_n_go/login_dir/page/forgot_password_page.dart';
import 'package:shop_n_go/login_dir/page/mobile_login_page.dart';
import 'package:shop_n_go/login_dir/page/login_screen_page.dart';
import 'package:shop_n_go/login_dir/page/sign_up_page.dart';
import 'package:shop_n_go/shared/page/dashboard_page.dart';
import 'package:shop_n_go/shared/page/splash_page.dart';
import 'package:shop_n_go/shop_in_dir/page/shop_in_page.dart';
import 'package:shop_n_go/stores_dir/page/store_search_page.dart';
import 'package:shop_n_go/stores_dir/page/stores_details.dart';
import 'package:shop_n_go/stores_dir/page/stores_page.dart';

class AppRoutes {
  static const String SplashPage = "Splash Page";
  static const String LoginScreenPage = "Login Screen Page";
  static const String SignUpPage = "Sign Up Page";
  static const String MobileLoginPage = "Mobile Login Page";
  static const String ConfirmOtpPage = "Confirm OTP Page";
  static const String DashboardPage = "Dashboard Page";
  static const String HomePage = "Home Page";
  static const String CartPage = "Cart Page";
  static const String AllCategorySearch = "All Category Search";
  static const String AllProductPage = "All Product Page";
  static const String CategoryNamePage = "Category Name Page";
  static const String CategoriesDetailsPage = "Categories Details Page";
  static const String StoresPage = "Stores Page";
  static const String StoresDetailsPage = "Stores Details Page";
  static const String StoreSearchPage = "Store Search Page";
  static const String CartDetailsPage = "Cart Details Page";
  static const String AboutUsPage = "About Us Page";
  static const String AccountPage = "Account Page";
  static const String AddressPage = "Address Page";
  static const String CancelRefundPage = "Cancel Refund Page";
  static const String HelpPage = "Help Page Page";
  static const String ProfilePage = "Profile Page";
  static const String OrderPage = "Order Page";
  static const String PaymentPage = "Payment Page";
  static const String PrivacyPolicyPage = "Privacy Policy Page";
  static const String RewardPage = "Reward Page";
  static const String SettingPage = "Setting Page";
  static const String TermConditionPage = "Term Condition Page";
  static const String ShopInPage = "Shop In Page";
  static const String MapSearchPage = "Map Search Page";
  static const String MapStoreDetailsPage = "Map Store Details Page";
  static const String AllBestSellerProduct = "All Best Seller Product Page";
  static const String ForgotPasswordPage = "Forgot Password Page";
}

Map<String, WidgetBuilder> routes = {
  AppRoutes.SplashPage: (context) => const SplashPage(),
  AppRoutes.LoginScreenPage: (context) => const LoginScreenPage(),
  AppRoutes.SignUpPage: (context) => const SignUpPage(),
  AppRoutes.MobileLoginPage: (context) => const MobileLoginPage(),
  AppRoutes.ConfirmOtpPage: (context) => const ConfirmOtpPage(),
  AppRoutes.DashboardPage: (context) => const DashboardPage(),
  AppRoutes.HomePage: (context) => const HomePage(),
  AppRoutes.CartPage: (context) => const CartPage(),
  AppRoutes.AllCategorySearch: (context) => const AllCategorySearch(),
  AppRoutes.AllProductPage: (context) => const AllProductPage(),
  AppRoutes.CategoryNamePage: (context) => const CategoryNamePage(),
  AppRoutes.CategoriesDetailsPage: (context) => const CategoriesDetailsPage(),
  AppRoutes.StoresPage: (context) => const StoresPage(),
  AppRoutes.StoresDetailsPage: (context) => const StoresDetailsPage(),
  AppRoutes.StoreSearchPage: (context) => const StoreSearchPage(),
  AppRoutes.CartDetailsPage: (context) => const CartDetailsPage(),
  AppRoutes.AboutUsPage: (context) => const AboutUsPage(),
  AppRoutes.AccountPage: (context) => const AccountPage(),
  AppRoutes.AddressPage: (context) => const AddressPage(),
  AppRoutes.CancelRefundPage: (context) => const CancelRefundPage(),
  AppRoutes.HelpPage: (context) => const HelpPage(),
  AppRoutes.OrderPage: (context) => const OrderPage(),
  AppRoutes.PaymentPage: (context) => const PaymentPage(),
  AppRoutes.PrivacyPolicyPage: (context) => const PrivacyPolicyPage(),
  AppRoutes.ProfilePage: (context) => const ProfilePage(),
  AppRoutes.RewardPage: (context) => const RewardPage(),
  AppRoutes.SettingPage: (context) => const SettingPage(),
  AppRoutes.TermConditionPage: (context) => const TermConditionPage(),
  AppRoutes.ShopInPage: (context) => const ShopInPage(),
  AppRoutes.MapSearchPage: (context) => const MapSearchPage(),
  AppRoutes.MapStoreDetailsPage: (context) => const MapStoreDetailsPage(),
  AppRoutes.AllBestSellerProduct: (context) => const AllBestSellerProduct(),
  AppRoutes.ForgotPasswordPage: (context) => const ForgotPasswordPage(),
};
