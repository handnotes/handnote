import 'package:handnote/constants/enums.dart';

class WalletBook {
  final int? id;

  final String name;

  final Status status;

  final DateTime createdAt;

  final DateTime updatedAt;

  final DateTime? deletedAt;

  WalletBook({
    this.id,
    required this.name,
    this.status = Status.active,
    createdAt,
    updatedAt,
    this.deletedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  WalletBook copyWith({
    int? id,
    String? name,
    Status? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return WalletBook(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      'name': name,
      'status': status.index,
      'created_at': createdAt.toUtc().toIso8601String(),
      'updated_at': updatedAt.toUtc().toIso8601String(),
      'deleted_at': deletedAt?.toUtc().toIso8601String(),
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory WalletBook.fromMap(Map<String, dynamic> map) {
    return WalletBook(
      id: map['id'] as int,
      name: map['name'] as String,
      status: Status.values[map['status'] as int],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      deletedAt: map['deleted_at'] == null ? null : DateTime.parse(map['deleted_at']),
    );
  }

  @override
  String toString() {
    return 'WalletBook(id: $id, name: $name)';
  }
}
