import 'package:analyzer/dart/element/element.dart' as e;
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

const String CLASS_NAME = "className";

class Guard {
  dynamic returnType;
  String? name;
  List<dynamic>? parameters;

  Guard(this.returnType, this.name, this.parameters);
}

class RouteParser {
  Map<String, dynamic> routeMap = {};
  List<String> importList = [];
  String? notFoundPage;
  Map<String, dynamic> redirectedMap = {};
  Map<String, dynamic> guards = {};

  void parseRoute(e.Element element, ConstantReader annotation, BuildStep buildStep) {
    print("ElementKind : ${element.kind.name} \n");
    _constructMap(routeMap, element, annotation, buildStep);
  }

  void parseRedirect(e.Element element, ConstantReader annotation, BuildStep buildStep) {
    print("ElementKind : ${element.kind.name} \n");
    _constructMap(redirectedMap, element, annotation, buildStep);
  }

  void parseFunction(e.Element element, ConstantReader annotation, BuildStep buildStep) {
    print("ElementKind : ${element.kind.name} \n");
    _constructMethods(element as e.FunctionElement, annotation, buildStep);
  }

  void _constructMethods(e.FunctionElement methodElement, ConstantReader annotation, BuildStep buildStep) {
    String? guardName = methodElement.displayName;
    if (guardName == null) {
      return;
    }

    try {

      String pathKey = "'" + guardName + "'";

      if(guards[guardName] != null) {
        return;
      }

      guards[pathKey] = methodElement.displayName;
      if (buildStep.inputId.path.contains('lib/')) {
        print(buildStep.inputId.path);
        importList.add(
            "import 'package:${buildStep.inputId.package}/${buildStep.inputId.path.replaceFirst('lib/', '')}'");
      } else {
        importList.add("${buildStep.inputId.path}");
      }
    } catch (e) {
      print('parse route error $e');
    }
  }

  void _constructMap(Map<String, dynamic> map, e.Element element, ConstantReader annotation, BuildStep buildStep) {
    String? url = annotation.peek('url')?.stringValue;
    if (url == null) {
      return;
    }

    try {
      final uri = Uri.parse(url);
      String path = uri.path;
      String pathKey = "'" + path + "'";
      String? guard_name = annotation.peek('guard_name')?.stringValue;

      if(map[pathKey] != null) {
        print('parse route error: already exist for $url');
        return;
      }
      Map<String, dynamic> detailMap = {'"'"className"'"': element.displayName,
                                  '"'"rawURL"'"': "'" + url + "'",
                                };
      if (guard_name != null) {
        detailMap['"'"guard_name"'"' ] = "'" + guard_name + "'";
      }

      map[pathKey] = detailMap;
      if (buildStep.inputId.path.contains('lib/')) {
        print(buildStep.inputId.path);
        importList.add(
            "import 'package:${buildStep.inputId.package}/${buildStep.inputId.path.replaceFirst('lib/', '')}'");
      } else {
        importList.add("${buildStep.inputId.path}");
      }
    } catch (e) {
      print('parse route error $e');
    }
  }

}