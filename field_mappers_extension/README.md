Description
---
Uses class_extensions to generate field mappers.
Field mappers are a convenient way of constructing copies of immutable objects with altered values.

See also [to_string_extension](https://pub.dev/packages/to_string_extension), [json_extension](https://pub.dev/packages/json_extension), [withers_extension](https://pub.dev/packages/withers_extension)

Tutorial
---
1. We need a class to generate field mappers for. You usually want to generate field mappers for immutable classes.

    ##### `${PROJECT_ROOT}/lib/model.dart`
    ```dart
    import 'package:meta/meta.dart';
    
    @immutable
    class SomeValueClass {
      final String strVal;
      final int intVal;
    }
    ```

2. For field mappers to work you need to add some boiler plate:
    * `part 'model.g.dart';`
    * annotation `@FieldMappers()`
    * mixin `_$SomeValueClass`
    * all args constructor `SomeValueClass(this.strVal, this.intVal);`

    ##### `${PROJECT_ROOT}/lib/model.dart`
    ```dart
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
    ```

3. Configure code generation. More info at [build](https://github.com/dart-lang/build).

    ##### `${PROJECT_ROOT}/build.yaml`
    ```yaml
    targets:
      $default:
        builders:
          class_extensions:
            generate_for:
            - lib/*.dart
    ```
4. Add dependencies.

    ##### `${PROJECT_ROOT}/pubspec.yaml`
    ```yaml
    name: example
    
    dependencies:
      field_mappers_extension_annotations: ^0.1.0
    
    dev_dependencies:
      build_runner: ^1.0.0
      field_mappers_extension: 8.0.0
    ```

5. Run code generation: `pub run build_runner build`. File `${PROJECT_ROOT}/lib/model.g.dart` should be created.

6. If everything goes well you should be able to use field mappers.

    ##### `${PROJECT_ROOT}/bin/main.dart`
    ```dart
    import 'package:example/model.dart';
    
    void main() {
      var some = SomeValueClass("some", 0);
      var other = some.mapIntVal((old) => old + 1).mapStrVal((old) => old + " other");
      print('${other.strVal} ${other.intVal}');
    }
    ```

7. You can also see the [example](https://github.com/svarzee/field_mappers_extension/tree/master/field_mappers_extension/example).
