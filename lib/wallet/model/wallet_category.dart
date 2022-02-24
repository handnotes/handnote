import 'package:flutter/material.dart';
import 'package:handnote/utils/string.dart';

enum WalletCategoryType {
  outcome,
  income,
}

enum WalletCategoryStatus {
  disable,
  enable,
}

class WalletCategory {
  WalletCategory({
    this.id,
    this.pid,
    this.type = WalletCategoryType.outcome,
    this.name = '',
    this.icon,
    this.sort = 0,
    this.status = WalletCategoryStatus.enable,
    createdAt,
    updatedAt,
    this.deletedAt,
  })  : createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  WalletCategory.root() : this(id: 0, name: 'root');

  final int? id;
  final int? pid;

  /// Type
  final WalletCategoryType type;
  final String name;
  final IconData? icon;
  final int sort;
  final WalletCategoryStatus status;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  WalletCategory copyWith({
    int? id,
    int? pid,
    WalletCategoryType? type,
    String? name,
    IconData? icon,
    int? sort,
    WalletCategoryStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return WalletCategory(
      id: id ?? this.id,
      pid: pid ?? this.pid,
      type: type ?? this.type,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      sort: sort ?? this.sort,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      'pid': pid,
      'type': type.index,
      'name': name,
      'icon': encodeIcon(icon),
      'sort': sort,
      'status': status.index,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory WalletCategory.fromMap(Map<String, dynamic> map) {
    return WalletCategory(
      id: map['id'] as int,
      pid: map['pid'] as int?,
      type: WalletCategoryType.values[map['type'] as int],
      name: map['name'] as String,
      icon: decodeIcon(map['icon'] as String?),
      sort: map['sort'] as int,
      status: WalletCategoryStatus.values[map['status'] as int],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      deletedAt: map['deleted_at'] == null ? null : DateTime.parse(map['deleted_at']),
    );
  }

  @override
  String toString() {
    return 'WalletCategory(id: $id, pid: $pid, type: ${type.name}, name: $name, sort: $sort)';
  }
}
