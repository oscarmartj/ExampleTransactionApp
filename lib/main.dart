
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _ethAmountController = TextEditingController();

  final client = Web3Client(
    'http://192.168.0.4:7546',
    Client()
  );

  final credentials = EthPrivateKey.fromHex(
      '0xb05d6b33588e23c1ccd3932437bbffcd53fe4fa99e00dd712779391f0854d8bc'
  );


  Future<void> sendTransaction(double ethAmount) async {
    final int weiAmount = (ethAmount * 1e18).round();
    final transaction = Transaction(
      from: credentials.address,
      to: EthereumAddress.fromHex("0x1609a2ab6ba783B588A1D46CAa22155e25449552"),
      gasPrice: EtherAmount.inWei(BigInt.from(20)),
      maxGas: 21000,
      value: EtherAmount.inWei(BigInt.from(weiAmount)),
    );
    await client.sendTransaction(credentials,transaction);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ETH Transfer App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter ETH Transfer App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _ethAmountController,
                decoration: const InputDecoration(
                  hintText: 'Enter ETH amount to transfer',
                ),
              ),
              MaterialButton(onPressed: () async {
                final ethAmount = double.parse(_ethAmountController.text);
                await sendTransaction(ethAmount);
              },
                child: Text('Send Transaction')
              )
            ],
          ),
        ),
      ),
    );
  }
}

