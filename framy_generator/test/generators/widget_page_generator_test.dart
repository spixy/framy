import 'package:framy_generator/framy_object.dart';
import 'package:framy_generator/generator/widget_page_generator.dart';
import 'package:test/test.dart';

void main() {
  group('Widget page generator result', () {
    test('should not generate anything when no widgets passed', () {
      final result = generateWidgetPages([]);
      expect(result, isEmpty);
    });

    group('when a widget is passed', () {
      //given
      final widgetObjects = [
        FramyObject()
          ..name = 'MyWidget'
          ..type = FramyObjectType.widget
          ..widgetDependencies = []
      ];

      test('should have a class with name FramyXXXCustomPage', () {
        //when
        final result = generateWidgetPages(widgetObjects);
        //then
        expect(result.contains('class FramyMyWidgetCustomPage'), isTrue);
      });

      test('should contain key Framy_XXX_Page', () {
        //when
        final result = generateWidgetPages(widgetObjects);
        //then
        expect(result.contains('Framy_MyWidget_Page'), isTrue);
      });

      test('should contain custom widget XXX constructor', () {
        //when
        final result = generateWidgetPages(widgetObjects);
        //then
        expect(result.contains('MyWidget('), isTrue);
      });

      test('should contain LayoutBuilder', () {
        //when
        final result = generateWidgetPages(widgetObjects);
        //then
        expect(result.contains('LayoutBuilder('), isTrue);
      });

      test('should contain list with dependencies', () {
        //when
        final result = generateWidgetPages(widgetObjects);
        //then
        expect(
            result.contains('List<FramyDependencyModel> dependencies'), isTrue);
      });

      test('should contain FramyWidgetDependenciesPanel', () {
        //when
        final result = generateWidgetPages(widgetObjects);
        //then
        expect(result.contains('FramyWidgetDependenciesPanel('), isTrue);
      });

      test('should contain FramyWidgetDependenciesFAB', () {
        //when
        final result = generateWidgetPages(widgetObjects);
        //then
        expect(result.contains('FramyWidgetDependenciesFAB('), isTrue);
      });
    });

    test('should contain 2 classes with proper names when 2 widgets are passed',
        () {
      //given
      final widgetObjects = [
        FramyObject()
          ..name = 'Widget1'
          ..type = FramyObjectType.widget
          ..widgetDependencies = [],
        FramyObject()
          ..name = 'Widget2'
          ..type = FramyObjectType.widget
          ..widgetDependencies = [],
      ];
      //when
      final result = generateWidgetPages(widgetObjects);
      //then
      expect(result.contains('FramyWidget1CustomPage'), isTrue);
      expect(result.contains('FramyWidget2CustomPage'), isTrue);
    });

    test(
        'should contain initialized dependencies list when widget has dependency',
        () {
      //given
      final widgetObjects = getFramyObjectWithDependency(FramyWidgetDependency(
        'arg1',
        FramyWidgetDependencyType.string,
        null,
        false,
      ));
      //when
      final result = generateWidgetPages(widgetObjects);
      //then
      final expectedList = '''
  List<FramyDependencyModel> dependencies = [
    FramyDependencyModel<String>('arg1', FramyDependencyType.string, null),''';
      expect(result.contains(expectedList), isTrue);
    });

    test(
        'should use dependency in widget constructor when the non-named dependency is passed',
        () {
      //given
      final widgetObjects = getFramyObjectWithDependency(FramyWidgetDependency(
        'arg1',
        FramyWidgetDependencyType.string,
        null,
        false,
      ));
      //when
      final result = generateWidgetPages(widgetObjects);
      //then
      expect(
        result.contains(RegExp('Widget1\\(\n *dependency\\(\'arg1\'\\).value')),
        isTrue,
      );
    });

    test(
        'should use dependency in widget constructor when the named dependency is passed',
        () {
      //given
      final widgetObjects = getFramyObjectWithDependency(FramyWidgetDependency(
        'arg1',
        FramyWidgetDependencyType.string,
        null,
        true,
      ));
      //when
      final result = generateWidgetPages(widgetObjects);
      //then
      expect(
        result.contains(
            RegExp('Widget1\\(\n *arg1: dependency\\(\'arg1\'\\).value')),
        isTrue,
      );
    });

    test(
        'should use default value in dependency initialization when default value is present',
        () {
      //given
      final widgetObjects = getFramyObjectWithDependency(FramyWidgetDependency(
        'arg1',
        FramyWidgetDependencyType.string,
        "'fooDefaultValue'",
        false,
      ));
      //when
      final result = generateWidgetPages(widgetObjects);
      //then
      expect(
        result.contains(RegExp('FramyDependencyModel.*\'fooDefaultValue\'')),
        isTrue,
      );
    });
  });
}

List<FramyObject> getFramyObjectWithDependency(
    FramyWidgetDependency dependency) {
  return [
    FramyObject()
      ..name = 'Widget1'
      ..type = FramyObjectType.widget
      ..widgetDependencies = [dependency]
  ];
}
