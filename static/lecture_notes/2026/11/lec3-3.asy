if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="lec3-3";
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

pair A, B, C, O;
O = origin;
A = dir(110); B = dir(210); C = dir(330);

dot("$A$", A, dir(110));
dot("$B$", B, dir(230));
dot("$C$", C, dir(310));

draw(A--B--C--cycle);

pair D, E, F, H;
D = foot(A, B, C); E = foot(B, A, C); F = foot(C, A, B); H = extension(A, D, B, E);

draw(circumcircle(A, B, D));
draw(circumcircle(A, C, D));

pair[] EE, FF;
EE = intersectionpoints(line(C, F), circumcircle(A, B, D));
FF = intersectionpoints(line(B, E), circumcircle(A, C, D));

draw(circumcircle(EE[0], EE[1], FF[0]), heavygray+dashed);

dot("$B'$", E, dir(10)); dot("$C'$", F, dir(195));
dot("$P$", FF[0], dir(255)); dot("$Q$", FF[1], dir(40));
dot("$M$", EE[0], dir(285)); dot("$N$", EE[1], dir(170));
dot("$A'$", D, dir(260)); dot("$H$", H, dir(120));

draw(C--EE[1]); draw(B--FF[1]); draw(A--D);
markrightangle(B, E, C, 7); markrightangle(B, F, C, 7); markrightangle(C, D, A, 7);
