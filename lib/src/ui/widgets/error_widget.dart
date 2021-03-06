import 'package:flutter/material.dart';
import 'package:flutter_paystack/src/paystack.dart';
import 'package:flutter_paystack/src/ui/widgets/animated_widget.dart';
import 'package:flutter_paystack/src/ui/widgets/buttons.dart';

class ErrorWidget extends StatelessWidget {
  final TickerProvider vSync;
  final AnimationController controller;
  final CheckoutMethod method;
  final String text;
  final VoidCallback payWithBank;
  final VoidCallback tryAnotherCard;
  final VoidCallback startOverWithCard;

  ErrorWidget({
    @required this.text,
    @required this.vSync,
    @required this.method,
    this.payWithBank,
    this.tryAnotherCard,
    this.startOverWithCard,
  }) : controller = new AnimationController(
          duration: const Duration(milliseconds: 500),
          vsync: vSync,
        ) {
    controller.forward();
  }

  final emptyContainer = new Container();

  @override
  Widget build(BuildContext context) {
    var isCardPayment =
        method == CheckoutMethod.selectable || method == CheckoutMethod.card;
    var buttonMargin =
        isCardPayment ? new SizedBox(height: 5.0) : emptyContainer;
    return new Container(
      child: new CustomAnimatedWidget(
        controller: controller,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Icon(
              Icons.warning,
              size: 50.0,
              color: const Color(0xFFf9a831),
            ),
            new SizedBox(height: 10.0),
            new Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            new SizedBox(height: 25.0),
            isCardPayment
                ? new WhiteButton(
                    onPressed: tryAnotherCard, text: 'Try another card')
                : emptyContainer,
            buttonMargin,
            method == CheckoutMethod.selectable || method == CheckoutMethod.bank
                ? new WhiteButton(
                    onPressed: payWithBank,
                    text: method == CheckoutMethod.bank
                        ? 'Retry'
                        : 'Try paying with your bank account',
                  )
                : emptyContainer,
            buttonMargin,
            isCardPayment
                ? new WhiteButton(
                    onPressed: startOverWithCard,
                    text: 'Start over with same card',
                    iconData: Icons.refresh,
                    bold: false,
                    flat: true,
                  )
                : emptyContainer
          ],
        ),
      ),
    );
  }
}
