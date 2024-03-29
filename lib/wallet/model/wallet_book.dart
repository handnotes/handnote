import 'package:handnote/constants/enums.dart';
import 'package:handnote/model.dart';

class WalletBook implements Model {
  final int? id;

  final String name;

  final Status status;

  final DateTime createdAt;

  final DateTime updatedAt;

  final DateTime? deletedAt;

  @override
  WalletBook({
    this.id,
    required this.name,
    this.status = Status.active,
    createdAt,
    updatedAt,
    this.deletedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  @override
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

  @override
  Map<String, dynamic> toMap() {
    final map = {
      'name': name,
      'status': status.index,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'updatedAt': updatedAt.toUtc().toIso8601String(),
      'deletedAt': deletedAt?.toUtc().toIso8601String(),
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  @override
  factory WalletBook.fromMap(Map<String, dynamic> map) {
    return WalletBook(
      id: map['id'] as int,
      name: map['name'] as String,
      status: Status.values[map['status'] as int],
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
      updatedAt: DateTime.parse(map['updatedAt']).toLocal(),
      deletedAt: map['deletedAt'] == null ? null : DateTime.parse(map['deletedAt']).toLocal(),
    );
  }

  @override
  String toString() {
    return 'WalletBook(id: $id, name: $name)';
  }
}
