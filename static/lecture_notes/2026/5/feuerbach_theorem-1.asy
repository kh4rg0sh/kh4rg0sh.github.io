if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="feuerbach_theorem-1";
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
size(12.5cm); defaultpen(fontsize(10pt));

pair A, B, C, I, O, I_A, I_B, I_C, M_A, M_B, M_C;
A = dir(110); B = dir(185); C = dir(355);

O = origin; I = incenter(A, B, C);
I_A = excenter(B, C, A); I_B = excenter(C, A, B); I_C = excenter(A, B, C);
M_A = (B + C) / 2; M_B = (C + A) / 2; M_C = (A + B) / 2;

dot("$A$", A, dir(A)); dot("$B$", B, dir(210)); dot("$C$", C, dir(335));

draw(A--B--C--cycle);
draw(incircle(A, B, C), red); draw(excircle(A, B, C), blue);
draw(excircle(B, C, A), blue); draw(excircle(C, A, B), blue);
draw(circumcircle(M_A, M_B, M_C));

pair X_1, X_2, X_3, X_4, X_5, X_6;
X_1 = foot(I_A, A, B); X_2 = foot(I_A, A, C);
X_3 = foot(I_B, B, C); X_4 = foot(I_B, A, B);
X_5 = foot(I_C, A, C); X_6 = foot(I_C, B, C);

draw(B--X_1, gray); draw(C--X_2, gray); draw(C--X_3, gray); draw(A--X_4, gray); draw(A--X_5, gray); draw(B--X_6, gray);

pair D = foot(I, B, C); pair Dp = reflect(A, I) * D;
pair FF[] = intersectionpoints(line(M_A, Dp), circumcircle(M_A, M_B, M_C));

dot("$Fe$", FF[1], dir(45));

pair[] Fa, Fb, Fc;
Fa = intersectionpoints(circumcircle(M_A, M_B, M_C), excircle(B, C, A));
Fb = intersectionpoints(circumcircle(M_A, M_B, M_C), excircle(C, A, B));
Fc = intersectionpoints(circumcircle(M_A, M_B, M_C), excircle(A, B, C));

dot("$F_a$", Fa[0], dir(300));
dot("$F_b$", Fb[0], dir(45));
dot("$F_c$", Fc[0], dir(180));
