import 'package:code_gen/sci_route.dart';
import 'approute.route.g.dart';

@sciRoot
class AppRoute {

  SciRouterInternalImpl internalImpl = SciRouterInternalImpl();
  dynamic getPage(String url) {
    SciRouteResult result = internalImpl.router(url);
    if(result.state == SciRouterResultState.NOT_FOUND) {
      print("Router error: page not found");
      return null;
    }
    return result.widget;
  }
}