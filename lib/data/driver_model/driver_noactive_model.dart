class DriverNoactiveResponse {
  final List<DriverNoactiveModel> data;
  final PaginationMeta meta;

  DriverNoactiveResponse({required this.data, required this.meta});

  factory DriverNoactiveResponse.fromJson(Map<String, dynamic> json) {
    return DriverNoactiveResponse(
      data: (json["data"] as List? ?? [])
          .map((e) => DriverNoactiveModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: PaginationMeta.fromJson(json["meta"] as Map<String, dynamic>),
    );
  }
}

class DriverNoactiveModel {
  final int id;
  final String name;
  final String phone;
  final String carNumber;
  final int unpaidPechatsCount;
  final int unpaidPechatsSum;
  final int totalPechatsCount;
  final int paidPechatsCount;
  final String createdAt;
  final String updatedAt;

  DriverNoactiveModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.carNumber,
    required this.unpaidPechatsCount,
    required this.unpaidPechatsSum,
    required this.totalPechatsCount,
    required this.paidPechatsCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DriverNoactiveModel.fromJson(Map<String, dynamic> json) {
    return DriverNoactiveModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      carNumber: json["car_number"] ?? "",
      unpaidPechatsCount: (json["unpaid_pechats_count"] ?? 0) as int,
      unpaidPechatsSum: (json["unpaid_pechats_sum"] ?? 0) as int,
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
      paidPechatsCount: json["paid_pechats_count"] ?? 0,
      totalPechatsCount: json["total_pechats_count"] ?? 0,
    );
  }
}

class PaginationMeta {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  PaginationMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      currentPage: json["current_page"] ?? 1,
      lastPage: json["last_page"] ?? 1,
      perPage: json["per_page"] ?? 0,
      total: json["total"] ?? 0,
    );
  }
}
