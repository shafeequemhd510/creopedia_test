import 'package:creopediatest/screens/MyMap.dart';
import 'package:flutter/material.dart';

import 'package:toast/toast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  var tecAmount=TextEditingController();

  Razorpay _razorpay = Razorpay();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen"),),
      body: Column(
        children: <Widget>[
          MaterialButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMap()));
          },
          child: Text("Map"),),
          Text("payment GateWaty",style: Theme.of(context).textTheme.headline5,),
          TextField(
            controller: tecAmount,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Enter Amount"
            ),
          )
          ,MaterialButton(onPressed: (){

            if(tecAmount.text.length>0){
              _showNativeView(tecAmount.text);
            }else{
             Toast.show("enter amount", context,gravity: Toast.CENTER);
            }
          },
          child: Text("Payment gateway"),),

        ],
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Toast.show("Payment success", context,gravity: Toast.CENTER);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Toast.show("Eroor", context,gravity: Toast.CENTER);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    Toast.show("Excternal ", context,gravity: Toast.CENTER);
  }


   String razorPayTxestId = "rzp_test_1DP5mmOlF5G5ag";
  Future<Null> _showNativeView(String amount) async {
    var options = {
      'key': razorPayTxestId,
//      'key': razorPayKeyId,
      'amount': (1 * double.parse(amount)),
//      'amount': 100,
      'name': 'Shafeeque',
      'description': "my descript",
      'notes': 'my notes',
//      'prefill': {'contact': phone, 'email': email},
      'prefill': {
        'contact': "6235883830",
        'email': "143shafeeque@gamil.com"
      },
//      "image": "https://kleemz.com/assets/site/images/resources/logo.png",
      'external': {
        'wallets': ['paytm']
      },
      "notes": {"name": "customer name"},
      /*"theme": {
        "color": "#eb8f26"
      },*/
      "method": {"netbanking": true, "card": true, "wallet": true, "upi": true},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }
}
