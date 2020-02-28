import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:class_extensions/class_extensions.dart';
import 'package:field_mappers_extension_annotations/annotations.dart';
import 'package:source_gen/source_gen.dart';

class FieldMappersGenerator extends ClassExtensionGenerator<FieldMappers> {
  @override
  String generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    ClassElement clazz = element;
    final out = StringBuffer();
    clazz.fields.forEach((field) => out.writeln(_generateFieldMapper(clazz, field)));
    return out.toString();
  }

  String _generateFieldMapper(ClassElement clazz, FieldElement field) {
    final fieldMapperName = 'map${field.name[0].toUpperCase()}${field.name.substring(1)}';
    return '${clazz.name} ${fieldMapperName}(${field.type.name} Function(${field.type.name}) map) => ${clazz.name}${_generateCtor(clazz, field)};';
  }

  String _generateCtor(ClassElement clazz, FieldElement field) {
    final out = StringBuffer();
    out.write('(');
    out.write(clazz.unnamedConstructor.parameters.map((param) => _generateCtorArg(clazz, field, param)).join(', '));
    out.write(')');
    return out.toString();
  }

  String _generateCtorArg(ClassElement clazz, FieldElement field, ParameterElement param) {
    return field.name == param.name ? 'map((this as ${clazz.name}).${param.name})' : '(this as ${clazz.name}).${param.name}';
  }
}
