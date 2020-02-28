import 'package:build/build.dart';
import 'package:class_extensions/class_extensions.dart';

import 'src/field_mappers_generator.dart';

Builder fieldMappersDummyBuilder(BuilderOptions options) => registerClassExtensionGenerator(4, FieldMappersGenerator());
