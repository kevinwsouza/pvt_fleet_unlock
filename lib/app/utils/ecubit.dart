import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ECubit<State> extends Cubit<State> {
  ECubit(super.initialState);

  @override
  void emit(State state) {
    if (!isClosed) return super.emit(state);
    log('Cannot emit new states after calling close');
  }
}