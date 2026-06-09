if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="steiner_line-1";
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

pair A, B, C, P, O;
O = origin;
A = dir(110); B = dir(200); C = dir(340);

P = dir(60);

pair X, Y, Z;
X = foot(P, B, C); Y = foot(P, C, A); Z = foot(P, A, B);

dot("$A$", A, dir(155)); dot("$B$", B, dir(225)); dot("$C$", C, dir(315));
dot("$P$", P, dir(55)); dot("$X$", X, dir(280)); dot("$Y$", Y, dir(225)); dot("$Z$", Z, dir(100));

draw(A--B--C--cycle);
draw(unitcircle);

draw(P--X); draw(P--Y); draw(P--Z);
draw(A--Z); markrightangle(A, Z, P);
markrightangle(P, Y, A); markrightangle(C, X, P);

draw(circumcircle(P, X, C), gray+dashed);
draw(circumcircle(P, Y, A), gray+dashed);
draw(circumcircle(P, X, Z), gray+dashed);

draw(X--Z, red); draw(P--C, gray); draw(P--A, gray);
