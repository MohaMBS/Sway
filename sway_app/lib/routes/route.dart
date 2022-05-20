            
// @CupertinoAutoRouter            
// @AdaptiveAutoRouter            
// @CustomAutoRouter            
import 'package:auto_route/auto_route.dart';
import 'package:sway_app/screens/dashboard.dart';
import 'package:sway_app/screens/login.dart';

@MaterialAutoRouter(            
  replaceInRouteName: 'Page,Route',            
  routes: <AutoRoute>[            
    AutoRoute(page: Login, initial: true),            
    AutoRoute(page: DashboardV),            
  ],            
)            
class $AppRouter {}    