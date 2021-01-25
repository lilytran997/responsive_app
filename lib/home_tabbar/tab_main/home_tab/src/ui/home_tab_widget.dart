import 'package:demo_desktop/common/constant.dart';
import 'package:demo_desktop/home_tabbar/src/bloc/home_tabbar_bloc.dart';
import 'package:demo_desktop/models/service_category_request_model.dart';
import 'package:demo_desktop/utilities/custom_line.dart';
import 'package:demo_desktop/utilities/custom_scaffold.dart';
import 'package:demo_desktop/utilities/globals.dart';
import 'package:demo_desktop/utilities/network_image.dart';
import 'package:demo_desktop/utilities/responsive.dart';
import 'package:demo_desktop/utilities/row_title_widget.dart';
import 'package:demo_desktop/utilities/tab_model.dart';
import 'package:flutter/material.dart';

class HomeTabPage extends StatefulWidget {
  final HomeTabbarBloc bloc;
  final Function(int index) onTapCallBack;
  const HomeTabPage(this.bloc, {Key key, this.onTapCallBack}) : super(key: key);
  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  List<TabWidget> _activityIcon; //_titleHome
  ScrollController _controller = ScrollController();
  double _index = 0;
  double _middleIndex = 0.0;
  @override
  void initState() {
    super.initState();
    _activityIcon = List<TabWidget>();
    _controller.addListener(() {
      if (_controller != null && _controller.hasClients) {
        _index = _controller.offset;
        _middleIndex = (_controller.position.maxScrollExtent +
                _controller.position.minScrollExtent) /
            2;
        if (_index <= _middleIndex) {
          widget.bloc.setIndex(0);
        } else {
          widget.bloc.setIndex(1);
        }
      }
    });
    _activityIcon
      ..add(TabWidget(Image.asset(icMainReport), Container(), stringReport, () {
        widget.onTapCallBack(2);
      }))
      ..add(TabWidget(
          Image.asset(icMainSuppliesDisable), Container(), stringReceive, () {
//        CustomNavigator().push(context, MainDeliveryPage());
      }, isDisable: true))
      ..add(TabWidget(Image.asset(icMainDeployment), Container(), stringDeploy,
          () {
      }))
      ..add(TabWidget(Image.asset(icMainMap), Container(), stringPoints, () {
        // CustomNavigator().push(context, GroupPointScreen());
      }))
      ..add(TabWidget(Image.asset(icMainChecklist), Container(), stringCusCare,
          () {
        // CustomNavigator().push(context, CustomerCarePage());
      }))
      ..add(TabWidget(Image.asset(icMainPotentialCusDisable), Container(),
          stringPotentialCus, () {}, isDisable: true))
      ..add(TabWidget(
          Image.asset(icLiquidation), Container(), stringLiquidation, () {
        // CustomNavigator().push(context, MainLiquidationPage());
      }));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.bloc.initBloc();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildTitleProvince() {
    return Container(
      margin: EdgeInsets.only(bottom: Globals.minPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              RichText(
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Xin chào, ",
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400)),
                    TextSpan(
                        text: "LiLy",
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700)),
                  ]))
            ],
          ),
          Container(
            height: 4.0,
          ),
          InkWell(
            onTap: () => widget.bloc.pushLocationPage(widget.bloc, false),
            child: Row(
              children: <Widget>[
                RichText(
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Đang bán tại ",
                          style: TextStyle(
                              color: whiteColor.withOpacity(0.7),
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: "Hồ Chí Minh",
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700)),
                    ])),
                InkWell(
                  child: Container(
                    child: Icon(
                      Icons.expand_more,
                      color: whiteColor,
                      size: 25,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListActivityItem() {
    return Container(
      margin: EdgeInsets.all(Globals.minPadding),
      child: Wrap(
        children: _activityIcon
            .asMap()
            .map((index, element) => MapEntry(
                index,
                _buildTitleIcon(element.title, element.icon, element.onTap,
                    isDisable: element.isDisable)))
            .values
            .toList(),
      ),
    );
  }

  Widget _buildImplementation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RenderRowTitleWidget(
          stringImplementation,
          TextStyle(
              color: bigStone80Color,
              fontWeight: FontWeight.w600,
              fontSize: 18),
          suffixChild: InkWell(
            onTap: () {
              // CustomNavigator().push(
              //     context,
              //     MainDeploymentPage(
              //       currentIndex: 0,
              //     ));
            },
            child: Container(
              padding:
              EdgeInsets.symmetric(horizontal: Globals.minPadding),
              child: Text(
                stringAll,
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
            ),
          ),
        ),
        Container(
          width: Globals.maxWidth,
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildItemCardCompleted(
                    icSlipReturned, stringProgressCompleted)
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSlipsReturn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RenderRowTitleWidget(
          stringSlipsReturn,
          TextStyle(
              color: bigStone80Color,
              fontWeight: FontWeight.w600,
              fontSize: 18),
          suffixChild: InkWell(
            onTap: () {
              // CustomNavigator().push(
              //     context,
              //     MainDeploymentPage(
              //       currentIndex: 1,
              //     ));
            },
            child: Container(
              padding:
              EdgeInsets.symmetric(horizontal: Globals.minPadding),
              child: Text(
                stringAll,
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
          ),
        ),
        Container(
          width: Globals.maxWidth,
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
              [
                _buildItemCardCompleted(icSlipReturned, stringSlipReturned)
              ],
            ),
          ),
        ),
//
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      height: Globals.maxHeight,
      child: Column(
        children: [
          Container(
            height: Globals.statusBarHeight+Globals.maxPadding,
            color: primaryColor,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMainService(),
                  _buildListActivityItem(),
                  _buildImplementation(),
                  _buildSlipsReturn()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleIcon(String name, String url) {

    String imageUrl = url ?? "";
    String name = "";
    if ((name ?? "") != "") {
      if (name.contains("/")) {
        List<String> temp = name.split("/");
        name = temp[0] + "\n /" + temp[1];
      } else if (name.contains(" ")) {
        List<String> temp = name.split(" ");
        for (int i = 0; i < temp.length; i++) {
          name += temp[i];
          name += " ";
          if (i == 1) {
            name += "\n";
          }
        }
      } else {
        name = name;
      }
    }
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(
            right: Globals.minPadding,
            left: Globals.minPadding,
           ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: Globals.maxPadding*2.3,
                margin: EdgeInsets.only(
                    right: Globals.minPadding / 2,
                    left: Globals.minPadding / 2),
                alignment: Alignment.center,
                child: Image.asset(icMainChecklist)),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                name,
                textScaleFactor: 0.9,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitleIcon(String title, Widget icon, Function onTap,
      {isDisable = false}) {
    return Container(
      width: (Globals.maxWidth - Globals.maxPadding) / 4,
      padding: EdgeInsets.symmetric(vertical: Globals.minPadding),
      child: InkWell(
        onTap: onTap,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 50.0,
                margin: EdgeInsets.symmetric(horizontal: Globals.minPadding),
                child: icon,
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: Globals.minPadding),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13.0,
                      color: isDisable ? bigStone40Color : bigStone80Color,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemCardCompleted(String icon, String title) {
    return Container(
      width: Globals.maxWidth * 0.6,
      margin:
          EdgeInsets.only(left: Globals.maxPadding, bottom: Globals.maxPadding),
      padding: EdgeInsets.only(
          right: Globals.minPadding,
          bottom: Globals.maxPadding,
          top: Globals.maxPadding,
          left: Globals.minPadding),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.05),
              offset: Offset(0.0, 0.8),
              blurRadius: 15.0,
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50.0,
            margin: EdgeInsets.only(top: Globals.minPadding),
            child: Image.asset(icon),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: Globals.maxPadding, bottom: Globals.minPadding),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: bigStone40Color),
            ),
          )
        ],
      ),
    );
  }

  Widget _titleService(ServiceCategoryRequestModel model) {
    if (model.regType == null) return Container();
    return InkWell(
      onTap: () {
        widget.bloc.selectService(model);
      },
      child: Container(
        margin: EdgeInsets.only(left: Globals.maxPadding, right: Globals.minPadding/2),
        padding: EdgeInsets.only(top: Globals.minPadding),
        child: Column(
          children: [
            Text(
              model.regType == 0 ? stringSale : stringSellMore,
              style: TextStyle(
                color: model.isSelected ? primaryColor : bigStone80Color,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            model.isSelected
                ? Container(
                    color: primaryColor,
                    height: 2,
                    width: Globals.maxPadding * 2,
                    margin: EdgeInsets.only(top: 8.0),
                  )
                : Container(
                    margin: EdgeInsets.only(top: 8.0),
                  )
          ],
        ),
      ),
    );
  }

  Widget _buildContentTitleHome() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleProvince(),
        Container(
          height: Globals.maxHeight * 0.25,
          width:  Globals.maxWidth,
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withOpacity(0.05),
                  offset: Offset(0.0, 0.8),
                  blurRadius: 24.0,
                ),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder(
                  stream: widget.bloc.outputCategoryRequest,
                  builder: (_, snap) {
                    if (snap.data == null || !snap.hasData) return Container();
                    List<ServiceCategoryRequestModel> _listTitleService =
                        snap.data;
                    return Row(
                      children: _listTitleService
                          .map((e) => _titleService(e))
                          .toList(),
                    );
                  }),
              CustomLine(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child:
                     ListView.builder(
                          padding: EdgeInsets.only(
                              left: Globals.minPadding,
                              right: Globals.minPadding),
                          shrinkWrap: true,
                          itemCount:4,
                          controller: _controller,
                          scrollDirection: Axis.horizontal,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (_, index) {

                            return _titleIcon("","");
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 10,
                          height: 4,
                          decoration: BoxDecoration(
                              color: royal60Color,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(12.0))),
                        ),
                      ],
                    ),
                    Container(
                      height: Globals.minPadding * 0.6,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMainService() {
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: Globals.maxWidth,
            child: Column(
              children: List.unmodifiable(() sync* {
                yield new Container(
                  height: Globals.maxHeight * 0.3,
                  alignment: Alignment.topCenter,
                  width: Globals.maxWidth,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                          image: AssetImage(imgAppbar), fit: BoxFit.cover)),
                );
                yield new Container(
                  height: Globals.maxPadding,
                );
              }()),
            ),
          ),
          Positioned(
            top: Globals.statusBarHeight,
            right: Globals.maxPadding,
            left: Globals.maxPadding,
            child: _buildContentTitleHome(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Globals.maxWidth = MediaQuery.of(context).size.width;
    Globals.maxHeight = MediaQuery.of(context).size.height;
    Globals.statusBarHeight = MediaQuery.of(context).padding.top;
    if(ResponsiveWidget.isSmallScreen(context)){
      if(ResponsiveWidget.isLargerWidth(context)){
        Globals.maxPadding = Globals.maxHeight * 0.05;
        Globals.minPadding = Globals.maxPadding / 2;
        Globals.tabbarSize = Globals.maxHeight / 10 * 7;
        print(Globals.maxPadding);
        print("ssssssssssssss");
      }else{
        Globals.maxPadding = Globals.maxWidth * 0.05;
        Globals.minPadding = Globals.maxPadding / 2;
        Globals.tabbarSize = Globals.maxWidth / 10 * 7;
        print(Globals.maxPadding);
        print("bbbbbbbbbbbbb");
      }
    }else if(ResponsiveWidget.isMediumScreen(context)){
      Globals.maxPadding = Globals.maxHeight * 0.05;
      Globals.minPadding = Globals.maxPadding / 2;
      Globals.tabbarSize = Globals.maxHeight / 10 * 7;
      print(Globals.maxPadding);
      print("ddddddddddddddd");
    }else{
      Globals.maxPadding = Globals.maxHeight * 0.05;
      Globals.minPadding = Globals.maxPadding / 2;
      Globals.tabbarSize =Globals.maxHeight / 10 * 7;
      print(Globals.maxPadding);
      print("cccccccccc");
    }
    return CustomScaffold(
      backgroundColor: royalBlue01Color,
      body: _buildBody(),
      onRefresh: () => widget.bloc.initBloc(),
    );
  }
}
