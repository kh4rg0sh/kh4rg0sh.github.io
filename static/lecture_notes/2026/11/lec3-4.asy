if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="lec3-4";
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

pair A, B, C, A1, B1, C1, D, A2, H;
A = dir(120);
B = dir(210);
C = dir(330);
B1 = foot(B, C, A);
C1 = foot(C, A, B);
A1 = foot(A, B, C);
D = .5B + .5C;
A2 = extension(B1, C1, B, C);
H = orthocenter(A, B, C);

draw(A--B--C--cycle);
draw(circumcircle(B, C, A));
draw(A2--B); draw(A2--B1);
draw(C--C1); draw(B--B1);

pair DD = foot(D, A, A2); draw(A--A1);
draw(A--A2); draw(D--DD, gray+dashed);
markrightangle(D, DD, A, 7);
markrightangle(B, C1, C, 7);
markrightangle(B, B1, C, 7);
markrightangle(C, A1, A, 7);

dot("$A$", A, N);
dot("$B$", B, SW);
dot("$C$", C, SE);
dot("$A_1$", A1, SW);
dot("$B_1$", B1, NE);
dot("$C_1$", C1, NW);
dot("$A_2$", A2, S);
dot("$D$", D, S);
dot("$H$", H, dir(310));
dot("$A_3$", DD, NW);

draw(circumcircle(A, D, A1), heavygray+dashed);
draw(circumcircle(A1, B1, C1), heavygray+dashed);
draw(circumcircle(B, C, B1), gray+dotted);
draw(circumcircle(A, B1, C1), gray+dotted);
