if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="lec4-20";
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

pair A, B, C, O, N, I, E, F, IA;
O = origin; A = dir(120); B = dir(210);
C = dir(330); N = dir(90); I = incenter(A, B, C);
E = dir(45); F = dir(165); IA = excenter(C, B, A);

pair A1 = rotate(90, I) * A;
pair B1 = extension(I, A1, A, B);
pair C1 = extension(I, A1, A, C);

pair[] TT = intersectionpoints(line(N, I), circumcircle(A, B, C));
pair T = TT[0];

dot("$C$", A, dir(89));
dot("$A$", B, dir(225));
dot("$B$", C, dir(315));
dot("$P$", T, dir(250));
dot("$I$", I, dir(180));

draw(A--B--C--cycle);
draw(circumcircle(A, B, C));
draw(circumcircle(T, B1, C1));

pair X = foot(IA, B, C);
dot("$X$", X, dir(270));
draw(A--T);

dot("$N$", N, dir(115));
pair[] QQ = intersectionpoints(line(A, X), circumcircle(T, B1, C1));
dot("$Q$", QQ[1], dir(35)); draw(T--N, heavygray+dashed); draw(A--X, heavygray+dashed);

pair M = dir(270);
dot("$M$", M, dir(225));
draw(A--M);

pair I1 = circumcenter(T, B1, C1);
dot("$I_1$", I1, dir(20));
draw(arc(circumcircle(T, A, I1), -90, 90), gray+dashed);
draw(I1--QQ[1], gray); draw(M--N, gray);
