if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="main-1";
if(settings.render < 0) settings.render=4;
settings.outformat="";
settings.inlineimage=true;
settings.embed=true;
settings.toolbar=false;
viewportmargin=(2,2);

/* Geogebra to Asymptote conversion, documentation at artofproblemsolving.com/Wiki go to User:Azjps/geogebra */
import contour; import graph; size(34.05647689509711cm);
real labelscalefactor = 0.5; /* changes label-to-point distance */
pen dps = linewidth(0.7) + fontsize(10); defaultpen(dps); /* default pen style */
pen dotstyle = black; /* point style */
real xmin = -1.7370045945232921, xmax = 32.31947230057382, ymin = -6.8992748391467345, ymax = 5.782722328715412; /* image dimensions */
pen zzttqq = rgb(0.6,0.2,0.); pen bubtba = rgb(0.7058823529411765,0.7019607843137254,0.7294117647058823); pen rcrcrf = rgb(0.10980392156862745,0.10980392156862745,0.12156862745098039);

draw((7.88,3.22)--(5.,-4.)--(15.,-4.)--cycle, linewidth(2.) + zzttqq);
/* draw grid of horizontal/vertical lines */
pen gridstyle = linewidth(0.7) + bubtba; real gridx = 1., gridy = 1.; /* grid intervals */
for(real i = ceil(xmin/gridx)*gridx; i <= floor(xmax/gridx)*gridx; i += gridx)
draw((i,ymin)--(i,ymax), gridstyle);
for(real i = ceil(ymin/gridy)*gridy; i <= floor(ymax/gridy)*gridy; i += gridy)
draw((xmin,i)--(xmax,i), gridstyle);
/* end grid */

Label laxis; laxis.p = fontsize(10);
xaxis(xmin, xmax,defaultpen+rcrcrf, Ticks(laxis, Step = 1., Size = 2, NoZero),EndArrow(6), above = true);
yaxis(ymin, ymax,defaultpen+rcrcrf, Ticks(laxis, Step = 1., Size = 2, NoZero),EndArrow(6), above = true); /* draws axes; NoZero hides '0' label */
/* draw figures */
real implicitf1 (real x, real y) { return 181299.90112000023-72020.14783999989*y^1-4128.585279999999*y^2-612.2560000000003*y^3-64879.06976000007*x^1+16050.311359999978*x^1*y^1-187.76800000000014*x^1*y^2+7206.436159999999*x^2-612.255999999999*x^2*y^1-187.76799999999992*x^3; }
draw(contour(implicitf1, (xmin,ymin), (xmax,ymax), new real[]{0}, 500), linewidth(2.));
draw((7.88,3.22)--(5.,-4.), linewidth(2.) + zzttqq);
draw((5.,-4.)--(15.,-4.), linewidth(2.) + zzttqq);
draw((15.,-4.)--(7.88,3.22), linewidth(2.) + zzttqq);
/* dots and labels */
dot((7.88,3.22),dotstyle);
label("$A$", (7.9310162085312115,3.3657171279517875), NE * labelscalefactor);
dot((5.,-4.),dotstyle);
label("$B$", (5.062642566661125,-3.85617792975157), NE * labelscalefactor);
dot((15.,-4.),dotstyle);
label("$C$", (15.050989360178276,-3.85617792975157), NE * labelscalefactor);
label("$c$", (6.212904077867911,-0.3034714900749184), NE * labelscalefactor,zzttqq);
label("$a$", (9.998574874244675,-4.220184737095489), NE * labelscalefactor,zzttqq);
label("$b$", (11.60020482655792,-0.21610985631237778), NE * labelscalefactor,zzttqq);
clip((xmin,ymin)--(xmin,ymax)--(xmax,ymax)--(xmax,ymin)--cycle);
/* end of picture */
