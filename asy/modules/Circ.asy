/* Useful functions for drawing circuit diagrams.
 * Version 0.1
 *
 * Copyright (C) 2003 GS Bustamante Argañaraz
 *               2008-2009 W. Trevor King <wking@drexel.edu>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 *
 *
 * Based on MetaPost's MakeCirc by Gustavo Sebastian Bustamante Argañaraz.
 *   http://www.ctan.org/tex-archive/help/Catalogue/entries/makecirc.html
 */

// Command definitions for easier labeling

texpreamble("\def\ohm{\ensuremath{\,\Omega}}");
texpreamble("\def\kohm{\,k\ensuremath{\Omega}}");
texpreamble("\def\modarg#1#2{\setbox0=\hbox{$\mkern-1mu/#2^\circ$}\dp0=.21ex $#1\underline{\box0}$}");

int rotatelabel = 0;
int norotatelabel = 1;
int labeling = rotatelabel;

// Macros for the pens, I define them as such so when they expand,
// look for the last value assigned to linewd and use it
// (thanks to JLD). The linewd value assigns it as newinternal to
// be able to change it «from out».

real linewd = 0.25mm;

pen line = makepen(scale(0.5*linewd)*unitcircle);
pen misc = makepen(scale(0.4*linewd)*unitcircle);

// Arrowhead definitions

real ahlength = 4bp; // Arrowhead length
real ahangle = 30;   // Arrowhead angle

path miscahead (path p)
{
  real t = reltime(p, 1.0);
  pair A = point(p,t);
  pair u = -dir(p,t);
  path a = shift(A)*((0,0)--(scale(ahlength)*rotate(15)*u));
  path b = shift(A)*((0,0)--(scale(ahlength)*rotate(-15)*u));
  return (a & reverse(a) & b & reverse(b))--cycle;
}

path fullhead (path p, real length=ahlength, real angle=ahangle)
{
  real t = reltime(p, 1.0);
  pair A = point(p,t);
  pair u = -dir(p,t);
  path a = shift(A)*((0,0)--(scale(length)*rotate(angle/2)*u));
  path b = shift(A)*((0,0)--(scale(length)*rotate(-angle/2)*u));
  return (A -- a -- reverse(b) --cycle);
}

path bjtahead (path p)
{
  pair A = point(p,reltime(p,0.7));
  pair u = -dir(p,reltime(p,0.5));
  path a = shift(A)*((0,0)--(scale(ahlength)*rotate(20)*u));
  path b = shift(A)*((0,0)--(scale(ahlength)*rotate(-20)*u));
  return (a & reverse(a) & b & reverse(b))--cycle;
}

path txtahead (path p)
{
  pair A = point(p,reltime(p,1.0));
  pair B = point(p,reltime(p,0.97));
  pair u = dirtime(p,reltime(p,1.0));
  return A{-u}..(A - scale(7)*rotate(15)*u)--B
		  --(A - scale(7)*rotate(-15)*u)..A{u}--cycle;
}

// function to wire the symbols together

int nsq=0, udsq=2, rlsq=3;

void wire(pair pin_beg, pair pin_end, int type=nsq, real dist=0)
{
  if (dist == 0) {
    if (type==nsq) {
      draw(pin_beg--pin_end, line);
    } else if (type==udsq) {
      draw(pin_beg--(pin_beg.x,pin_end.y)--pin_end, line);
    } else if (type==rlsq) {
      draw(pin_beg--(pin_end.x,pin_beg.y)--pin_end, line);
    } else {
      write("Error, unrecognized wire type ",type);
    }
  } else {
    if (type==udsq) {
      draw(pin_beg--(pin_beg+(0,dist))--(pin_end.x,pin_beg.y + dist)
	   --pin_end, line);
    } else if (type==rlsq) {
      draw(pin_beg--(pin_beg+(dist,0))--(pin_beg.x + dist,pin_end.y)
	   --pin_end, line);
    } else {
      write("Error, unrecognized wireU type",type);
    }
  }
}

// Macro to center text among two pins

bool witharrow=false, noarrow=true;

void ctext(pair pin_beg, pair pin_end, string txt, bool type)
{
  picture ctxt;
  if (type==noarrow) {
    ; // pass
  } else if (type==witharrow) {
    draw(ctxt, pin_beg--pin_end);
    draw(ctxt, txtahead(pin_beg--pin_end));
    draw(ctxt, txtahead(reverse(pin_beg--pin_end)));
  } else {
    write("Error, unrecognized ctext type",type);
  }
  label(ctxt, txt, 0.5(pin_beg+pin_end));
  add(currentpicture, ctxt);
}

// Definition of lbsep (label separation), distance among symbol and label.

real lbsep=3mm;


// ----- Here the symbols begin --------

struct TwoTerminal {
  pair beg;
  pair end;
  pair mid;
  real len;
  real ang;
  real lchar;
  real lcharv;
  string name;
  string val;
  path pLine[]; // cyclic paths are filled in
  path pMisc[];
  
  void operator init(pair beg, real len, real ang, real lchar, real lcharv, string name, string val, path pLine[]={}, path pMisc[]={}) {
    this.beg = beg;
    this.end = beg+rotate(ang)*(len,0);
    this.mid = (this.beg + this.end)/2;
    this.len = len;
    this.ang = ang % 360;
    this.lchar = lchar;
    this.lcharv = lcharv;
    this.name = name;
    this.val = val;
    this.pLine = pLine;
    this.pMisc = pMisc;
  }

