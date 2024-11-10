part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const WELCOME = _Paths.WELCOME;
  static const REGISTER = _Paths.REGISTER;
  static const LOGIN = _Paths.LOGIN;
  static const HOME = _Paths.HOME;
  static const PROFILE = _Paths.PROFILE;
  static const SEARCH = _Paths.SEARCH;
  static const RESULT = _Paths.RESULT;
  static const DETAILS = _Paths.DETAILS;
  static const FILTER = _Paths.FILTER;
  static const DASHBOARD = _Paths.DASHBOARD;
  static const DETAILPAYMENT = _Paths.DETAILPAYMENT;
  static const WEBVIEW = _Paths.WEBVIEW;
}

abstract class _Paths {
  _Paths._();

  static const WELCOME = '/welcome';
  static const REGISTER = '/register';
  static const LOGIN = '/login';
  static const HOME = '/home';
  static const PROFILE = '/profile';
  static const SEARCH = '/search';
  static const RESULT = '/result';
  static const DETAILS = '/details';
  static const FILTER = '/filter';
  static const DASHBOARD = '/dashboard';
  static const DETAILPAYMENT = '/detail-payment';
  static const WEBVIEW = '/webview';
}
