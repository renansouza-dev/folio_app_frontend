class PaginationResponse<T> {
  final List<T> content;
  final int totalPages;
  final int totalElements;
  final bool last;

  PaginationResponse({
    required this.content,
    required this.totalPages,
    required this.totalElements,
    required this.last,
  });

  factory PaginationResponse.fromJson(Map<String, dynamic> json) {
    return PaginationResponse(
      content: json['content'] as List<T>,
      last: json['last'],
      totalPages: json['totalPages'],
      totalElements: json['totalElements'],
    );
  }
}
