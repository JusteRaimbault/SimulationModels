package swarmchemistry

import scala.collection.mutable.ArrayBuffer
import scala.util.Random

case class SwarmPopulation(
                          population: Seq[SwarmIndividual],
                          title: String
                          )


object SwarmPopulation {

  def apply(n: Int, title: String, worldDim: Position)(implicit rng: Random): SwarmPopulation = {
    val params = SwarmParameters(rng)
    SwarmPopulation(
      Seq.fill(n)(SwarmIndividual(worldDim,params)),
      title
    )
  }

  def apply(prevpop: SwarmPopulation,title: String, worldDim: Position)(implicit rng: Random): SwarmPopulation = SwarmPopulation(
    Seq.tabulate(prevpop.population.size)(i => SwarmIndividual(worldDim,prevpop.population(i).parameters)),
    title
  )

  def apply(pop1: SwarmPopulation, pop2: SwarmPopulation,rate: Double,title: String,worldDim: Position)(implicit rng: Random): SwarmPopulation = {
    val tmppop = new ArrayBuffer[SwarmIndividual]()
    for (i <- 0 to (pop1.population.size + pop2.population.size)/ 2){
      val source = if (rng.nextDouble < rate) pop1 else pop2
      tmppop.append(SwarmIndividual(worldDim,source.population((rng.nextDouble*source.population.size).toInt).parameters))
    }
    SwarmPopulation(tmppop.toSeq,title)
  }


  def perturbate(pcm: Double,spaceDim: Double,pop: SwarmPopulation)(implicit rng: Random): SwarmPopulation = {
    val size = bounded((pop.population.size * (1 + ((rng.nextDouble * 2.0 - 1.0) * pcm ))).toInt,1,SwarmParameters.numberOfIndividualsMax)
    val tmppop = new ArrayBuffer[SwarmIndividual]()
    for (i <- 0 to size){
      tmppop.append(SwarmIndividual(Position(spaceDim),pop.population((rng.nextDouble*pop.population.size).toInt).parameters))
    }
    SwarmPopulation(tmppop.toSeq,pop.title)
  }

}