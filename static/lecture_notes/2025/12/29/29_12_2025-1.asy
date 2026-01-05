if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="29_12_2025-1";
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

import graph;

size(5.55cm);

real xmin=-5.76, xmax=4.8, ymin=-3.69, ymax=3.71;

pen zzttqq = rgb(0.6,0.2,0);
pen wwwwqq = rgb(0.4,0.4,0);
pen qqwuqq = rgb(0,0.39,0);

pair A = (-2, 2.5);
pair B = (-3,-1.5);
pair C = ( 2,-1.5);
pair I = (-1.27,-0.15);
pair Dp = (-2.58,0.18); // renamed from D -> Dp to avoid clash
pair O = (-0.5,-2.92);
pair E = (-0.31,0.81);

// triangle
draw(A--B--C--cycle, zzttqq);

// two little angle‐arc wedges
draw(arc(Dp,0.25,-104.04,-56.12)--Dp--cycle, qqwuqq);
draw(arc(E,0.25,-92.92,-45)--E--cycle, qqwuqq);

// triangle edges
draw(A--B, zzttqq);
draw(B--C, zzttqq);
draw(C--A, zzttqq);

// circles
draw(circle(I,1.35), linewidth(1.2)+dotted+wwwwqq);
draw(circle(O,2.87), linetype("2 2")+blue);

// segments
draw(Dp--O);
draw(E--O);

// points
dot(A); dot(B); dot(C);
dot(I); dot(Dp); dot(E); dot(O);

// labels
label("A", A, dir(110));
label("B", B, dir(140));
label("C", C, dir(20));
label("D", Dp, dir(150));
label("E", E, dir(60));
label("O", O, dir(290));
label("I", I, dir(100));

// clip to figure window
clip( (xmin,ymin)--(xmin,ymax)--(xmax,ymax)--(xmax,ymin)--cycle );
