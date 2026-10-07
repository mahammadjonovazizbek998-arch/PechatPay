class PechatCreateResponse {
  final String message;
  final PechatCreateData? data;

  const PechatCreateResponse({required this.message, this.data});

  factory PechatCreateResponse.fromJson(Map<String, dynamic> json) {
    return PechatCreateResponse(
      message: json['message']?.toString() ?? '',
      data: json['data'] != null
          ? PechatCreateData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class PechatCreateData {
  final int id;
  final String driverName;
  final String carNumber;
  final String type; // "nasiya" yoki "naqt"
  final int stampPrice;
  final int pechatCount;
  final int unpaidPechatsCount;
  final int unpaidPechatsSum;
  final DateTime? createdAt;
  final int  count;
  final int summa;

  const PechatCreateData({
    required this.id,
    required this.driverName,
    required this.carNumber,
    required this.type,
    required this.stampPrice,
    required this.pechatCount,
    required this.unpaidPechatsCount,
    required this.unpaidPechatsSum,
    required this.count,
    required this.summa,
    this.createdAt,
  });

  bool get isNasiya => type == 'nasiya';

  bool get isNaqt => type == 'naqt';

  factory PechatCreateData.fromJson(Map<String, dynamic> json) {
    return PechatCreateData(
      id: (json['id'] as num?)?.toInt() ?? 0,
      driverName: json['driver_name']?.toString() ?? '',
      carNumber: json['car_number']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      stampPrice: (json['stamp_price'] as num?)?.toInt() ?? 0,
      pechatCount: (json['pechat_count'] as num?)?.toInt() ?? 0,
      unpaidPechatsCount: (json['unpaid_pechats_count'] as num?)?.toInt() ?? 0,
      unpaidPechatsSum: (json['unpaid_pechats_sum'] as num?)?.toInt() ?? 0,
      summa: (json["summa"] ?? 0),
      count: (json["count"] ?? 0),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }
}
