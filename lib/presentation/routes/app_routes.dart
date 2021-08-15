import 'package:auto_route/annotations.dart';
import 'package:collaction_app/presentation/authentication/auth_screen.dart';

import '../contact_form/contact_form_screen.dart';
import '../crowd_action/crowd_action_browse.dart';
import '../home/home_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage),
    AutoRoute(page: CrowdActionBrowsePage),
    AutoRoute(page: ContactFormPage),
    AutoRoute(page: AuthPage, initial: true),
  ],
)
class $AppRouter {}
