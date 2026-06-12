if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="monge-1";
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
size(12cm); defaultpen(fontsize(10pt));

pair tangent(pair P, pair O, real r, int n=1)
{
real d,R;
pair X,T;
d=abs(P-O);
if (d<r) return O;
R=sqrt(d^2-r^2);
X=intersectionpoint(circle(O,r),O--P);
if (n==1)
{
T=intersectionpoint(circle(P,R),arc(O,r,degrees(X-O),degrees(X-O)+180));
}
else if (n==2)
{
T=intersectionpoint(circle(P,R),arc(O,r,degrees(X-O)+180,degrees(X-O)+360));
}
else {T=O;}
return T;
}

pair O1 = (0, 0);
pair O2 = (10, 0);
pair O3 = (7, -8);
real r1 = 5;
real r2 = 3;
real r3 = 1.8;
path C1 = circle(O1, r1);
path C2 = circle(O2, r2);
path C3 = circle(O3, r3);
draw(C1); draw(C2); draw(C3);

pair T1 = O1 + unit(O2 - O1) * (r1 / (r1 - r2)) * abs(O2 - O1);
pair T2 = O1 + unit(O3 - O1) * (r1 / (r1 - r3)) * abs(O3 - O1);
pair T3 = O2 + unit(O3 - O2) * (r2 / (r2 - r3)) * abs(O3 - O2);

dot("$O_1$", O1, dir(225));
dot("$O_2$", O2, dir(315));
dot("$O_3$", O3, dir(225));
dot("$T_1$", T1, dir(315));
dot("$T_3$", T2, dir(315));
dot("$T_2$", T3, dir(315));
draw(O1--T1, gray+dashed);
draw(O1--T2, gray+dashed);
draw(O2--T3, gray+dashed);

pair A1 = tangent(T1, O1, r1, 1);
pair A2 = tangent(T1, O1, r1, 2);
pair B1 = tangent(T1, O2, r2, 1);
pair B2 = tangent(T1, O2, r2, 2);
draw(A1--T1); draw(A2--T1);

pair A3 = tangent(T2, O1, r1, 1);
pair A4 = tangent(T2, O1, r1, 2);
pair C1 = tangent(T2, O3, r3, 1);
pair C2 = tangent(T2, O3, r3, 2);
draw(A3--T2); draw(A4--T2);

pair B3 = tangent(T3, O2, r2, 1);
pair B4 = tangent(T3, O2, r2, 2);
pair C3 = tangent(T3, O3, r3, 1);
pair C4 = tangent(T3, O3, r3, 2);
draw(B3--T3); draw(B4--T3);

draw(T1--T3, red);
