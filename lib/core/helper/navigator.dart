import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>();

  static get context => navigationKey.currentState?.context;

  static removeAllFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static removeOverlays() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }

  static Future<dynamic> push(
      {bool isNamed = true,
      required dynamic page,
      dynamic arguments,
      bool preventDuplicates = true,
      bool closeOverlays = false}) async {
    removeAllFocus();
    if (closeOverlays) {
      removeOverlays();
    }
    if (isNamed) {
      if (preventDuplicates) {
        final _isDuplicate = checkDuplicateRoute(page, arguments);

        if (_isDuplicate) {
          return;
        }
      }
      return await Navigator.pushNamed(context, page, arguments: arguments);
    } else {
      return await Navigator.push(
          context, MaterialPageRoute(builder: (context) => page));
    }
  }

  static Future<dynamic> pushReplacement({
    bool isNamed = true,
    required dynamic page,
    dynamic arguments,
    bool preventDuplicates = true,
    bool closeOverlays = false,
  }) async {
    removeAllFocus();
    if (closeOverlays) {
      removeOverlays();
    }
    if (isNamed) {
      if (preventDuplicates) {
        final _isDuplicate = checkDuplicateRoute(page, arguments);
        if (_isDuplicate) return;
      }
      return await Navigator.pushReplacementNamed(
        context,
        page,
        arguments: arguments,
      );
    } else {
      return await Navigator.pushReplacement(context, page);
    }
  }

  static Future<dynamic> goBack<T>({
    T? result,
    bool maybePop = true,
    bool closeOverlays = false,
  }) async {
    removeAllFocus();
    if (closeOverlays) {
      removeOverlays();
    }
    if (maybePop) {
      return await Navigator.maybePop(context, result);
    } else {
      Navigator.pop(context, result);
    }
  }

  static popUntil({
    required RoutePredicate predicate,
    bool closeOverlays = false,
  }) {
    removeAllFocus();
    if (closeOverlays) {
      removeOverlays();
    }
    Navigator.popUntil(context, predicate);
  }

  static Future<T?>? pushReplacementAll<T>({
    bool isNamed = true,
    required dynamic page,
    dynamic arguments,
    bool closeOverlays = false,
  }) async {
    removeAllFocus();
    if (closeOverlays) {
      removeOverlays();
    }
    if (isNamed) {
      return await Navigator.pushNamedAndRemoveUntil(
        context,
        page,
        (route) => false,
        arguments: arguments,
      );
    } else {
      return await Navigator.pushAndRemoveUntil(
        context,
        page,
        (route) => false,
      );
    }
  }

  static Future<T?>? pushAndRemoveUntil<T>({
    bool isNamed = true,
    required dynamic page,
    required bool Function(Route<dynamic>) predicate,
    dynamic arguments,
    bool closeOverlays = false,
  }) async {
    removeAllFocus();
    if (closeOverlays) {
      removeOverlays();
    }
    if (isNamed) {
      return await Navigator.pushNamedAndRemoveUntil(
        context,
        page,
        predicate,
        arguments: arguments,
      );
    } else {
      return await Navigator.pushAndRemoveUntil(
        context,
        page,
        predicate,
      );
    }
  }

  static bool checkDuplicateRoute(String page, dynamic arguments) {
    bool _isNewRouteSameAsCurrent = false;

    bool isEqualMaps = false;

    popUntil(
      predicate: (route) {
        try {
          isEqualMaps = mapEquals(
              route.settings.arguments as Map<String, dynamic>?,
              arguments as Map<String, dynamic>?);
        } catch (error) {
          log('notMap in checkDuplicateRouteMethod $error');
        }
        if ((route.settings.name == page &&
                route.settings.arguments == arguments) &&
            isEqualMaps) {
          log('newRouteSame $_isNewRouteSameAsCurrent');
          _isNewRouteSameAsCurrent = true;
        }
        return true;
      },
    );
    return _isNewRouteSameAsCurrent;
  }
}
