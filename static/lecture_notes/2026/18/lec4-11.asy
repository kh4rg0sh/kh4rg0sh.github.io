if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="lec4-11";
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

pair A, B, C, D;
A = dir(105);
B = dir(210);
C = dir(330);
D = foot(A, B, C);

draw(A--B--C--cycle);
dot("$A$", A, dir(130));
dot("$B$", B, dir(225));
dot("$C$", C, dir(315));
dot("$D$", D, dir(225));

pair I = incenter(A, B, C);
dot("$I$", I, dir(60));

pair X = D + 3 * (unit(B - D) + unit(A - D));
pair Y = D + 3 * (unit(C - D) + unit(A - D));

pair I1 = I + (Y - D);
pair I2 = I + (X - D);
pair R = extension(I, I1, B, C);
dot("$T_1$", R, dir(225));

pair S = extension(I, I2, B, C);
dot("$T_2$", S, dir(315));

pair U = extension(I, I1, A, D);
pair V = extension(I, I2, A, D);
dot("$S_1$", U, dir(165));
dot("$S_2$", V, dir(30));

draw(circumcircle(A, B, C));
draw(R--I); draw(S--V);

pair O1 = R + (U - D);
pair O2 = S + (V - D);
dot("$O_1$", O1, dir(120));
dot("$O_2$", O2, dir(60));

draw(circle(O1, abs(O1 - R)));
draw(circle(O2, abs(O2 - S)));

draw(A--D);

pair M = (B + C) / 2;
dot("$M$", M, dir(225));

draw(O1--O2);
