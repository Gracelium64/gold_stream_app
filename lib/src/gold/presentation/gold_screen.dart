import 'package:flutter/material.dart';
import 'package:gold_stream_app/src/gold/data/fake_gold_api.dart';
import 'package:gold_stream_app/src/gold/presentation/widgets/gold_header.dart';
import 'package:intl/intl.dart';

class GoldScreen extends StatelessWidget {
  const GoldScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Stream<double> goldPriceStream = getGoldPriceStream();
    double goldPrice = 69.22;

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
              StreamBuilder<double>(
                stream: goldPriceStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    goldPrice = snapshot.data!;
                  } else if (snapshot.hasError) {
                    return Text(
                      'Error retrieving gold price: ${snapshot.error}',
                    );
                  }
                  return Text(
                    NumberFormat.simpleCurrency(
                      locale: 'de_DE',
                    ).format(
                      snapshot.data != null ? snapshot.data! : goldPrice,
                    ),
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
