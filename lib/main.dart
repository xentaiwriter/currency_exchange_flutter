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
<<<<<<< HEAD
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.grey[100],
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
        useMaterial3: true,
      ),
      home: ExchangeRatePage(),
=======
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExchangeHomePage(),
>>>>>>> 00c5b255bff348e0d721a373dfa41b8d5c51ada9
    );
  }
}

<<<<<<< HEAD
class ExchangeRatePage extends StatefulWidget {
  @override
  _ExchangeRatePageState createState() => _ExchangeRatePageState();
}

class _ExchangeRatePageState extends State<ExchangeRatePage> {
  String baseCurrency = "USD";
  String targetCurrency = "EUR";
  double? exchangeRate;

  final List<String> currencyList = [
    'USD', 'EUR', 'GBP', 'JPY', 'AUD', 'CAD', 'CHF', 'CNY', 'SEK', 'NOK'
  ];

  Future<void> fetchExchangeRate() async {
    final url = Uri.parse("https://open.er-api.com/v6/latest/$baseCurrency");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['result'] == 'success') {
          setState(() {
            exchangeRate = data['rates'][targetCurrency]?.toDouble();
          });
        }
      } else {
        throw Exception("Failed to load exchange rate");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
=======
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
>>>>>>> 00c5b255bff348e0d721a373dfa41b8d5c51ada9
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
<<<<<<< HEAD
        title: Text("💱 Currency Exchange"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade100, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              "Select currencies",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: baseCurrency,
                    decoration: InputDecoration(labelText: "From"),
                    items: currencyList
                        .map((currency) => DropdownMenuItem<String>(
                      value: currency,
                      child: Text(currency),
                    ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          baseCurrency = value;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: targetCurrency,
                    decoration: InputDecoration(labelText: "To"),
                    items: currencyList
                        .map((currency) => DropdownMenuItem<String>(
                      value: currency,
                      child: Text(currency),
                    ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          targetCurrency = value;
                        });
                      }
=======
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
>>>>>>> 00c5b255bff348e0d721a373dfa41b8d5c51ada9
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
<<<<<<< HEAD
            ElevatedButton.icon(
              onPressed: fetchExchangeRate,
              icon: Icon(Icons.sync),
              label: Text("Get Exchange Rate"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            SizedBox(height: 36),
            if (exchangeRate != null)
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white.withOpacity(0.95),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                        "$baseCurrency → $targetCurrency",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        exchangeRate!.toStringAsFixed(4),
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: CircularProgressIndicator(),
              ),
=======
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
>>>>>>> 00c5b255bff348e0d721a373dfa41b8d5c51ada9
          ],
        ),
      ),
    );
  }
}
