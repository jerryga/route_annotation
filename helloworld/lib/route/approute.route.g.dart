// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// SciRouteGenerator
// **************************************************************************

import 'package:code_gen/sci_route.dart';

import 'package:helloworld/guard/guard.dart';
import 'package:helloworld/page/PageA.dart';
import 'package:helloworld/page/PageB.dart';
import 'package:helloworld/page/PageC.dart';
import 'package:helloworld/page/LoginPage.dart';
import 'package:helloworld/page/NotFoundPage.dart';

class SciRouterInternalImpl extends SciRouterInternal {
  SciRouterInternalImpl();
  final Map<String, dynamic> routeMap = {
    '/PageA': {"className": PageA, "rawURL": '/PageA'},
    '/PageB': {
      "className": PageB,
      "rawURL": '/PageB',
      "guard_name": 'checkLogin'
    },
    '/PageC': {"className": PageC, "rawURL": '/PageC'},
    '/loginPage': {"className": LoginPage, "rawURL": '/loginPage'}
  };
  final Map<String, dynamic> redirectedRouteMap = {
    '/notFoundPage': {
      "className": NotFoundPage,
      "rawURL": '/notFoundPage?title=404'
    }
  };
  final Map<String, dynamic> guardsMap = {'checkLogin': checkLogin};
  @override
  SciRouteResult router(String url) {
    try {
      SciRouteResult result =
          SciRouteResult(state: SciRouterResultState.UNKNOWN);
      final uri = Uri.parse(url);
      var params = uri.queryParameters;
      String path = uri.path;
      var innerMap = routeMap[path];
      Type? pageClass;
      dynamic classInstance;

      if (innerMap != null && innerMap is Map) {
        pageClass = innerMap["className"];
      }
      if (pageClass == null) {
        Map<String, dynamic>? redirectInfo;

        if (params is Map) {
          String? redirectedPageName = params["redirectedPage"];
          if (redirectedPageName == null) {
            redirectInfo = redirectedRouteMap.values.toList().first;
          } else {
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
        } else {
          classInstance = createInstance(pageClass, params);
          result.state = SciRouterResultState.REDIRECTED;
        }
      } else {
        classInstance = createInstance(pageClass, params);
        final guardName = innerMap["guard_name"];
        if (guardName != null) {
          dynamic guardWidget = createGuards(guardName, classInstance);
          if (guardWidget != null) {
            return SciRouteResult(
                widget: guardWidget, state: SciRouterResultState.INTERCEPTED);
          } else {
            result.state = SciRouterResultState.FOUND;
          }
        } else {
          result.state = SciRouterResultState.FOUND;
        }
      }

      result.widget = classInstance;
      return result;
    } catch (e) {
      return SciRouteResult(state: SciRouterResultState.NOT_FOUND);
    }
  }

  dynamic createInstance(Type clazz, dynamic arg) {
    {
      switch (clazz) {
        case PageA:
          return PageA(arg);
        case PageB:
          return PageB(arg);
        case PageC:
          return PageC(arg);
        case LoginPage:
          return LoginPage(arg);
        case NotFoundPage:
          return NotFoundPage(arg);
        default:
          return null;
      }
    }
  }

  dynamic createGuards(String guardName, dynamic arg) {
    {
      switch (guardName) {
        case 'checkLogin':
          return checkLogin(arg);
        default:
          return null;
      }
    }
  }
}
