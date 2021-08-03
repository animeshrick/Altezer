class UploadImgModel {
    UploadImgModel({
        required this.message,
        required this.status,
        required this.imageUrl,
    });

    final String message;
    final String status;
    final String imageUrl;

    factory UploadImgModel.fromJson(Map<String, dynamic> json) => UploadImgModel(
        message: json["message"],
        status: json["status"],
        imageUrl: json["imageUrl"],
    );
}
