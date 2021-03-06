import 'package:moneyapp/Service/TransactionService.dart';

class Tudo {
  int id;
  String title;
  String type;
  String created_at;
  String value;

  Tudo({
    required this.id,
    required this.title,
    required this.type,
    required this.created_at,
    required this.value
  });

  Tudo copyWith({
    int? id,
    String? title,
    String? type,
    String? created_at,
    String? value,
  }) {
    return Tudo(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      created_at: created_at ?? this.created_at,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'created_at': created_at,
      'value': value
    };
  }

  factory Tudo.fromMap(Map<String, dynamic> map) {
    return Tudo(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      type: map['type'] ?? '',
      created_at: map['created_at'] ?? '',
      value: map['value'] ?? '',

    );
  }
}