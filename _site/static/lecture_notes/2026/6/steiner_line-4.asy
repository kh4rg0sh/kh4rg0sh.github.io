if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="steiner_line-4";
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
size(10cm); defaultpen(fontsize(10pt));

pair A, B, C, P, O;
O = origin;
A = dir(110); B = dir(200); C = dir(340);

P = dir(60);
dot("$A$", A, dir(145)); dot("$B$", B, dir(225)); dot("$C$", C, dir(315));
dot("$P$", P, dir(55));

pair X, Y, Z;
X = reflect(B, C) * P; Y = reflect(C, A) * P; Z = reflect(A, B) * P;

dot("$A$", A, dir(155)); dot("$B$", B, dir(225)); dot("$C$", C, dir(315));
dot("$P$", P, dir(55)); dot("$X$", X, dir(280)); dot("$Y$", Y, dir(225)); dot("$Z$", Z, dir(100));

draw(A--B--C--cycle);
draw(unitcircle);
draw(X--Z, red); draw(P--C, gray); draw(P--A, gray);

draw(P--X, gray+dashed); draw(P--Y, gray+dashed); draw(P--Z, gray+dashed);

pair Xr, Yr, Zr;
Xr = foot(P, B, C); Yr = foot(P, C, A); Zr = foot(P, A, B);

markrightangle(C, Xr, P); markrightangle(C, Yr, P); markrightangle(B, Zr, P);
draw(A--Zr, gray(0.65)+dashed);

pair I = incenter(A, B, C);
draw(A--reflect(A, I) * P, green);
draw(B--reflect(B, I) * P, green);
draw(C--reflect(C, I) * P, green);

pair T, U, V;
T = extension(A, reflect(A, I) * P, X, Z);
U = extension(B, reflect(B, I) * P, X, Z);
V = extension(C, reflect(C, I) * P, X, Z);

markrightangle(A, T, Z);
markrightangle(B, U, X);
markrightangle(X, V, C);
