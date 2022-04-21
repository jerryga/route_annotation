/*节点*/
class SciRoot {
  const SciRoot();
}

class SciRoute {
  final String? url;
  final String? guard_name;
  const SciRoute({this.url, this.guard_name});
}

class SciRedirectedRoute {
  final String? url;
  const SciRedirectedRoute({this.url});
}

class SciFunction {
  const SciFunction();
}

enum SciRouterResultState {
  UNKNOWN,
  FOUND,
  NOT_FOUND,
  REDIRECTED,
  INTERCEPTED,
}

class SciRouteResult {
  dynamic? widget;
  SciRouterResultState? state;
  SciRouteResult({this.widget, this.state});
}

abstract class SciRouterInternal {
  SciRouteResult router(String url);
}

const Object sciRoot = const SciRoot();

