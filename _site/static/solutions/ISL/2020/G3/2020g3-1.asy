if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="2020g3-1";
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
size(12cm); defaultpen(fontsize(12pt));

pair A, B, C, D, P;
B = (3, 0); D = (-3, 0); A = (-0.8, -4);

P = reflect(B, D) * A;

pair O = circumcenter(B, P, D);
C = O + abs(B - O) * dir(80);

dot("$A$", A, dir(225));
dot("$B$", B, dir(315));
dot("$C$", C, dir(85));
dot("$D$", D, dir(225));
dot("$P$", P, dir(155));

draw(circumcircle(B, P, D));
draw(A--B--C--D--cycle);

pair E, F, K, L, X;
E = reflect(B, C) * A;
F = reflect(C, D) * A;
K = extension(B, D, A, E);
L = extension(A, F, B, D);

dot("$K$", K, dir(325));
dot("$L$", L, dir(225));
dot("$E$", E, dir(315));
dot("$F$", F, dir(135));

draw(A--F); draw(A--E); draw(K--L); draw(A--C);
draw(F--D); draw(B--E); draw(C--F); draw(C--E);

pair DD = foot(D, A, F);
draw(D--DD, gray+dotted); markrightangle(A, DD, D, 7);

pair BB = foot(B, A, E);
draw(B--BB, gray+dotted); markrightangle(B, BB, A, 7);

draw(B--P, gray); draw(D--P, gray); draw(A--P, gray+dotted);
pair AA = foot(A, B, D); markrightangle(B, AA, P, 7);

pair P1 = reflect(C, D) * P; pair P2 = reflect(B, C) * P;
draw(A--P2, red);

draw(arc(circumcircle(F, D, P), -190, 40), heavygray+dashed);
draw(arc(circumcircle(P, B, E), -180, -30), heavygray+dashed);

X = extension(A, P2, B, D);
dot("$X$", X, dir(315)); draw(X--P, red);
