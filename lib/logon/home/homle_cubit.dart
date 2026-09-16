import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';


part 'homle_state.dart';

class HomleCubit extends Cubit<HomleState> {
  HomleCubit() : super(HomleInitial(currentIndex: 0));
}
