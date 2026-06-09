if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="lec4-21";
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
size(12cm); defaultpen(fontsize(12pt));

pair A, B, C, I;

A = dir(130);
B = dir(200);
C = dir(340);
I = incenter(A, B, C);

pair D, E, F;
D = foot(I, B, C);
E = foot(I, C, A);
F = foot(I, A, B);

dot("$A$", A, dir(130));
dot("$B$", B, dir(225));
dot("$C$", C, dir(315));
dot("$D$", D, dir(225));
dot("$E$", E, dir(45));
dot("$F$", F, dir(135));
dot("$I$", I, dir(0));

draw(A--B--C--cycle);
draw(circumcircle(A, B, C));
draw(circumcircle(D, E, F));

pair DD = 2 * I - D;
dot("$D'$", DD, dir(45));

pair M = dir(90);
dot("$M$", M, dir(70));

pair HH = orthocenter(D, E, F);
pair R = reflect(E, F) * HH;
dot("$R$", R, dir(130));

pair[] PP = intersectionpoints(line(A, R), circumcircle(D, E, F));
pair P = PP[0]; dot("$P$", P, dir(225));

pair[] TT = intersectionpoints(line(A, R), circumcircle(A, B, C));
pair T = TT[0]; dot("$T$", T, dir(225));

pair K = 2 * T - I;
dot("$K$", K, dir(225));

draw(arc(circumcircle(B, I, C), 20, 220), heavygray+dashed);

pair S = extension(D, I, A, M); dot("$S$", S, dir(120));
pair[] QQ = intersectionpoints(line(K, P), circumcircle(B, F, P));
pair Q = QQ[1]; dot("$Q'$", Q, dir(30));

draw(circumcircle(B, F, P), heavygray);
draw(circumcircle(C, E, P), heavygray);
draw(K--S, blue); draw(I--D); draw(I--S, gray+dashed);
draw(A--M); draw(K--M); draw(D--E--F--cycle, gray); draw(A--T, red); draw(D--R, gray);

pair N = dir(270);
dot("$N$", N, dir(315));
draw(A--N);
draw(N--M);

draw(circumcircle(A, D, S), gray+dashed);
draw(arc(circumcircle(A, I, D), -60, 40), gray+dashed);
draw(arc(circumcircle(R, I, D), -70, 80), gray+dashed);

