
// Ishlatish:
//   final res = StatsResponse.fromJson(jsonDecode(body));
//   res.data.summary.count;
//   res.data.pechatTrend.first.count;      // jami (filial: serverdan, tarmoq: yig'indi)
//   res.data.pechatTrend.first.branches;   // tarmoq javobida: har bir filial bo'yicha

int _toInt(dynamic v) => v is num ? v.toInt() : int.tryParse('$v') ?? 0;

class StatsResponse {
  final String message;
  final StatsData data;

  StatsResponse({required this.message, required this.data});

  factory StatsResponse.fromJson(Map<String, dynamic> json) => StatsResponse(
    message: json['message'] ?? '',
    data: StatsData.fromJson(json['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data.toJson(),
  };
}

class StatsData {
  /// Butun faoliyat statistikasida `[]` keladi -> null
  final StatsDate? date;
  final StatsSummary summary;
  final UnpaidPechats allTimeUnpaidPechats;
  final StatsSummary? previous;
  final StatsSummary? shift1;
  final StatsSummary? shift2;
  final List<PechatTrendItem> pechatTrend;
  final List<PaymentTrendItem> paymentTrend;
  final List<TopDriver> topDrivers;

  StatsData({
    this.date,
    required this.summary,
    required this.allTimeUnpaidPechats,
    this.previous,
    this.shift1,
    this.shift2,
    required this.pechatTrend,
    required this.paymentTrend,
    required this.topDrivers,
  });

  factory StatsData.fromJson(Map<String, dynamic> json) => StatsData(
    date: json['date'] is Map<String, dynamic>
        ? StatsDate.fromJson(json['date'])
        : null,
    summary: StatsSummary.fromJson(json['summary']),
    allTimeUnpaidPechats:
    UnpaidPechats.fromJson(json['all_time_unpaid_pechats']),
    previous: json['previous'] != null
        ? StatsSummary.fromJson(json['previous'])
        : null,
    shift1: json['shift_1'] != null
        ? StatsSummary.fromJson(json['shift_1'])
        : null,
    shift2: json['shift_2'] != null
        ? StatsSummary.fromJson(json['shift_2'])
        : null,
    pechatTrend: (json['pechat_trend'] as List? ?? [])
        .map((e) => PechatTrendItem.fromJson(e))
        .toList(),
    paymentTrend: (json['payment_trend'] as List? ?? [])
        .map((e) => PaymentTrendItem.fromJson(e))
        .toList(),
    topDrivers: (json['top_drivers'] as List? ?? [])
        .map((e) => TopDriver.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'date': date?.toJson() ?? [],
    'summary': summary.toJson(),
    'all_time_unpaid_pechats': allTimeUnpaidPechats.toJson(),
    'previous': previous?.toJson(),
    'shift_1': shift1?.toJson(),
    'shift_2': shift2?.toJson(),
    'pechat_trend': pechatTrend.map((e) => e.toJson()).toList(),
    'payment_trend': paymentTrend.map((e) => e.toJson()).toList(),
    'top_drivers': topDrivers.map((e) => e.toJson()).toList(),
  };
}

class StatsDate {
  final DateTime? previousStart;
  final DateTime? previousEnd;
  final DateTime? start;
  final DateTime? shift1End;
  final DateTime? shift2Start;
  final DateTime? end;

  StatsDate({
    this.previousStart,
    this.previousEnd,
    this.start,
    this.shift1End,
    this.shift2Start,
    this.end,
  });

  static DateTime? _d(dynamic v) =>
      v == null ? null : DateTime.tryParse(v.toString());

  factory StatsDate.fromJson(Map<String, dynamic> json) => StatsDate(
    previousStart: _d(json['previous_start']),
    previousEnd: _d(json['previous_end']),
    start: _d(json['start']),
    shift1End: _d(json['shift_1_end']),
    shift2Start: _d(json['shift_2_start']),
    end: _d(json['end']),
  );

  Map<String, dynamic> toJson() => {
    'previous_start': previousStart?.toIso8601String(),
    'previous_end': previousEnd?.toIso8601String(),
    'start': start?.toIso8601String(),
    'shift_1_end': shift1End?.toIso8601String(),
    'shift_2_start': shift2Start?.toIso8601String(),
    'end': end?.toIso8601String(),
  };
}

/// summary, previous, shift_1, shift_2 — hammasi bir xil tuzilmada
class StatsSummary {
  final int count;
  final int summa;
  final int uniqueDriversCount;
  final int paymentCount;
  final int paymentPechatCount;
  final int paymentSumma;
  final int paymentUniqueDriversCount;

  StatsSummary({
    required this.count,
    required this.summa,
    required this.uniqueDriversCount,
    required this.paymentCount,
    required this.paymentPechatCount,
    required this.paymentSumma,
    required this.paymentUniqueDriversCount,
  });

  factory StatsSummary.fromJson(Map<String, dynamic> json) => StatsSummary(
    count: _toInt(json['count']),
    summa: _toInt(json['summa']),
    uniqueDriversCount: _toInt(json['unique_drivers_count']),
    paymentCount: _toInt(json['payment_count']),
    paymentPechatCount: _toInt(json['payment_pechat_count']),
    paymentSumma: _toInt(json['payment_summa']),
    paymentUniqueDriversCount: _toInt(json['payment_unique_drivers_count']),
  );

  Map<String, dynamic> toJson() => {
    'count': count,
    'summa': summa,
    'unique_drivers_count': uniqueDriversCount,
    'payment_count': paymentCount,
    'payment_pechat_count': paymentPechatCount,
    'payment_summa': paymentSumma,
    'payment_unique_drivers_count': paymentUniqueDriversCount,
  };
}

class UnpaidPechats {
  final int count;
  final int summa;

  UnpaidPechats({required this.count, required this.summa});

  factory UnpaidPechats.fromJson(Map<String, dynamic> json) => UnpaidPechats(
    count: _toInt(json['count']),
    summa: _toInt(json['summa']),
  );

  Map<String, dynamic> toJson() => {'count': count, 'summa': summa};
}

/// Tarmoq javobida trend ichidagi bitta filial (do'kon) qiymati.
class BranchPechat {
  final int id;
  final String name;
  final int count;
  final int summa;

  BranchPechat({
    required this.id,
    required this.name,
    required this.count,
    required this.summa,
  });

  factory BranchPechat.fromJson(Map<String, dynamic> json) => BranchPechat(
    id: _toInt(json['id']),
    name: json['name']?.toString() ?? '',
    count: _toInt(json['count']),
    summa: _toInt(json['summa']),
  );

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'count': count, 'summa': summa};
}

class BranchPayment {
  final int id;
  final String name;
  final int paymentCount;
  final int pechatCount;
  final int summa;

  BranchPayment({
    required this.id,
    required this.name,
    required this.paymentCount,
    required this.pechatCount,
    required this.summa,
  });

  factory BranchPayment.fromJson(Map<String, dynamic> json) => BranchPayment(
    id: _toInt(json['id']),
    name: json['name']?.toString() ?? '',
    paymentCount: _toInt(json['payment_count']),
    pechatCount: _toInt(json['pechat_count']),
    summa: _toInt(json['summa']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'payment_count': paymentCount,
    'pechat_count': pechatCount,
    'summa': summa,
  };
}

/// Filial javobi:  {label, count, summa}
/// Tarmoq javobi:  {label, data: [{id, name, count, summa}, ...]}
/// Ikkala holatda ham [count] va [summa] to'ldiriladi; tarmoqda ular
/// filiallar yig'indisi, [branches] esa har bir filial bo'yicha qiymat.
class PechatTrendItem {
  final String label;
  final int count;
  final int summa;
  final List<BranchPechat> branches;

  PechatTrendItem({
    required this.label,
    required this.count,
    required this.summa,
    this.branches = const [],
  });

  factory PechatTrendItem.fromJson(Map<String, dynamic> json) {
    if (json['data'] is List) {
      final branches = (json['data'] as List)
          .map((e) => BranchPechat.fromJson(e as Map<String, dynamic>))
          .toList();
      return PechatTrendItem(
        label: json['label']?.toString() ?? '',
        count: branches.fold(0, (s, e) => s + e.count),
        summa: branches.fold(0, (s, e) => s + e.summa),
        branches: branches,
      );
    }
    return PechatTrendItem(
      label: json['label']?.toString() ?? '',
      count: _toInt(json['count']),
      summa: _toInt(json['summa']),
    );
  }

  Map<String, dynamic> toJson() => {
    'label': label,
    if (branches.isEmpty) ...{'count': count, 'summa': summa},
    if (branches.isNotEmpty)
      'data': branches.map((e) => e.toJson()).toList(),
  };
}

class PaymentTrendItem {
  final String label;
  final int paymentCount;
  final int pechatCount;
  final int summa;
  final List<BranchPayment> branches;

  PaymentTrendItem({
    required this.label,
    required this.paymentCount,
    required this.pechatCount,
    required this.summa,
    this.branches = const [],
  });

  factory PaymentTrendItem.fromJson(Map<String, dynamic> json) {
    if (json['data'] is List) {
      final branches = (json['data'] as List)
          .map((e) => BranchPayment.fromJson(e as Map<String, dynamic>))
          .toList();
      return PaymentTrendItem(
        label: json['label']?.toString() ?? '',
        paymentCount: branches.fold(0, (s, e) => s + e.paymentCount),
        pechatCount: branches.fold(0, (s, e) => s + e.pechatCount),
        summa: branches.fold(0, (s, e) => s + e.summa),
        branches: branches,
      );
    }
    return PaymentTrendItem(
      label: json['label']?.toString() ?? '',
      paymentCount: _toInt(json['payment_count']),
      pechatCount: _toInt(json['pechat_count']),
      summa: _toInt(json['summa']),
    );
  }

  Map<String, dynamic> toJson() => {
    'label': label,
    if (branches.isEmpty) ...{
      'payment_count': paymentCount,
      'pechat_count': pechatCount,
      'summa': summa,
    },
    if (branches.isNotEmpty)
      'data': branches.map((e) => e.toJson()).toList(),
  };
}

class TopDriver {
  final int driverId;
  final String name;
  final String phone;
  final String carNumber;
  final int pechatCount;
  final int pechatSumma;

  TopDriver({
    required this.driverId,
    required this.name,
    required this.phone,
    required this.carNumber,
    required this.pechatCount,
    required this.pechatSumma,
  });

  factory TopDriver.fromJson(Map<String, dynamic> json) => TopDriver(
    driverId: _toInt(json['driver_id']),
    name: json['name'] ?? '',
    phone: json['phone'] ?? '',
    carNumber: json['car_number'] ?? '',
    pechatCount: _toInt(json['pechat_count']),
    pechatSumma: _toInt(json['pechat_summa']),
  );

  Map<String, dynamic> toJson() => {
    'driver_id': driverId,
    'name': name,
    'phone': phone,
    'car_number': carNumber,
    'pechat_count': pechatCount,
    'pechat_summa': pechatSumma,
  };
}
