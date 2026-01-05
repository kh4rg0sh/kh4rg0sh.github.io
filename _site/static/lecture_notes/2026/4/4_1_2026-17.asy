if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="4_1_2026-17";
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
size(7cm); defaultpen(fontsize(10pt));
pair A, B, C, O, X, I, M_A;

A=dir(135); B=dir(210); C=dir(330);
O = circumcenter(A, B, C); M_A = (B+C)/2;
X = extension(B,B+rotate(90)*(B-O), O, M_A);
pair[] KK = intersectionpoints(A--X, circumcircle(A, B, C));
I = incenter(A, B, C);

pair[] MM = intersectionpoints(line(X, O), circumcircle(A, B, C));

dot("$A$", A, dir(A)); dot("$B$", B, dir(225)); dot("$C$", C, dir(315));
dot("$F$", KK[1], dir(225)); dot("$E$", MM[0], dir(315));
draw(circumcircle(A, B, C)); draw(A--B--C--cycle);

pair D = extension(A, MM[0], B, C);
dot("$D$", D, dir(60)); draw(A--MM[0]); draw(circumcircle(D, MM[0], KK[1]));
draw(A--KK[1]); dot("$O$", O, dir(40));
dot("$M$", M_A, dir(50)); dot("$N$", MM[1], dir(75));
draw(MM[0]--MM[1]); draw(D--KK[1]); draw(D--MM[1], dashed); draw(KK[1]--MM[0]);
markrightangle(MM[0], KK[1], MM[1], 7);
markrightangle(D, M_A, MM[0], 7); draw(A--MM[1]);
markrightangle(MM[0], A, MM[1], 7);
draw(circumcircle(A, D, M_A), heavygray+dashed);
