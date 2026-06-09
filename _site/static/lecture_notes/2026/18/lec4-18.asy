if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="lec4-18";
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

pair A, B, C, O, N, I, E, F;
O = origin; A = dir(120); B = dir(210);
C = dir(330); N = dir(90); I = incenter(A, B, C);
E = dir(45); F = dir(165);

pair A1 = rotate(90, I) * A;
pair B1 = extension(I, A1, A, B);
pair C1 = extension(I, A1, A, C);

pair[] TT = intersectionpoints(line(N, I), circumcircle(A, B, C));
pair T = TT[0];

dot("$A$", A, dir(130));
dot("$B$", B, dir(225));
dot("$C$", C, dir(315));
dot("$T$", T, dir(250));
dot("$B_1$", B1, dir(150));
dot("$C_1$", C1, dir(5));
dot("$I$", I, dir(300));

draw(A--B--C--cycle);
draw(circumcircle(A, B, C));
draw(circumcircle(T, B1, C1));
draw(B1--C1, gray);
draw(A--I); markrightangle(C1, I, A, 7);
draw(B--T); draw(C--T); draw(A--T);

pair P = extension(A, T, B1, C1);

dot("$P$", P, dir(130));
draw(B--P); draw(C--P);
