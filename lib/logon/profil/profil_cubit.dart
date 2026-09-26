import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';


part 'profil_state.dart';

class ProfilCubit extends Cubit<ProfilState> {
  ProfilCubit() : super(ProfilInitial());
}
