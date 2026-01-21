if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="2024g2-1";
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

defaultpen(fontsize(11pt));
size(9cm);

pair A, B, C, D, K, L, I, X, Y, J, P, Q, R, S;
A = dir(110);
B = dir(200);
C = dir(340);
I = incenter(A, B, C);
K = (A+C)/2;
L = (A+B)/2;
J = 2*I-A;
D = extension(A, I, B, C);
X = extension(B, C, J, J+A-C);
Y = extension(B, C, J, J+A-B);
P = dir(270);
Q = IP(A--(2*A-P), circumcircle(B, J, C));
R = extension(J, X, A, B);
S = extension(J, Y, A, C);
draw(A--B--C--cycle);
draw(circumcircle(A, B, C));
draw(incircle(A, B, C));
draw(R--J--S);
draw(Y--P--X, gray);
draw(B--J--C, heavygray);
draw(K--I--L--cycle, heavygray);
draw(A--P); draw(circumcircle(B, P, X), heavygray+dashed);
draw(circumcircle(C, P, Y), heavygray+dashed);

dot("$A$", A, dir(130));
dot("$B$", B, dir(B));
dot("$C$", C, dir(C));
dot("$P$", P, dir(220));
dot("$I$", I, dir(210));
dot("$A'$", J, dir(200));
dot("$D$", D, dir(240));
dot("$X$", X, dir(240));
dot("$Y$", Y, dir(320));
dot("$L$", L, dir(150));
dot("$K$", K, dir(40));

