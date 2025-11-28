import 'package:flutter_test/flutter_test.dart';
import 'package:tabularium/features/library/domain/entities/shelf.dart';

void main() {
  group('Shelf', () {
    final testDate = DateTime(2025, 1, 1);
    final testShelf = Shelf(
      id: 'test-id',
      name: 'Test Shelf',
      bookIds: const ['book1', 'book2', 'book3'],
      isDefault: false,
      createdDate: testDate,
    );

    group('Factory constructors', () {
      test('createAll should create default All shelf', () {
        // Act
        final shelf = Shelf.createAll();

        // Assert
        expect(shelf.id, equals(Shelf.allShelfId));
        expect(shelf.name, equals('All'));
        expect(shelf.bookIds, isEmpty);
        expect(shelf.isDefault, isTrue);
      });

      test('createUnsorted should create default Unsorted shelf', () {
        // Act
        final shelf = Shelf.createUnsorted();

        // Assert
        expect(shelf.id, equals(Shelf.unsortedShelfId));
        expect(shelf.name, equals('Unsorted'));
        expect(shelf.bookIds, isEmpty);
        expect(shelf.isDefault, isTrue);
      });
    });

    group('copyWith', () {
      test('should create new shelf with updated name', () {
        // Act
        final newShelf = testShelf.copyWith(name: 'New Name');

        // Assert
        expect(newShelf.name, equals('New Name'));
        expect(newShelf.id, equals(testShelf.id));
        expect(newShelf.bookIds, equals(testShelf.bookIds));
      });

      test('should create new shelf with updated bookIds', () {
        // Act
        final newShelf = testShelf.copyWith(bookIds: ['book4', 'book5']);

        // Assert
        expect(newShelf.bookIds, equals(['book4', 'book5']));
        expect(newShelf.name, equals(testShelf.name));
      });

      test('should create new shelf with updated isDefault', () {
        // Act
        final newShelf = testShelf.copyWith(isDefault: true);

        // Assert
        expect(newShelf.isDefault, isTrue);
        expect(newShelf.id, equals(testShelf.id));
      });
    });

    group('addBook', () {
      test('should add book to shelf', () {
        // Act
        final newShelf = testShelf.addBook('book4');

        // Assert
        expect(newShelf.bookIds, equals(['book1', 'book2', 'book3', 'book4']));
      });

      test('should not add duplicate book', () {
        // Act
        final newShelf = testShelf.addBook('book2');

        // Assert
        expect(newShelf.bookIds, equals(['book1', 'book2', 'book3']));
        expect(newShelf, equals(testShelf));
      });

      test('should add book to empty shelf', () {
        // Arrange
        final emptyShelf = Shelf(
          id: 'empty',
          name: 'Empty',
          bookIds: const [],
          createdDate: testDate,
        );

        // Act
        final newShelf = emptyShelf.addBook('book1');

        // Assert
        expect(newShelf.bookIds, equals(['book1']));
      });
    });

    group('removeBook', () {
      test('should remove book from shelf', () {
        // Act
        final newShelf = testShelf.removeBook('book2');

        // Assert
        expect(newShelf.bookIds, equals(['book1', 'book3']));
      });

      test('should handle removing non-existent book', () {
        // Act
        final newShelf = testShelf.removeBook('book999');

        // Assert
        expect(newShelf.bookIds, equals(['book1', 'book2', 'book3']));
      });

      test('should handle removing from empty shelf', () {
        // Arrange
        final emptyShelf = Shelf(
          id: 'empty',
          name: 'Empty',
          bookIds: const [],
          createdDate: testDate,
        );

        // Act
        final newShelf = emptyShelf.removeBook('book1');

        // Assert
        expect(newShelf.bookIds, isEmpty);
      });

      test('should remove all occurrences of book', () {
        // Arrange
        final shelfWithDuplicates = Shelf(
          id: 'test',
          name: 'Test',
          bookIds: const ['book1', 'book2', 'book1', 'book3'],
          createdDate: testDate,
        );

        // Act
        final newShelf = shelfWithDuplicates.removeBook('book1');

        // Assert
        expect(newShelf.bookIds, equals(['book2', 'book3']));
      });
    });

    group('JSON serialization', () {
      test('should serialize to JSON correctly', () {
        // Act
        final json = testShelf.toJson();

        // Assert
        expect(json['id'], equals('test-id'));
        expect(json['name'], equals('Test Shelf'));
        expect(json['bookIds'], equals(['book1', 'book2', 'book3']));
        expect(json['isDefault'], equals(false));
        expect(json['createdDate'], equals(testDate.toIso8601String()));
      });

      test('should deserialize from JSON correctly', () {
        // Arrange
        final json = {
          'id': 'test-id',
          'name': 'Test Shelf',
          'bookIds': ['book1', 'book2', 'book3'],
          'isDefault': false,
          'createdDate': testDate.toIso8601String(),
        };

        // Act
        final shelf = Shelf.fromJson(json);

        // Assert
        expect(shelf.id, equals('test-id'));
        expect(shelf.name, equals('Test Shelf'));
        expect(shelf.bookIds, equals(['book1', 'book2', 'book3']));
        expect(shelf.isDefault, equals(false));
        expect(shelf.createdDate, equals(testDate));
      });

      test('should round-trip through JSON serialization', () {
        // Act
        final json = testShelf.toJson();
        final deserializedShelf = Shelf.fromJson(json);

        // Assert
        expect(deserializedShelf, equals(testShelf));
      });

      test('should handle default isDefault value in JSON', () {
        // Arrange
        final json = {
          'id': 'test-id',
          'name': 'Test Shelf',
          'bookIds': ['book1'],
          'createdDate': testDate.toIso8601String(),
        };

        // Act
        final shelf = Shelf.fromJson(json);

        // Assert
        expect(shelf.isDefault, equals(false));
      });
    });

    group('Equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        final shelf1 = testShelf;
        final shelf2 = Shelf(
          id: 'test-id',
          name: 'Test Shelf',
          bookIds: const ['book1', 'book2', 'book3'],
          isDefault: false,
          createdDate: testDate,
        );

        // Assert
        expect(shelf1, equals(shelf2));
      });

      test('should not be equal when ids differ', () {
        // Arrange
        final shelf1 = testShelf;
        final shelf2 = testShelf.copyWith(id: 'different-id');

        // Assert
        expect(shelf1, isNot(equals(shelf2)));
      });

      test('should not be equal when names differ', () {
        // Arrange
        final shelf1 = testShelf;
        final shelf2 = testShelf.copyWith(name: 'Different Name');

        // Assert
        expect(shelf1, isNot(equals(shelf2)));
      });

      test('should not be equal when bookIds differ', () {
        // Arrange
        final shelf1 = testShelf;
        final shelf2 = testShelf.copyWith(bookIds: ['book1', 'book2']);

        // Assert
        expect(shelf1, isNot(equals(shelf2)));
      });
    });

    group('Constants', () {
      test('allShelfId should be "all"', () {
        expect(Shelf.allShelfId, equals('all'));
      });

      test('unsortedShelfId should be "unsorted"', () {
        expect(Shelf.unsortedShelfId, equals('unsorted'));
      });
    });
  });
}
