import 'package:flutter/material.dart';

import '../../shared/color.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: blackPure.withOpacity(
        0.15,
      ),
    );
  }
}
