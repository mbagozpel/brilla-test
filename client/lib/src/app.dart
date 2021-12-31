import 'package:client/_screens/Onboarding/onboarding.dart';
import 'package:client/_screens/bottom_nav/bottom_nav.dart';
import 'package:client/_screens/interests/interests.dart';
import 'package:client/_screens/login/forgot_password.dart';
import 'package:client/_screens/login/login.dart';
import 'package:client/_screens/phone_verification/phone_verification.dart';
import 'package:client/_screens/settings/change_password.dart';
import 'package:client/_screens/settings/profile_settings.dart';
import 'package:client/_screens/signup/signup.dart';
import 'package:client/_utilities/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Providing a restorationScopeId allows the Navigator built by the
      // MaterialApp to restore the navigation stack when a user leaves and
      // returns to the app after it has been killed while running in the
      // background.
      restorationScopeId: 'app',

      // Provide the generated AppLocalizations to the MaterialApp. This
      // allows descendant Widgets to display the correct translations
      // depending on the user's locale.
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],

      // Use AppLocalizations to configure the correct application title
      // depending on the user's locale.
      //
      // The appTitle is defined in .arb files found in the localization
      // directory.
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,

      // Define a light and dark color theme. Then, read the user's
      // preferred ThemeMode (light, dark, or system default) from the
      // SettingsController to display the correct theme.
      theme: theme(context),
      darkTheme: ThemeData.dark(),

      // Define a function to handle named routes in order to support
      // Flutter web url navigation and deep linking.
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case SignUpScreen.routeName:
                return const SignUpScreen();
              case LoginScreen.routeName:
                return const LoginScreen();
              case InterestScreen.routeName:
                return InterestScreen();
              case VerificationScreen.routeName:
                return VerificationScreen();
              case ResetPassword.routeName:
                return ResetPassword();
              case ChangePassword.routeName:
                return const ChangePassword();
              case BottomNav.routeName:
                return const BottomNav();
              case ProfileSettings.routeName:
                return const ProfileSettings();
              case OnboardingScreen.routeName:
              default:
                return const OnboardingScreen();
            }
          },
        );
      },
    );
  }
}
