import 'package:eazy_pay/widgets/constants.dart';
import 'package:flutter/material.dart';

class BanksList extends StatelessWidget {
  const BanksList({
    Key key,
    @required this.banks,
  }) : super(key: key);

  final List banks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppbar(
        context,
        title: 'Eazy Pay',
      ),
      body: ListView.builder(
        itemCount: banks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Theme.of(context).accentColor.withOpacity(0.8),
                  Theme.of(context).accentColor.withOpacity(0.6),
                  Theme.of(context).accentColor.withOpacity(0.4),
                  Theme.of(context).accentColor.withOpacity(0.2),
                ])),
                child: ListTile(
                  title: Text(
                    banks[index]["name"],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Theme.of(context).textTheme.headline5.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
