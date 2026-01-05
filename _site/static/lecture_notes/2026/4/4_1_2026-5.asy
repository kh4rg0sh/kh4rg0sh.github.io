if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="4_1_2026-5";
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

size(7cm); defaultpen(fontsize(10pt));
pair A, B, C, O, I;

A = dir(135); B = dir(200); C = dir(340);
I = incenter(A,B,C); O = origin;

dot("$A$", A, dir(A)); dot("$B$", B, dir(225)); dot("$C$", C, dir(315));
dot("$O$", O, dir(45)); dot("$I$", I, dir(65));
draw(circumcircle(A, B, C)); draw(A--B--C--cycle);

pair MM[] = intersectionpoints(line(A, I), circumcircle(A, B, C));
pair NN[] = intersectionpoints(line(MM[0], O), circumcircle(A, B, C));
dot("$M$", MM[0], dir(315)); dot("$M'$", NN[1], dir(45));
draw(A--MM[0]); draw(MM[0]--NN[1]); draw(A--NN[1]);
markrightangle(MM[0], A, NN[1]); draw(I--O);
