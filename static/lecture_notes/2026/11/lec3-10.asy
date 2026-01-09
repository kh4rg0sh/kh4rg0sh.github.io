if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="lec3-10";
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

pair O1 = (-2,0);
pair O2 = (2,1);
real r1 = 4;
real r2 = 2;

draw(circle(O1, r1));
draw(circle(O2, r2));

pair Dvec = O2 - O1;
real d = length(Dvec);
real theta = acos((r1 - r2)/d)*180/pi;
pair u = Dvec / d;
pair v = rotate(theta)*u;

pair A = O1 + r1 * v;
pair B = O2 + r2 * v;

draw(A--B);
label("$A$", A, dir(A));
label("$B$", B, dir(B));

pair[] circleIntersections = intersectionpoints(circle(O1, r1), circle(O2, r2));
pair M = circleIntersections[0];
pair N = circleIntersections[1];

dot("$M$", M, dir(90));
dot("$N$", N, dir(-70));

pair dirAB = unit(B - A);

pair C = intersectionpoint(M - 1*dirAB -- M - 10*dirAB, circle(O1, r1));
pair D = intersectionpoint(M -- M + 10*dirAB, circle(O2, r2));
label("$C$", C, dir(135));
label("$D$", D, dir(45));

pair E = extension(A, C, B, D);
draw(C--E);
draw(D--E);
draw(C--D);
dot("$E$", E, dir(90));

pair P = extension(A, N, C, D);
pair Q = extension(B, N, C, D);
draw(A--N, gray);
draw(B--N, gray);
dot("$P$", P, dir(-110));
dot("$Q$", Q, dir(-60));

draw(E--P, gray);
draw(E--Q, gray);