  void putlabel(picture pic=currentpicture) {
    picture picL;
    pair pName, pVal; // point
    real rName, rVal; // rotated by
    align aName, aVal;
    if (labeling==rotatelabel) {
      pName = (lchar+lbsep)*dir (90+ang);
      pVal = (lcharv+lbsep)*dir (270+ang);
      aName = NoAlign;
      aVal = NoAlign;
      if (ang <= 90 || ang > 270) {
	rName = ang;
	rVal = ang;
      } else if (ang > 90 && ang <= 270) {
	rName = 180+ang;
	rVal = 180+ang;
      }
    } else if (labeling==norotatelabel) {
      rName = 0;
      rVal = 0;
      if (ang == 0) {
	pName = (lchar+.25lbsep)*dir (90+ang);
	pVal = (lcharv+.25lbsep)*dir (270+ang);
	aName = N;
	aVal = S;
      } else if (ang < 90) {
	pName = (lchar)*dir (90+ang);
	pVal = (lcharv)*dir (270+ang);
	aName = NW;
	aVal = SE;
      } else if (ang == 90) {
	pName = (lchar+.25lbsep)*dir (90+ang);
	pVal = (lcharv+.25lbsep)*dir (270+ang);
	aName = W;
	aVal = E;
      } else if (90 < ang && ang < 180) {
	pName = (lchar)*dir (90+ang);
	pVal = (lcharv)*dir (270+ang);
	aName = SW;
	aVal = NE;
      } else if (ang == 180) {
	pName = (lchar+.25lbsep)*dir (90+ang);
	pVal = (lcharv+.25lbsep)*dir (270+ang);
	aName = S;
	aVal = N;
      } else if (ang > 180 && ang < 270) {
	pName = (lchar)*dir (90+ang);
	pVal = (lcharv)*dir (270+ang);
	aName = SE;
	aVal = NW;
      } else if (ang == 270) {
	pName = (lchar+.25lbsep)*dir (90+ang);
	pVal = (lcharv+.25lbsep)*dir (270+ang);
	aName = E;
	aVal = W;
      } else if (270 < ang && ang < 360) {
	pName = (lchar)*dir (90+ang);
	pVal = (lcharv)*dir (270+ang);
	aName = NE;
	aVal = SW;
      }
    }
    Label lName = rotate(rName)*Label(name);
    label(picL, lName, pName, aName);    
    Label lVal = rotate(rVal)*Label(val);
    label(picL, lVal, pVal, aVal);
    add(pic, picL, (end-beg)/2);
  }

  /* Rather than placing the element with a point and direction (beg,
   * ang), center an element between the pairs a and b.  The optional
   * offset shifts the element in the direction rotated(90)*(b-a)
   * (i.e. up for offset > 0 if b is directly right of a).
   */
  void centerto(pair a, pair b, real offset=0) {
    this.ang = degrees(b-a);
    this.beg = (a+b)/2
      - unit(b-a)*this.len/2 + offset*dir(this.ang+90);
    this.end = this.beg+rotate(ang)*(this.len,0);
    this.mid = (this.beg + this.end)/2;
  }

  void draw(picture pic=currentpicture) {
    picture picT;
    for (int i=0; i< pLine.length; i+=1) {
      draw(picT, rotate(ang)*pLine[i], line);
      if (cyclic(pLine[i]))
	fill(picT, rotate(ang)*pLine[i], line);
    }
    for (int i=0; i< pMisc.length; i+=1) {
      draw(picT, rotate(ang)*pMisc[i], misc);
      if (cyclic(pMisc[i]))
	fill(picT, rotate(ang)*pMisc[i], misc);
    }
    putlabel(picT);
    add(pic, picT, beg);
  }
}

void centerto(TwoTerminal reference, TwoTerminal target, real offset=0,
	      bool reverse=false)
{
  if (reverse == false)
    target.centerto(reference.beg, reference.end, offset);
  else
    target.centerto(reference.end, reference.beg, offset);
}

// --- Resistor (Resistencia) ---

real rstlth=2mm;
int normal=0, variable=2;

TwoTerminal resistor(pair beg=(0,0), real ang=0, int type=normal,
		     string name="", string val="", bool draw=true)
{
  path pLine, pMisc[]={};
  TwoTerminal term;

  pLine = (0,0)--(2rstlth,0)--(2.25rstlth,.75rstlth);
  for (real i=.5; i<=2.5; i+=0.5)
    pLine = pLine--((2.25+i)*rstlth,((-1)**(2i))*.75rstlth);
  pLine = pLine -- (5rstlth,0)--(7rstlth,0);
  if (type==normal) {
    ; //pass
  } else if (type==variable) {
    ahlength=.8rstlth;
    pMisc.push((2rstlth,-rstlth)--(5.5rstlth,rstlth));
    pMisc.push(miscahead((2rstlth,-rstlth)--(5.5rstlth,rstlth)));
  } else {
    write("Error, unrecognized resistor type",type);    
  }
  term = TwoTerminal(beg, 7rstlth, ang, .8rstlth, .8rstlth, name, val, pLine, pMisc);
  if (draw == true)
    term.draw();
  return term;
}

// --- Inductor (bobina) ---

real coil=2mm;
int Up=0, Down=1;

TwoTerminal inductor(pair beg=(0,0), real ang=0, int type=Up, string name="",
		     string val="", bool draw=true)
{
  path pLine;
  TwoTerminal term;
  
  if (type==Up) {
    pLine = (0,0)--(coil,0);
    for (int i=2; i<=4; i+=1)
      pLine = pLine{N}..{S}(i*coil,0);
    pLine = pLine{N}..{S}(5coil,0)--(6coil,0);
  } else if (type==Down) {
    pLine = (0,0)--(coil,0);
    for (int i=2; i<=4; i+=1)
      pLine = pLine{S}..{N}(i*coil,0);
    pLine = pLine{S}..{N}(5coil,0)--(6coil,0);
    // the original makecirc changed labelangle to ang-180
  } else {
    write("Error, unrecognized inductor type",type);
  }
  term = TwoTerminal(beg, 6coil, ang, coil, coil, name, val, pLine);
  // the original makecirc used .5coil for lcharv
  if (draw == true)
    term.draw();
  return term;
}

