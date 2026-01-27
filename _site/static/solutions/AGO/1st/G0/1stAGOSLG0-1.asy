if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="1stAGOSLG0-1";
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

pair A, B, C, O;
O = origin;
A = dir(121);
B = dir(215);
C = dir(325);

pair BB = rotate(90, B) * O;
pair CC = rotate(90, C) * O;

pair S = extension(B, BB, C, CC);
pair M = (B + C) / 2;
pair N = (A + S) / 2;
pair D = foot(A, B, C);
pair MM = 2 * N - M;

dot("$A$", A, dir(140));
dot("$B$", B, dir(225));
dot("$C$", C, dir(315));
dot("$S$", S, dir(225));
dot("$D$", D, dir(225));
dot("$M$", M, dir(315));
dot("$N$", N, dir(45));
dot("$M'$", MM, dir(135));

draw(A--B--C--cycle);
draw(circumcircle(A, B, C));
draw(B--S); draw(C--S);
draw(A--S); draw(A--D);
draw(M--S); draw(N--S);
draw(M--MM); markrightangle(C, D, A, 7); draw(N--D);
draw(arc(circumcircle(D, MM, M), -230, -10), heavygray+dashed);
