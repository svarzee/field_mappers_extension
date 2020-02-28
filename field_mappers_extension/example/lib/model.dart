import 'package:meta/meta.dart';
import 'package:field_mappers_extension_annotations/annotations.dart';

part 'model.g.dart';

@FieldMappers()
@immutable
class SomeValueClass with _$SomeValueClass {
  final String strVal;
  final int intVal;

  SomeValueClass(this.strVal, this.intVal);
}

@FieldMappers()
@immutable
class SomeValueClass2 with _$SomeValueClass2 {
  final String strVal;
  final int intVal;

  SomeValueClass2(this.strVal, this.intVal);
}
