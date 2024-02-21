class FormulirPatroliLaut {
  late int users_id;
  late String tanggal_kejadian;
  late int m_shift_id;
  late String uraian_hasil;
  late String keterangan;
  late List<PhotoPatroliLaut> photo_patroli_laut;

  FormulirPatroliLaut({
    required this.users_id,
    required this.tanggal_kejadian,
    required this.m_shift_id,
    required this.uraian_hasil,
    required this.keterangan,
    required this.photo_patroli_laut,
  });

  FormulirPatroliLaut.fromJson(Map<String, dynamic> json) {
    users_id = json['users_id'];
    tanggal_kejadian = json['tanggal_kejadian'];
    m_shift_id = json['m_shift_id'];
    uraian_hasil = json['uraian_hasil'];
    keterangan = json['keterangan'];
    photo_patroli_laut = (json['photo_patroli_laut'] as List<dynamic>?)
            ?.map((photoJson) => PhotoPatroliLaut.fromJson(photoJson))
            .toList() ??
        [];
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

  Map<String, dynamic> toJson() {
    return {
      'photo_path': photo_path,
    };
  }
}
