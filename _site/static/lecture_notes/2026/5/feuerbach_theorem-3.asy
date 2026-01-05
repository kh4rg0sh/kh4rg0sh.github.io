if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="feuerbach_theorem-3";
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

pair A, B, C, O;
A = dir(110); B = dir(210); C = dir(330);
dot("$A$", A, dir(A)); dot("$B$", B, dir(210)); dot("$C$", C, dir(335));

draw(A--B--C--cycle);
draw(circumcircle(A, B, C));

pair P = dir(10);
dot("$P$", P, dir(P));

pair I = incenter(A, B, C);
draw(A--P, blue); draw(B--P, blue); draw(C--P, blue);

draw(A--reflect(A, I) * P, red);
draw(B--reflect(B, I) * P, red);
draw(C--reflect(C, I) * P, red);

// helper for filled angles
path angleSector(pair X, pair Y, pair Z, real r) {
real a1 = degrees(dir(X - Y));
real a2 = degrees(dir(Z - Y));
return arc(Y, r, a1, a2) -- Y -- cycle;
}

// filled + marked angles at A
filldraw(
angleSector(reflect(A,I)*P, A, B, 0.2),
lightgray + opacity(0.35),
black
);
filldraw(
angleSector(C, A, P, 0.2),
lightgray + opacity(0.35),
black
);

markangle(reflect(A,I)*P, A, B, radius=15);
markangle(C, A, P, radius=15);

// filled + marked angles at C
filldraw(
angleSector(B, C, reflect(C,I)*P, 0.2),
lightgray + opacity(0.35),
gray
);
filldraw(
angleSector(P, C, A, 0.2),
lightgray + opacity(0.35),
gray
);
