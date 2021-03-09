import 'package:demo_desktop/common/constant.dart';
import 'package:demo_desktop/home_tabbar/src/bloc/home_tabbar_bloc.dart';
import 'package:demo_desktop/models/service_category_request_model.dart';
import 'package:demo_desktop/utilities/custom_line.dart';
import 'package:demo_desktop/utilities/globals.dart';
import 'package:demo_desktop/utilities/responsive.dart';
import 'package:demo_desktop/utilities/tab_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:universal_html/html.dart' as html;

class HomeTabDesktopPage extends StatefulWidget {
  final HomeTabbarBloc bloc;
  const HomeTabDesktopPage({Key key, this.bloc}) : super(key: key);
  @override
  _HomeTabDesktopPageState createState() => _HomeTabDesktopPageState();
}

class _HomeTabDesktopPageState extends State<HomeTabDesktopPage> {
  ScrollController _controller = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget _itemButton(TabWidget model) {
    return InkWell(
      onTap: () {
        widget.bloc.selectTab(model);
        String name = "";
        if (model.child.runtimeType.toString().contains("Screen")) {
          name = model.child.runtimeType.toString().replaceAll('Screen', '') +
              "Tab";
        } else if (model.child.runtimeType.toString().contains("Page")) {
          name =
              model.child.runtimeType.toString().replaceAll('Page', '') + "Tab";
        } else {
          name = model.child.runtimeType.toString() + "Tab";
        }
        html.window.history.pushState(null, "/HomePage", "/HomePage#$name");
      },
      child: Container(
        // height: 60.0,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          border: (model.isSelected ?? false)
              ? Border(bottom: BorderSide(color: Colors.white))
              : null,
        ),
        child: Center(
          child: (model.icon == null || model.iconUrl == null)
              ? Text(
                  model.title ?? "",
                  style: TextStyle(
                      color: (model.isSelected ?? false)
                          ? Colors.white
                          : Colors.black,
                      fontSize: 15.0),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      AssetImage(model.iconUrl),
                      color: (model.isSelected ?? false)
                          ? Colors.white
                          : Colors.black,
                    ),
                    if (ResponsiveWidget.isLargeScreen(context))
                      Container(
                        width: 5,
                      ),
                    if (ResponsiveWidget.isLargeScreen(context))
                      Expanded(
                        child: Text(
                          model.title ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: (model.isSelected ?? false)
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 15),
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
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

  Widget _titleService(ServiceCategoryRequestModel model) {
    if (model.regType == null) return Container();
    return InkWell(
      onTap: () {
        widget.bloc.selectService(model);
      },
      child: Container(
        margin: EdgeInsets.only(
            left: Globals.maxPadding, right: Globals.maxPadding),
        padding: EdgeInsets.only(
          top: Globals.minPadding,
        ),
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

  Widget _titleIcon(String nameText, String url) {
    String imageUrl = url ?? "";
    String name = "";
    if ((nameText ?? "") != "") {
      if (nameText.contains("/")) {
        List<String> temp = nameText.split("/");
        name = temp[0] + "\n /" + temp[1];
      } else if (nameText.contains(" ")) {
        List<String> temp = nameText.split(" ");
        for (int i = 0; i < temp.length; i++) {
          name += temp[i];
          name += " ";
          if (i == 1) {
            name += "\n";
          }
        }
      } else {
        name = nameText;
      }
    }
    return GestureDetector(
      onTap: () {},
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
                height: Globals.maxWidth * 0.1,
                margin: EdgeInsets.only(
                    right: Globals.minPadding / 2,
                    left: Globals.minPadding / 2),
                alignment: Alignment.center,
                child: Image.asset(icMainChecklist)),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                name,
                textScaleFactor: 0.9,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListCategory() {
    return StreamBuilder(
        stream: widget.bloc.outputCategoryRequest,
        builder: (_, snap) {
          if (snap.data == null || !snap.hasData) return Container();
          List<ServiceCategoryRequestModel> _listTitleService = snap.data;
          return BootstrapRow(
            height: Globals.maxHeight * 0.25,
            children: <BootstrapCol>[
              BootstrapCol(
                sizes: 'col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12',
                orders: 'order-1 order-sm-1 order-md-1 order-lg-1 order-xl-1',
                child: Column(
                  children: [
                    Row(
                      children: _listTitleService
                          .map((e) => _titleService(e))
                          .toList(),
                    ),
                    CustomLine(),
                  ],
                ),
              ),
              BootstrapCol(
                  sizes: 'col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12',
                  orders: 'order-3 order-sm-3 order-md-3 order-lg-3 order-xl-3',
                  child: BootstrapContainer(
                    fluid: true,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    children: [
                      SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(
                            horizontal: Globals.maxPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: ["", "", "", ""]
                              .map((e) => _titleIcon("text", ""))
                              .toList(),
                        ),
                      )
                    ],
                  )),
              BootstrapCol(
                sizes: 'col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12',
                orders: 'order-4 order-sm-4 order-md-4 order-lg-4 order-xl-4',
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 10,
                          height: 4,
                          decoration: BoxDecoration(
                              color: royal60Color,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                        ),
                      ],
                    ),
                    Container(
                      height: 10,
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder(
          stream: widget.bloc.outputListTab,
          builder: (_, snapshot) {
            if (snapshot.data == null) return Container();
            List<TabWidget> _listTab = snapshot.data;
            TabWidget _tabSelected;
            _listTab.forEach((element) {
              if (element.isSelected) {
                _tabSelected = element;
              }
            });
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_listTab != null || _listTab.length > 0)
                  _tabSelected.id == 1
                      ? Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            BootstrapContainer(
                              fluid: true,
                              padding: EdgeInsets.only(
                                  bottom: Globals.maxHeight * 0.25),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                  image: DecorationImage(
                                      image: AssetImage(imgAppbar),
                                      fit: BoxFit.cover)),
                              children: [
                                BootstrapRow(
                                  height: Globals.maxHeight * 0.1,
                                  children: <BootstrapCol>[
                                    BootstrapCol(
                                      sizes:
                                          'col-xs-12 col-sm-12 col-md-4 col-lg-4 col-xl-4',
                                      orders:
                                          'order-1 order-sm-1 order-md-1 order-lg-1 order-xl-1',
                                      child: BootstrapContainer(
                                        fluid: true,
                                        padding:
                                            EdgeInsets.all(Globals.maxPadding),
                                        children: [
                                          _buildTitleProvince(),
                                        ],
                                      ),
                                    ),
                                    BootstrapCol(
                                      sizes:
                                          'col-xs-12 col-sm-12 col-md-8 col-lg-8 col-xl-8',
                                      orders:
                                          'order-2 order-sm-2 order-md-2 order-lg-2 order-xl-2',
                                      child: BootstrapContainer(
                                        fluid: true,
                                        padding: EdgeInsets.symmetric(
                                            vertical: Globals.maxPadding),
                                        children: [
                                          BootstrapRow(
                                              height: Globals.maxHeight * 0.15,
                                              children: <BootstrapCol>[]
                                                ..addAll(_listTab
                                                    .asMap()
                                                    .map((index, element) =>
                                                        MapEntry(
                                                            index,
                                                            BootstrapCol(
                                                                sizes:
                                                                    'col-xs-12 col-sm-12 col-md-3 col-lg-2 col-xl-2',
                                                                // orders:
                                                                //     'order-1 order-sm-1 order-md-2 order-lg-2 order-xl-2',
                                                                child: _itemButton(
                                                                    element))))
                                                    .values
                                                    .toList()))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 0.0,
                              right: Globals.maxPadding,
                              left: Globals.maxPadding,
                              child: BootstrapContainer(
                                // height: 50.0,
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: shadowColor.withOpacity(0.05),
                                        offset: Offset(0.0, 0.8),
                                        blurRadius: 24.0,
                                      ),
                                    ]),
                                children: [_buildListCategory()],
                                // fluid: true,
                                // children: [
                                //   _buildListCategory()
                                // ],
                              ),
                            )
                          ],
                        )
                      : BootstrapContainer(
                          fluid: true,
                          // padding:
                          // EdgeInsets.only(bottom: Globals.maxHeight * 0.25),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(imgAppbar),
                                  fit: BoxFit.cover)),
                          children: [
                            BootstrapRow(
                              height: Globals.maxHeight * 0.1,
                              children: <BootstrapCol>[
                                BootstrapCol(
                                  sizes:
                                      'col-xs-12 col-sm-12 col-md-4 col-lg-4 col-xl-4',
                                  orders:
                                      'order-1 order-sm-1 order-md-1 order-lg-1 order-xl-1',
                                  child: BootstrapContainer(
                                    fluid: true,
                                    padding: EdgeInsets.all(Globals.maxPadding),
                                    children: [
                                      _buildTitleProvince(),
                                    ],
                                  ),
                                ),
                                BootstrapCol(
                                  sizes:
                                      'col-xs-12 col-sm-12 col-md-8 col-lg-8 col-xl-8',
                                  orders:
                                      'order-2 order-sm-2 order-md-2 order-lg-2 order-xl-2',
                                  child: BootstrapContainer(
                                    fluid: true,
                                    padding: EdgeInsets.symmetric(
                                        vertical: Globals.maxPadding),
                                    children: [
                                      BootstrapRow(
                                          height: Globals.maxHeight * 0.1,
                                          children: <BootstrapCol>[]..addAll(_listTab
                                              .asMap()
                                              .map((index, element) => MapEntry(
                                                  index,
                                                  BootstrapCol(
                                                      sizes: 'col-xs-12 col-sm-12 col-md-3 col-lg-2 col-xl-2',
                                                      // orders:
                                                      //     'order-1 order-sm-1 order-md-2 order-lg-2 order-xl-2',
                                                      child: _itemButton(element))))
                                              .values
                                              .toList()))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                Expanded(
                  child: _tabSelected.child ?? Container(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
