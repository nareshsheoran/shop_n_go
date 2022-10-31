// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

class AppDetails {
  static String appName = "ShopNGo";

  // static  String currencySign = "\u{20B9}";
  static String currencySign = "KES ";
}

class Constant {
  // static const Color primaryColor = Color(0xff04448c);
  // static  Color primaryColor = Colors.orange.shade800;
  static Color primaryColor = Colors.green;
  static Color? dividerColor = Colors.grey[500];
}

class ProfileDetails {
  static String? id;
  static String? name;
  static String? userName;
  static String? img;
  static String? email;
  static String? password;
  static String? phone;
  static String? date;
  static String? gender;
  static String? resendPhone;
  static String? loginToken;
  static String? signUpToken;
  static String? otp;
}

class MapDetails {
  static String? longitude;
  static String? latitude;
}

class AddressDetails {
  static String? city;
  static String? country;
  static String? flat;
  static String? pinCode;
  static String? state;
  static String? area;
  static String? landMark;
}

class NetworkUtil {
  static String baseUrl = "https://apiforshopandgo.pythonanywhere.com/shopngo-api/";
  static String getSignUpUrl = baseUrl + "register/";
  static String getLoginUrl = baseUrl + "login/";
  static String getUserProfileUrl = baseUrl + "user-profile/";
  static String getAllProductUrl = baseUrl + "all-products/";
  static String getProductDetailsUrl = baseUrl + "all-products/";
  static String getConsumerAddressUrl = baseUrl + "consumer-address/";
  static String getCategoryUrl = baseUrl + "category/";
  static String getCategoryBasedProductUrl = baseUrl + "category-based-product/";
  static String getOrderDetailsUrl = baseUrl + "orders/";
  static String getStoreListUrl = baseUrl + "store-list/";
  static String getRecommendedUrl = baseUrl + "recommended/";
  static String getBestSellerProductUrl = baseUrl + "best-seller-products/";
  static String getAddIntoFavouriteUrl = baseUrl + "favourite-products/";
  static String getFavouriteProdUrl = baseUrl + "favourite-products/";
  static String getProductIntoCardUrl = baseUrl + "products-card";
  static String getAllCartProductUrl = baseUrl + "products-card/";
  static String getUpdatePasswordUrl = baseUrl + "update-password/";
  static String getVendorProductUrl = baseUrl + "vendor-product/";
  static String getVendorProfileUrl = baseUrl + "store-list/";
  static String getNearByStoreUrl = baseUrl + "near-by-store";
  static String getAddIntoCartStoreBasisUrl = baseUrl + "add-into-cart-store-basis";
  static String getStoreProductRatingUrl = baseUrl + "store-product-rating";
  static String getProdDetailsByBarCodeUrl = baseUrl + "get-product-detail-by-barcode";
  static String getStoreMobileLoginUrl = baseUrl + "store-mobile-login-api";
  static String getStoreVerifyOtpUrl = baseUrl + "store-verify-otp";
  static String postAddToCartUrl = baseUrl + "add-to-cart/";
  static String postRemoveToCartUrl = baseUrl + "remove-to-cart/";
  static String storeListCartUrl = baseUrl + "cart-store-list/";
  static String cartItemByStoreUrl = baseUrl + "get-to-cart/";
  static String cartToOrderUrl = baseUrl + "cart-to-order";
  static String fetchMasterOrderUrl = baseUrl + "master-order";
  static String fetchMasterOrderDetailsUrl = baseUrl + "master-order-details";
}

class ApiKey {
  static String apiKey = "AIzaSyCY-SmJ29RYyqiwa3S8I9WblOlnR-Eqbhw";
}

class ImageDimension {
  static double imageHeight = 75;
  static double imageWidth = 75;
}

class IconDimension {
  static double iconSize = 18;
}

class CardDimension {
  static double elevation = 5;
  static Color shadowColor = Constant.primaryColor;
}

class CProgressIndicator {
  static CircularProgressIndicator circularProgressIndicator =
      CircularProgressIndicator(
    color: Constant.primaryColor,
    strokeWidth: 3,
    // value: 40,
  );
}

