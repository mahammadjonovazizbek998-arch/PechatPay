import 'driver_noactive_model.dart';

class HistoryHomePage {
  final List<Driver> data;
  final PaginationMeta meta;

  const HistoryHomePage({required this.data, required this.meta});

  factory HistoryHomePage.fromJson(Map<String, dynamic> json) {
    return HistoryHomePage(
      data: (json["data"] as List? ?? [])
          .map((e) => Driver.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: PaginationMeta.fromJson(json["meta"] as Map<String, dynamic>),
    );
  }
}

class Driver {
  final int id;
  final String name;
  final String phone;
  final String carNumber;
  final int unpaidPechatsCount;
  final int unpaidPechatsSum;
  final String createdAt;
  final String updatedAt;
  final String? action;
  final ActionData? actionData;

  const Driver({
    required this.id,
    required this.name,
    required this.phone,
    required this.carNumber,
    required this.unpaidPechatsCount,
    required this.unpaidPechatsSum,
    required this.createdAt,
    required this.updatedAt,
    this.action,
    this.actionData,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'] as int,
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      carNumber: json['car_number']?.toString() ?? '',
      unpaidPechatsCount: (json['unpaid_pechats_count'] as num?)?.toInt() ?? 0,
      unpaidPechatsSum: (json['unpaid_pechats_sum'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at']??"",

      updatedAt: json['updated_at'] ??"",
      action: json['action']?.toString(),
      actionData: json['action_data'] != null
          ? ActionData.fromJson(json['action_data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ActionData {
  final int id;
  final int summa;
  final DateTime? createdAt;

  const ActionData({required this.id, required this.summa, this.createdAt});

  factory ActionData.fromJson(Map<String, dynamic> json) {
    return ActionData(
      id: json['id'] as int,
      summa: (json['summa'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }
}
