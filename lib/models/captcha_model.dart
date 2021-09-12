class CaptchaModel{
  String uuid;
  String image;

//<editor-fold desc="Data Methods">

  CaptchaModel({
    required this.uuid,
    required this.image,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CaptchaModel &&
          runtimeType == other.runtimeType &&
          uuid == other.uuid &&
          image == other.image);

  @override
  int get hashCode => uuid.hashCode ^ image.hashCode;

  @override
  String toString() {
    return 'CaptchaModel{' + ' uuid: $uuid,' + ' image: $image,' + '}';
  }

  CaptchaModel copyWith({
    String? uuid,
    String? image,
  }) {
    return CaptchaModel(
      uuid: uuid ?? this.uuid,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': this.uuid,
      'image': this.image,
    };
  }

  factory CaptchaModel.fromMap(Map<String, dynamic> map) {
    return CaptchaModel(
      uuid: map['uuid'] as String,
      image: map['image'] as String,
    );
  }

//</editor-fold>
}