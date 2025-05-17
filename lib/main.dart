import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(CurrencyExchangeApp());
}

class CurrencyExchangeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Exchange',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExchangeHomePage(),
    );
  }
}

class ExchangeHomePage extends StatefulWidget {
  @override
  _ExchangeHomePageState createState() => _ExchangeHomePageState();
}

class _ExchangeHomePageState extends State<ExchangeHomePage> {
  String fromCurrency = 'USD';
  String toCurrency = 'EUR';
  double? exchangeRate;
  bool isLoading = false;

  final currencies = ['USD', 'EUR', 'GBP', 'JPY', 'AUD', 'CAD', 'CHF'];

  Future<void> fetchExchangeRate() async {
    setState(() {
      isLoading = true;
    });
    final url =
        'https://api.exchangerate.host/latest?base=$fromCurrency&symbols=$toCurrency';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        exchangeRate = data['rates'][toCurrency]?.toDouble();
        isLoading = false;
      });
    } else {
      setState(() {
        exchangeRate = null;
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch exchange rate')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchExchangeRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Exchange'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchExchangeRate,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: fromCurrency,
                    items: currencies.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        fromCurrency = newValue!;
                        fetchExchangeRate();
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: toCurrency,
                    items: currencies.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        toCurrency = newValue!;
                        fetchExchangeRate();
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Center(
              child: isLoading
                  ? CircularProgressIndicator()
                  : exchangeRate != null
                      ? Text(
                          '1 $fromCurrency = ${exchangeRate!.toStringAsFixed(4)} $toCurrency',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        )
                      : Text('Unable to fetch data'),
            ),
          ],
        ),
      ),
    );
  }
}
