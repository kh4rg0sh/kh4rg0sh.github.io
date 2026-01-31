if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="monge-5";
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

pair P,C,D,I,K,L,IA,IB,A,B,EE,F,Q,O,I1,I2;
P=dir(120); C=dir(205); D=dir(335);
I=incenter(P,C,D); K=foot(I,P,D);
L=foot(I,P,C); IA=K+0.8*(K-I);
IB=extension(L,I,P,P+(C-P)*dir(90)*(IA-P)/(I-P));
A=extension(P,reflect(P,IA)*K,D,reflect(D,IA)*K);
B=extension(P,reflect(P,IB)*L,C,reflect(C,IB)*L);
EE=extension(A,C,B,D); F=extension(A,K,B,L);
Q=extension(A,D,B,C); O=incenter(Q,A,B);
I1=extension(A,IA,C,I); I2=extension(B,IB,D,I);

draw(B--F--A);
draw(B--D);
draw(A--C);
draw(C--foot(O,B,C));
draw(incircle(Q,A,B),dotted);
draw(circle(I1,abs(I1-foot(I1,C,D))),heavygray+dashed);
draw(circle(I2,abs(I2-foot(I2,C,D))),heavygray+dashed);
draw(incircle(P,A,D)); draw(incircle(P,C,B));
draw(incircle(P,C,D)); draw(A--B--C--D--cycle);
draw(C--P--D); draw((EE+4*(EE-O))--(O+3*(O-EE)));

dot("\(P\)",P,N);
dot("\(C\)",C,SW);
dot("\(D\)",D,SE);
dot("\(A\)",A,NE);
dot("\(B\)",B,W);
dot("\(K\)",K,dir(15));
dot("\(L\)",L,dir(120));
dot("\(E\)",EE,S);
dot("\(F\)",F,dir(280));
dot("\(I\)",I,dir(260));
dot("\(O\)",O,SE);
