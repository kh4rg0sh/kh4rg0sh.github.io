if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="4_1_2026-8";
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

size(7cm); defaultpen(fontsize(10pt)); pen pri=heavyred; pen pri2=lightred; pen sec=lightblue; pen tri=purple+pink; pen qua=fuchsia+pink+dashed; pen fil=invisible; pen sfil=invisible; pen tfil=invisible;

pair A,B,C,I,EE,F,M,NN,P,X,Y,Q,MA,K; A=dir(110); B=dir(225); C=dir(315); I=incenter(A,B,C); EE=foot(I,C,A); F=foot(I,A,B); M=extension(EE,F,C,C+A-B); NN=extension(EE,F,B,B+A-C); P=extension(B,M,C,NN); X=extension(A,C,B,M); Y=extension(A,B,C,NN); Q=(M+NN)/2; MA=(B+C)/2; K=extension(B,I,EE,F);

draw(B--K--MA,qua); draw(X--Y,pri2); draw(B--M,tri);draw(C--NN,tri); fill(B--F--NN--cycle,sfil); fill(C--EE--M--cycle,sfil); draw(C--M--NN--B,sec); filldraw(incircle(A,B,C),fil,pri2); filldraw(A--B--C--cycle,fil,pri);

dot("\(A\)",A,N); dot("\(B\)",B,SW); dot("\(C\)",C,SE); dot("\(M_A\)",MA,S); dot("\(E\)",EE,dir(60)); dot("\(F\)",F,NW); dot("\(M\)",M,NE); dot("\(N\)",NN,NW); dot("\(I\)",I,dir(120)); dot("\(P\)",P,S); dot("\(K\)",K,NW); dot("\(X\)",X,dir(-15)); dot("\(Y\)",Y,dir(220));
