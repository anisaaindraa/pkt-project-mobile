class FormulirPatroliLaut {
  late bool success;
  late String message;
  late FormulirPatroliLautData data;

  FormulirPatroliLaut({
    required this.success,
    required this.message,
    required this.data,
  });

  FormulirPatroliLaut.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = FormulirPatroliLautData.fromJson(json['data']);
  }
}

class FormulirPatroliLautData {
  late int users_id;
  late String tanggal_kejadian;
  late int m_shift_id;
  late String uraian_hasil;
  late String keterangan;
  late List<PhotoPatroliLaut> photo_patroli_laut;

  FormulirPatroliLautData({
    required this.users_id,
    required this.tanggal_kejadian,
    required this.m_shift_id,
    required this.uraian_hasil,
    required this.keterangan,
    required this.photo_patroli_laut,
  });

  factory FormulirPatroliLautData.fromJson(Map<String, dynamic> json) {
    return FormulirPatroliLautData(
      users_id: json['users_id'],
      tanggal_kejadian: json['tanggal_kejadian'],
      m_shift_id: json['nama_shift'],
      uraian_hasil: json['uraian_hasil'],
      keterangan: json['keterangan'],
      photo_patroli_laut: json['photo_patroli_laut'] != null
          ? List<PhotoPatroliLaut>.from(json['photo_patroli_laut']
              .map((photoJson) => PhotoPatroliLaut.fromJson(photoJson)))
          : [],
    );
  }
}

class PhotoPatroliLaut {
  late String photo_path;

  PhotoPatroliLaut({
    required this.photo_path,
  });

  PhotoPatroliLaut.fromJson(Map<String, dynamic> json) {
    photo_path = json['photo_path'];
  }
}