// --- Capacitor (condensador) ---

real platsep=1mm;
int normal=0, electrolytic=1, variable=2, variant=3;

TwoTerminal capacitor(pair beg=(0,0), real ang=0, int type=normal,
		      string name="", string val="", bool draw=true)
{
  path pLine[]={}, pMisc[]={};
  TwoTerminal term;

  pLine.push((0,0)--(3platsep,0));
  pLine.push((4platsep,0)--(7platsep,0));

  if (type==normal) {
    pLine.push((3platsep,-2.5platsep)--(3platsep,2.5platsep));
    pLine.push((4platsep,-2.5platsep)--(4platsep,2.5platsep));
  } else if (type==electrolytic) {
    pLine.push((3platsep,-1.8platsep)--(3platsep,1.8platsep));
    pLine.push((2platsep,-2.5platsep)--(4platsep,-2.5platsep)
	       --(4platsep,+2.5platsep)--(2platsep,2.5platsep));
  } else if (type==variable) {
    pLine.push((3platsep,-2.5platsep)--(3platsep,2.5platsep));
    pLine.push((4platsep,-2.5platsep)--(4platsep,2.5platsep));
    pMisc.push((platsep,-2.5platsep)--(6platsep,2.5platsep));
    ahlength=1.7platsep;
    pMisc.push(miscahead((platsep,-2.5platsep)--(6platsep,2.5platsep)));
  } else if (type==variant) {
    pLine.push((3platsep,-2.5platsep)--(3platsep,2.5platsep));
    pLine.push((4.5platsep,-2.5platsep)..(4platsep,0)..(4.5platsep,2.5platsep));
  } else {
    write("Error, unrecognized capacitor type",type);
  }
  term = TwoTerminal(beg, 7platsep, ang, 2.5platsep, 2.5platsep, name, val, pLine, pMisc);
  if (draw == true)
    term.draw();
  return term;
}

// --- Diode (diodo) ---

real diodeht=3.5mm;
int zener=1, LED=2;
// I droped the pin parameters, since other device (e.g. electrolytic
// capacitors) are also polarized.  The positioning method centerto(),
// provides enough flexibility.

TwoTerminal diode(pair beg=(0,0), real ang=0, int type=normal, string name="",
		  string val="", bool draw=true)
{
  path pLine[]={}, pMisc[]={};
  real lchar, lcharv;
  TwoTerminal term;

  pLine.push((0,0)--(diodeht,0)--(diodeht,.5diodeht)--(2diodeht,0)--(diodeht,-.5diodeht)--(diodeht,0));
  pLine.push((2diodeht,0)--(3diodeht,0));
  lchar = 0.6diodeht; lcharv = 0.6diodeht;
  
  if (type==normal) {
    pLine.push((2diodeht,-.5diodeht)--(2diodeht,.5diodeht));
  } else if (type==zener) {
    pLine.push((2.5diodeht,-.5diodeht)--(2diodeht,-.5diodeht)--(2diodeht,.5diodeht)--(1.5diodeht,.5diodeht));
  } else if (type==LED) {
    path a = (diodeht,.5diodeht)--(2diodeht,0);
    pair u = unit((.5,1)); // perpendicular to a
    path b = (0,0)--diodeht*u;
    pLine.push((2diodeht,-.5diodeht)--(2diodeht,.5diodeht));
    lchar = 1.5diodeht;
    pMisc.push(shift(point(a,reltime(a,0.25))+point(b,0.33))*((0,0)--diodeht*u));
    pMisc.push(shift(point(a,reltime(a,0.60))+point(b,0.33))*((0,0)--diodeht*u));
    pMisc.push(fullhead(pMisc[0], 0.4diodeht, 30));
    pMisc.push(fullhead(pMisc[1], 0.4diodeht, 30));
  } else {
    write("Error, unrecognized capacitor type",type);
  }
  term = TwoTerminal(beg, 3diodeht, ang, lchar, lcharv, name, val,pLine,pMisc);
  if (draw == true)
    term.draw();
  return term;
}

//--- Battery (bater'ia) ---

real bsize = 6mm;

TwoTerminal battery(pair beg=(0,0), real ang=0, string name="", string val="",
		    bool draw=true)
{
  path pLine[]={}, pMisc[]={};
  real lchar, lcharv;
  TwoTerminal term;

  pLine.push((0,0)--(0.4bsize,0));
  pLine.push((1.4bsize,0)--(1.8bsize,0));
  
  for (int i=0; i<3; i+=1) {
    pLine.push(((0.4+0.4i)*bsize, -0.2bsize)--((0.4+0.4i)*bsize, 0.2bsize));
    pLine.push(((0.6+0.4i)*bsize, -0.6bsize)--((0.6+0.4i)*bsize, 0.6bsize));
  }
  lchar = 0.6bsize; lcharv = 0.6bsize;

  term = TwoTerminal(beg, 1.8bsize, ang, lchar, lcharv, name, val,pLine,pMisc);
  if (draw == true)
    term.draw();
  return term;
}

//--- Switches (Llaves) ---

int NO=0, NC=1;
real ssep=3mm, swt=1.2ssep; // TODO remove swt?

/* `switch' is a Asymptote keyword (or it should be), so append SPST
 * for Single Pole Single Throw.
 */
