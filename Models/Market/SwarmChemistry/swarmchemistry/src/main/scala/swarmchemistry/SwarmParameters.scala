package swarmchemistry

import scala.util.Random

case class SwarmParameters(
                            neighborhoodRadius: Double,
                            normalSpeed: Double,
                            maxSpeed: Double,
                            c1 : Double,
                            c2: Double,
                            c3: Double,
                            c4: Double,
                            c5: Double
                          )


object SwarmParameters {

  val numberOfIndividualsMax = 300
  val neighborhoodRadiusMax = 300
  val normalSpeedMax = 20
  val maxSpeedMax = 40
  val c1Max = 1
  val c2Max = 1
  val c3Max = 100
  val c4Max = 0.5
  val c5Max = 1


  def apply(implicit rng: Random): SwarmParameters = SwarmParameters(
    neighborhoodRadiusMax*rng.nextDouble,
    normalSpeedMax*rng.nextDouble,
    maxSpeedMax*rng.nextDouble,
    c1Max*rng.nextDouble,
    c2Max*rng.nextDouble,
    c3Max*rng.nextDouble,
    c4Max*rng.nextDouble,
    c5Max*rng.nextDouble
  )

  //def apply(p1: Double,p2: Double,p3: Double,p4: Double,p5: Double,p6: Double,p7: Double,p8: Double)

  def apply(params: SwarmParameters): SwarmParameters = {
    SwarmParameters(
      bounded(params.neighborhoodRadius,0,neighborhoodRadiusMax),
      bounded(params.normalSpeed,0,normalSpeedMax),
      bounded(params.maxSpeed,0,maxSpeedMax),
      bounded(params.c1,0,c1Max),
      bounded(params.c2,0,c2Max),
      bounded(params.c3,0,c3Max),
      bounded(params.c4,0,c4Max),
      bounded(params.c5,0,c5Max)
    )
  }


  def mutate(rate: Double,magnitude: Double,params: SwarmParameters)(implicit rng: Random): SwarmParameters = {
    SwarmParameters(
      SwarmParameters(
        if (rng.nextDouble < rate) params.neighborhoodRadius + (rng.nextDouble - 0.5)*magnitude*neighborhoodRadiusMax  else params.neighborhoodRadius,
        if (rng.nextDouble < rate) params.normalSpeed + (rng.nextDouble - 0.5)*magnitude*normalSpeedMax else params.normalSpeed,
        if (rng.nextDouble < rate) params.maxSpeed + (rng.nextDouble - 0.5 )*magnitude*maxSpeedMax else params.maxSpeed,
        if (rng.nextDouble < rate) params.c1 + (rng.nextDouble - 0.5)*magnitude*c1Max else params.c1,
        if (rng.nextDouble < rate) params.c2 + (rng.nextDouble - 0.5)*magnitude*c2Max else params.c2,
        if (rng.nextDouble < rate) params.c3 + (rng.nextDouble - 0.5)*magnitude*c3Max else params.c3,
        if (rng.nextDouble < rate) params.c4 + (rng.nextDouble - 0.5)*magnitude*c4Max else params.c4,
        if (rng.nextDouble < rate) params.c5 + (rng.nextDouble - 0.5)*magnitude*c5Max else params.c5
      )
    )
  }


}
