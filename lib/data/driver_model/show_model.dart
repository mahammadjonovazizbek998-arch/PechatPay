import 'driver_noactive_model.dart';

class UnpaidPechat {
  final int id;
  final int summa;
  final DateTime? createdAt;

  const UnpaidPechat({required this.id, required this.summa, this.createdAt});

  factory UnpaidPechat.fromJson(Map<String, dynamic> json) {
    return UnpaidPechat(
      id: json['id'] as int,
      summa: json['summa'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }
}

class DriverDetailData {
  final int pechatSumma;
  final DriverNoactiveModel driver;
  final List<UnpaidPechat> unpaidPechat;

  const DriverDetailData({
    required this.pechatSumma,
    required this.driver,
    required this.unpaidPechat,
  });

  factory DriverDetailData.fromJson(Map<String, dynamic> json) {
    return DriverDetailData(
      pechatSumma: (json['pechat_summa'] as num?)?.toInt() ?? 0,
      driver: DriverNoactiveModel.fromJson(
        json['driver'] as Map<String, dynamic>,
      ),
      unpaidPechat: (json['unpaid_pechat'] as List? ?? [])
          .map((e) => UnpaidPechat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
