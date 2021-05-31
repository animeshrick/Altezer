class BannerImage {
    BannerImage({
        required this.message,
        required this.status,
        required this.imgCover,
        required this.imgLogo,
    });

    final String message;
    final String status;
    final String imgCover;
    final String imgLogo;

    factory BannerImage.fromJson(Map<String, dynamic> json) => BannerImage(
        message: json["message"],
        status: json["status"],
        imgCover: json["imgCover"],
        imgLogo: json["imgLogo"],
    );
}
