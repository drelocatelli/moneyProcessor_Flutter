class Tudo {
  String title;
  String type;
  String created_at;

  Tudo({
    required this.title,
    required this.type,
    required this.created_at,
  });

  Tudo copyWith({
    String? title,
    String? type,
    String? created_at,
  }) {
    return Tudo(
      title: title ?? this.title,
      type: type ?? this.type,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'type': type,
      'created_at': created_at,
    };
  }

  factory Tudo.fromMap(Map<String, dynamic> map) {
    return Tudo(
      title: map['title'] ?? '',
      type: map['type'] ?? '',
      created_at: map['created_at'] ?? '',
    );
  }
}