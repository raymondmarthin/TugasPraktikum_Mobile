import 'hewan.dart';

class Kucing extends Hewan {
  String warnaBulu;

  Kucing(String nama, double berat, this.warnaBulu) : super(nama, berat);

  get porsiMakan => null;

  @override
  String makan(Hewan hewan, double porsi) {
    super.makan(hewan, porsi);
    return 'Kucing (${hewan.nama}) sedang makan sebanyak $porsi gram';
  }
}