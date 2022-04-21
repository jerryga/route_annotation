
import 'package:code_gen/route_parser.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart' as e;
import 'package:build/build.dart';
import 'package:code_gen/sci_integration.dart';

import 'sci_route.dart';

RouteParser routeParser = RouteParser();
//解析
class RouteParseGenerator extends GeneratorForAnnotation<SciRoute> {
  @override
  generateForAnnotatedElement(e.Element element, ConstantReader annotation, BuildStep buildStep) {
    routeParser.parseRoute(element, annotation, buildStep);
    return null;
  }
}

class SciRedirectedRouteGenerator extends GeneratorForAnnotation<SciRedirectedRoute>  {
  @override
  generateForAnnotatedElement(e.Element element, ConstantReader annotation, BuildStep buildStep) {
    routeParser.parseRedirect(element, annotation, buildStep);
    return null;
  }
}

class SciFunctionGenerator extends GeneratorForAnnotation<SciFunction>  {
  @override
  generateForAnnotatedElement(e.Element element, ConstantReader annotation, BuildStep buildStep) {
    routeParser.parseFunction(element, annotation, buildStep);
    return null;
  }
}
//合成统一route
class SciRouteGenerator extends GeneratorForAnnotation<SciRoot> {
  @override
  generateForAnnotatedElement(e.Element element, ConstantReader annotation, BuildStep buildStep) {
    return SciIntegration(routeParser).startIntegrating();
  }
}
