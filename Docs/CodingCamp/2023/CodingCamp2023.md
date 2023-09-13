# Coding Camp 2023

## Organisation

*The coding camp is self-organised. On the first day, we will take some time to discuss the proposals below and organise into working groups (from 1 person to all) for each one confirmed, depending on interests and convergences. To foster exchanges, we will try to have at least one seminar per day, and to gather in the evening to share our progress (not mandatory). The last half-day will be dedicated to wrapping up and discussing the next OpenMOLE season (until the next Coding Camp).*

## Presentations

*We can have once a day a ~1h seminar from someone wanting to share his research, OpenMOLE success stories, new ideas, project proposal, etc.; please add yourself here with the theme if you would like to present.*


**Faire une visio  pour les collègues lointains !!!!**

- [name=Juste] Multiscale urban models: exploration and validation pitfalls
- [name=Juste] A proposal for model typologies based on process decomposition
- [name=Paul] (If I'm ready) A panorama on distances, to be used for calibration or other metrics/measures (Pierre: acoustical distance will be part of it ? ;))
- [name=Romain] An Incomplete State of OpenMOLE (visio day 1?)
- [name=Etienne] ComExp (Companion Exploration) a cas study in Sénégal with PSE
- [name=Etienne] From game to simulation: stimulating avenues to follow with OpenMole : perspectives on Niayes in Senegal
- [name=Kirana] Systematic literature review of ABMs simulating wildlife disturbances (work in progress)
- [name=Kirana] BORNEO: ABM simulation of orangutan movement behaviour and the model exploration with OpenMOLE

## Projects

*Projects you would like to work on.*

- [name=Juste]
    - Benchmark of stochastic multi-objective optimisation methods
        - [x] try to compile mgo-benchmark with minimal updates [11/07]
        - update libs and scala (in progress) [12/07]
        - create a dockerfile 
    - OSE method: progress on paper (concurrent inverse problem method to implement, benchmark)
    - Spatial sensitivity: theoretical framing for Saltelli-like indicators (student coming in September)
        - [x] brainstorm & draft setup; abstract for CCS 2023 [10/07]
    - Implement more Sources
    - [x] Merge proxyJump branch for ssh jump access to environments [10/07] - to merge: https://github.com/openmole/openmole/pull/550
    - Morris: replications?
    - omr format and interoperability, link with the Subdense project (postdoc Feb. 2024) and a git-based interactive dashboard
    - Test NSGA3
    - [x] Model classification through process decomposition [11/07]
    - [x] Debug JuliaTask (ICI) [11/07]
    - [x] Multiscale modeling: poster ALife 2023 [13/07]

- [name=Paul]
    - First steps in Noisemodeling calibration vs. Paysages Sonores Nantais DB with Jonathan
    - Guided tour of OpenMOLE with Aman, towards alert sirens localisation optimisation  

- [name=Pierre]
    - Set up again the optimization chain for siren localisation with Aman.
    - Help Jonathan to have a working acoustic model (see above)  

- [name=Etienne]
    - With Oleks, work on the workflow enbeding Cormas in OpenMole (based on this [docker](https://hub.docker.com/r/elcep/cormas)) and a primitive maide by Romain years ago
    - take a look on [Ocelet](http://www.ocelet.fr/) exploration
    - Discuter avec Juste de PSE et OSE avec l'impementation de [SEIR](https://github.com/ElCep/repro-seir) du travail avec Dr Duboz

- [name=Aurélien]
    - PSE method: parameter exploration for a farm interactions model
    - Upscale simulations with a cluster
    - First steps in sensitivity analysis: documentation and application to compare model outputs for different scenarios

- [name=Cécile]
    - Exploration road-map: finish the map-like presentation of OpenMole methods
    - Documentation
    - Spatial causal inference: OpenMole methods for causal uncertainty?

- [name=Kirana]
    - Learn project MO3 (Romain?)
    - Learn PSE 
    - Documentation of model exploration (with a case of BORNEO)
    - How to perform ABM exploration: Classification of methods which has been used for Agent-based model validation / exploration, with a specific case of ABMs in the field of wildlife disturbances (ongoing manuscript from a thesis chapter). 