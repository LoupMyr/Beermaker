class Recette {
  static String srmToRGB(double srm) {
// Returns an RGB value based on SRM
    double r = 0;
    double g = 0;
    double b = 0;
    if (srm >= 0 && srm <= 1) {
      r = 240;
      g = 239;
      b = 181;
    } else if (srm > 1 && srm <= 2) {
      r = 233;
      g = 215;
      b = 108;
    } else if (srm > 2) {
// Set red decimal
      if (srm < 70.6843) {
        r = 243.8327 - (6.4040 * srm) + (0.0453 * srm * srm);
      } else {
        r = 17.5014;
      }
// Set green decimal
      if (srm < 35.0674) {
        g = 230.929 - 12.484 * srm + 0.178 * srm * srm;
      } else {
        g = 12.0382;
      }
// Set blue decimal
      if (srm < 4) {
        b = -54 * srm + 216;
      } else if (srm >= 4 && srm < 7) {
        b = 0;
      } else if (srm >= 7 && srm < 9) {
        b = 13 * srm - 91;
      } else if (srm >= 9 && srm < 13) {
        b = 2 * srm + 8;
      } else if (srm >= 13 && srm < 17) {
        b = -1.5 * srm + 53.5;
      } else if (srm >= 17 && srm < 22) {
        b = 0.6 * srm + 17.8;
      } else if (srm >= 22 && srm < 27) {
        b = -2.2 * srm + 79.4;
      } else if (srm >= 27 && srm < 34) {
        b = -0.4285 * srm + 31.5714;
      } else {
        b = 17;
      }
    }
    int red = r.toInt();
    int green = g.toInt();
    int blue = b.toInt();
    String rr = red.toRadixString(16);
//red.toHexString(red);
    String gg = green.toRadixString(16);
    String bb = blue.toRadixString(16);
    String rgb = "0xFF";
    if (rr.length < 2) {
      rr = "0" + rr;
    } else if (gg.length < 2) {
      gg = "0" + gg;
    } else if (bb.length < 2) {
      bb = "0" + bb;
    }
    rgb = rgb + rr + gg + bb;
    return rgb;
  }
}
