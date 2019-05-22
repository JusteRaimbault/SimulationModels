package swarmchemistry

import scala.util.Random

case class SwarmIndividual(
                          position: Position,
                          speed: Position,
                          parameters: SwarmParameters
                          // rankInXOrder: Int, rankInYOrder: Int, rankInZOrder: Int
                          ) {



  def accelerate(a: Position,maxMove: Double): SwarmIndividual = {
    this.copy(speed = (speed + a) normalize(maxMove))
  }

  def move: SwarmIndividual = this.copy(position = position + speed )

}


object SwarmIndividual {

  /**
    * random individual in world dimensions
    * @param worldDim
    * @return
    */
  def apply(worldDim: Position)(implicit rng: Random): SwarmIndividual = SwarmIndividual(
    Position(Position(),worldDim),Position(Position(-5.0),Position(10.0)),SwarmParameters(rng)
  )

  def apply(worldDim: Position,params: SwarmParameters)(implicit rng: Random): SwarmIndividual = SwarmIndividual(
    Position(Position(),worldDim),Position(Position(-5.0),Position(10.0)),params
  )

}


