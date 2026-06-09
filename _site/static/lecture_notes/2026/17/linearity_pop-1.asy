if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="linearity_pop-1";
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
size(9cm); defaultpen(fontsize(10pt));

pair A,B,C,D,O,P,Q,X,Y,S,T,M;

O = (0,0);
A = dir(120);
B = dir(210);
C = dir(330);
D = dir(60);
S = foot(O,A,D);
M = (B+C)/2;
T = (A+M)/2;
P = intersectionpoint(circumcircle(A,B,C),S--S+dir(T--S)*100);
Q = intersectionpoint(circumcircle(A,B,C),S--S+dir(S--T)*100);
Y = intersectionpoint(circumcircle(O,P,Q),O--O+dir(O--S)*100);
X = extension(A,Y,B,C);

draw(A--B--C--cycle);
draw(circumcircle(O,X,Y));
draw(circumcircle(A,B,C));
draw(Y--X);
draw(A--M);
draw(Y--M);
draw(X--B);

dot("$O$",O, dir(340));
dot("$A$",A,dir(120));
dot("$B$",B,dir(245));
dot("$C$",C,dir(-35));
dot("$M$",M,dir(-60));
dot("$X$",X,dir(-145));
dot("$Y$",Y,dir(45));
dot("$N$",T,dir(180));

markrightangle(O, M, X, 7); markrightangle(X, A, O, 7);
draw(A--O); draw(arc(circumcircle(A, O, M), -20, 200), heavygray+dashed);
