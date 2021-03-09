import 'package:demo_desktop/common/constant.dart';
import 'package:demo_desktop/home_tabbar/src/bloc/home_tabbar_bloc.dart';
import 'package:demo_desktop/home_tabbar/tab_main/home_tab/src/ui/home_tab_widget.dart';
import 'package:demo_desktop/home_tabbar/tab_main/profile_tab/src/ui/profile_tab_widget.dart';
import 'package:demo_desktop/home_tabbar/tab_main/report_tab/src/ui/report_tab_widget.dart';
import 'package:demo_desktop/utilities/responsive.dart';
import 'package:demo_desktop/utilities/tab_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
// import 'package:universal_html/prefer_universal/js.dart' as js;

import 'home_desktop_widget.dart';

class HomeTabbarPage extends StatefulWidget {
  @override
  _HomeTabbarPageState createState() => _HomeTabbarPageState();
}

class _HomeTabbarPageState extends State<HomeTabbarPage> {
  List<TabWidget> _tabs;
  HomeTabbarBloc _bloc;
  CupertinoTabController _controller = CupertinoTabController(initialIndex: 0);
  // final _messaging = FBMessaging.instance;
  @override
  void initState() {
    super.initState();
    _tabs = List<TabWidget>();
    _bloc = HomeTabbarBloc(context);
    _tabs
      ..add(TabWidget(
          ImageIcon(AssetImage(icTabbarHome)),
          HomeTabPage(
            _bloc,
            onTapCallBack: onTapCallBack,
          ),
          stringTabbarHome,
          () {},iconUrl: icTabbarHome,isSelected: true,id: 1))
      ..add(TabWidget(ImageIcon(AssetImage(icTabbarCart)), Container(),
          stringTabbarCart, () {},iconUrl: icTabbarCart,id: 2))
      ..add(TabWidget(ImageIcon(AssetImage(icTabbarQueueIn)), ReportPage(),
          stringTabbarQueueIn, () {},iconUrl: icTabbarQueueIn,id: 3))
      ..add(TabWidget(ImageIcon(AssetImage(icTabbarNotification)), Container(),
          stringTabbarNotification, () {},iconUrl: icTabbarNotification,id: 4))
      ..add(TabWidget(ImageIcon(AssetImage(icTabbarUser)), ProfilePage(),
          stringTabbarUser, () {},iconUrl: icTabbarUser,id: 5));
    _controller.addListener(() {
      String name = "";
      if (_tabs[_controller.index]
          .child
          .runtimeType
          .toString()
          .contains("Screen")) {
        name = _tabs[_controller.index]
                .child
                .runtimeType
                .toString()
                .replaceAll('Screen', '') +
            "Tab";
      } else if (_tabs[_controller.index]
          .child
          .runtimeType
          .toString()
          .contains("Page")) {
        name = _tabs[_controller.index]
                .child
                .runtimeType
                .toString()
                .replaceAll('Page', '') +
            "Tab";
      } else {
        name = _tabs[_controller.index].child.runtimeType.toString() + "Tab";
      }
      // _navigatorKey.currentState.pushNamed(_tabs[_controller.index].child.runtimeType.toString());
      print(name);
      html.window.history.pushState(null, "/HomePage", "/HomePage#$name");
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc.setListTab(_tabs);
      _bloc.initBloc();
    });
    // _messaging.requestPermission().then((_) async {
    //   final _token = await _messaging.getToken();
    //   print('Token: $_token');
    // });
  }

  onTapCallBack(int index) {
    if (index != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.index = index;
      });
    }
  }

  @override
  void dispose() {
    _bloc.dispose();
    _controller.removeListener(() {});
    super.dispose();
  }

  Widget _setupLayout() {
    return Container(
      child: CupertinoTabScaffold(
        controller: _controller,
        tabBar: CupertinoTabBar(
          backgroundColor: bigStone02Color,
          activeColor: primaryColor,
          items: _tabs
              .map((e) => BottomNavigationBarItem(icon: e.icon, label: e.title))
              .toList(),
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            routes: <String, WidgetBuilder>{
              _tabs[index].child.runtimeType.toString():
                  (BuildContext context) =>_tabs[index].child,
            },
            builder: (BuildContext context) {
              return _tabs[index].child;
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_controller.index == 0) {
          return;
        } else {
          _controller.index = 0;
          return;
        }
      },
      child: Scaffold(
        backgroundColor: royalBlue01Color,
        body: ResponsiveWidget(
          smallScreen: _setupLayout(),
          largeScreen: HomeTabDesktopPage(bloc: _bloc,),
          mediumScreen: HomeTabDesktopPage(bloc: _bloc,),
        ),
      ),
    );
  }
}
