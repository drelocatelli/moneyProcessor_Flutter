import 'package:moneyapp/Service/TransactionService.dart';

class Tudo {
  String title;
  String type;
  String created_at;
  double value;

  Tudo({
    required this.title,
    required this.type,
    required this.created_at,
    required this.value
  });

  Tudo copyWith({
    String? title,
    String? type,
    String? created_at,
    double? value,
  }) {
    return Tudo(
      title: title ?? this.title,
      type: type ?? this.type,
      created_at: created_at ?? this.created_at,
      value: value ?? this.value,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'type': type,
      'created_at': created_at,
      'value': value
    };
  }

  factory Tudo.fromMap(Map<String, dynamic> map) {
    return Tudo(
      title: map['title'] ?? '',
      type: map['type'] ?? '',
      created_at: map['created_at'] ?? '',
      value: map['value'] ?? '',

    );
  }
}