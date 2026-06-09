if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="lec4-10";
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

pair A, B, C, O;
A = (-3, 0); B = (3, 0);
O = (1.3, 0); C = (A + B) / 2;

pair O1 = rotate(90, O) * A;
pair[] PP = intersectionpoints(line(O, O1), circle(C, abs(A - C)));

dot("$A$", A, dir(225));
dot("$B$", B, dir(315));
dot("$O$", O, dir(225));
dot("$P$", PP[0], dir(45));

draw(A--B);
draw(circumcircle(A, B, PP[0]));

pair I = incenter(A, B, PP[0]);
pair M = dir(270) * 3; dot("$I$", I, dir(150));

pair X = O + 3 * (unit(A - O) + unit(PP[0] - O));
pair Y = O + 3 * (unit(B - O) + unit(PP[0] - O));

pair I1 = I + (Y - O);
pair I2 = I + (X - O);
pair R = extension(I, I1, A, B);
dot("$R$", R, dir(225));

pair S = extension(I, I2, A, B);
dot("$S$", S, dir(315));

pair U = extension(I, I1, PP[0], O);
pair V = extension(I, I2, PP[0], O);
dot("$U$", U, dir(150));
dot("$V$", V, dir(30));

draw(R--U); draw(S--I); draw(PP[0]--O);
draw(A--B--PP[0]--cycle);

pair O1 = R + (U - O);
pair O2 = S + (V - O);

dot("$O_1$", O1, dir(220));
dot("$O_2$", O2, dir(90));

draw(circle(O1, abs(O1 - R)));
draw(circle(O2, abs(O2 - S)));

draw(R--PP[0]--S, red);

draw(arc(circumcircle(PP[0], A, R), -130, 10), blue+dashed);
draw(arc(circumcircle(PP[0], B, S), -240, -60), blue+dashed);
