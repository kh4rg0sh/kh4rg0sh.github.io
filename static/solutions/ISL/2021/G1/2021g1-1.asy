if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="2021g1-1";
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

pair A, B, C, D, E, P, Q, R, S, T;
A = (0, 0); B = (3, 0); P = (4.3, 0); C = (1.5, 3.8); D = C + (A - B);
pair[] QQ = intersectionpoints(line(D, P), circumcircle(A, C, D));
pair[] RR = intersectionpoints(line(C, P), circumcircle(A, QQ[0], P));

T = extension(C, D, A, QQ[0]);

draw(A--B--C--D--cycle);
draw(B--P); draw(A--RR[1]);
draw(P--D); draw(A--C);
draw(C--T); draw(A--T);
draw(P--C); draw(B--T, gray+dashed); draw(C--QQ[0], gray);
draw(circumcircle(A, P, QQ[0])); draw(circumcircle(A, C, D));

dot("$A$", A, dir(210)); dot("$B$", B, dir(315));
dot("$C$", C, dir(105)); dot("$D$", D, dir(135));
dot("$P$", P, dir(330)); dot("$Q$", QQ[0], dir(295));
dot("$T$", T, dir(45)); dot("$R$", RR[1], dir(0));

draw(circumcircle(A, B, C), heavygray+dashed);
draw(circumcircle(C, T, RR[1]), heavygray+dashed);
