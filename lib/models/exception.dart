class Exception {
  final String id;
  final String message;

  const Exception({required this.id, required this.message});

  factory Exception.fromJson(Map<String, dynamic> json) {
    return Exception(id: json["id"], message: json["message"]);
  }
}
