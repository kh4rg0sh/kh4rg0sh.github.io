if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="monge-6";
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
size(14cm); defaultpen(fontsize(10pt));

pair A, B, C, D, P, Q, R, S, O, Ia, Ib, Ic, Id, I, E, F, G, H, X, Y, Z;
pair M = (-0.8, 1), N = reflect((0, 0), (1, 0)) * M;
real ra, rb, rc, rd;
O = origin;
Ia = 0.6 * (0, 1); Ib = 0.6 * (-1, 0); Ic = 0.9 * (0, -1); Id = 1.0 * (1, 0);
ra = abs(foot(Ia, O, M)-Ia); rb = abs(foot(Ib, O, M)-Ib);
rc = abs(foot(Ic, O, M)-Ic); rd = abs(foot(Id, O, M)-Id);

P = extension(O, M, reflect(Ia, Ib) * O, reflect(Ia, Ib) * N);
Q = extension(O, N, reflect(Ib, Ic) * O, reflect(Ib, Ic) * M);
R = extension(O, M, reflect(Ic, Id) * O, reflect(Ic, Id) * N);
S = extension(O, N, reflect(Id, Ia) * O, reflect(Id, Ia) * M);

A = extension(P, reflect(P, Ia) * O, S, reflect(S, Ia) * O);
B = extension(Q, reflect(Q, Ib) * O, P, reflect(P, Ib) * O);
C = extension(R, reflect(R, Ic) * O, Q, reflect(Q, Ic) * O);
D = extension(S, reflect(S, Id) * O, R, reflect(R, Id) * O);

E = extension(A, B, Q, S);
F = extension(B, C, P, R);
G = extension(C, D, Q, S);
H = extension(D, A, P, R);
X = extension(E, F, G, H);
Y = extension(E, H, F, G);
Z = extension(F, S, P, G);

I = extension(B, incenter(A, B, C), D, incenter(A, D, C));

draw(circle(Ia, ra)^^circle(Ib, rb)^^circle(Ic, rc)^^circle(Id, rd));
draw(A--B--C--D--cycle);
draw(P--R^^Q--S);
draw(A--E--S^^Q--G--C);
draw(A--H--P^^B--F--P);
draw(G--X^^E--F, dashed);
draw(E--Y^^F--G, dashed);
draw(CP(I, foot(I, A, B)));
draw(C--X^^D--Y, dashed);
draw(F--S^^G--Z, dotted);

dot("$A$", A, dir(120));
dot("$B$", B, dir(260));
dot("$C$", C, dir(300));
dot("$D$", D, dir(D));
dot("$O$", O, dir(270));
dot("$P$", P, dir(90));
dot("$Q$", Q, dir(180));
dot("$R$", R, dir(R));
dot("$S$", S, dir(100));
dot("$E$", E, dir(E));
dot("$F$", F, dir(F));
dot("$G$", G, dir(G));
dot("$H$", H, dir(90));
dot("$X$", X, dir(X));
dot("$Y$", Y, dir(Y));
dot(Z);
