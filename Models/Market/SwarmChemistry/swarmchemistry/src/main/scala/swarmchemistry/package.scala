
import scala.util.Random


/**
  *
  * Adaptation of Object Harvesting for Swarm Chemistry
  *   Sayama, H. (2018, July). Seeking open-ended evolution in Swarm Chemistry II: Analyzing long-term dynamics via automated object harvesting. In Artificial Life Conference Proceedings (pp. 59-66). One Rogers Street, Cambridge, MA 02142-1209 USA journals-info@ mit. edu: MIT Press.
  *
  *  author source code from http://bingweb.binghamton.edu/~sayama/SwarmChemistry/
  *
  */
package object swarmchemistry {




  case class Position(
                     x: Double,
                     y: Double,
                     z: Double
                     ) {

    def +(p: Position): Position = Position(x+p.x,y+p.y,z+p.z)

    def *(alpha: Double): Position = Position(alpha*x,alpha*y,alpha*z)

    def normalize(maxMove: Double): Position = {
      val d = x * x + y * y + z * z
      val normalizationFactor = maxMove / math.sqrt(d)
      if (d > maxMove * maxMove) this*normalizationFactor else this.copy()
    }

  }

  object Position {
    def apply(mi: Position,ma: Position)(implicit rng: Random): Position = Position(mi.x + ma.x*rng.nextDouble,mi.y + ma.y*rng.nextDouble,mi.z + ma.z*rng.nextDouble)
    def apply(): Position = Position(0.0,0.0,0.0)
    def apply(alpha: Double) = Position(alpha,alpha,alpha)
  }




  def bounded(p: Double,mi: Double, ma: Double): Double = math.max(math.min(p,ma),mi)

  def bounded(p: Int,mi: Int, ma: Int): Int = math.max(math.min(p,ma),mi)

}
