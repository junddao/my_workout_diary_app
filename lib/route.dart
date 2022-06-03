import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_workout_diary_app/page_tabs.dart';
import 'package:my_workout_diary_app/pages/01_login/page_login.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic arguments = settings.arguments;

    switch (settings.name) {
      case 'PageTabs':
        return CupertinoPageRoute(
          builder: (_) => PageTabs(),
          settings: settings,
        );

      case 'PageLogin':
        return CupertinoPageRoute(
          builder: (_) => PageLogin(),
          settings: settings,
        );

      // case 'PageSplash':
      //   return CupertinoPageRoute(
      //     builder: (_) => PageSplash(),
      //     settings: settings,
      //   );

      // case 'PageAgreement':
      //   return CupertinoPageRoute(
      //     builder: (_) => PageAgreement(),
      //     settings: settings,
      //   );

      // case 'PageMap':
      //   return CupertinoPageRoute(
      //     builder: (_) => PageMap(
      //       pinId: arguments,
      //     ),
      //     settings: settings,
      //   );
      // case 'PageSetLocation':
      //   return CupertinoPageRoute(
      //     builder: (_) => PageSetLocation(),
      //     settings: settings,
      //   );

      // case 'PagePost':
      //   return CupertinoPageRoute(
      //     builder: (_) => PagePost(),
      //     settings: settings,
      //   );

      // case 'PageMyPost':
      //   return CupertinoPageRoute(
      //     builder: (_) => PageMyPost(),
      //     settings: settings,
      //   );
      // case 'PageUserPost':
      //   return CupertinoPageRoute(
      //     builder: (_) => PageUserPost(),
      //     settings: settings,
      //   );

      // case 'PagePopularPost':
      //   return CupertinoPageRoute(
      //     builder: (_) => PagePopularPost(),
      //     settings: settings,
      //   );

      // case 'PagePostCreate':
      //   return CupertinoPageRoute(
      //     builder: (_) => PagePostCreate(),
      //     settings: settings,
      //   );

      // case 'PageSelectLocation':
      //   return CupertinoPageRoute(
      //     builder: (_) => PageSelectLocation(),
      //     settings: settings,
      //   );

      // case 'PagePostDetail':
      //   return CupertinoPageRoute(
      //     builder: (_) => PagePostDetail(),
      //     settings: settings,
      //   );

      // case 'PagePostCommunity':
      //   return CupertinoPageRoute(
      //     builder: (_) => PagePostCommunity(),
      //     settings: settings,
      //   );

      // case 'PageOtherUser':
      //   return CupertinoPageRoute(
      //     builder: (_) => PageOtherUser(
      //       userId: arguments,
      //     ),
      //     settings: settings,
      //   );

      // case 'PageUserSetting':
      //   return CupertinoPageRoute(
      //     builder: (_) => PageUserSetting(),
      //     settings: settings,
      //   );

      // case 'DSPhotoViewer':
      //   return CupertinoPageRoute(
      //     builder: (_) => DSPhotoViewer(
      //       filePath: arguments,
      //     ),
      //     settings: settings,
      //   );

      // case 'PageIntroSlider':
      //   return CupertinoPageRoute(
      //     builder: (_) => PageIntroSlider(),
      //     settings: settings,
      //   );

      // case 'PageBlock':
      //   return CupertinoPageRoute(
      //     builder: (_) => PageBlock(),
      //     settings: settings,
      //   );

      // case 'PageConfirm':
      //   return CupertinoPageRoute(
      //     builder: (_) => PageConfirm(
      //       title: arguments[0],
      //       contents1: arguments[1],
      //       contents2: arguments[2],
      //     ),
      //     settings: settings,
      //   );

      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('${settings.name} 는 lib/route.dart에 정의 되지 않았습니다.'),
            ),
          ),
        );
    }
  }

  static loadMain(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('PageTabs', (route) => false);
    // if (Singleton.shared.userData!.user!.agreeTerms == true) {
    //   Navigator.of(context)
    //       .pushNamedAndRemoveUntil('PageTabs', (route) => false);
    // } else {
    //   Navigator.of(context).pushNamedAndRemoveUntil(
    //     'PageAgreement',
    //     (route) => false,
    //     arguments: true,
    //   );
    // }
  }
}
