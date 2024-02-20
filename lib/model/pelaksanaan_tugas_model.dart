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
