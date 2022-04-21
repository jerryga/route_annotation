import 'package:code_gen/route_parser.dart';
/*组装*/
class SciIntegration {
  final RouteParser routeParser;
  SciIntegration(this.routeParser);

  String createInstance() {
    final StringBuffer buffer =StringBuffer();
    buffer.writeln('switch (clazz) {');
    final allRoutes = {...routeParser.routeMap, ...routeParser.redirectedMap};
    allRoutes.forEach((String path, dynamic type) {
    dynamic cls = type['"'"className"'"'];
    buffer.writeln('case $cls: return $cls(arg);');
    });
    buffer..writeln('default:return null;')..writeln('}');
    return buffer.toString();
  }

  List<Map<String, String>> createImports() {
    final List<Map<String, String>> imports = <Map<String, String>>[];
    routeParser.importList.forEach((element) => imports.add(<String, String>{'path': element}));
    return imports;
  }

  String createGuards() {
    final StringBuffer buffer =StringBuffer();
    buffer.writeln('switch (guardName) {');
    routeParser.guards.forEach((String path, dynamic type) {
      buffer.writeln('case '"'$type'"': return $type(arg);');
    });
    buffer..writeln('default:return null;')..writeln('}');
    return buffer.toString();
  }

  String startIntegrating() {
    var mapListStr = routeParser.routeMap.toString();
    var instance = createInstance();
    var guardsInstance = createGuards();
    var importsStr = '\n';
    var redirectedmapListStr = routeParser.redirectedMap.toString();
    var guardMapStr = routeParser.guards.toString();

    routeParser.importList.forEach((element) => importsStr += ('\n' + element + ';'));

    return """
import 'package:code_gen/sci_route.dart';
$importsStr

class SciRouterInternalImpl extends SciRouterInternal {
  SciRouterInternalImpl();
  final Map<String, dynamic> routeMap = $mapListStr;
   final Map<String, dynamic> redirectedRouteMap = $redirectedmapListStr;
   final Map<String, dynamic> guardsMap = $guardMapStr;
  @override
  SciRouteResult router(String url) {
    try {
      SciRouteResult result = SciRouteResult(state: SciRouterResultState.UNKNOWN);
      final uri = Uri.parse(url);
      var params = uri.queryParameters;
      String path = uri.path;
      var innerMap = routeMap[path];
      Type? pageClass;
      dynamic classInstance;

      if (innerMap != null && innerMap is Map) {
          pageClass = innerMap["className"];
      }
      if(pageClass == null) {
      Map<String, dynamic>? redirectInfo;
    
      if (params is Map) {
        String? redirectedPageName = params["redirectedPage"];
        if (redirectedPageName == null) {
            redirectInfo = redirectedRouteMap.values.toList().first;
          }else {
             redirectInfo = redirectedRouteMap[redirectedPageName];
          }
      }
        if (redirectInfo != null) {
        pageClass = redirectInfo["className"];
        final uri = Uri.parse(redirectInfo["rawURL"]);
        params = uri.queryParameters;
        }
        
         if (pageClass == null) {
          result.state = SciRouterResultState.NOT_FOUND;
        }else {
          classInstance = createInstance(pageClass, params);
          result.state = SciRouterResultState.REDIRECTED;
        }
      }else {
        classInstance = createInstance(pageClass, params);
        final guardName = innerMap["guard_name"];
        if (guardName != null) {
            dynamic guardWidget = createGuards(guardName, classInstance);
            if (guardWidget != null) {
            return SciRouteResult(widget:guardWidget , state: SciRouterResultState.INTERCEPTED);
            }else {
                 result.state = SciRouterResultState.FOUND;
            }
          
        }else {
          result.state = SciRouterResultState.FOUND;
        }
      }
    
      result.widget = classInstance;
      return result;
     }
    catch(e) {
      return SciRouteResult(state: SciRouterResultState.NOT_FOUND);
    }
  }

  dynamic createInstance(Type clazz, dynamic arg) {
    {$instance}
  }
  
  dynamic createGuards(String guardName, dynamic arg) {
    {$guardsInstance}
  }
}
""";
  }
}