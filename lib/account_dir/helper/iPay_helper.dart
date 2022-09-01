import 'dart:convert';

import 'package:ipaycheckout/ipaycheckout.dart';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:shop_n_go/account_dir/helper/env_cons.dart';

class HttpHelper {
  Future<String> generateUrl(
      String phoneNumber, String email, String amount) async {
    final iPay = IPay(vendorId: vendorId, vendorSecurityKey: securityKey);
    var oid = getRandomString(10);
    var inv = oid;
    var url = iPay.checkoutUrl(
      live: live,
      oid: oid,
      inv: inv,
      ttl: amount,
      tel: phoneNumber,
      eml: email,
      curr: currency,
      cbk: cbk,
      cst: cst,
      crl: crl,
      mpesa: mpesa,
      bonga: bonga,
      airtel: airtel,
      equity: equity,
      mobilebanking: mobilebanking,
      creditcard: creditcard,
      mkoporahisi: mkoporahisi,
      saida: saida,
      elipa: elipa,
      unionpay: unionpay,
      mvisa: mvisa,
      vooma: vooma,
      pesalink: pesalink,
      autopay: autopay,
    );

    var key = utf8.encode(securityKey);
    var newPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^\w]+'), '');
    var finalAmount = double.parse(amount).toStringAsFixed(0);
    var dataString =
        "$live$oid$inv$finalAmount$newPhoneNumber$email$vendorId$currency$p1$p2$p3$p4$cbk$cst$crl";
    var bytes = utf8.encode(dataString);

    var hmacSha1 = Hmac(sha1, key); // HMAC-SHA256
    var digest = hmacSha1.convert(bytes);
    print("digest: $digest");

    url = baseUrl +
        "live=$live&oid=$oid&inv=$inv&ttl=$finalAmount&tel=$newPhoneNumber&eml=$email&vid=$vendorId&curr=$currency&p1=$p1&p2=$p2&p3=$p3&p4=$p4&cbk=$cbk&cst=$cst&crl=$crl&hsh=$digest&mpesa=$mpesa&bonga=$bonga&airtel=$airtel&equity=$equity&creditcard=$creditcard&mobilebanking=$mobilebanking&mkoporahisi=$mkoporahisi&saida=$saida&elipa=$elipa&unionpay=$unionpay&mvisa=$mvisa&vooma=$vooma&pesalink=$pesalink&autopay=$autopay";

    // print("sha:$url");
    // print("sha:$sha");

    print("vendorSecurityKey: ${iPay.vendorSecurityKey}");
    print("vendorId: ${iPay.vendorId}");
    print("Url: $url");
    return url;
  }

  String getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    var newOid = String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    return newOid;
  }
}
