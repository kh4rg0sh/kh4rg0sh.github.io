if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="coaxial-3";
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

pair O1, O2;
O1 = (0, 0); O2 = (0, 2);

path C1 = circle(O1, 2.5);
path C2 = circle(O2, 1);

draw(C1); draw(C2, red+dashed);

pair[] AA = intersectionpoints(C1, C2);
dot("$A$", AA[1], dir(135)); dot("$B$", AA[0], dir(45));

pair X, Y;
X = dir(10) * 2.5; Y = dir(230) * 2.5;
dot("$X$", X, dir(325)); dot("$Y$", Y, dir(225));

pair[] UU = intersectionpoints(line(AA[1], X), C2);
pair[] VV = intersectionpoints(line(AA[0], Y), C2);

dot("$U$", UU[1], dir(15));
dot("$V$", VV[1], dir(120));

draw(AA[1]--X); draw(AA[0]--Y);
draw(X--Y, blue); draw(UU[1]--VV[1], blue);
