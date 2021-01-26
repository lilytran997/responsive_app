import 'package:demo_desktop/common/constant.dart';
import 'package:demo_desktop/home_tabbar/src/bloc/home_tabbar_bloc.dart';
import 'package:demo_desktop/home_tabbar/tab_main/home_tab/src/ui/home_tab_widget.dart';
import 'package:demo_desktop/home_tabbar/tab_main/report_tab/src/ui/report_tab_widget.dart';
import 'package:demo_desktop/utilities/tab_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class HomeTabbarPage extends StatefulWidget {
  @override
  _HomeTabbarPageState createState() => _HomeTabbarPageState();
}

class _HomeTabbarPageState extends State<HomeTabbarPage> {
  List<TabWidget> _tabs;
  HomeTabbarBloc _bloc;
  CupertinoTabController _controller = CupertinoTabController(initialIndex: 0);

  @override
  void initState() {
    super.initState();
    _tabs = List<TabWidget>();
    _bloc = HomeTabbarBloc(context);
    _tabs
      ..add(TabWidget(
          ImageIcon(AssetImage(icTabbarHome)),
          HomeTabPage(_bloc,onTapCallBack: onTapCallBack,
          ),
          stringTabbarHome,(){}))
      ..add(TabWidget(
          ImageIcon(AssetImage(icTabbarCart)),
          Container(),
          stringTabbarCart,(){}))
      ..add(TabWidget(ImageIcon(AssetImage(icTabbarQueueIn)),MyHomePage(),
          stringTabbarQueueIn,(){}))
      ..add(TabWidget(ImageIcon(AssetImage(icTabbarNotification)),Container(),
          stringTabbarNotification,(){}))
      ..add(TabWidget(
          ImageIcon(AssetImage(icTabbarUser)), Container(), stringTabbarUser,(){}));
    _controller.addListener(() {
      String name ="";
      if(_tabs[_controller.index].child.runtimeType.toString().contains("Screen")){
        name =
            _tabs[_controller.index].child.runtimeType.toString().replaceAll('Screen', ' ') + "Screen";
      }else if( _tabs[_controller.index].child.runtimeType.toString().contains("Page")){
        name =
            _tabs[_controller.index].child.runtimeType.toString().replaceAll('Page', ' ') + "Screen";
      }else{
        name = _tabs[_controller.index].child.runtimeType.toString()+ "Screen";
      }
      print(name);
    });
  }

  onTapCallBack(int index) {
    if (index != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.index =  index;
      });
    }
  }

  @override
  void dispose() {
    _bloc.dispose();
    _controller.removeListener(() { });
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
              .map((e) =>
                  BottomNavigationBarItem(icon: e.icon, label: e.title))
              .toList(),
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
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
      onWillPop: (){
        if(_controller.index==0){
          return;
        }else{
          _controller.index=0;
          return;
        }
      },
      child: Scaffold(
        backgroundColor: royalBlue01Color,
        body: _setupLayout(),
      ),
    );
  }
}
