if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="feuerbach_theorem-2";
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
size(10cm); defaultpen(fontsize(10pt));

pair A, B, C, O, M_A, M_B, M_C, H, H_A, H_B, H_C, E_A, E_B, E_C;
A = dir(110); B = dir(190); C = dir(350);

M_A = (B + C) / 2; M_B = (C + A) / 2; M_C = (A + B) / 2;
H_A = foot(A, B, C); H_B = foot(B, A, C); H_C = foot(C, A, B); H = extension(A, H_A, B, H_B);

E_A = (A + H) / 2; E_B = (B + H) / 2; E_C = (C + H) / 2;

dot("$A$", A, dir(A)); dot("$B$", B, dir(210)); dot("$C$", C, dir(335));
dot("$M_A$", M_A, dir(315)); dot("$M_B$", M_B, dir(45)); dot("$M_C$", M_C, dir(135));
dot("$H_A$", H_A, dir(225)); dot("$H_B$", H_B, dir(60)); dot("$H_C$", H_C, dir(120));
dot("$E_A$", E_A, dir(55)); dot("$E_B$", E_B, dir(335)); dot("$E_C$", E_C, dir(205)); dot("$H$", H, dir(20));

draw(A--B--C--cycle); draw(circumcircle(M_A, M_B, M_C));
draw(A--H_A); draw(B--H_B); draw(C--H_C);
