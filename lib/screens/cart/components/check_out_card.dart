import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:shop_app/helper/auth.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key? key,
    this.total,
  }) : super(key: key);
  final total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                Text("Add voucher code"),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "\$ " + total,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Check Out",
                    press: () async {
                      final uid = Provider.of<AuthenticationService>(context,
                              listen: false)
                          .getUser()!
                          .uid;
                      if (isPaypalPaymentValid(total)) {
                        await processPayment(total, uid);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

bool isPaypalPaymentValid(String total) {
  if (double.parse(total) != 0) {
    return true;
  } else
    return false;
}

Future<void> processPayment(String total, String uid) async {
  var request = BraintreeDropInRequest(
    tokenizationKey: tokenizationKey,
    collectDeviceData: true,
    paypalRequest: BraintreePayPalRequest(
      amount: total,
      displayName: 'Eatify',
    ),
    cardEnabled: true,
  );
  final result = await BraintreeDropIn.start(request);
  // On sucessful nonce getting from the braintree
  if (result != null) {
    // Post receipt to Firebase
    await sendNonceToFirebase(total, result, uid);
  }
}

Future<void> sendNonceToFirebase(
    String total, BraintreeDropInResult result, String uid) async {
  await FirebaseFirestore.instance.collection('receipts').add({
    'amount': total,
    'device_data': result.deviceData,
    'nonce': result.paymentMethodNonce.nonce,
    'is_processed': false,
    'store_id': '',
    'uid': uid,
  });
}
