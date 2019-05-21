package swarmchemistry



case class SwarmIndividual(
                          position: Position,
                          speed: Position,
                          parameters: SwarmParameters
                          )

public SwarmParameters genome;
public int rankInXOrder, rankInYOrder, rankInZOrder;

public SwarmIndividual() {
this(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, new SwarmParameters());
}

public SwarmIndividual(double xx, double yy, double zz, double dxx, double dyy, double dzz, SwarmParameters g) {
x = xx;
y = yy;
z = zz;
dx = dx2 = dxx;
dy = dy2 = dyy;
dz = dz2 = dzz;
genome = g;
rankInXOrder = 0;
rankInYOrder = 0;
rankInZOrder = 0;
}

public void accelerate(double ax, double ay, double az, double maxMove) {
dx2 += ax;
dy2 += ay;
dz2 += az;

double d = dx2 * dx2 + dy2 * dy2 + dz2 * dz2;
if (d > maxMove * maxMove) {
double normalizationFactor = maxMove / Math.sqrt(d);
dx2 *= normalizationFactor;
dy2 *= normalizationFactor;
dz2 *= normalizationFactor;
}
}

public void move() {
dx = dx2;
dy = dy2;
dz = dz2;
x += dx;
y += dy;
z += dz;
}




object SwarmIndividual {



}
