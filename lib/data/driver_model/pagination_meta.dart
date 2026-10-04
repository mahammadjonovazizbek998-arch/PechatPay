class PaginationMeta {
  int currentPage;
  int lastPage;
  int perPage;
  int total;

  PaginationMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory PaginationMeta.formsJon(Map<String, dynamic> json) {
    return PaginationMeta(
      currentPage: json["current_page"],
      lastPage: json["last_page"],
      perPage: json["per_page"],
      total: json["total"],
    );
  }
}
