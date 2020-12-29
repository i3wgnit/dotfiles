path circle(frame dest, frame src=dest, real xmargin=0, real ymargin=xmargin,
             pen p=currentpen, filltype filltype=NoFill, bool above=true)
{
  pair m=min(src);
  pair M=max(src);
  pair D=M-m;
  static real factor=0.5*sqrt(2);
  int sign=filltype == NoFill ? 1 : -1;
  pair h=0.5*sign*(max(p)-min(p));
  real r=max(factor*D.x+h.x+xmargin,factor*D.y+h.y+ymargin);
  path g=circle(0.5*(M+m), r);
  frame F;
  if(above == false) {
    filltype.fill(F,g,p);
    prepend(dest,F);
  } else filltype.fill(dest,g,p);
  return g;
}

