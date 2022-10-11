import 'dart:math';

class Calculs {
  static double calcMalt(double litreBiere, double degres) {
    return (litreBiere * degres) / 20;
  }

  static double calcBrassage(double malt) {
    return malt * 2.8;
  }

  static double calcRincage(double litreBiere, double brassage) {
    return (litreBiere * 1.25) - (brassage * 0.7);
  }

  static double calcMcu(double moyenneEbc, double litreBiere) {
    return double.parse(((4.23 * moyenneEbc) / litreBiere).toStringAsFixed(3));
  }

  static double calcAmerisant(litreBiere) {
    return litreBiere * 3;
  }

  static double calcLevure(litreBiere) {
    return litreBiere / 2;
  }

  static double calcEbc(double mcu) {
    return double.parse((2.9396 * (pow(mcu, 0.6859))).toStringAsFixed(3));
  }

  static double calcSrm(ebc) {
    return double.parse((0.508 * ebc).toStringAsFixed(3));
  }
}
