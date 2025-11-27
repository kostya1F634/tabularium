import 'package:equatable/equatable.dart';

/// Entity representing a shelf (collection) of books
class Shelf extends Equatable {
  final String id;
  final String name;
  final List<String> bookIds;
  final bool isDefault;
  final DateTime createdDate;

  const Shelf({
    required this.id,
    required this.name,
    required this.bookIds,
    this.isDefault = false,
    required this.createdDate,
  });

  /// Default "All" shelf ID
  static const String allShelfId = 'all';

  /// Create default "All" shelf
  static Shelf createAll() {
    return Shelf(
      id: allShelfId,
      name: 'All',
      bookIds: const [],
      isDefault: true,
      createdDate: DateTime.now(),
    );
  }

  Shelf copyWith({
    String? id,
    String? name,
    List<String>? bookIds,
    bool? isDefault,
    DateTime? createdDate,
  }) {
    return Shelf(
      id: id ?? this.id,
      name: name ?? this.name,
      bookIds: bookIds ?? this.bookIds,
      isDefault: isDefault ?? this.isDefault,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  /// Add book to shelf
  Shelf addBook(String bookId) {
    if (bookIds.contains(bookId)) {
      return this;
    }
    return copyWith(bookIds: [...bookIds, bookId]);
  }

  /// Remove book from shelf
  Shelf removeBook(String bookId) {
    return copyWith(bookIds: bookIds.where((id) => id != bookId).toList());
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bookIds': bookIds,
      'isDefault': isDefault,
      'createdDate': createdDate.toIso8601String(),
    };
  }

  /// Create from JSON
  factory Shelf.fromJson(Map<String, dynamic> json) {
    return Shelf(
      id: json['id'] as String,
      name: json['name'] as String,
      bookIds: List<String>.from(json['bookIds'] as List),
      isDefault: json['isDefault'] as bool? ?? false,
      createdDate: DateTime.parse(json['createdDate'] as String),
    );
  }

  @override
  List<Object?> get props => [id, name, bookIds, isDefault, createdDate];
}
