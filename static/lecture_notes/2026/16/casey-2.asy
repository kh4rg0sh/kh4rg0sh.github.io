if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="casey-2";
if(settings.render < 0) settings.render=4;
settings.outformat="";
settings.inlineimage=true;
settings.embed=true;
settings.toolbar=false;
viewportmargin=(2,2);

defaultpen(fontsize(10pt));
size(8cm); // set a reasonable default
usepackage("amsmath");
usepackage("amssymb");
settings.tex="pdflatex";
settings.outformat="pdf";
// Replacement for olympiad+cse5 which is not standard
import geometry;
// recalibrate fill and filldraw for conics
void filldraw(picture pic = currentpicture, conic g, pen fillpen=defaultpen, pen drawpen=defaultpen)
{ filldraw(pic, (path) g, fillpen, drawpen); }
void fill(picture pic = currentpicture, conic g, pen p=defaultpen)
{ filldraw(pic, (path) g, p); }
// some geometry
pair foot(pair P, pair A, pair B) { return foot(triangle(A,B,P).VC); }
pair centroid(pair A, pair B, pair C) { return (A+B+C)/3; }
// cse5 abbreviations
path CP(pair P, pair A) { return circle(P, abs(A-P)); }
path CR(pair P, real r) { return circle(P, r); }
pair IP(path p, path q) { return intersectionpoints(p,q)[0]; }
pair OP(path p, path q) { return intersectionpoints(p,q)[1]; }
path Line(pair A, pair B, real a=0.6, real b=a) { return (a*(A-B)+A)--(b*(B-A)+B); }
// cse5 more useful functions
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
pair Drawing(Label s = "", pair A, pair B = plain.S, pen p = defaultpen) {
dot(MP(s, A, B, p), p);
return A;
}
path Drawing(path g, pen p = defaultpen, arrowbar ar = None) {
draw(g, p, ar);
return g;
}

import geometry;
size(6cm); defaultpen(fontsize(10pt));

pair O, O1;
real R, r;
R = 4; r = 2.2;

O = origin; O1 = O + (R - r) * dir(45);
draw(circle(O, R)); draw(circle(O1, r));

pair K = O1 + r * dir(270); dot("$K$", K, dir(305));
pair P1 = K - rotate(90) * (O1 - K);
pair P2 = K + rotate(90) * (O1 - K);

pair[] AA = intersectionpoints(line(P1, P2), circle(O, R));
dot("$B$", AA[0], dir(225)); dot("$C$", AA[1], dir(315));

pair A = R * dir(98); dot("$A$", A, dir(100));
pair T = O1 + r * dir(45); dot("$T$", T, dir(45));
pair M = O + R * dir(270);

pair I = incenter(A, AA[0], AA[1]);

pair[] LL = intersectionpoints(line(K, I), circle(O1, r));
dot("$L$", LL[0], dir(150));

pair D = extension(A, LL[0], AA[0], AA[1]);
dot("$D$", D, dir(225));

draw(A--AA[0]--AA[1]--cycle); draw(A--D);

dot("$I$", I, dir(45));

pair E = extension(A, I, AA[0], AA[1]);
dot("$E$", E, dir(225));

draw(K--LL[0], heavygray+dashed);
draw(A--E);
