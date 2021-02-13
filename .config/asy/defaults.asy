import config_private;

usepackage("amsmath");
usepackage("amssymb");

defaultpen(fontsize(10pt));

import geometry;

path CP(pair P, pair A) { return circle(P, abs(A-P)); }
path CR(pair P, real r) { return circle(P, r); }
pair IP(path p, path q) { return intersectionpoints(p,q)[0]; }
pair OP(path p, path q) { return intersectionpoints(p,q)[1]; }
path Line(pair A, pair B, real a=0.6, real b=a) { return (a*(A-B)+A)--(b*(B-A)+B); }
picture CC() {
    picture p=rotate(0)*currentpicture;
    currentpicture.erase();
    return p;
}
pair MP(Label s, pair A, pair B = plain.S, pen p = defaultpen) {
    Label L = s;
    L.s = "$"+s.s+"$";
    label(L, A, B, p);
    return A;
}

file defaults_local = input(asy_home+"/defaults.asy.local", check=false);
if (!error(defaults_local)) {
    eval("import "+asy_home+"/defaults.asy.local", true);
}
close(defaults_local);
