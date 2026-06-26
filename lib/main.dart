import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/portfolio_controller.dart';
import 'utils/theme.dart';
import 'views/home_view.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PortfolioController()),
      ],
      child: MaterialApp(
        title: 'Abhinav S - Flutter Developer',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const HomeView(),
      ),
    );
  }
}
