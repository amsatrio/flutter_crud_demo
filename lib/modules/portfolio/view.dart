import 'package:flutter/material.dart';

class PortfolioView extends StatelessWidget {
  const PortfolioView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text("Portfolio"),),
        body: Text("Home"),
      ),
    );
  }
}