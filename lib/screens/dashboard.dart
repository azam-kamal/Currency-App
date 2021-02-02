import 'dart:async';
import 'package:flutter_currency_converter/Currency.dart';
import 'package:flutter_currency_converter/flutter_currency_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:decorative_app_bar/decorative_app_bar.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:country_currency_pickers/currency_picker_dropdown.dart';
import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/dash';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  var curr1 = 'EUR';
  var curr2 = 'PKR';

  @override
  void dispose() {
    // TODO: implement dispose
    _amountController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  //AlertBox
  Future<void> _showMyDialog(String e) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('An Error Occured'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Check your Internet Connection'),
                Text('Or is your Amount Empty?'),
                Text(e.toString())
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Try Again'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  var _amountController = TextEditingController();
  var _resultController = TextEditingController();

  void _doSomething() async {
    Timer(Duration(seconds: 1), () {
      getAmounts();
      _btnController.success();
      _btnController.reset();
    });
  }

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.white, Color(0xffffccbc)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  Widget currencyDrop1() {
    return Container(
        padding: EdgeInsets.only(left: 10),
        child: ClayContainer(
            width: 120,
            height: 50,
            emboss: true,
            borderRadius: 10,
            child: ClayContainer(
                borderRadius: 10,
                depth: 250,
                child: CurrencyPickerDropdown(
                  initialValue: 'EUR',
                  itemBuilder: _buildCurrencyDropdownItem,
                  onValuePicked: (Country country) {
                    print("${country.currencyCode}");
                    curr1 = country.currencyCode;
                  },
                ))));
  }

  Widget currencyDrop2() {
    return Container(
        padding: EdgeInsets.only(left: 10),
        child: ClayContainer(
            width: 120,
            height: 50,
            emboss: true,
            borderRadius: 10,
            child: ClayContainer(
                borderRadius: 10,
                depth: 250,
                child: CurrencyPickerDropdown(
                  initialValue: 'PKR',
                  itemBuilder: _buildCurrencyDropdownItem,
                  onValuePicked: (Country country) {
                    print("${country.currencyCode}");
                    curr2 = country.currencyCode;
                  },
                ))));
  }

  Widget text() {
    return Container(
        child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: EdgeInsets.only(top: 50, left: 20),
          child: ClayContainer(
            color: Colors.blue[900],
            borderRadius: 5,
            child: ClayContainer(
              borderRadius: 10,
              color: Colors.blue[900],
              depth: 100,
              child: Text(
                "Currency",
                style: TextStyle(
                    letterSpacing: 2.0,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: 45, right: 20),
            child: ClayContainer(
                color: Colors.blue[900],
                emboss: true,
                borderRadius: 50,
                child: ClayContainer(
                    depth: 100,
                    color: Colors.blue[900],
                    borderRadius: 50,
                    child: Image.asset('asset/images/logo.png')))),
      ]),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: EdgeInsets.only(top: 10, left: 50),
              child: ClayContainer(
                color: Colors.blue[900],
                borderRadius: 5,
                child: ClayContainer(
                  borderRadius: 10,
                  depth: 100,
                  color: Colors.blue[900],
                  child: Text(
                    'Converter',
                    style: TextStyle(
                        letterSpacing: 2.0,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ))
        ],
      ),
    ]));
  }

  Widget _buildCurrencyDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("${country.currencyCode}"),
          ],
        ),
      );

  void getAmounts() async {
    try {
      if (_amountController.text.isEmpty) {
        _amountController.text = '1';
      }
        var convertedValuee = await FlutterCurrencyConverter.convert(
            Currency(curr1, amount: double.parse(_amountController.text)),
            Currency(curr2));
        if (convertedValuee.toString() == 'null') {
          _showMyDialog('An Error Occured!');
        } else {
          _resultController.text = convertedValuee.toString();
        }
    } catch (e) {
      _showMyDialog(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // planCount = Provider.of<LastActFunc>(context, listen: false).actItems.length;
    var media = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecorativeAppBar(
              barHeight: media.size.height * 0.4,
              barPad: 200,
              radii: 50,
              background: Colors.white,
              gradient1: Colors.blue[900],
              gradient2: Colors.blue[900],
              extra: text(),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                currencyDrop1(),
                //textfield
                Container(
                    width: media.size.width * 0.5,
                    child: Container(
                      child: TextField(
                        showCursor: false,
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            focusColor: Colors.blue[900],
                            hintText: 'Amount for Conversion'),
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              currencyDrop2(),
              Container(
                  width: media.size.width * 0.5,
                  child: Container(
                    child: TextField(
                      controller: _resultController,
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: 'Result',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ))
            ]),
          ],
        ),
      ),
      floatingActionButton: RoundedLoadingButton(
        color: Colors.blue[900],
        child: Text('Convert', style: TextStyle(color: Colors.white)),
        controller: _btnController,
        onPressed: _doSomething,
        width: 200,
      ),
    );
  }
}
