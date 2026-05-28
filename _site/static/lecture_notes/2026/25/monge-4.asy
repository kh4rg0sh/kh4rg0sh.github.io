if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="monge-4";
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
size(10cm); defaultpen(fontsize(11pt));
pair A = dir(110); pair B = dir(210); pair C = dir(330);

draw(A--B--C--cycle); draw(incircle(A, B, C));

pair D = 0.35*B+0.65*C; draw(A--D);

pair I_B = incenter(A, B, D);
pair I_C = incenter(A, C, D);
pair E = foot(I_B, B, C);
pair F = foot(I_C, B, C);

draw(incircle(A, B, D));
draw(incircle(A, C, D));
pair I = incenter(A, B, C);

pair P = extension(I_B, I_C, A, D);
draw(I_B--I_C);

pair X = extension(B, I, C, P);
pair Y = extension(C, I, B, P);
pair Z = extension(E, X, F, Y);

draw(B--I--C);
draw(X--C, dotted);
draw(Y--B, dotted);
draw(E--Z--F, dashed);

pair T = extension(B, C, I_B, I_C);
pair W = foot(I, B, C);
draw(W--Z);

dot("$A$", A, dir(A));
dot("$B$", B, dir(270));
dot("$C$", C, dir(270));
dot("$D$", D, dir(D));
dot("$I_B$", I_B, dir(170));
dot("$I_C$", I_C, dir(30));
dot("$E$", E, dir(E));
dot("$F$", F, dir(F));
dot("$I$", I, dir(60));
dot("$P$", P, dir(250));
dot("$X$", X, dir(160));
dot("$Y$", Y, dir(40));
dot("$Z$", Z, dir(140));
dot("$W$", W, dir(W));
