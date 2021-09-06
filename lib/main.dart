import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_test/data/data_providers/mock_inventory_api.dart';
import 'package:splash_test/data/repositories/inventory_repository.dart';
import 'package:splash_test/logic/cubits/cart_cubit.dart';
import 'package:splash_test/presentation/pages/home_page.dart';

void main() {
  runApp(App(
    // Todo -- remove this later
    inventoryRepository: MockInventoryApi(),
  ));
}

class App extends StatelessWidget {
  final InventoryRepository inventoryRepository;

  App({required this.inventoryRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SplashPOS Test',
      home: RepositoryProvider(
        create: (context) => inventoryRepository,
        child: BlocProvider(
          create: (_) => CartCubit(inventoryRepository),
          child: HomePage(),
        ),
      ),
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xff0277bd),
          accentColor: Color(0xffffecb3),
          backgroundColor: Color(0xffffffff),
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          iconTheme: IconThemeData(color: Colors.black, size: 20),
          fontFamily: 'Georgia',
          textTheme: TextTheme(
            headline1: GoogleFonts.montserrat(
                fontSize: 100,
                fontWeight: FontWeight.w300,
                letterSpacing: -1.5),
            headline2: GoogleFonts.montserrat(
                fontSize: 62, fontWeight: FontWeight.w300, letterSpacing: -0.5),
            headline3: GoogleFonts.montserrat(
                fontSize: 50, fontWeight: FontWeight.w400),
            headline4: GoogleFonts.montserrat(
                fontSize: 35, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            headline5: GoogleFonts.montserrat(
                fontSize: 25, fontWeight: FontWeight.w400),
            headline6: GoogleFonts.montserrat(
                fontSize: 21, fontWeight: FontWeight.w500, letterSpacing: 0.15),
            subtitle1: GoogleFonts.montserrat(
                fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.15),
            subtitle2: GoogleFonts.roboto(
                fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.1),
            bodyText1: GoogleFonts.roboto(
                fontSize: 19, fontWeight: FontWeight.w400, letterSpacing: 0.5),
            bodyText2: GoogleFonts.roboto(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            button: GoogleFonts.roboto(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 1),
            caption: GoogleFonts.robotoMono(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.4,
                color: Colors.white),
            overline: GoogleFonts.robotoMono(
                fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 1.5),
          )),
    );
  }
}
