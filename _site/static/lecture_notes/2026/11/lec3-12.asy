if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="lec3-12";
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

pair A, B, C, D, E, F, O, H, X, Q, Ma, Mb, G, M, N;
O = origin;

A = dir(120); B = dir(210); C = dir(330); Ma = (B + C) / 2; Mb = (C + A) / 2; G = extension(A, Ma, B, Mb);
D = foot(A, B, C); E = foot(B, A, C); F = foot(C, A, B);
H = extension(A, D, B, E);

draw(A--B--C--cycle); draw(circumcircle(A, B, C));
dot("$A$", A, dir(120)); dot("$B$", B, dir(230)); dot("$C$", C, dir(310));
dot("$D$", D, dir(290)); dot("$E$", E, dir(45)); dot("$F$", F, dir(135));
dot("$H$", H, dir(15)); dot("$G$", G, dir(15));

pair Dp = 2*Ma - D; pair Ap = A + Dp - D;
dot("$D'$", Dp, dir(260)); dot("$A'$", Ap, dir(60));

pair[] NN = intersectionpoints(line(Ap, G), circumcircle(A, B, C));
pair[] MM = intersectionpoints(line(A, G), circumcircle(A, B, C));

dot("$M$", MM[0], dir(310)); dot("$N$", NN[0], dir(230));

draw(A--MM[0]); draw(Ap--NN[0]); draw(Ap--Dp); draw(A--Ap);
draw(A--D); draw(B--E); draw(C--F);

markrightangle(C, D, A, 7); markrightangle(B, E, C, 7); markrightangle(C, F, A, 7);

dot("$M_A$", Ma, dir(320)); draw(circumcircle(D, MM[0], NN[0]), heavygray+dashed);
draw(circumcircle(D, E, F), gray); draw(circumcircle(MM[0], NN[0], E), gray+dashed);