class Images {
  // static const logoImg =
  //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiBk1gqnnfaW-yDDr6amkB59pVv91M0aI1JQ&usqp=CAU";

  static const baseUrl = "https://apiforshopandgo.pythonanywhere.com";
  static const logoImg = "assets/images/logo.jpg";
  static const tomatoImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYEboA7iFZTTrtVYt3Qnw8s8UG5zblBbiXEQ&usqp=CAU";
  static const potatoImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpB_DNCC9_RsRG-M_ctnzG6DqReZZHFqXziA&usqp=CAU";
  static const chillyImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQ1hK3aPxWMEnYdoaUS7hpR_tuxcJ581qRaw&usqp=CAU";
  static const ladiesFingerImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLu6GbGiP_bNE6Xqdm7LMSdUjTHWBc5TYDzw&usqp=CAU";
  static const onionImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0tS7FPnR37UpBfNwu7jWh7EO6DEJ2W3G2Fg&usqp=CAU";
  static const radisImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvgvQvdsyGHrKCygO27TEO1QY1guZsXpQz4w&usqp=CAU";
  static const hippoNutsImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiqQXz3of53QRt7uK79pC1bsbpsnP9qM2JyA&usqp=CAU";
  static const iceCreamImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTk2JU9R0-sHrDdjmGF95U2CcaCDM9L9QnqFA&usqp=CAU";
  static const lifeBoyImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTn59F5eH3NWdhZCfMi3QW2WQ-Kb84sRAoD9A&usqp=CAU";
  static const soapImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToN7f7JC9wHZLsp13pm9hQjI-ax1mHQHxArg&usqp=CAU";
  static const munchesImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJefAxHVlUwXr2rSnB7dqbfm4TwhF0MFr8nw&usqp=CAU";
  static const biscuitsImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlz6Truk-rTRRqVkBBkQ7D3IpJyw00e2Ju-Q&usqp=CAU";
  static const oreoImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTby4rFYxL9UZjbCQXcKE7-fBm7BlmwT4_GTw&usqp=CAU";
  static const oilImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRV-rst5znlqhdxDnnePxrCJqSCXP-MyKUjiA&usqp=CAU";
  static const vegetablesImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWJCVkUKs1oLVTOEbr4mzqtiW-fxNvjf6SbQ&usqp=CAU";
  static const fruitsImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2uZAoLfKPtr7D1o2wnFdkD79pYlZMAAD1WA&usqp=CAU";
  static const softDrinksImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZJChumYmhzZ7UM7lMocaac0QephvjfQLFBw&usqp=CAU";
  static const nutsImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmNvwNJNL_YJRwI2r_AvJgKGFr7-RXi5Z9bA&usqp=CAU";
  static const mangoImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsfxuW9jinPorTozJjXuhCezT4sVwmN1s7Sw&usqp=CAU";
  static const bananaImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvjoTGiVe15IDRj23zxl215nEYAm1zDkyPcA&usqp=CAU";
  static const grapesImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvbkcH48tsulr-TBvy7f1YD9BnGN6zPPROKw&usqp=CAU";
  static const milkImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvJwPmv_OMFoCQUNRAp9gYQCChUgZ57lpy0w&usqp=CAU";
  static const bakeryImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuCkmG4EcLtxTLgqVswWTT-l0BQNbvcIIhaA&usqp=CAU";
  static const diaryImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKbxkM9sqO36bCwMVRXis6VDuJpYeOqscVzg&usqp=CAU";
  static const frozenImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuV9CfIEMyX6wDRvrgvZq7sOxWHiwkNmhApw&usqp=CAU";
  static const cookingEssImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHeWhvga7-wGVvyUqRXbuin6Rim2KAGOMhNw&usqp=CAU";
  static const laysImg = "${baseUrl}/media/product_image/Lays_brand_logo_cDRB49B.png";
}
