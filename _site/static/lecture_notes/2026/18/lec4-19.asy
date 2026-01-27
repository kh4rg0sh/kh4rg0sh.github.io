if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="lec4-19";
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
size(8cm); defaultpen(fontsize(10pt));

pair A, B, C, I, D, E, F, G, M;
A = dir(120); B = dir(210); C = dir(330);
I = incenter(A, B, C); M = dir(270);

pair B1 = rotate(90, I) * B;
pair C1 = rotate(90, I) * C;
D = extension(I, C1, B, C);
E = extension(I, B1, B, C);
F = extension(I, C1, A, C);
G = extension(I, B1, A, B);

pair[] TC = intersectionpoints(line(M, D), circumcircle(A, B, C));
pair[] TB = intersectionpoints(line(M, E), circumcircle(A, B, C));

dot("$A$", A, dir(130));
dot("$B$", B, dir(225));
dot("$C$", C, dir(315));
dot("$P$", D, dir(225));
dot("$R$", E, dir(315));
dot("$Q$", F, dir(45));
dot("$S$", G, dir(135));
dot("$M$", M, dir(225));
dot("$T_C$", TC[1], dir(150));
dot("$T_B$", TB[1], dir(30));
dot("$I$", I, dir(0));

draw(A--B--C--cycle); draw(circumcircle(A, B, C));
draw(circumcircle(TC[1], D, F), red);
draw(circumcircle(TB[1], E, G), blue);

draw(M--TC[1]); draw(M--TB[1]);
draw(D--F, red); draw(E--G, blue);

pair A1, B1, C1;
A1 = foot(I, B, C); B1 = foot(I, C, A); C1 = foot(I, A, B);
dot("$D$", A1, dir(225)); dot("$E$", B1, dir(45)); dot("$F$", C1, dir(135));
draw(circumcircle(A1, B1, C1)); draw(I--A1, heavygray); draw(I--B1, heavygray); draw(I--C1, heavygray);
markrightangle(C, A1, I, 7);

pair N = (I + A1) / 2;
dot("$N$", N, dir(20));
