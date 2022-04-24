import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'dependent_event.dart';

part 'dependent_state.dart';

class DependentBloc extends Bloc<DependentEvent, DependentInitial> {
  DependentBloc() : super(DependentInitial()) {
    /*on<LoginPressed>((event, emit) {
      emit(WelcomeInitial(pressTarget: WelcomePressTarget.login));
    });
    on<SignupPressed>((event, emit) {
      emit(WelcomeInitial(pressTarget: WelcomePressTarget.signup));
    });*/
  }
}
