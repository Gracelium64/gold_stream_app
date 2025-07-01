import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gold_stream_app/src/gold/data/fake_gold_api.dart';
import 'package:gold_stream_app/src/gold/presentation/widgets/gold_header.dart';
import 'package:intl/intl.dart';

class GoldScreen extends StatefulWidget {
  const GoldScreen({super.key});

  @override
  State<GoldScreen> createState() => _GoldScreenState();
}

class _GoldScreenState extends State<GoldScreen> {
  double? goldPrice;
  StreamSubscription<double>? goldPriceSubscription;
  Stream<double> goldPriceStream = getGoldPriceStream();

  @override
  void initState() {
    super.initState();
    goldPriceSubscription = goldPriceStream.listen(
      (event) {
        setState(() {
          goldPrice = event;
        });
      },
      onError: (error) {
        debugPrint('Error fetching gold price: $error');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GoldHeader(),
              SizedBox(height: 20),
              Text(
                'Live Kurs:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 20),
              Text(
                goldPrice != null
                    ? NumberFormat.simpleCurrency(
                        locale: 'de_DE',
                      ).format(
                        goldPrice,
                      )
                    : 'Loading..',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    goldPriceSubscription?.cancel();
    super.dispose();
  }
}
