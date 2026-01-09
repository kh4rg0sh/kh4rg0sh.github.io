if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="lec3-8";
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

pair A = (2,5);
pair B = (0,0);
pair C = (6,0);
pair H = orthocenter(A,B,C);

pair M_A = midpoint(B--C);
pair M_B = midpoint(A--C);
pair M_C = midpoint(A--B);

path circA = circle(M_A, abs(H - M_A));
path circB = circle(M_B, abs(H - M_B));
path circC = circle(M_C, abs(H - M_C));

pair[] A_pts = intersectionpoints(circA, B--C);
pair A1 = A_pts[0], A2 = A_pts[1];

pair[] B_pts = intersectionpoints(circB, A--C);
pair B1 = B_pts[0], B2 = B_pts[1];

pair[] C_pts = intersectionpoints(circC, A--B);
pair C1 = C_pts[0], C2 = C_pts[1];

draw(A--B--C--cycle);

draw(circA, gray(0.7)+dashed);
draw(circB, gray(0.7)+dashed);
draw(circC, gray(0.7)+dashed);
draw(circumcircle(A1,A2,C2), heavygray+dashed);

draw(B--C, gray);
draw(A--C, gray);
draw(A--B, gray);

dot("$A$", A, dir(120));
dot("$B$", B, dir(230));
dot("$C$", C, dir(310));
dot("$H$", H, dir(H));
dot("$A_2$", A1, dir(310));
dot("$A_1$", A2, dir(230));
dot("$B_2$", B1, dir(90));
dot("$B_1$", B2, dir(340));
dot("$C_1$", C1, dir(110));
dot("$C_2$", C2, dir(200));

pair Ma, Mb, Mc;
Ma = (B + C) / 2; Mb = (A + C) / 2; Mc = (A + B) / 2;

dot("$M_A$", Ma, dir(310));
dot("$M_B$", Mb, dir(50));
dot("$M_C$", Mc, dir(130));
draw(Ma--Mb--Mc--cycle, gray);
