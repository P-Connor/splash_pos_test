import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class ClockCubit extends Cubit<ClockState> {
  // TODO - sync time with server
  ClockCubit() : super(ClockState(DateTime.now())) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      emit(ClockState(DateTime.now()));
    });
  }
}

@immutable
class ClockState extends Equatable {
  final DateTime _time;

  ClockState(this._time);

  String get time {
    // TODO - format based on preferences
    return DateFormat('h:mm a').format(_time);
  }

  String get date {
    return DateFormat('MMM d, y').format(_time);
  }

  @override
  List<Object?> get props => [_time];
}
