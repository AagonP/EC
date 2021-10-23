import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:shop_app/helper/auth.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

final mock_address =
    "268 Lý Thường Kiệt, Phường 14, Quận 10, Thành phố Hồ Chí Minh";

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({Key? key, required this.subtotal, required this.store_id})
      : super(key: key);
  final subtotal;
  final store_id;

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  String dropdownValue = 'Cash';

  @override
  @override
  Widget build(BuildContext context) {
    String shipFee = "15.00";
    String total =
        (double.parse(shipFee) + double.parse(widget.subtotal)).toString();
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
                DropdownButton<String>(
                  value: dropdownValue,
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: kPrimaryColor,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['Cash', 'Online Payment']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
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
                  child: SvgPicture.asset(
                    "assets/icons/location.svg",
                    color: kPrimaryColor,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(250),
                  child: GestureDetector(
                    onTap: () {
                      // TODO: Change addrress
                    },
                    child: Container(
                      child: Text(
                        mock_address,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    text: "Applicable fee:",
                  ),
                ),
                Spacer(),
                Text.rich(
                  TextSpan(
                    text: " " + shipFee + " \VND",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    text: "Subtotal:",
                  ),
                ),
                Spacer(),
                Text.rich(
                  TextSpan(
                    text: " " + widget.subtotal + " \VND",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:",
                  ),
                ),
                Spacer(),
                Text.rich(
                  TextSpan(
                    text: " " + total + " \VND",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            SizedBox(
              width: getProportionateScreenWidth(190),
              child: DefaultButton(
                text: "Check Out",
                press: () async {
                  final uid =
                      Provider.of<AuthenticationService>(context, listen: false)
                          .getUser()!
                          .uid;
                  // Check if there is item in the cart
                  if (double.parse(widget.subtotal) != 0) {
                    if (dropdownValue == 'Online Payment') {
                      // If paypal is chosen
                      if (await processPayment(total, uid, widget.store_id)) {
                        await deleteOrder(uid);
                        Navigator.of(context).pop();
                      }
                    } else {
                      // If cash is chosen
                      await deleteOrder(uid);
                      Navigator.of(context).pop();
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> deleteOrder(String uid) async {
  // delete items from cart
  var collection = FirebaseFirestore.instance
      .collection('orders')
      .doc(uid)
      .collection('foods');
  var snapshots = await collection.get();
  // Delete item id from foods collection and update no_item = 0
  for (var doc in snapshots.docs) {
    if (doc.id != 'no_item') {
      await doc.reference.delete();
    } else {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(uid)
          .collection('foods')
          .doc('no_item')
          .update({'no_item': '0'}).catchError(
              (error) => print("Failed to update total: $error"));
    }
  }
  // update total, store id
  await FirebaseFirestore.instance.collection('orders').doc(uid).update({
    'total': '0.00',
    'store_id': '',
  }).catchError((error) => print("Failed to update total: $error"));
}

Future<bool> processPayment(String total, String uid, String store_id) async {
  // Return true if the transaction is completed
  var request = BraintreeDropInRequest(
    tokenizationKey: tokenizationKey,
    collectDeviceData: true,
    paypalRequest: BraintreePayPalRequest(
      amount: total,
      displayName: 'Eatify',
    ),
    cardEnabled: false,
  );
  final result = await BraintreeDropIn.start(request);
  // On sucessful nonce getting from the braintree
  if (result != null) {
    // Post receipt to Firebase
    await sendNonceToFirebase(total, result, uid, store_id);
    return true;
  } else {
    return false;
  }
}

Future<void> sendNonceToFirebase(String total, BraintreeDropInResult result,
    String uid, String store_id) async {
  await FirebaseFirestore.instance.collection('receipts').add({
    'amount': total,
    'device_data': result.deviceData,
    'nonce': result.paymentMethodNonce.nonce,
    'is_processed': false,
    'store_id': store_id,
    'uid': uid,
  });
}
