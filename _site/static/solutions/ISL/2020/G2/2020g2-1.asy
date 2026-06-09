if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="2020g2-1";
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

size(9cm); defaultpen(fontsize(11pt));
pen sec=heavygreen; pen pri=heavycyan; pen tri=olive;
pen sfil=invisible; pen fil=invisible; pen tfil=invisible;

pair O,P,A,B,I,C,D;
O=(0,0); P=dir(100); A=dir(200); B=dir(340);
I=incenter(P,A,B);
C=extension(B,B+(P-B)*(I-A)/(P-A),P,P+(B-P)*(P-A)/(B-A)*(P-A)/(I-A));
D=extension(A,A+(P-A)*(I-B)/(P-B),P,P+(A-P)*(P-B)/(A-B)*(P-B)/(I-B));

draw(A--B--C--D--cycle);
draw(A--P); draw(B--P); draw(C--P); draw(D--P);
draw(circumcircle(A, P, B), gray(0.2));
draw(circumcircle(D, A, P), heavygray+dashed);
draw(circumcircle(B, C, P), heavygray+dashed);
draw(A--O, gray); draw(B--O, gray); draw(P--O, gray);
draw(O--D, lightgray); draw(O--C, lightgray);

dot("\(P\)",P,P); dot("\(A\)",A,SW); dot("\(B\)",B,SE); dot("\(C\)",C,N);
dot("\(D\)",D,N); dot("\(O\)",O,dir(15));