TwoTerminal switchSPST(pair beg=(0,0), real ang=0, int type=NO, string name="",
		       string val="", bool draw=true)
{
  path pLine[]={}, pMisc[]={};
  real lchar, lcharv;
  TwoTerminal term;

  pLine.push((0,0)--(0.7ssep,0));
  pLine.push((1.7ssep,ssep/3)--(1.7ssep,0)--(2.4ssep,0));
  lchar = 0.6ssep; lcharv = 0.6ssep;

  if (type==NO) {
    pLine.push((0.7ssep,0)--(1.8ssep,0.7ssep));
  } else if (type==NC) {
    pLine.push((0.7ssep,0)--(2ssep,ssep/3));
  } else {
    write("Error, unrecognized switchSPST type",type);
  }
  term = TwoTerminal(beg, 2.4ssep, ang, lchar, lcharv, name, val, pLine,pMisc);
  if (draw == true)
    term.draw();
  return term;
}

//--- Current (Corriente) ---

real isize=2mm;

// adjusted from makecirc original to center arrowhead under text
TwoTerminal current(pair beg=(0,0), real ang=0, string name="", string val="",
		    bool draw=true)
{
  path pLine[]={}, pMisc[]={};
  real lchar, lcharv;
  TwoTerminal term;
  lchar = 0.4isize; lcharv = 0.4isize;
  pLine.push((0,0)--(1.5isize,0));
  pLine.push((1.5isize,0)--(2isize,0));
  pMisc.push(fullhead(pLine[0], isize, 45));
  term = TwoTerminal(beg, 2isize, ang, lchar, lcharv, name, val, pLine, pMisc);
  if (draw == true)
    term.draw();
  return term;
}

//--- Sources (fuentes de alimentaci'on) ---

real ssize=6mm;
int AC=0,DC=1,I=2,V=3;

TwoTerminal source(pair beg=(0,0), real ang=0, int type=AC, string name="",
		   string val="", bool draw=true)
{
  path pLine[]={}, pMisc[]={};
  real len, lchar, lcharv;
  TwoTerminal term;


  if (type == AC || type == I || type == V) {
    len = 2ssize;
    lchar = 0.5ssize; lcharv = 0.5ssize;
    pLine.push((0,0)--(.5ssize,0));
    pLine.push(shift((ssize,0))*scale(ssize/2)*(E..N..W..S..E));
    pLine.push((1.5ssize,0)--(2ssize,0));
    if (type == AC) {
      pLine.push((2ssize/3,0ssize){NE}..{E}((1/3+.5)*ssize,.2ssize)..{SE}(ssize,0)..{E}((2/3+.5)*ssize,-.2ssize)..{NE}(4ssize/3,0));
    } else if (type == I) {
      pLine.push((2ssize/3,0)--(4ssize/3,0));
      pLine.push(fullhead(pLine[3], 4ssize/15, 30));
    } else if (type == V) {
      pLine.push((1.05ssize,0)--(1.45ssize,0));
      pLine.push((1.25ssize,-.2ssize)--(1.25ssize,.2ssize));
      pLine.push((.95ssize,0)--(.55ssize,0));      
    }
  } else if (type == DC) {
    len = ssize;
    lchar = 0.6ssize; lcharv = .6ssize;
    pLine.push((0,0)--(0.4ssize,0));
    pLine.push((.6ssize,0)--(ssize,0));
    pLine.push((.4ssize,-.2ssize)--(.4ssize,.2ssize));
    pLine.push((.6ssize,-.6ssize)--(.6ssize,.6ssize));
  }
  term = TwoTerminal(beg, len, ang, lchar, lcharv, name, val, pLine, pMisc);
  if (draw == true)
    term.draw();
  return term;
}

