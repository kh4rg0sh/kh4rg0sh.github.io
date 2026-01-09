if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="coaxial-4";
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

size(8cm);
defaultpen(fontsize(10pt));

pair O, A, B, C, H, L, P, Q, Y, D, EE, X, SS, T;
O=(0,0);
A=dir(110);
B=dir(220);
C=dir(320);
H=A+B+C;
L=dir(270);
P=2*foot(O,B,foot(B,A,L))-B;
Q=2*foot(O,C,foot(C,A,L))-C;
Y=A+P+Q;
D=extension(A,B,P,Y);
EE=extension(A,C,Q,Y);
X=extension(P,EE,Q,D);
SS=foot(P,A,Q);
T=foot(Q,A,P);

draw(circle(O,1));
draw(A--B--C--cycle);
draw(B--P, heavygray);
draw(C--Q, heavygray);
draw(circumcircle(A,D,EE),gray(0.6));
draw(D--EE, heavygray);
draw(H--A--Y--cycle, heavygray);

dot("$A$",A,N);
dot("$B$",B,B);
dot("$C$",C,C);
dot("$H$",H,S);
dot("$P$",P,P);
dot("$Q$",Q,Q);
dot("$Y$",Y,unit(Y-A));
dot("$D$",D,dir(210));
dot("$E$",EE,dir(18));
dot("$X$",X,NW);

draw(P--X, gray(0.2)+dashed);
draw(Q--X, gray(0.2)+dashed);

pair M, N;
N = reflect(A, B) * H;
M = reflect(A, C) * H;

dot("$M$", M, dir(45));
dot("$N$", N, dir(190));

draw(B--M); draw(C--N);
draw(P--N, gray(0.4)+dashed);
draw(Q--M, gray(0.4)+dashed);

draw(arc(circumcircle(N, M, H), 200, 360), gray(0.75)+dashed);
