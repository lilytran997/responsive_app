import 'package:demo_desktop/models/service_category_request_model.dart';
import 'package:demo_desktop/utilities/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HomeTabbarBloc extends BaseBloc {
  HomeTabbarBloc(BuildContext context) {
    setContext(context);
  }

  final _streamIndex = BehaviorSubject<int>();

  Stream<int> get outputIndex => _streamIndex.stream;
  List<ServiceCategoryRequestModel> _listServiceGroup;


  setIndex(int event) => _streamIndex.sink.add(event);
  final _streamCategoryRequest = BehaviorSubject<List<ServiceCategoryRequestModel>>();
  Stream<List<ServiceCategoryRequestModel>> get outputCategoryRequest => _streamCategoryRequest.stream;

  setCategoryRequest(List<ServiceCategoryRequestModel> event) => _streamCategoryRequest.sink.add(event);

  @override
  void dispose() {
    // TODO: implement dispose
    _streamCategoryRequest.close();
    _streamIndex.close();
    super.dispose();
  }

  initBloc() async {
    _listServiceGroup = List<ServiceCategoryRequestModel>();
    _listServiceGroup
      ..add(ServiceCategoryRequestModel(
          customerLocationId: 0,
          regType: 0,
          isSelected: true))
      ..add(ServiceCategoryRequestModel(
          customerLocationId: 0,
          regType: 1,
          isSelected: false));
    ServiceCategoryRequestModel _serviceGroup;
    _listServiceGroup.forEach((element) {
      if (element.isSelected) _serviceGroup = element;
    });
    setCategoryRequest(_listServiceGroup);
  }

  selectService(ServiceCategoryRequestModel model) async {
    try {
      ServiceCategoryRequestModel event =
          _listServiceGroup.firstWhere((element) => element.isSelected);
      if (event != null) event.isSelected = false;
      model.isSelected = true;
      setCategoryRequest(_listServiceGroup);
    } catch (e) {
      print('error: ' + e.toString());
    }
  }

  pushLocationPage(HomeTabbarBloc bloc, bool isSale) async {
  }

}
