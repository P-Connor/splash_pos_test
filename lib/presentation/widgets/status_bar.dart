import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_test/logic/cubits/clock_cubit.dart';

class StatusBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.overline ?? TextStyle(),
      child: SizedBox(
        height: 50,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Theme.of(context).dividerColor),
            ),
          ),
          child: Row(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    IconButton(
                      tooltip: "Logout",
                      icon: Transform.rotate(
                        angle: pi,
                        child: Icon(Icons.logout_sharp),
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      tooltip: "Settings",
                      icon: Icon(Icons.settings),
                      onPressed: () {},
                    ),
                    IconButton(
                      tooltip: "Functions",
                      icon: Icon(Icons.menu),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Text("User: Connor Popp (Admin)\nStation: Station420"),
              SizedBox(width: 10),
              Expanded(child: SizedBox()),
              Clock(),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ClockCubit(),
      child: BlocBuilder<ClockCubit, ClockState>(builder: (context, state) {
        return Text("${state.time}\n${state.date}",
            textAlign: TextAlign.center);
      }),
    );
  }
}
