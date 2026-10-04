import 'driver_noactive_model.dart';

class DriverHistoryResponse {

  final List<HistoryItem> data;
  final PaginationMeta meta;

  const DriverHistoryResponse({

    required this.data,
    required this.meta,
  });

  factory DriverHistoryResponse.fromJson(Map<String, dynamic> json) {
    return DriverHistoryResponse(
      data: (json['data'] as List? ?? [])
          .map((e) => HistoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: PaginationMeta.fromJson(
        (json['meta'] as Map<String, dynamic>?) ?? {},
      ),
    );
  }
}

class HistoryItem {
  final int id;
  final String action; // "pechat" yoki "pay"
  final String filialName;
  final int summa;
  final DateTime? createdAt;

  // action == "pechat" bo'lganda
  final String? type; // "nasiya" yoki "naqt"
  final bool isPaid;
  final PayInfo? pay;

  // action == "pay" bo'lganda
  final int? count;
  final List<HistoryPechat> pechats;

  const HistoryItem({
    required this.id,
    required this.action,
    required this.filialName,
    required this.summa,
    this.createdAt,
    this.type,
    this.isPaid = false,
    this.pay,
    this.count,
    this.pechats = const [],
  });

  bool get isPechat => action == 'pechat';
  bool get isPay => action == 'pay';

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: (json['id'] as num?)?.toInt() ?? 0,
      action: json['action']?.toString() ?? '',
      filialName: json['filial_name']?.toString() ?? '',
      summa: (json['summa'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      type: json['type']?.toString(),
      isPaid: json['is_paid'] == true,
      pay: json['pay'] != null
          ? PayInfo.fromJson(json['pay'] as Map<String, dynamic>)
          : null,
      count: (json['count'] as num?)?.toInt(),
      pechats: (json['pechats'] as List? ?? [])
          .map((e) => HistoryPechat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class PayInfo {
  final int id;
  final String filialName;
  final int count;
  final int summa;
  final DateTime? createdAt;

  const PayInfo({
    required this.id,
    required this.filialName,
    required this.count,
    required this.summa,
    this.createdAt,
  });

  factory PayInfo.fromJson(Map<String, dynamic> json) {
    return PayInfo(
      id: (json['id'] as num?)?.toInt() ?? 0,
      filialName: json['filial_name']?.toString() ?? '',
      count: (json['count'] as num?)?.toInt() ?? 0,
      summa: (json['summa'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }
}

class HistoryPechat {
  final int id;
  final String filialName;
  final int summa;
  final DateTime? createdAt;

  const HistoryPechat({
    required this.id,
    required this.filialName,
    required this.summa,
    this.createdAt,
  });

  factory HistoryPechat.fromJson(Map<String, dynamic> json) {
    return HistoryPechat(
      id: (json['id'] as num?)?.toInt() ?? 0,
      filialName: json['filial_name']?.toString() ?? '',
      summa: (json['summa'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }
}