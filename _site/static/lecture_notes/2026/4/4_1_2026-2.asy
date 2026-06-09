if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="4_1_2026-2";
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

size(7cm);
defaultpen(fontsize(10pt));

pair A,B,C,P,Pa;
A = dir(110);
B = dir(200);
C = dir(340);

P = (0.1,0.1);
draw(A--B--C--cycle);

pair D, E, F;
D = extension(A,P, B,C);
E = extension(B,P, A,C);
F = extension(C,P, A,B);
draw(A--D); draw(B--E); draw(C--F);

dot("$A$",A,dir(A));
dot("$B$",B,dir(B));
dot("$C$",C,dir(C));
dot("$P$",P,dir(55));

pair IA = incenter(A,B,C);
pair rA = reflect(A, IA)*(P);
pair Aiso = extension(A,rA,B,C);
draw(A--Aiso, heavygray+dashed);

pair rB = reflect(B, IA)*(P);
pair Biso = extension(B,rB,A,C);
draw(B--Biso, heavygray+dashed);

pair rC = reflect(C, IA)*(P);
pair Ciso = extension(C,rC,A,B);
draw(C--Ciso, heavygray+dashed);

Pa = extension(A,Aiso,B,Biso);

dot("$Q$", Pa, dir(135));
dot("$D$", D, dir(315)); dot("$E$", E, dir(45)); dot("$F$", F, dir(135));
dot("$D'$", Aiso, dir(235)); dot("$E'$", Biso, dir(55)); dot("$F'$", Ciso, dir(145));
