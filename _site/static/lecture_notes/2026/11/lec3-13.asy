if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="lec3-13";
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

pair A, B, C, H, O, K, D, E, X, Y, P;
O = origin;

A = dir(110); B = dir(210); C = dir(330);

dot("$A$", A, dir(120)); dot("$B$", B, dir(210)); dot("$C$", C, dir(330));
dot("$O$", O, dir(45)); draw(A--B--C--cycle); draw(circumcircle(A, B, C));

D = foot(A, B, C); E = foot(B, A, C);
H = extension(A, D, B, E); K = (A + H) / 2;

X = reflect(B, C) * H; Y = reflect(A, C) * H;
dot("$X$", X, dir(225)); dot("$Y$", Y, dir(45)); dot("$H$", H, dir(135));
dot("$D$", D, dir(225)); dot("$E$", E, dir(75)); draw(A--X); draw(B--Y);
dot("$K$", K, dir(135)); draw(circumcircle(B, X, E), dashed);

path C1 = circumcircle(B, X, E);
pair[] PP = intersectionpoints(line(A, C), C1);

dot("$P$", PP[0], dir(40)); draw(O--PP[0]);
draw(B--K); draw(K--PP[0]); draw(X--PP[0]);
