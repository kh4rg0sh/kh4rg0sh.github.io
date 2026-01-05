if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="4_1_2026-7";
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

size(8cm); defaultpen(fontsize(10pt));

pair A,B,C,I,E,F,M,N,K;
A=dir(135); B=dir(200); C=dir(340);
I=incenter(A,B,C); E=foot(I,C,A); F=foot(I,A,B);
K=extension(B,I,E,F); M = (B+C)/2; N = (A+C)/2;

dot("$A$", A, dir(A)); dot("$B$", B, dir(B)); dot("$C$", C, dir(C));
draw(A--B--C--cycle);

pair D; D = foot(I, B, C);
dot("$D$", D, SW); dot("$F$", F, NW); dot("$E$", E, dir(90));

dot("$I$", I, SE); dot("$K$", K, NE);
draw(circle(I, abs(I - D)));
draw(B--I); draw(I--D); draw(I--F); draw(I--E);
draw(I--K); draw(E--K); draw(C--K); draw(E--F);

markrightangle(C, D, I, 7);
markrightangle(I, F, B, 7);
markrightangle(A, E, I, 7);
markrightangle(I, K, C, 7);

draw(circumcircle(I, D, C));
dot("$M_A$", M, SE); dot("$M_B$", N, dir(340));
draw(M--N--K, heavygray+dashed);
draw(arc(circumcircle(B, K, C), 0, 180), heavygray+dashed);
