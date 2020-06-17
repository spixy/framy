import 'package:framy_annotation/framy_annotation.dart';
import 'package:framy_generator/widget_resolver.dart';
import 'package:source_gen_test/source_gen_test.dart';

import 'dummy_classes.dart';

Future<void> main() async {
  final reader = await initializeLibraryReaderForDirectory(
    'test/resolvers',
    'widget_resolver_test.dart',
  );

  initializeBuildLogTracking();
  testAnnotatedElements<FramyWidget>(
    reader,
    WidgetResolver(),
    useDartFormatter: false,
  );
}

@ShouldGenerate('''
[
  {
    "type": "FramyObjectType.widget",
    "import": "package:__test__/widget_resolver_test.dart",
    "name": "CounterFloatingActionButton",
    "isStatic": false,
    "kind": "CLASS",
    "parentObject": null,
    "widgetDependencies": []
  }
]''')
@FramyWidget()
class CounterFloatingActionButton {}

@ShouldGenerate('''
[
  {
    "type": "FramyObjectType.widget",
    "import": "package:__test__/widget_resolver_test.dart",
    "name": "WidgetWithConstructor",
    "isStatic": false,
    "kind": "CLASS",
    "parentObject": null,
    "widgetDependencies": [
      {
        "name": "arg1",
        "type": "FramyWidgetDependencyType.string",
        "defaultValue": null,
        "isNamed": false
      }
    ]
  }
]''')
@FramyWidget()
class WidgetWithConstructor {
  WidgetWithConstructor(String arg1) {}
}

@ShouldGenerate('''
[
  {
    "type": "FramyObjectType.widget",
    "import": "package:__test__/widget_resolver_test.dart",
    "name": "WidgetWithConstructorAndKey",
    "isStatic": false,
    "kind": "CLASS",
    "parentObject": null,
    "widgetDependencies": [
      {
        "name": "arg1",
        "type": "FramyWidgetDependencyType.string",
        "defaultValue": null,
        "isNamed": true
      }
    ]
  }
]''')
@FramyWidget()
class WidgetWithConstructorAndKey {
  WidgetWithConstructorAndKey({Key key, String arg1}) {}
}

@ShouldGenerate('''
[
  {
    "type": "FramyObjectType.widget",
    "import": "package:__test__/widget_resolver_test.dart",
    "name": "WidgetWithConstructorWithDefaultParamValue",
    "isStatic": false,
    "kind": "CLASS",
    "parentObject": null,
    "widgetDependencies": [
      {
        "name": "arg1",
        "type": "FramyWidgetDependencyType.string",
        "defaultValue": "'test1'",
        "isNamed": true
      }
    ]
  }
]''')
@FramyWidget()
class WidgetWithConstructorWithDefaultParamValue {
  WidgetWithConstructorWithDefaultParamValue({String arg1 = 'test1'}) {}
}
