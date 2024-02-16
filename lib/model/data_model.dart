class LoginAuth {
  String message;
  late TokenAuth data;

  LoginAuth({required this.message, required Map<String, dynamic> jsonData})
      : data = TokenAuth.fromJson(jsonData);

  LoginAuth.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        data = TokenAuth.fromJson(json['data']);
}

class TokenAuth {
  String token;

  TokenAuth({required this.token});

  factory TokenAuth.fromJson(Map<String, dynamic> data) {
    return TokenAuth(
      token: data['token'],
    );
  }
}

class User {
  late String email;
  late String password;

  User({required this.email, required this.password});

  User.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      email = json['data']['email'] ?? "";
      password = json['data']['password'] ?? "";
    } else {
      email = "";
      password = "";
    }
  }
}

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
  late int id;
  late int usersId;
  late String tanggalKejadian;
  late int mShiftId;
  late String uraianHasil;
  late String keterangan;
  late List<PhotoPatroliLaut> photoPatroliLaut;

  FormulirPatroliLautData({
    required this.id,
    required this.usersId,
    required this.tanggalKejadian,
    required this.mShiftId,
    required this.uraianHasil,
    required this.keterangan,
    required this.photoPatroliLaut,
  });

  FormulirPatroliLautData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    tanggalKejadian = json['tanggal_kejadian'];
    mShiftId = json['m_shift_id'];
    uraianHasil = json['uraian_hasil'];
    keterangan = json['keterangan'];
    if (json['photo_patroli_laut'] != null) {
      photoPatroliLaut = List<PhotoPatroliLaut>.from(json['photo_patroli_laut']
          .map((photoJson) => PhotoPatroliLaut.fromJson(photoJson)));
    } else {
      photoPatroliLaut = [];
    }
  }
}

class PhotoPatroliLaut {
  late String photoPath;

  PhotoPatroliLaut({
    required this.photoPath,
  });

  PhotoPatroliLaut.fromJson(Map<String, dynamic> json) {
    photoPath = json['photo_path'];
  }
}

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

class FormulirPelaksanaanTugas {
  late bool success;
  late String message;
  late FormulirPelaksanaanTugasData data;

  FormulirPelaksanaanTugas({
    required this.success,
    required this.message,
    required this.data,
  });

  FormulirPelaksanaanTugas.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = FormulirPelaksanaanTugasData.fromJson(json['data']);
  }
}

class FormulirPelaksanaanTugasData {
  late int id;
  late int usersId;
  late String tanggalKejadian;
  late int mPosId;
  late int mSipamId;
  late int mShiftId;
  late List<WaktuUraianTugas> waktuUraianTugas;
  late List<InventarisPos> inventarisPos;
  late String keterangan;

  FormulirPelaksanaanTugasData({
    required this.id,
    required this.usersId,
    required this.tanggalKejadian,
    required this.mPosId,
    required this.mSipamId,
    required this.mShiftId,
    required this.waktuUraianTugas,
    required this.inventarisPos,
    required this.keterangan,
  });

  FormulirPelaksanaanTugasData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    tanggalKejadian = json['tanggal_kejadian'];
    mPosId = json['m_pos_id'];
    mSipamId = json['m_sipam_id'];
    mShiftId = json['m_shift_id'];

    if (json['waktu_uraian_tugas'] != null) {
      waktuUraianTugas = List<WaktuUraianTugas>.from(json['waktu_uraian_tugas']
          .map((waktuUraianTugasJson) =>
              WaktuUraianTugas.fromJson(waktuUraianTugasJson)));
    } else {
      waktuUraianTugas = [];
    }

    if (json['inventaris_pos'] != null) {
      inventarisPos = List<InventarisPos>.from(json['inventaris_pos'].map(
          (inventarisPosJson) => InventarisPos.fromJson(inventarisPosJson)));
    } else {
      inventarisPos = [];
    }

    keterangan = json['keterangan'];
  }
}

class WaktuUraianTugas {
  late String waktu;
  late String uraianTugas;

  WaktuUraianTugas({
    required this.waktu,
    required this.uraianTugas,
  });

  WaktuUraianTugas.fromJson(Map<String, dynamic> json) {
    waktu = json['waktu'];
    uraianTugas = json['uraian_tugas'];
  }
}

class InventarisPos {
  late int mBarangInventarisId;
  late int jumlah;
  late String keterangan;

  InventarisPos({
    required this.mBarangInventarisId,
    required this.jumlah,
    required this.keterangan,
  });

  InventarisPos.fromJson(Map<String, dynamic> json) {
    mBarangInventarisId = json['m_barang_inventaris_id'];
    jumlah = json['jumlah'];
    keterangan = json['keterangan'];
  }
}
