class ServiceCategoryRequestModel {
  int customerLocationId;
  int regType;
  bool isSelected;

  ServiceCategoryRequestModel({this.customerLocationId, this.regType,this.isSelected});

  ServiceCategoryRequestModel.fromJson(Map<String, dynamic> json) {
    customerLocationId = json['CustomerLocationId'];
    regType = json['RegType'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerLocationId'] = this.customerLocationId;
    data['RegType'] = this.regType;
    return data;
  }
}