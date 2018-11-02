import cse5;
import twlCirclePath;

real Norm(pair p) {
    return sqrt((p.x)^2 + (p.y)^2);
}

path Link(object o1, object o2) {
    pair a = point(o2, (0,0)) - point(o1, (0,0));
    return point(o1, a) -- point(o2, -a);

    //pair m3 = point(o2, (0,0)) - point(o1, (0,0));
    //pair m1 = rotate(22.5, point(o1, (0,0)))*point(o1, m3) - point(o1, (0,0)),
    //m2 = point(o2, (0,0)) - rotate(-22.5, point(o2, (0,0)))*point(o2, -m3);
    ////D(m1 -- point(o1, (0,0)), blue);
    ////D(m2 -- point(o2, (0,0)), red);
    ////D(m1 -- m2);
    //D(point(o1, m3) {m1} .. {m2} point(o2, -m3), Arrow);
}
path Link(object o1) {
    pair m3 = point(o1, (0,0));
    pair m1 = rotate(22.5)*m3,
         m2 = rotate(-22.5)*m3;

    real norm = Norm(m3);
    pair m3N = m3 / norm;

    return point(o1, m1) {m1} .. point(o1, m3) + 1cm*m3N .. {-m2} point(o1, m2);
}

pair[] genCoors(int n, real radius = 2cm, pair z = (0,0), real rot = 0) {
    pair[] coor;
    path circ = circle(0, radius);
    for (int i = 0; i < n; ++i)
        coor.push(z+rotate(rot)*WP(circ, i / n));
    return coor;
}

object Vertex(picture pic=currentpicture, Label L, pair position, pen p=currentpen) {
    return draw(pic, L, circle, position, p);
}
object Vertex(picture pic=currentpicture, pair position, pen p=currentpen) {
    return draw(pic, "", circle, position, p, Fill);
}

object[] genObjects(pair[] coors) {
    object[] obj;
    for (int i = 0; i < coors.length; ++i)
        obj.push(Vertex(coors[i]));
    return obj;
}
object[] genObjects(pair[] coors, Label[] labels) {
    object[] obj;
    for (int i = 0; i < coors.length; ++i)
        obj.push(Vertex(labels[i], coors[i]));
    return obj;
}

void Edges(picture pic=currentpicture, object[] obj, int[] edges, pen p=currentpen) {
    for (int i = 0; i < edges.length / 2; ++i)
        draw(pic, Link(obj[edges[2*i]], obj[edges[2*i+1]]), p);
}

object V(picture pic=currentpicture, Label L, pair position, pen p=currentpen) = Vertex;
object V(picture pic=currentpicture, pair position, pen p=currentpen) = Vertex;
path L(object o1, object o2) = Link;
path L(object o1) = Link;
