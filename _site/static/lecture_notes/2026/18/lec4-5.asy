if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="lec4-5";
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

pair O1, O2, O;
real R, r1, r2;
R = 4; r1 = R / 3; r2 = R / 2.414;

O = origin; O1 = O + (R - r1) * dir(150); O2 = O + (R - r2) * dir(45);
dot("$O$", O, dir(225)); dot("$O_1$", O1, dir(60)); dot("$O_2$", O2, dir(130));

draw(circle(O, R));
draw(circle(O1, r1)); draw(circle(O2, r2));

pair A, B; A = (-4, 0); B = (4, 0);
dot("$A$", A, dir(180)); dot("$B$", B, dir(0)); draw(A--B);

pair C, D;
C = O1 + r1 * dir(270); D = O2 + r2 * dir(270);

pair E, F;
E = O1 + r1 * dir(150); F = O2 + r2 * dir(45);

dot("$C$", C, dir(225)); dot("$D$", D, dir(315));
dot("$E$", E, dir(135)); dot("$F$", F, dir(45));

draw(E--O, heavygray); draw(F--O, heavygray);

pair X = O + R * dir(270);
dot("$X$", X, dir(225));

draw(E--X, gray); draw(F--X, gray);
draw(circumcircle(E, C, D), heavygray+dashed); draw(O--X); markrightangle(X, O, B, 7);
draw(O1--C); draw(O2--D); markrightangle(O, C, O1, 6); markrightangle(O2, D, O, 6);
