// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class AddPostsTable extends DataClass implements Insertable<AddPostsTable> {
  final String firstName;
  final String lastName;
  AddPostsTable({@required this.firstName, @required this.lastName});
  factory AddPostsTable.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return AddPostsTable(
      firstName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name']),
      lastName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name']),
    );
  }
  factory AddPostsTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return AddPostsTable(
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
    };
  }

  @override
  AddPostsCompanion createCompanion(bool nullToAbsent) {
    return AddPostsCompanion(
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
    );
  }

  AddPostsTable copyWith({String firstName, String lastName}) => AddPostsTable(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );
  @override
  String toString() {
    return (StringBuffer('AddPostsTable(')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(firstName.hashCode, lastName.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is AddPostsTable &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName);
}

class AddPostsCompanion extends UpdateCompanion<AddPostsTable> {
  final Value<String> firstName;
  final Value<String> lastName;
  const AddPostsCompanion({
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
  });
  AddPostsCompanion.insert({
    @required String firstName,
    @required String lastName,
  })  : firstName = Value(firstName),
        lastName = Value(lastName);
  AddPostsCompanion copyWith(
      {Value<String> firstName, Value<String> lastName}) {
    return AddPostsCompanion(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}

class $AddPostsTable extends AddPosts
    with TableInfo<$AddPostsTable, AddPostsTable> {
  final GeneratedDatabase _db;
  final String _alias;
  $AddPostsTable(this._db, [this._alias]);
  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  GeneratedTextColumn _firstName;
  @override
  GeneratedTextColumn get firstName => _firstName ??= _constructFirstName();
  GeneratedTextColumn _constructFirstName() {
    return GeneratedTextColumn(
      'first_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  GeneratedTextColumn _lastName;
  @override
  GeneratedTextColumn get lastName => _lastName ??= _constructLastName();
  GeneratedTextColumn _constructLastName() {
    return GeneratedTextColumn(
      'last_name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [firstName, lastName];
  @override
  $AddPostsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'add_posts';
  @override
  final String actualTableName = 'add_posts';
  @override
  VerificationContext validateIntegrity(AddPostsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.firstName.present) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableValue(d.firstName.value, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (d.lastName.present) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableValue(d.lastName.value, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  AddPostsTable map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return AddPostsTable.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(AddPostsCompanion d) {
    final map = <String, Variable>{};
    if (d.firstName.present) {
      map['first_name'] = Variable<String, StringType>(d.firstName.value);
    }
    if (d.lastName.present) {
      map['last_name'] = Variable<String, StringType>(d.lastName.value);
    }
    return map;
  }

  @override
  $AddPostsTable createAlias(String alias) {
    return $AddPostsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $AddPostsTable _addPosts;
  $AddPostsTable get addPosts => _addPosts ??= $AddPostsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [addPosts];
}
