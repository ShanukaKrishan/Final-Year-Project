import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:watch_store/OrderDetailScreen/orderDetailScreen.dart';
import 'package:watch_store/constants.dart';
import 'package:watch_store/widgets/customButtons.dart';

import 'package:watch_store/widgets/widgetAppBar.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PaymentScreen extends StatefulWidget {
  static String routeName = '/PaymentScreen';
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const WidgetAppBar(appBarTitle: "PAYMENT DETAILS"),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  // borderRadius: BorderRadius.only(
                  //     bottomLeft: Radius.circular(15),
                  //     bottomRight: Radius.circular(15)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      CreditCardWidget(
                        cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        cardHolderName: cardHolderName,
                        cvvCode: cvvCode,
                        showBackView: isCvvFocused,
                        obscureCardNumber: false,
                        obscureCardCvv: true,
                        isHolderNameVisible: true,
                        cardBgColor: Color.fromRGBO(32, 33, 37, 1),
                        isSwipeGestureEnabled: true,
                        onCreditCardWidgetChange:
                            (CreditCardBrand creditCardBrand) {},
                        customCardTypeIcons: <CustomCardTypeIcon>[
                          CustomCardTypeIcon(
                            cardType: CardType.mastercard,
                            cardImage: Image.asset(
                              'assets/images/mastercard.png',
                              height: 48,
                              width: 48,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  CreditCardForm(
                    formKey: formKey,
                    obscureCvv: true,
                    obscureNumber: true,
                    cardNumber: cardNumber,
                    cvvCode: cvvCode,
                    isHolderNameVisible: true,
                    isCardNumberVisible: true,
                    isExpiryDateVisible: true,
                    cardHolderName: cardHolderName,
                    expiryDate: expiryDate,
                    cardNumberDecoration: buildCardDecoration(
                        hintText: "XXXX XXXX XXXX XXXX",
                        labelText: "Card Number"),
                    expiryDateDecoration: buildCardDecoration(
                        labelText: 'Expired Date', hintText: 'XX/XX'),
                    cvvCodeDecoration:
                        buildCardDecoration(labelText: 'CVV', hintText: 'XXX'),
                    cardHolderDecoration: buildCardDecoration(
                        labelText: 'Card Holder', hintText: 'Name'),
                    onCreditCardModelChange: onCreditCardModelChange,
                    themeColor: kPrimaryColor,
                  ),
                  const SizedBox(height: 50),
                  CustomButton(
                      buttonText: "Confirm",
                      press: () {
                        pushNewScreen(
                          context,

                          screen: const OrderDetailScreen(),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                        // Navigator.pushNamed(
                        //     context, OrderDetailScreen.routeName);
                        print(cardHolderName);
                        print(expiryDate);
                        print(cvvCode);
                      }),
                  const SizedBox(height: 50),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration buildCardDecoration(
      {required String labelText, required String hintText}) {
    return InputDecoration(
      labelStyle: const TextStyle(
        color: Colors.black,
      ),
      hintStyle: const TextStyle(color: Colors.black, fontSize: 14),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColor),
      ),
      labelText: labelText,
      hintText: hintText,
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
