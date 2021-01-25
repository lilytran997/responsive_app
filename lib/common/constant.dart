

import 'package:demo_desktop/utilities/check_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final primaryColor = HexColor("3E64FF");
final orangePeelColor = HexColor('FFAC00');
final caribbeanGreenColor = HexColor('0BD78C');
final radicalRedColor = HexColor('FF4A5E');
//Secondary Colors
final royalBlue100Color = HexColor('284EEB');
final royal60Color = HexColor('7E95F3');
//final royal60Color = HexColor("F3A17E");
final royalBlue30Color = HexColor('BFCAF9');
final royalBlue08Color =  HexColor('EEF1FD');
final royalBlue01Color =  HexColor('FDFDFF');
final pizazzOrangeColor =  HexColor('FF8500');
final mountainGreenColor =  HexColor('FF8500');
final sunsetOrangeColor = HexColor('F43F4A');
final orangePeel = HexColor("#FF9900");
final pizazz100Color = HexColor("F37807");
//Neutral Colors
final whiteColor  = HexColor('FFFFFF');
final bigStone02Color = HexColor('FAFAFB');
final bigStone08Color = HexColor('ECEDEF');
final bigStone20Color = HexColor('CFD2D7');
final bigStone40Color = HexColor('A0A4AF');
final searchColor = HexColor("231F20");
final bigStone60Color = HexColor('666D7C');
final bigStone80Color = HexColor('3C4459');
final bigStone100Color = HexColor('111C36');
final redColor = HexColor('FF0000');
final blueDarkColor = HexColor("29376D");
// Custom Colors
final grayBackground = HexColor('E5E5E5');
final shadowColor = HexColor("000000");


final icMainSellMore ="assets/ic-main-sellmore.png";
final icMainChecklist= "assets/ic-main-checklist.png";
final icMainDeployment ="assets/ic-main-deployment.png";
final icMainMap= "assets/ic-main-map.png";
final icMainDelivery= "assets/ic-main-delivery.png";
final icMainSuppliesDisable = "assets/ic-main-supplies-disable.png";
final icMainPotentialCus= "assets/ic-main-potential-cus.png";
final icMainPotentialCusDisable = "assets/ic-main-customers-disable.png";
final icLiquidation = "assets/ico-liquidation.png";
final icMainReport="assets/ic-main-report.png";
final icTabbarHome = "assets/ic-tabbar-home.png";
final icTabbarCart = "assets/ic-tabbar-cart.png";
final icTabbarNotification = "assets/ic-tabbar-notification.png";
final icTabbarQueueIn= "assets/ic-tabbar-queue-in.png";
final icTabbarUser = "assets/ic-tabbar-user.png";
final icClose = "assets/ic-close.png";
final icProgressCompleted ="assets/ic-progress-completed.png";
final icSlipReturned="assets/ic-slip-returned.png";
final imgAppbar = "assets/img-bg-appbar.png";

final stringTabbarHome = "Trang chủ";
final stringFind ="TÌM";
final stringTabbarCart = "Bán hàng";
final stringTabbarNotification = "Thông báo";
final stringTabbarQueueIn = "Báo cáo";
final stringTabbarUser = "Tài khoản";
final stringInternetHome = "Internet\n/PayTV";
final stringPlayBoxHome = "FPT\nPlayBox";
final stringCameraHome = "FPT\nCamera";
final stringExtraHome = "Giải trí\nđa nền tảng";
final stringSale = "Bán mới ngay";
final stringSaleNew="Bán mới";
final stringReceive ="Nhận vật tư";
final stringPoints = "Tập điểm";
final stringDeploy="Triển khai";
final stringReport = "Báo cáo";
final stringSellMore = "Bán thêm";
final stringPotentialCus ="KH tiềm năng";
final stringLiquidation = "Thanh Lý TSD";
final stringCusCare ="CSKH";
final stringCustomerCare = "Chăm sóc khách hàng";
final stringAll="Tất cả";
final stringImplementation ="Tiến độ triển khai";
final stringSlipsReturn = "Phiếu thi công trả về";
final stringSlipReturned = "Mọi phiếu thi công đã hoàn thành!";
final stringProgressCompleted = "Mọi triển khai đã hoàn thành!";

changeStatusBarColor(Color color, bool isDark) {
  SystemChrome.setSystemUIOverlayStyle(isDark
      ? SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: color, statusBarIconBrightness: Brightness.dark)
      : SystemUiOverlayStyle.light.copyWith(
      statusBarColor: color, statusBarIconBrightness: Brightness.light));
}