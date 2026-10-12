
import '../../data/dashboar_model/all_dashboar_model.dart';
import '../../data/driver_model/chip_model.dart';
import '../../data/token_model/token_erorr_model.dart';
import '../../data/token_model/token_model.dart';

/// Barcha holatlar bir xil maydonlarni saqlaydi (index, filiallar, chip, sana...),
/// shuning uchun UI istalgan holatda ham `state.statisticsBool`,
/// `state.filiallPagel[state.index]` kabi qiymatlarni o'qiy oladi.

sealed class DashboardState {
  final int index;
  final List<TokenModelApiUserModel> filiallPagel;
  final List<ChipModel> chip;
  final DateTime selectedDate;
  final int selectedIndex;
  final StatsResponse? statsResponse;

  /// true  -> Pechatlash tabi
  /// false -> Naqdlashtirish tabi
  final bool statisticsBool;

  const DashboardState({
    required this.index,
    required this.filiallPagel,
    required this.chip,
    required this.selectedDate,
    required this.selectedIndex,
    required this.statsResponse,
    required this.statisticsBool,
  });
}

/// Boshlang'ich holat
final class DashboardInitial extends DashboardState {
  const DashboardInitial({
    required super.index,
    required super.filiallPagel,
    required super.chip,
    required super.selectedDate,
    required super.selectedIndex,
    required super.statsResponse,
    required super.statisticsBool,
  });
}

/// Yuklanmoqda
final class DashboardLoding extends DashboardState {
  const DashboardLoding({
    required super.index,
    required super.filiallPagel,
    required super.chip,
    required super.selectedDate,
    required super.selectedIndex,
    required super.statsResponse,
    required super.statisticsBool,
  });
}

/// Ma'lumot muvaffaqiyatli yuklandi / yangilandi
final class DashboardFinish extends DashboardState {
  const DashboardFinish({
    required super.index,
    required super.filiallPagel,
    required super.chip,
    required super.selectedDate,
    required super.selectedIndex,
    required super.statsResponse,
    required super.statisticsBool,
  });
}

/// Xatolik
final class DashboardError extends DashboardState {
  final TokenErorrModel tokenErorrModel;

  const DashboardError({
    required this.tokenErorrModel,
    required super.index,
    required super.filiallPagel,
    required super.chip,
    required super.selectedDate,
    required super.selectedIndex,
    required super.statsResponse,
    required super.statisticsBool,
  });
}
