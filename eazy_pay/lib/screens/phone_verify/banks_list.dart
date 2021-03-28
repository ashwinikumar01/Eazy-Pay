import 'package:eazy_pay/models/signup_email.dart';
import 'package:eazy_pay/screens/home_screen.dart';
import 'package:eazy_pay/screens/sign_up_screen/sign_up_screen.dart';
import 'package:eazy_pay/widgets/constants.dart';
import 'package:flutter/material.dart';

class BanksList extends StatefulWidget {
  const BanksList({
    Key key,
    @required this.banks,
  }) : super(key: key);

  final List banks;

  @override
  _BanksListState createState() => _BanksListState();
}

class _BanksListState extends State<BanksList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppbar(
        context,
        title: 'Eazy Pay',
      ),
      body: ListView.builder(
        itemCount: widget.banks.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpScreen(
                    id: widget.banks[index]["id"],
                  ),
                ),
              );
            },
            child: Padding(
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
                      widget.banks[index]["name"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            Theme.of(context).textTheme.headline5.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
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
