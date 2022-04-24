import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'edit_event.dart';

part 'edit_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileInitial> {
  EditProfileBloc() : super(EditProfileInitial()) {
    /*on<LoginPressed>((event, emit) {
      emit(WelcomeInitial(pressTarget: WelcomePressTarget.login));
    });
    on<SignupPressed>((event, emit) {
      emit(WelcomeInitial(pressTarget: WelcomePressTarget.signup));
    });*/
  }
}
