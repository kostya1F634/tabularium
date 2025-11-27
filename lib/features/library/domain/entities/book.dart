import 'package:equatable/equatable.dart';

/// Entity representing a book in the library
class Book extends Equatable {
  final String id;
  final String fileName;
  final String filePath;
  final String? title;
  final String? author;
  final String? alias;
  final String? thumbnailPath;
  final DateTime addedDate;
  final DateTime lastOpenedDate;
  final int pageCount;
  final int fileSize;

  const Book({
    required this.id,
    required this.fileName,
    required this.filePath,
    this.title,
    this.author,
    this.alias,
    this.thumbnailPath,
    required this.addedDate,
    required this.lastOpenedDate,
    this.pageCount = 0,
    this.fileSize = 0,
  });

  /// Get display title (use alias if available, then title, otherwise fileName without extension)
  String get displayTitle {
    if (alias != null && alias!.isNotEmpty) {
      return alias!;
    }
    if (title != null && title!.isNotEmpty) {
      return title!;
    }
    // Remove .pdf extension
    final name = fileName.toLowerCase().endsWith('.pdf')
        ? fileName.substring(0, fileName.length - 4)
        : fileName;
    return name;
  }

  Book copyWith({
    String? id,
    String? fileName,
    String? filePath,
    String? title,
    String? author,
    String? alias,
    String? thumbnailPath,
    DateTime? addedDate,
    DateTime? lastOpenedDate,
    int? pageCount,
    int? fileSize,
    bool clearAlias = false,
  }) {
    return Book(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      title: title ?? this.title,
      author: author ?? this.author,
      alias: clearAlias ? null : (alias ?? this.alias),
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      addedDate: addedDate ?? this.addedDate,
      lastOpenedDate: lastOpenedDate ?? this.lastOpenedDate,
      pageCount: pageCount ?? this.pageCount,
      fileSize: fileSize ?? this.fileSize,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fileName': fileName,
      'filePath': filePath,
      'title': title,
      'author': author,
      'alias': alias,
      'thumbnailPath': thumbnailPath,
      'addedDate': addedDate.toIso8601String(),
      'lastOpenedDate': lastOpenedDate.toIso8601String(),
      'pageCount': pageCount,
      'fileSize': fileSize,
    };
  }

  /// Create from JSON
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as String,
      fileName: json['fileName'] as String,
      filePath: json['filePath'] as String,
      title: json['title'] as String?,
      author: json['author'] as String?,
      alias: json['alias'] as String?,
      thumbnailPath: json['thumbnailPath'] as String?,
      addedDate: DateTime.parse(json['addedDate'] as String),
      lastOpenedDate: DateTime.parse(json['lastOpenedDate'] as String),
      pageCount: json['pageCount'] as int? ?? 0,
      fileSize: json['fileSize'] as int? ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fileName,
        filePath,
        title,
        author,
        alias,
        thumbnailPath,
        addedDate,
        lastOpenedDate,
        pageCount,
        fileSize,
      ];
}
