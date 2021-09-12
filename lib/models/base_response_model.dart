
class BaseResponseModel{
  String responseCode;
  String object;
  String message;
  String refreshedToken;
  String securityType;
  String objectOther;
  String receivePoint;
  String tranId;
  String smartToken;
  String subErrorCode;
  String subErrorDesc;
  String versionAppMobile;
  String linkImg;
  String minBalance;
  String overDraftFacility;
  String accName;
  String addRess;
  String fee;
  String vat;
  String discount;
  String otp;
  String coreSn;
  String totalGiftPoint;
  String totalRewardPoint;
  String totalUsedPoint;
  String totalPenaltyPoint;
  String? tranSn;


  BaseResponseModel({
    required this.totalGiftPoint,
    required this.totalRewardPoint,
    required this.responseCode,
    required this.totalUsedPoint,
    required this.totalPenaltyPoint,
    required this.object,
    required this.message,
    required this.refreshedToken,
    required this.securityType,
    required this.objectOther,
    required this.receivePoint,
    required this.tranId,
    required this.smartToken,
    required this.subErrorCode,
    required this.subErrorDesc,
    required this.versionAppMobile,
    required this.linkImg,
    required this.minBalance,
    required this.overDraftFacility,
    required this.accName,
    required this.addRess,
    required this.fee,
    required this.vat,
    required this.discount,
    required this.otp,
    required this.coreSn,
    this.tranSn
  });

  @override
  String toString() {
    return 'BaseResponse{responseCode: $responseCode, object: $object, '
        'message: $message, refreshedToken: $refreshedToken,'
        ' securityType: $securityType, objectOther: $objectOther, '
        'receivePoint: $receivePoint, tranId: $tranId, '
        'smartToken: $smartToken, minBalance: $minBalance'
        'overDraftFacility: $overDraftFacility, accName: $accName'
        'addRess: $addRess, fee: $fee'
        'tranSn: $tranSn'
        '}';
  }

  factory BaseResponseModel.fromMap(Map<String, dynamic> map) {
    return new BaseResponseModel(
      responseCode: map['responseCode'].toString(),
      object: map['object'].toString(),
      message: map['message'].toString(),
      refreshedToken: map['refreshedToken'].toString(),
      securityType: map['securityType'].toString(),
      objectOther: map['objectOther'].toString(),
      receivePoint: map['receivePoint'].toString(),
      tranId: map['tranId'].toString(),
      smartToken: map['smartToken'].toString(),
      subErrorCode: map['subErrorCode'].toString(),
      subErrorDesc: map['subErrorDesc'].toString(),
      versionAppMobile: map['versionAppMobile'].toString(),
      linkImg: map['linkImg'].toString(),
      minBalance: map['minBalance'].toString(),
      accName: map['accName'].toString(),
      overDraftFacility: map['overDraftFacility'].toString(),
      addRess: map['addRess'].toString(),
      fee: map['fee'].toString(),
      vat: map['vat'].toString(),
      discount: map['discount'].toString(),
      otp: map['otp'].toString(),
      coreSn: map['coreSn'].toString(),
      totalGiftPoint: map['totalGiftPoint'].toString(),
      totalPenaltyPoint: map['totalPenaltyPoint'].toString(),
      totalRewardPoint: map['totalRewardPoint'].toString(),
      totalUsedPoint: map['totalUsedPoint'].toString()
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'responseCode': this.responseCode,
      'object': this.object,
      'message': this.message,
      'refreshedToken': this.refreshedToken,
      'securityType': this.securityType,
      'objectOther': this.objectOther,
      'receivePoint': this.receivePoint,
      'tranId': this.tranId,
      'smartToken': this.smartToken,
      'subErrorCode': this.subErrorCode,
      'subErrorDesc': this.subErrorDesc,
      'versionAppMobile': this.versionAppMobile,
      'linkImg': this.linkImg,
    } ;
  }

//</editor-fold>

}
