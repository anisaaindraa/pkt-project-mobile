class FormulirPelaporanKejadian {
  late int users_id;
  late String jenis_kejadian;
  late String tanggal_kejadian;
  late String waktu_kejadian;
  late String tempat_kejadian;
  late String kerugian_akibat_kejadian;
  late String penanganan;
  late String keterangan_lain;
  late List<Korban> korban;
  late List<Pelaku> pelaku;

  FormulirPelaporanKejadian({
    required this.users_id,
    required this.jenis_kejadian,
    required this.tanggal_kejadian,
    required this.waktu_kejadian,
    required this.tempat_kejadian,
    required this.kerugian_akibat_kejadian,
    required this.penanganan,
    required this.keterangan_lain,
    required this.korban,
    required this.pelaku,
  });

  FormulirPelaporanKejadian.fromJson(Map<String, dynamic> json) {
    users_id = json['users_id'];
    jenis_kejadian = json['jenis_kejadian'];
    tanggal_kejadian = json['tanggal_kejadian'];
    waktu_kejadian = json['waktu_kejadian'];
    tempat_kejadian = json['tempat_kejadian'];
    kerugian_akibat_kejadian = json['kerugian_akibat_kejadian'];
    penanganan = json['penanganan'];
    keterangan_lain = json['keterangan_lain'];

    if (json['korban'] != null) {
      korban = List<Korban>.from(
          json['korban'].map((korbanJson) => Korban.fromJson(korbanJson)));
    } else {
      korban = [];
    }

    if (json['pelaku'] != null) {
      pelaku = List<Pelaku>.from(
          json['pelaku'].map((pelakuJson) => Pelaku.fromJson(pelakuJson)));
    } else {
      pelaku = [];
    }
  }
}

class Korban {
  late String nama_korban;
  late int umur_korban;
  late String pekerjaan_korban;
  late String alamat_korban;
  late int no_tlp_korban;

  Korban({
    required this.nama_korban,
    required this.umur_korban,
    required this.pekerjaan_korban,
    required this.alamat_korban,
    required this.no_tlp_korban,
  });

  Korban.fromJson(Map<String, dynamic> json) {
    nama_korban = json['nama_korban'];
    umur_korban = json['umur_korban'];
    pekerjaan_korban = json['pekerjaan_korban'];
    alamat_korban = json['alamat_korban'];
    no_tlp_korban = json['no_tlp_korban'];
  }
}

class Pelaku {
  late String nama_pelaku;
  late int umur_pelaku;
  late String pekerjaan_pelaku;
  late String alamat_pelaku;
  late int no_tlp_pelaku;

  Pelaku({
    required this.nama_pelaku,
    required this.umur_pelaku,
    required this.pekerjaan_pelaku,
    required this.alamat_pelaku,
    required this.no_tlp_pelaku,
  });

  Pelaku.fromJson(Map<String, dynamic> json) {
    nama_pelaku = json['nama_pelaku'];
    umur_pelaku = json['umur_pelaku'];
    pekerjaan_pelaku = json['pekerjaan_pelaku'];
    alamat_pelaku = json['alamat_pelaku'];
    no_tlp_pelaku = json['no_tlp_pelaku'];
  }
}
