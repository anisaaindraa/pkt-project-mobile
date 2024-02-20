class FormulirPelaporanKejadian {
  late bool success;
  late String message;
  late FormulirPelaporanKejadianData data;

  FormulirPelaporanKejadian({
    required this.success,
    required this.message,
    required this.data,
  });

  FormulirPelaporanKejadian.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = FormulirPelaporanKejadianData.fromJson(json['data']);
  }

  get statusCode => null;

  get body => null;
}

class FormulirPelaporanKejadianData {
  late int id;
  late int usersId;
  late String jenisKejadian;
  late String tanggalKejadian;
  late String waktuKejadian;
  late String tempatKejadian;
  late String kerugianAkibatKejadian;
  late String keteranganLain;
  late List<Korban> korban;
  late List<Pelaku> pelaku;

  FormulirPelaporanKejadianData({
    required this.id,
    required this.usersId,
    required this.jenisKejadian,
    required this.tanggalKejadian,
    required this.waktuKejadian,
    required this.tempatKejadian,
    required this.kerugianAkibatKejadian,
    required this.keteranganLain,
    required this.korban,
    required this.pelaku,
  });

  FormulirPelaporanKejadianData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    jenisKejadian = json['jenis_kejadian'];
    tanggalKejadian = json['tanggal_kejadian'];
    waktuKejadian = json['waktu_kejadian'];
    tempatKejadian = json['tempat_kejadian'];
    kerugianAkibatKejadian = json['kerugian_akibat_kejadian'];
    keteranganLain = json['keterangan_lain'];

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
  late String namaKorban;
  late int umurKorban;
  late String pekerjaanKorban;
  late String alamatKorban;
  late int noTlpKorban;

  Korban({
    required this.namaKorban,
    required this.umurKorban,
    required this.pekerjaanKorban,
    required this.alamatKorban,
    required this.noTlpKorban,
  });

  Korban.fromJson(Map<String, dynamic> json) {
    namaKorban = json['nama_korban'];
    umurKorban = json['umur_korban'];
    pekerjaanKorban = json['pekerjaan_korban'];
    alamatKorban = json['alamat_korban'];
    noTlpKorban = json['no_tlp_korban'];
  }
}

class Pelaku {
  late String namaPelaku;
  late int umurPelaku;
  late String pekerjaanPelaku;
  late String alamatPelaku;
  late int noTlpPelaku;

  Pelaku({
    required this.namaPelaku,
    required this.umurPelaku,
    required this.pekerjaanPelaku,
    required this.alamatPelaku,
    required this.noTlpPelaku,
  });

  Pelaku.fromJson(Map<String, dynamic> json) {
    namaPelaku = json['nama_pelaku'];
    umurPelaku = json['umur_pelaku'];
    pekerjaanPelaku = json['pekerjaan_pelaku'];
    alamatPelaku = json['alamat_pelaku'];
    noTlpPelaku = json['no_tlp_pelaku'];
  }
}
