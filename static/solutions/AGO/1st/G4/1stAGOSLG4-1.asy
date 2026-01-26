if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="1stAGOSLG4-1";
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

pair A, B, C, A0, B0, C0, H;
A = dir(120);
B = dir(210);
C = dir(330);
A0 = foot(A, B, C);
B0 = foot(B, A, C);
C0 = foot(C, A, B);
H = orthocenter(A, B, C);

draw(A--B--C--cycle);
draw(A0--B0--C0--cycle);
dot("$A$", A, dir(130));
dot("$B$", B, dir(225));
dot("$C$", C, dir(315));
dot("$A_0$", A0, dir(225));
dot("$B_0$", B0, dir(45));
dot("$C_0$", C0, dir(135));
dot("$I$", H, dir(0));

draw(A0--H); draw(B0--H); draw(C0--H);
draw(circumcircle(A, B0, C0), gray+dashed);
draw(circumcircle(A0, B, C0), gray+dashed);
draw(circumcircle(A0, B0, C), gray+dashed);
