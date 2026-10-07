import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pechat_pay/data/repository/auth.dart';

import '../../data/driver_model/driver_noactive_model.dart';
import '../../data/driver_model/history_home_page.dart';

import '../../data/driver_model/pechat.dart';
import '../../data/token_model/token_erorr_model.dart';

part 'homle_state.dart';

class HomleCubit extends Cubit<HomleState> {
  HomleCubit()
    : super(
        HomleInitial(
          currentIndex: 0,
          historyHomePage: null,
          driverNoactiveResponse: null,
          pechatCreateResponse: null,
        ),
      );
  AuthRepository authRepository = AuthRepository();

  Future<void> historyHomePage(int page) async {
    if (page == 1) {
      emit(
        HomeLoding(
          currentIndex: state.currentIndex,
          historyHomePage: null,
          driverNoactiveResponse: state.driverNoactiveResponse,
          pechatCreateResponse: state.pechatCreateResponse,
        ),
      );
    }
    final response = await authRepository.historyHomePage(page);

    if (response is TokenErorrModel) {
      emit(
        HomeError(
          currentIndex: state.currentIndex,
          historyHomePage: state.historyHomePage,
          tokenErorrModel: response,
          driverNoactiveResponse: state.driverNoactiveResponse,
          pechatCreateResponse: state.pechatCreateResponse,
        ),
      );
    } else if (response is HistoryHomePage) {
      emit(
        HomleFinish(
          currentIndex: state.currentIndex,
          historyHomePage: page == 1
              ? response
              : HistoryHomePage(
                  data: [...state.historyHomePage!.data, ...response.data],
                  meta: response.meta,
                ),
          driverNoactiveResponse: state.driverNoactiveResponse,
          pechatCreateResponse: state.pechatCreateResponse,
        ),
      );
    }
  }

  Future<void> searchHome(int page, String query) async {
    if (page == 1) {
      emit(
        HomeLoding(
          currentIndex: state.currentIndex,
          historyHomePage: state.historyHomePage,
          driverNoactiveResponse: null,
          pechatCreateResponse: state.pechatCreateResponse,
        ),
      );
    }
    final response = await authRepository.searchHome(page, query);

    if (response is TokenErorrModel) {
      emit(
        HomeError(
          currentIndex: state.currentIndex,
          historyHomePage: state.historyHomePage,
          tokenErorrModel: response,
          driverNoactiveResponse: state.driverNoactiveResponse,
          pechatCreateResponse: state.pechatCreateResponse,
        ),
      );
    } else if (response is DriverNoactiveResponse) {
      emit(
        HomleFinish(
          currentIndex: state.currentIndex,
          historyHomePage: state.historyHomePage,
          driverNoactiveResponse: page == 1
              ? response
              : DriverNoactiveResponse(
                  data: [
                    ...state.driverNoactiveResponse!.data,
                    ...response.data,
                  ],
                  meta: response.meta,
                ),
          pechatCreateResponse: state.pechatCreateResponse,
        ),
      );
    }
  }

  Future<void> pechat(int id, String type) async {
    emit(
      HomeLoding(
        currentIndex: state.currentIndex,
        historyHomePage: state.historyHomePage,
        driverNoactiveResponse: state.driverNoactiveResponse,
        pechatCreateResponse: state.pechatCreateResponse,
      ),
    );
    final response = await authRepository.pechat(id, type);

    if (response is TokenErorrModel) {
      emit(
        HomeError(
          currentIndex: state.currentIndex,
          historyHomePage: state.historyHomePage,
          tokenErorrModel: response,
          driverNoactiveResponse: state.driverNoactiveResponse,
          pechatCreateResponse: state.pechatCreateResponse,
        ),
      );
    } else if (response is PechatCreateResponse) {
      emit(
        HomleFinish(
          currentIndex: state.currentIndex,
          historyHomePage: state.historyHomePage,
          driverNoactiveResponse: state.driverNoactiveResponse,
          pechatCreateResponse: response,
        ),
      );
    }
  }

  void resetPechatResponse() {
    emit(
      HomleFinish(
        currentIndex: state.currentIndex,
        historyHomePage: state.historyHomePage,
        driverNoactiveResponse: state.driverNoactiveResponse,
        pechatCreateResponse: state.pechatCreateResponse,
      ),
    );
  }

  Future<void> pay(int id, int count) async {
    emit(
      HomeLoding(
        currentIndex: state.currentIndex,
        historyHomePage: state.historyHomePage,
        driverNoactiveResponse: state.driverNoactiveResponse,
        pechatCreateResponse: state.pechatCreateResponse,
      ),
    );
    final response = await authRepository.pay(id, count);
    if (response is TokenErorrModel) {
      emit(
        HomeError(
          currentIndex: state.currentIndex,
          historyHomePage: state.historyHomePage,
          tokenErorrModel: response,
          driverNoactiveResponse: state.driverNoactiveResponse,
          pechatCreateResponse: state.pechatCreateResponse,
        ),
      );
    } else if (response is PechatCreateResponse) {
      emit(
        HomleFinish(
          currentIndex: state.currentIndex,
          historyHomePage: state.historyHomePage,
          driverNoactiveResponse: state.driverNoactiveResponse,
          pechatCreateResponse: response,
        ),
      );
    }
  }
}
