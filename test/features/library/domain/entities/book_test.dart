import 'package:flutter_test/flutter_test.dart';
import 'package:tabularium/features/library/domain/entities/book.dart';

void main() {
  group('Book', () {
    final testDate = DateTime(2025, 1, 1);
    final testBook = Book(
      id: 'test-id',
      fileName: 'test.pdf',
      filePath: '/path/to/test.pdf',
      title: 'Test Title',
      author: 'Test Author',
      alias: 'Test Alias',
      thumbnailPath: '/path/to/thumbnail.png',
      addedDate: testDate,
      lastOpenedDate: testDate,
      pageCount: 100,
      fileSize: 1024,
    );

    group('displayTitle', () {
      test('should return alias when available', () {
        // Arrange
        final book = testBook;

        // Act
        final displayTitle = book.displayTitle;

        // Assert
        expect(displayTitle, equals('Test Alias'));
      });

      test('should return title when alias is null', () {
        // Arrange
        final book = testBook.copyWith(alias: null, clearAlias: true);

        // Act
        final displayTitle = book.displayTitle;

        // Assert
        expect(displayTitle, equals('Test Title'));
      });

      test('should return title when alias is empty', () {
        // Arrange
        final book = Book(
          id: 'test-id',
          fileName: 'test.pdf',
          filePath: '/path/to/test.pdf',
          title: 'Test Title',
          author: 'Test Author',
          alias: '',
          addedDate: testDate,
          lastOpenedDate: testDate,
        );

        // Act
        final displayTitle = book.displayTitle;

        // Assert
        expect(displayTitle, equals('Test Title'));
      });

      test(
        'should return fileName without .pdf when title and alias are null',
        () {
          // Arrange
          final book = Book(
            id: 'test-id',
            fileName: 'my-book.pdf',
            filePath: '/path/to/my-book.pdf',
            addedDate: testDate,
            lastOpenedDate: testDate,
          );

          // Act
          final displayTitle = book.displayTitle;

          // Assert
          expect(displayTitle, equals('my-book'));
        },
      );

      test('should return fileName as-is when it does not end with .pdf', () {
        // Arrange
        final book = Book(
          id: 'test-id',
          fileName: 'document.txt',
          filePath: '/path/to/document.txt',
          addedDate: testDate,
          lastOpenedDate: testDate,
        );

        // Act
        final displayTitle = book.displayTitle;

        // Assert
        expect(displayTitle, equals('document.txt'));
      });
    });

    group('copyWith', () {
      test('should create new book with updated id', () {
        // Act
        final newBook = testBook.copyWith(id: 'new-id');

        // Assert
        expect(newBook.id, equals('new-id'));
        expect(newBook.fileName, equals(testBook.fileName));
        expect(newBook.filePath, equals(testBook.filePath));
      });

      test('should create new book with updated title', () {
        // Act
        final newBook = testBook.copyWith(title: 'New Title');

        // Assert
        expect(newBook.title, equals('New Title'));
        expect(newBook.id, equals(testBook.id));
      });

      test('should clear alias when clearAlias is true', () {
        // Act
        final newBook = testBook.copyWith(clearAlias: true);

        // Assert
        expect(newBook.alias, isNull);
      });

      test('should preserve alias when clearAlias is false', () {
        // Act
        final newBook = testBook.copyWith(title: 'New Title');

        // Assert
        expect(newBook.alias, equals(testBook.alias));
      });

      test('should update lastOpenedDate', () {
        // Arrange
        final newDate = DateTime(2025, 12, 31);

        // Act
        final newBook = testBook.copyWith(lastOpenedDate: newDate);

        // Assert
        expect(newBook.lastOpenedDate, equals(newDate));
        expect(newBook.addedDate, equals(testBook.addedDate));
      });
    });

    group('JSON serialization', () {
      test('should serialize to JSON correctly', () {
        // Act
        final json = testBook.toJson();

        // Assert
        expect(json['id'], equals('test-id'));
        expect(json['fileName'], equals('test.pdf'));
        expect(json['filePath'], equals('/path/to/test.pdf'));
        expect(json['title'], equals('Test Title'));
        expect(json['author'], equals('Test Author'));
        expect(json['alias'], equals('Test Alias'));
        expect(json['thumbnailPath'], equals('/path/to/thumbnail.png'));
        expect(json['addedDate'], equals(testDate.toIso8601String()));
        expect(json['lastOpenedDate'], equals(testDate.toIso8601String()));
        expect(json['pageCount'], equals(100));
        expect(json['fileSize'], equals(1024));
      });

      test('should deserialize from JSON correctly', () {
        // Arrange
        final json = {
          'id': 'test-id',
          'fileName': 'test.pdf',
          'filePath': '/path/to/test.pdf',
          'title': 'Test Title',
          'author': 'Test Author',
          'alias': 'Test Alias',
          'thumbnailPath': '/path/to/thumbnail.png',
          'addedDate': testDate.toIso8601String(),
          'lastOpenedDate': testDate.toIso8601String(),
          'pageCount': 100,
          'fileSize': 1024,
        };

        // Act
        final book = Book.fromJson(json);

        // Assert
        expect(book.id, equals('test-id'));
        expect(book.fileName, equals('test.pdf'));
        expect(book.filePath, equals('/path/to/test.pdf'));
        expect(book.title, equals('Test Title'));
        expect(book.author, equals('Test Author'));
        expect(book.alias, equals('Test Alias'));
        expect(book.thumbnailPath, equals('/path/to/thumbnail.png'));
        expect(book.addedDate, equals(testDate));
        expect(book.lastOpenedDate, equals(testDate));
        expect(book.pageCount, equals(100));
        expect(book.fileSize, equals(1024));
      });

      test('should round-trip through JSON serialization', () {
        // Act
        final json = testBook.toJson();
        final deserializedBook = Book.fromJson(json);

        // Assert
        expect(deserializedBook, equals(testBook));
      });

      test('should handle null optional fields in JSON', () {
        // Arrange
        final json = {
          'id': 'test-id',
          'fileName': 'test.pdf',
          'filePath': '/path/to/test.pdf',
          'title': null,
          'author': null,
          'alias': null,
          'thumbnailPath': null,
          'addedDate': testDate.toIso8601String(),
          'lastOpenedDate': testDate.toIso8601String(),
          'pageCount': null,
          'fileSize': null,
        };

        // Act
        final book = Book.fromJson(json);

        // Assert
        expect(book.title, isNull);
        expect(book.author, isNull);
        expect(book.alias, isNull);
        expect(book.thumbnailPath, isNull);
        expect(book.pageCount, equals(0));
        expect(book.fileSize, equals(0));
      });
    });

    group('Equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        final book1 = testBook;
        final book2 = Book(
          id: 'test-id',
          fileName: 'test.pdf',
          filePath: '/path/to/test.pdf',
          title: 'Test Title',
          author: 'Test Author',
          alias: 'Test Alias',
          thumbnailPath: '/path/to/thumbnail.png',
          addedDate: testDate,
          lastOpenedDate: testDate,
          pageCount: 100,
          fileSize: 1024,
        );

        // Assert
        expect(book1, equals(book2));
      });

      test('should not be equal when ids differ', () {
        // Arrange
        final book1 = testBook;
        final book2 = testBook.copyWith(id: 'different-id');

        // Assert
        expect(book1, isNot(equals(book2)));
      });

      test('should not be equal when titles differ', () {
        // Arrange
        final book1 = testBook;
        final book2 = testBook.copyWith(title: 'Different Title');

        // Assert
        expect(book1, isNot(equals(book2)));
      });
    });
  });
}
