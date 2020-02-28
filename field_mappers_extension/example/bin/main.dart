import 'package:example/model.dart';

void main() {
  var some = SomeValueClass("some", 0);
  var other = some.mapIntVal((old) => old + 1).mapStrVal((old) => old + " other");
  print('${other.strVal} ${other.intVal}');
}
