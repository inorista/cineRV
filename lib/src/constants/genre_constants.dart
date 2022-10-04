import 'package:cinerv/src/constants/path_constants.dart';

getStringGenre(String genreName) {
  String result;
  const map = {
    'Phim Hành Động': "${ASSET_IMAGE_PATH}hanh_dong.jpg",
    'Phim Phiêu Lưu': "${ASSET_IMAGE_PATH}phieu_luu.jpg",
    'Phim Hoạt Hình': "${ASSET_IMAGE_PATH}hoat_hinh.jpg",
    'Phim Hài': "${ASSET_IMAGE_PATH}hai.jpg",
    'Phim Hình Sự': "${ASSET_IMAGE_PATH}hinh_su.jpg",
    'Phim Tài Liệu': "${ASSET_IMAGE_PATH}tai_lieu.jpg",
    'Phim Chính Kịch': "${ASSET_IMAGE_PATH}chinh_kich.jpg",
    'Phim Gia Đình': "${ASSET_IMAGE_PATH}gia_dinh.jpg",
    'Phim Giả Tượng': "${ASSET_IMAGE_PATH}fantasy.jpg",
    'Phim Lịch Sử': "${ASSET_IMAGE_PATH}lich_su.jpg",
    'Phim Kinh Dị': "${ASSET_IMAGE_PATH}kinh_di.jpg",
    'Phim Nhạc': "${ASSET_IMAGE_PATH}am_nhac.jpg",
    'Phim Bí Ẩn': "${ASSET_IMAGE_PATH}bi_an.jpg",
    'Phim Lãng Mạn': "${ASSET_IMAGE_PATH}lang_man.jpg",
    'Phim Khoa Học Viễn Tưởng': "${ASSET_IMAGE_PATH}khoa_hoc.jpg",
    'Chương Trình Truyền Hình': "${ASSET_IMAGE_PATH}tv.jpg",
    'Phim Gây Cấn': "${ASSET_IMAGE_PATH}giat_gan.jpg",
    'Phim Chiến Tranh': "${ASSET_IMAGE_PATH}chien_tranh.jpg",
    'Phim Miền Tây': "${ASSET_IMAGE_PATH}vien_tay.jpg",
  };
  result = map[genreName]!;
  return result;
}
