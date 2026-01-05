if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="feuerbach_theorem-6";
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
size(11cm); defaultpen(fontsize(11pt));

pair A, B, C, O;
A = dir(160); B = dir(215); C = dir(325);
dot("$A$", A, dir(A)); dot("$B$", B, dir(210)); dot("$C$", C, dir(335));

draw(A--B--C--cycle);
draw(circumcircle(A, B, C));

pair D, E, F, I;
I = incenter(A, B, C); D = foot(I, B, C); E = foot(I, A, C); F = foot(I, A, B);
pair Dp, Ep, Fp;
Dp = reflect(A, I) * D;
Ep = reflect(B, I) * E;
Fp = reflect(C, I) * F;

pair Ma, Mb, Mc;
Ma = (B + C) / 2; Mb= (C + A) / 2; Mc = (A + B) / 2;
pair Mar = reflect(A, I) * Ma;

draw(incircle(A, B, C));
dot("$D$", D, dir(240)); dot("$E$", E, dir(45)); dot("$F$", F, dir(165));
dot("$D'$", Dp, dir(355));
dot("$M_A$", Ma, dir(315));
dot("$M_A'$", Mar, dir(320));

dot("$I$", I, dir(80));
dot("$O$", O, dir(30));
draw(D--E--F--cycle);

pair[] TT = intersectionpoints(line(Ma, Dp), circumcircle(D, E, F));
pair[] TTr = intersectionpoints(line(Mar, D), circumcircle(D, E, F));

dot("$T$", TT[1], dir(60));
dot("$T'$", TTr[1], dir(140));

draw(Mar--TTr[1]);
draw(Ma--TT[1], gray+dashed);
draw(I--O); draw(D--TT[1], lightgray);
draw(A--I, lightgray);

pair Ft = foot(O, D, TTr[1]);
draw(I--Ft, gray+dotted);
markrightangle(D, Ft, I, 7);
