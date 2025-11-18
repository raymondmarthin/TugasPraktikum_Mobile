class Hewan {
  String nama;
  double berat;

  Hewan(this.nama, this.berat);

  String makan(Hewan hewan, double porsi) {
    hewan.berat += porsi/1000;
    return '${hewan.nama} telah makan sebanyak $porsi gram';
  }

  String lari(Hewan hewan, double kg) {
    hewan.berat -= kg/1000;
    return ('${hewan.nama} telah berlari dan kehilangan ${kg/1000} kg');
  }
}

