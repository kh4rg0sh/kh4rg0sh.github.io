if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="casey-3";
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
size(9cm); defaultpen(fontsize(11pt));

pair A, B, C, I, Ia, E, F, D, M, O;

A = dir(120);
B = dir(220);
C = dir(320);

I = incenter(A, B, C);
Ia = excenter(B, C, A);
D = foot(Ia, B, C);
E = foot(Ia, A, B);
F = foot(Ia, A, C);
M = (A + D) / 2;
O = (A + Ia) / 2;

pair[] PP = intersectionpoints(line(B, C), circumcircle(A, E, F));
pair P = PP[0]; pair Q = PP[1];

dot("$A$", A, dir(130));
dot("$B$", B, dir(225));
dot("$C$", C, dir(315));
dot("$D$", D, dir(225));
dot("$E$", E, dir(215));
dot("$F$", F, dir(315));
dot("$I_A$", Ia, dir(315));
dot("$M$", M, dir(45));
dot("$O$", O, dir(225));
dot("$P$", P, dir(225));
dot("$Q$", Q, dir(315));

draw(A--B--C--cycle);
draw(B--E); draw(C--F);
draw(A--D); draw(A--Ia);
draw(Ia--E); draw(Ia--F);
draw(Ia--D); draw(O--M);
draw(M--P); draw(M--Q);
draw(P--B); draw(C--Q);
draw(A--P); draw(P--Ia);
draw(A--Q); draw(Q--Ia);

draw(circumcircle(A, E, F));
draw(arc(circumcircle(M, P, Q), 0, 180), heavygray+dashed);
markrightangle(Ia, E, A, 7);
markrightangle(A, F, Ia, 7);
markrightangle(Ia, D, C, 7);
markrightangle(Ia, P, A, 7);
markrightangle(A, Q, Ia, 7);