/*

//%%<--- Transistor --->%%%
newinternal npn, pnp, cnpn, cpnp, bjtlth;
npn=1; pnp=-1; cnpn=0; cpnp=2; bjtlth=7mm;

vardef transistor@#(expr z,type,ang)=
	save BJT;
	pair T@#.B,T@#.E,T@#.C; % pines: Base, Emisor, Colector %
	T@#.B=z;
	T@#.E=(z+(bjtlth,-.75bjtlth)) rotatedaround(z,ang);
	T@#.C=(z+(bjtlth,.75bjtlth)) rotatedaround(z,ang);
	picture BJT;
	BJT=nullpicture;
	
	addto BJT doublepath z--(z+(.5bjtlth,0)) withpen line;
	addto BJT doublepath (z+(.5bjtlth,-.5bjtlth))--(z+(.5bjtlth,.5bjtlth)) withpen line;
	addto BJT doublepath (z+(.5bjtlth,.2bjtlth))--(z+(bjtlth,.5bjtlth))
	--(z+(bjtlth,.75bjtlth)) withpen line;
	
	if type=npn:
		addto BJT doublepath (z+(.5bjtlth,-.2bjtlth))--(z+(bjtlth,-.5bjtlth))
		--(z+(bjtlth,-.75bjtlth)) withpen line;
		addto BJT contour bjtahead (z+(.5bjtlth,-.2bjtlth))
		--(z+(bjtlth,-.5bjtlth)) withpen line;
	elseif type=cnpn:
		addto BJT doublepath (z+(.5bjtlth,-.2bjtlth))--(z+(bjtlth,-.5bjtlth))
		--(z+(bjtlth,-.75bjtlth)) withpen line;
		addto BJT contour bjtahead (z+(.5bjtlth,-.2bjtlth))
		--(z+(bjtlth,-.5bjtlth)) withpen line;
		addto BJT doublepath fullcircle scaled 1.3bjtlth shifted (z+(.65bjtlth,0))
		 withpen line;
	elseif type=pnp:
		addto BJT doublepath (z+(bjtlth,-.75bjtlth))--(z+(bjtlth,-.5bjtlth))
		--(z+(.5bjtlth,-.2bjtlth)) withpen line;
		addto BJT contour bjtahead (z+(bjtlth,-.5bjtlth))
		--(z+(.5bjtlth,-.2bjtlth)) withpen line;
	elseif type=cpnp:
		addto BJT doublepath (z+(bjtlth,-.75bjtlth))--(z+(bjtlth,-.5bjtlth))
		--(z+(.5bjtlth,-.2bjtlth)) withpen line;
		addto BJT contour bjtahead (z+(bjtlth,-.5bjtlth))
		--(z+(.5bjtlth,-.2bjtlth)) withpen line;
		addto BJT doublepath fullcircle scaled 1.3bjtlth shifted (z+(.65bjtlth,0)) withpen line;
	fi;
	
	draw BJT rotatedaround(z,ang);
enddef;

//%%<--- Measurement instruments (Intrumentos de medicion)--->%%%
newinternal volt, ampere, watt;
volt=0; ampere=1; watt=2;

vardef meains@#(expr z,type,ang,name)=
	save meter;
	pair mi@#.l, mi@#.r, mi@#.p; % pines %
	mi@#.l=z; mi@#.r=(z+(2ssize,0)) rotatedaround(z,ang);
	
	picture meter; meter=nullpicture;
	addto meter doublepath z--(z+(.5ssize,0));
	addto meter doublepath (z+(1.5ssize,0))--(z+(2ssize,0));
	if (type=volt) || (type=ampere):	
		addto meter doublepath fullcircle scaled ssize shifted (z+(ssize,0));
		if type=volt:
			addto meter also thelabel(latex("\textsf{V}") scaled (ssize/6mm) 
			rotated (-ang), (z+(ssize,0)));
		elseif type=ampere:
			addto meter also thelabel(latex("\textsf{A}") scaled (ssize/6mm) 
			rotated (-ang), (z+(ssize,0)));
		fi;
	elseif (type=watt):
		mi@#.p=(z+(ssize,-ssize)) rotatedaround(z,ang);
		addto meter doublepath (z+(.5ssize,-.5ssize))--(z+(.5ssize,.5ssize))
		--(z+(1.5ssize,.5ssize))--(z+(1.5ssize,-.5ssize))--cycle;
		addto meter doublepath (z+(ssize,-.5ssize))--(z+(ssize,-ssize));
		addto meter also thelabel(latex("\textsf{W}") scaled (ssize/6mm) 
		rotated (-ang), (z+(ssize,0)));
	fi;
	
	draw meter rotatedaround(z,ang) withpen line;
	
	if labeling=rotatelabel:
		if ((ang > (-90)) && (ang <= 90)) || ((ang > 270) && (ang <= 450)):
			label(latex(name) rotatedaround (.5[mi@#.l,mi@#.r],ang), 
			(.5ssize+lbsep)*dir (90+ang) shifted .5[mi@#.l,mi@#.r]);
		elseif ((ang > 90) && (ang <= 270)) || ((ang > (-270)) && (ang <= (-90))):
			label(latex(name) rotatedaround (.5[mi@#.l,mi@#.r],180+ang), 
			(.5ssize+lbsep)*dir (90+ang) shifted .5[mi@#.l,mi@#.r]);
		fi;
	elseif labeling=norotatelabel:
		if (ang = 0):
			label.top(latex(name), (.5ssize+.25lbsep)*dir (90+ang) 
			shifted .5[mi@#.l,mi@#.r]);
		elseif (ang > 0) && (ang < 90):
			label.ulft(latex(name), (.5ssize)*dir (90+ang) 
			shifted .5[mi@#.l,mi@#.r]);
		elseif (ang = 90):
			label.lft(latex(name),(.5ssize+.25lbsep)*dir (90+ang)
			shifted .5[mi@#.l,mi@#.r]);
		elseif (90 < ang) && (ang < 180):
			label.llft(latex(name),(.5ssize)*dir (90+ang)
			shifted .5[mi@#.l,mi@#.r]);
		elseif (ang = 180) || (ang = (-180)):
			label.bot(latex(name), (.5ssize+.25lbsep)*dir (90+ang) 
			shifted .5[mi@#.l,mi@#.r]);
		elseif ((ang > 180) && (ang < 270)) || ((ang > (-180)) && (ang < (-90))):
			label.lrt(latex(name),(.5ssize)*dir (90+ang)
			shifted .5[mi@#.l,mi@#.r]);
		elseif (ang = 270) || (ang = (-90)):
			label.rt(latex(name), (.5ssize+.25lbsep)*dir (90+ang) 
			shifted .5[mi@#.l,mi@#.r]);
		elseif ((270 < ang) && (ang < 360)) || ((ang < 0) && (ang > (-90))):
			label.urt(latex(name),(.5ssize)*dir (90+ang)
			shifted .5[mi@#.l,mi@#.r]);
		fi;
	fi;
enddef;

// --- Electrical machines (maquinas electricas) ---

TwoTerminal motor(pair beg, real ang, string name, string val)
{
  path pLine;
  TwoTerminal term;
  
  if (type==Up) {
    pLine = (0,0)--(coil,0);
    for (int i=2; i<=4; i+=1)
      pLine = pLine{N}..{S}(i*coil,0);
    pLine = pLine{N}..{S}(5coil,0)--(6coil,0);
  } else if (type==Down) {
    pLine = (0,0)--(coil,0);
    for (int i=2; i<=4; i+=1)
      pLine = pLine{S}..{N}(i*coil,0);
    pLine = pLine{S}..{N}(5coil,0)--(6coil,0);
    // original makecirc changed labelangle to ang-180
  }
  term = TwoTerminal(beg, 6coil, ang, coil, coil, name, val, pLine);
  // original makecirc used .5coil for lcharv
  term.draw();
  return term;
}
	M@#.D=z; M@#.B=(z+(2ssize,0)) rotatedaround(z,ang);
	picture mot; mot=nullpicture;
	
	addto mot doublepath z--(z+(.4ssize,0));
	addto mot doublepath (z+(1.6ssize,0))--(z+(2ssize,0));
	addto mot doublepath fullcircle scaled ssize shifted (z+(ssize,0));
	addto mot also thelabel(latex("\textsf{M}") scaled (ssize/6mm) 
	rotated (-ang), (z+(ssize,0)));
	
	path p,q,r,s,ca,cb,c,hc;
	p=(z+(.6ssize,.075ssize))--(z+(.4ssize,.075ssize));
	q=(z+(.4ssize,.075ssize))--(z+(.4ssize,-.075ssize));
	ca=(z+(.4ssize,-.075ssize))--(z+(.6ssize,-.075ssize));
	
	
	r=(z+(1.4ssize,.075ssize))--(z+(1.6ssize,.075ssize));
	s=(z+(1.6ssize,.075ssize))--(z+(1.6ssize,-.075ssize));
	cb=(z+(1.6ssize,-.075ssize))--(z+(1.4ssize,-.075ssize));
	
	c=fullcircle scaled ssize shifted (z+(ssize,0));
	hc=halfcircle scaled ssize rotated 270 shifted (z+(ssize,0));
	
	addto mot contour buildcycle(p,q,ca,c);
	addto mot doublepath buildcycle(p,q,ca,c);
	
	addto mot contour buildcycle(cb,s,r,hc);
	addto mot doublepath buildcycle(cb,s,r,hc);
	
	draw mot rotatedaround(z,ang) withpen line;
	
	putlabel(M@#.D,M@#.B,.5ssize,.5ssize,ang,name,val);
enddef;

vardef generator@#(expr z,ang,name,val)=
	save gen;
	pair G@#.D, G@#.B; % pines %
	G@#.D=z; G@#.B=(z+(2ssize,0)) rotatedaround(z,ang);
	picture gen; gen=nullpicture;
	
	addto gen doublepath z--(z+(.5ssize,0));
	addto gen doublepath (z+(1.5ssize,0))--(z+(2ssize,0));
	addto gen doublepath fullcircle scaled ssize shifted (z+(ssize,0));
	addto gen also thelabel(latex("\textsf{G}") scaled (ssize/6mm) 
	rotated (-ang), (z+(ssize,0)));
	
	draw gen rotatedaround(z,ang) withpen line;
	
	putlabel(G@#.D,G@#.B,.5ssize,.5ssize,ang,name,val);
enddef;

newinternal mid, Fe, auto;
mid=1; Fe=2; auto=3;

vardef transformer@#(expr z,type,ang)=
	save trafo;
	pair tf@#.pi, tf@#.ps, tf@#.si, tf@#.ss, tf@#.m;
	tf@#.pi=z; tf@#.ps=(z+(0,8coil)) rotatedaround(z,ang);
	tf@#.si=(z+(2.4coil,0)) rotatedaround(z,ang);
	tf@#.ss=(z+(2.4coil,8coil)) rotatedaround(z,ang);
	tf@#.m=(z+(3.4coil,4coil)) rotatedaround(z,ang);
	
	picture trafo; trafo=nullpicture;
	
	if type=normal:
	tf@#.pi=z; tf@#.ps=(z+(0,8coil)) rotatedaround(z,ang);
	tf@#.si=(z+(2.4coil,0)) rotatedaround(z,ang);
	tf@#.ss=(z+(2.4coil,8coil)) rotatedaround(z,ang);
		addto trafo doublepath z--(z+(0,coil)){right}..
		for i=2 upto 6:	{left}(z+(0,i*coil)){right}.. endfor
		{left}(z+(0,7coil))--(z+(0,8coil));
		addto trafo doublepath (z+(coil,coil))--(z+(coil,7coil));
		addto trafo doublepath (z+(1.4coil,coil))--(z+(1.4coil,7coil));
		addto trafo doublepath (z+(2.4coil,0))--(z+(2.4coil,coil)){left}..
		for i=2 upto 6:	{right}(z+(2.4coil,i*coil)){left}.. endfor
		{right}(z+(2.4coil,7coil))--(z+(2.4coil,8coil));
	elseif type=mid:
	tf@#.pi=z; tf@#.ps=(z+(0,8coil)) rotatedaround(z,ang);
	tf@#.si=(z+(2.4coil,0)) rotatedaround(z,ang);
	tf@#.ss=(z+(2.4coil,8coil)) rotatedaround(z,ang);
	tf@#.m=(z+(3.4coil,4coil)) rotatedaround(z,ang);
		addto trafo doublepath z--(z+(0,coil)){right}..
		for i=2 upto 6:	{left}(z+(0,i*coil)){right}.. endfor
		{left}(z+(0,7coil))--(z+(0,8coil));
		addto trafo doublepath (z+(coil,coil))--(z+(coil,7coil));
		addto trafo doublepath (z+(1.4coil,coil))--(z+(1.4coil,7coil));
		addto trafo doublepath (z+(2.4coil,0))--(z+(2.4coil,coil)){left}..
		for i=2 upto 6:	{right}(z+(2.4coil,i*coil)){left}.. endfor
		{right}(z+(2.4coil,7coil))--(z+(2.4coil,8coil));
		addto trafo doublepath (z+(2.4coil,4coil))--(z+(3.4coil,4coil));
	elseif type=Fe:
	tf@#.pi=z rotatedaround(z,ang); tf@#.ps=(z+(0,5.3coil)) rotatedaround(z,ang);
	tf@#.si=(z+(14coil,0)) rotatedaround(z,ang);
	tf@#.ss=(z+(14coil,5.228coil)) rotatedaround(z,ang);
		addto trafo doublepath z+(2coil,-2.5coil)--z+(12coil,-2.5coil)
		--z+(12coil,7.5coil)--z+(2coil,7.5coil)--cycle;
		addto trafo doublepath z+(4coil,-.5coil)--z+(10coil,-.5coil)
		--z+(10coil,5.5coil)--z+(4coil,5.5coil)--cycle;
		addto trafo doublepath z--z+(2coil,0)--z+(4coil,0.728coil)
		{right}..{left}z+(4coil,1.3*coil);
		for i=1 upto 4:
			addto trafo doublepath z+(2coil,(i+.5)*coil){left}..
			{right}z+(2coil,i*coil)--z+(4coil,(i+0.728)*coil)
			{right}..{left}z+(4coil,(i+1.3)*coil);
		endfor;
		addto trafo doublepath z+(2coil,5.3coil)--z+(0,5.3coil);
		for i=0 upto 3:
			addto trafo doublepath z+(10coil,i*coil){left}..
			{right}z+(10coil,(i+.5)*coil)--z+(12coil,(i+.5+0.728)*coil)
			{right}..{left}z+(12coil,(i+.656)*coil);
		endfor;
		addto trafo doublepath z+(10coil,4coil){left}..{right}
		z+(10coil,4.5coil)--z+(12coil,5.228coil)--z+(14coil,5.228coil);
		addto trafo doublepath z+(12coil,0)--z+(14coil,0);
	elseif type=auto:
	tf@#.pi=z rotatedaround(z,ang); tf@#.ps=(z+(0,4coil)) rotatedaround(z,ang);
	tf@#.si=(z+(4coil,-6coil)) rotatedaround(z,ang);
	tf@#.ss=(z+(4coil,4coil)) rotatedaround(z,ang);
		addto trafo doublepath z--z+(2coil,0);
		addto trafo doublepath z+(2coil,-6coil)--z+(2coil,-5coil){right}..
		for i=2 upto 10: {left}(z+(2coil,(i-6)*coil)){right}.. endfor
		{left}(z+(2coil,5coil))--z+(2coil,6coil)--z+(0,6coil);
		addto trafo doublepath z+(2coil,6coil)--z+(4coil,6coil);
		addto trafo doublepath z+(2coil,-6coil)--z+(4coil,-6coil);
	fi;
	
	draw trafo rotatedaround(z,ang) withpen line;
enddef;

//%%<--- Miscellaneous symbols --->%%%

newinternal gndlth, implth, simple, shield;
gndlth=5mm; implth=7mm; simple=1; shield=2;

vardef ground@#(expr z,type,ang)=
	save GND;
	pair gnd@#; % unico pin %
	gnd@#=z;
	picture GND; GND=nullpicture;
	addto GND doublepath z--(z+(0,-.5gndlth)) withpen line;
	if type=shield:
		addto GND doublepath (z+(-.5gndlth,-.5gndlth))--(z+(.5gndlth,-.5gndlth)) withpen line;
		addto GND doublepath (z+(-.35gndlth,-.6gndlth))--(z+(.35gndlth,-.6gndlth)) withpen line;
		addto GND doublepath (z+(-.2gndlth,-.7gndlth))--(z+(.2gndlth,-.7gndlth)) withpen line;
	elseif type=simple:
		addto GND doublepath (z+(-.5gndlth,-.5gndlth))--(z+(.5gndlth,-.5gndlth)) 
		withpen pencircle scaled 2linewd;
	fi;
	draw GND rotatedaround(z,ang);
enddef;

newinternal junctiondiam;
junctiondiam=1.25mm;

vardef junction@#(expr z,name)(suffix $)=
	pair J@#; J@#=z;
	draw z withpen pencircle scaled junctiondiam;
	label.$(latex(name),z);
enddef;

vardef impedance@#(expr z,ang,name,val)=
	save imp;
	pair Z@#.l, Z@#.r; % pines %
	Z@#.l=z;
	Z@#.r=(z+(1.5implth,0)) rotatedaround(z,ang);
	picture imp; imp=nullpicture;
	
	addto imp doublepath z--(z+(.25implth,0));
	addto imp doublepath (z+(.25implth,-.18implth))--(z+(.25implth,.18implth))
	--(z+(1.25implth,.18implth))--(z+(1.25implth,-.18implth))--cycle;
	addto imp doublepath (z+(1.25implth,0))--(z+(1.5implth,0));
		
	draw imp rotatedaround(z,ang) withpen line;
	
	putlabel(Z@#.l,Z@#.r,.2implth,.2implth,ang,name,val);
enddef;

vardef lamp@#(expr z,ang,name,val)=
	save ampl, p, q, r, s;
	pair La@#.l,La@#.r; % pines %
	La@#.l=z; La@#.r=(z+(2ssize,0)) rotatedaround(z,ang);
	
	picture ampl; ampl=nullpicture;
	
	addto ampl doublepath z--(z+(.5ssize,0));
	addto ampl doublepath fullcircle scaled ssize shifted (z+(ssize,0));
	addto ampl doublepath (z+(1.5ssize,0))--(z+(2ssize,0));
	
	pair p, q, r, s;
	p=(-ssize*dir 45 shifted (z+(ssize,0))--(z+(ssize,0))) intersectionpoint
	(fullcircle scaled ssize shifted (z+(ssize,0)));
	q=(ssize*dir 45 shifted (z+(ssize,0))--(z+(ssize,0))) intersectionpoint
	(fullcircle scaled ssize shifted (z+(ssize,0)));
	r=(-ssize*dir (-45) shifted (z+(ssize,0))--(z+(ssize,0))) intersectionpoint
	(fullcircle scaled ssize shifted (z+(ssize,0)));
	s=(ssize*dir (-45) shifted (z+(ssize,0))--(z+(ssize,0))) intersectionpoint
	(fullcircle scaled ssize shifted (z+(ssize,0)));
	
	addto ampl doublepath p--q;
	addto ampl doublepath r--s;
	
	draw ampl rotatedaround(z,ang) withpen line;
	
	putlabel(La@#.l,La@#.r,.5ssize,.5ssize,ang,name,val);
enddef;


//%%<--- Mesh current (corriente de malla) --->%%%

newinternal cw, ccw;
cw=0; ccw=1;

def imesh(expr c,wd,ht,dire,ang,name)=
	save im,r; picture im; numeric r;
	ahlength=3platsep; ahangle=20;
	if ht > wd: r=.2wd elseif ht < wd: r=.2ht fi;
	im=nullpicture;
	if dire=cw:
		addto im doublepath (xpart c - .5wd, ypart c - .5ht)
		--(xpart c - .5wd, ypart c + .5ht-r){up}
		..{right}(xpart c - .5wd + r, ypart c + .5ht)
		--(xpart c + .5wd - r, ypart c + .5ht){right}
		..{down}(xpart c + .5wd,ypart c + .5ht - r)
		--(xpart c + .5wd,ypart c - .5ht + r){down}
		..{left}(xpart c + .5wd - r,ypart c - .5ht)
		--(xpart c - .25wd, ypart c - .5ht);
		addto im contour arrowhead (xpart c - .5wd, ypart c - .5ht)
		--(xpart c - .5wd, ypart c + .5ht-r){up}
		..{right}(xpart c - .5wd + r, ypart c + .5ht)
		--(xpart c + .5wd - r, ypart c + .5ht){right}
		..{down}(xpart c + .5wd,ypart c + .5ht - r)
		--(xpart c + .5wd,ypart c - .5ht + r){down}
		..{left}(xpart c + .5wd - r,ypart c - .5ht)
		--(xpart c - .25wd, ypart c - .5ht);
	elseif dire=ccw:
		addto im doublepath (xpart c + .5wd, ypart c - .5ht)
		--(xpart c + .5wd, ypart c + .5ht-r){up}
		..{left}(xpart c + .5wd - r, ypart c + .5ht)
		--(xpart c - .5wd + r, ypart c + .5ht){left}
		..{down}(xpart c - .5wd,ypart c + .5ht - r)
		--(xpart c - .5wd,ypart c - .5ht + r){down}
		..{right}(xpart c - .5wd + r,ypart c - .5ht)
		--(xpart c + .25wd, ypart c - .5ht);
		addto im contour arrowhead (xpart c + .5wd, ypart c - .5ht)
		--(xpart c + .5wd, ypart c + .5ht-r){up}
		..{left}(xpart c + .5wd - r, ypart c + .5ht)
		--(xpart c - .5wd + r, ypart c + .5ht){left}
		..{down}(xpart c + .5wd,ypart c + .5ht - r)
		--(xpart c - .5wd,ypart c - .5ht + r){down}
		..{right}(xpart c - .5wd + r,ypart c - .5ht)
		--(xpart c + .25wd, ypart c - .5ht);
	fi;
	
	if labeling=rotatelabel:
		addto im also thelabel(latex("$" & name & "$"),c);
	elseif labeling=norotatelabel:
		addto im also thelabel(latex("$" & name & "$") rotatedaround(c,-ang),c);
	fi;
	
	draw im rotatedaround (c,ang) withpen line;
enddef;

//%%<--- Reostatos --->%%%

newinternal rheolth, Rrheo, Lrheo; 
rheolth=2mm; Rrheo=1; Lrheo=2;

vardef rheostat@#(expr z,type,ang)=
	save reo; picture reo; reo=nullpicture;
	pair rh@#.i, rh@#.s, rh@#.r;
	rh@#.i=z; rh@#.s=(z+(0,6rheolth)) rotatedaround(z,ang);
	rh@#.r=(z+(3rheolth,6rheolth)) rotatedaround(z,ang);
	
	ahangle=20; ahlength=rheolth;

	if type=Lrheo:
		addto reo doublepath (z+(6rheolth,-3rheolth))--(z+(4rheolth,-3rheolth))
		--(z+(4rheolth,-.7rheolth));
		addto reo contour arrowhead (z+(6rheolth,-3rheolth))--(z+(4rheolth,-3rheolth))
		--(z+(4rheolth,-.9rheolth));
	
		addto reo doublepath z--(z+(rheolth,0)){down}.. for i=2 upto 4:
		{up}(z+(i*rheolth,0)){down}.. endfor {up}(z+(5rheolth,0))--(z+(6rheolth,0));
	
		reo=reo rotatedaround(z,90);
	elseif type=Rrheo:
		addto reo doublepath (z+(6rheolth,-3rheolth))--(z+(4rheolth,-3rheolth))
		--(z+(4rheolth,-.7rheolth));
		addto reo contour arrowhead (z+(6rheolth,-3rheolth))--(z+(4rheolth,-3rheolth))
		--(z+(4rheolth,-.9rheolth));
	
		addto reo doublepath z--(z+(1.5rheolth,0))--(z+(1.75rheolth,.75rheolth))--
		for i=.5 step .5 until 2.5:	(z+((1.75+i)*rheolth,((-1)**(2i))*.75rheolth))--
		endfor (z+(4.5rheolth,0))--(z+(6rheolth,0)) withpen line;
	
		reo=reo rotatedaround(z,90);
	fi;
	draw reo rotatedaround(z,ang) withpen line;
enddef;

*/
