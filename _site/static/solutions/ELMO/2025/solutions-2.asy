if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="solutions-2";
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

pair A, B, C, O, H, BB, CC, M, N, P, D, E, F, X;
A = dir(110); B = dir(220); C = dir(320);
H = orthocenter(A, B, C);
M = (B+C)/2; N = (C+A)/2; P=(A+B)/2;
D = extension(A, H, B, C); E = extension(B, H, C, A); F = extension(C, H, A, B);
CC = 2 * F - C; BB = 2 * E - B;

pair v1 = rotate(90)*(BB - B);
pair v2 = rotate(90)*(CC - C);
X = extension(BB, BB + v1, CC, CC + v2);


dot("$O$", A, dir(60)); dot("$A$", B, dir(B)); dot("$B$", C, dir(C));
dot("$C$", BB, dir(35)); dot("$D$", CC, dir(155)); dot("$P$", X, dir(95));

draw(B--C--BB--X--CC--cycle); draw(BB--CC); draw(B--BB); draw(C--CC);
markrightangle(X, BB, B, 7); markrightangle(C, CC, X, 7); dot("$M$", M, dir(315));

draw(A--X);
draw(M--A, heavygray+dashed); draw(A--B, gray); draw(A--C, gray);
draw(B--X, gray); draw(C--X, gray);
draw(A--CC, gray); draw(A--BB, gray);

draw(circle(A, abs(A-D)), gray+dotted);
