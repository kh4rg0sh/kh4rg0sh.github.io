if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="coaxial-7";
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
size(11cm); defaultpen(fontsize(11pt));pen med=mediummagenta;pen light=pink;pen deep=deepmagenta;pen org=magenta;pen heavy=heavymagenta;

pair O,A,B,C,D,E,F,G,M,N,S,T,Q,R;
O=(0,0); D=dir(15); A=dir(110); B=dir(205); C=dir(330);
path w=circumcircle(A,B,C);
E=extension(A,C,B,D);
F=extension(A,D,B,C);
G=2.2*incenter(B,E,C)-1.2*E;
N=foot(G,E,C);
M=foot(G,E,B);
S=extension(B,C,N,M);
T=extension(A,D,N,M);
Q=intersectionpoints(circle(G,abs(G-M)),w)[0];
R=intersectionpoints(circle(G,abs(G-M)),w)[1];

draw(w);
draw(A--B--C--D--cycle);
draw(circle(G,abs(G-M)));
draw(circumcircle(Q,R,S), heavygray+dashed);
draw(D--T);draw(C--F);
draw(M--T);
draw(A--C);
draw(B--D);

clip((-1,1)--(3.5,1)--(3.5,-1.5)--(-1,-1.5)--cycle);

dot("$B$",B,dir(B));
dot("$C$",C,dir(300));
dot("$A$",A,dir(A));
dot("$D$",D,dir(55));
dot("$E$",E,dir(80));
dot("$F$",F,dir(70));
dot("$M$",M,dir(140));
dot("$N$",N,dir(60));
dot("$S$",S,dir(270));
dot("$T$",T,dir(60));
dot("$Q$",Q,dir(Q));
dot("$R$",R,dir(290));
