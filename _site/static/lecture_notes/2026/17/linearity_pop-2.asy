if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="linearity_pop-2";
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

pair A, B, C, M, D, E, F;
A = dir(120); B = dir(210); C = dir(330);
M = (B + C) / 2; D = (0.7 * B + 0.3 * C);
pair[] EE = intersectionpoints(line(A, B), circumcircle(A, D, C));
pair[] FF = intersectionpoints(line(A, C), circumcircle(A, B, D));

dot("$A$", A, dir(120));
dot("$B$", B, dir(230));
dot("$C$", C, dir(310));
dot("$M$", M, dir(310));
dot("$D$", D, dir(265));
dot("$E$", EE[0], dir(190));
dot("$F$", FF[0], dir(40));

draw(A--B--C--cycle);
draw(circumcircle(A, D, C), heavygray);
draw(circumcircle(A, D, B), heavygray);
draw(circumcircle(A, EE[0], FF[0]), heavygray+dashed);

pair[] XX = intersectionpoints(line(A, M), circumcircle(A, EE[0], FF[0]));
dot("$X$", XX[0], dir(250)); draw(A--M); draw(circumcircle(A, B, C));
