---
tags: exmodelo, dsl
title: eX Modelo Summer School
slideOptions:
  theme: 'white'
  transition: 'fade'
 
---
  <style>
    .reveal .slides section {
        font-size: 30px;
        text-align: left;
        color: #666;
    }   
    
    .reveal .slides section h2{
        font-size: 40px;
        color: #37abc8;
    }
    
    .reveal blockquote {
        margin-top:20px;
        padding: 0 1em;
        color: #999;
        border-left: 0.25em solid #ddd;
        box-shadow:none;
        font-size:35px;
        font-style:normal;
        width:100%;
    }
    
    .reveal a {
    color: #0c2c85;
    }
    
.reveal .slides section img { 
  background: none;
  border: none;
  box-shadow: none;
  display: block;
  margin: 10px auto;
    max-width:100%;
    max-height:100%;
}
    
    .reveal .slides {
         display: block;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
  background: url(https://miniocodimd.openmole.org:443/codimd/uploads/upload_3d8c8d9cf6036122fc2fca8f07dd9ee3.png) no-repeat 100% 100%;
        background-attachment:fixed;
        background-size: 170px auto;
    }
    
</style>


<h1 style="width:82%">
eX Modelo
</h1>
<h2>
Retour d’expérience
</h2>
</h2>

![](https://miniocodimd.openmole.org:443/codimd/uploads/upload_33251a691293639535cde0b95c6057d4.png)

#### Mathieu Leclaire (ISC-PIF), Sebastien Rey (Idées) , Béatrice Charton (CRIANN), Hélène Arduin (B2PHI), Paul Chapron (LaSTIG), Guillaume Chérel (ISC-PIF), Etienne Delay (Cirad), Benoist Gaston (CRIANN), François Lavallée (IRSTEA), Jonathan Passerat-Palmbach (BioMedia), Pierre Peigne (Ecole 42), Julien Perret (LaSTIG), Juste Raimbault (CASA), Romain Reuillon (ISC-PIF)

---

## Modélisateurs en SHS

- pratiques HPC assez peu répandues
- pratiques d'exploration de modèles peu connues
- peu d'accès aux ressources et peu d'ingénieurs dédiés

---

## OpenMOLE et les modèles Systèmes Complexes


- **embarque les codes numériques** des modélisateurs (quelque soit le langage)

- propose un DSL pour **réaliser des analyses avancées d'exploration du modèles** (analyse de sensibilité, calibrage, optimisation, étude de la diversité, etc)

- **distribue la charge de l'execution** sur des environnements de calcul haute performance (quelque soit le l'infrastructure: serveur, cluster, grille, cloud)

---

## La communauté OpenMOLE

- logiciel développé depuis 10 ans
- environ 25 contributeurs logiciel
- des coding camp (10-15 personnes) annuels depuis 4 ans

![](https://miniocodimd.openmole.org:443/codimd/uploads/upload_70cc6d27b1f67ec9659e9e550ded7680.jpg =500x)


---

## Calcul sur la vo complex-systems

![](https://miniocodimd.openmole.org:443/codimd/uploads/upload_4477237c8666586773f2f2a550c04390.png)

---

## Nos objectifs de l'école

- toucher un public large: **doctorants, chercheurs, entreprise**
- donner un **enseignement théorique** sur les méthodes d'exploration
- enseigner **l'usage d'OpenMOLE par la pratique** autour d'un modèle jouet
- mettre les participants en situation de **Challenge par groupe**

---

## Les enjeux pédagogiques (1/2)

- *Start from scratch* sur le plan du contenu
- Documentation à jour
- Branche logicielle stabilisée
- Contenu pédagogique Open-Source reproductible
- Mise à disposition des ressources informatiques:
    - Machines virtuelles avec 1 OpenMOLE/pers.
    - HPC >= 200 coeurs/groupe
    - construction du modèle jouet pour l'exploration

---

## Les enjeux pédagogiques (2/2): le modèle Zombie
- rapidité d'exécution (< 1 seconde)
- peu de mécanismes, des observables ouvrant sur une complexité d'analyse
- un challenge d'exploration que nous nous sommes imposé à nous-même

---

## Audience

![](https://miniocodimd.openmole.org:443/codimd/uploads/upload_f9de517b7ba932c92b13b91323072c6f.jpg =700x)

---

## Audience

| Doctorants | Chercheurs | Entreprises |
| :--------: | :--------: | :--------: |
| 14 |8|3|

---

## Audience

| FRA | IND | ITA | BFA | RUS | IDN | GER | ENG | US |
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:
| 14 |3|2|1|1|1|1|1|1|

---

## Audience

### Laboratoires
| CNRS | CIRAD | Entreprise | INRA | IRSTEA | IFSTTAR | Pasteur|
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|4|4|3|2|1|1|1|

<br/>

### Universités
|**TU Dresden** | **Luxembourg** | **Groningen** | **UCL** | **Oxford** | **ULB**|
:--:|:--:|:--:|:--:|:--:|:--:|
1|1|1|1|1|1|

---

## Audience


| Hommes | Femmes |
| :--------: | :------: |
| 17 |8|

---

## Le modèle Zombie  : Démonstration

{%youtube Dji1W-Q6yQY %}

---

## Le modèle Zombie

![](https://miniocodimd.openmole.org/codimd/uploads/upload_0d3b891fec1dac0f973db27f25c2a3e5.png)

![](https://miniocodimd.openmole.org/codimd/uploads/upload_7cee01edf98c8bab219b8c285a97b49d.png)

![](https://miniocodimd.openmole.org/codimd/uploads/upload_03a80cac121aedd97829cd6b02c2cdbc.png)


---

## Les options du modèle Zombie

- **Armée** : Tue des Z.
- **Croix-Rouge** : Soin des H.
- **Pièges** : Capture des Z.
- **Espace** : Fixé ou Procédural

---

## Le programme

  - Objectifs de l'exploration des modèles - théorie
  - Les méthodes d'exploration dans OpenMOLE: théorie puis application
  - Le challenge (1,5 j)
    - 1 question / groupe => 5 groupes
    - application des méthodes & modification code
    - restitution collective

---

## Le Challenge

![](https://miniocodimd.openmole.org:443/codimd/uploads/upload_f2151456237a211060cd1db04df64491.jpg =700x)

---

#### Groupe 1 / *Visionnaries* p

- **Principe :** Des lunettes permettent aux H. de voir plus loin
- **Question(s) :** 
    1. Quel est l'effet de la distance de perception des lunettes
    2. Quel est l'effet de la proportion d'H. équipés de telles lunettes
- **Objectif :** Minimiser le nombre d'infection / Maximiser le nombre d'H échappés
- **Méthode(s) :** Calibration(NSGA2), Analyse de sensibilité (Sobol)
- **Résultats :** effet positif et significatif sur H., pas d'effet sur l'armée ni la croix rouge

---

#### Groupe 2 /  *Body and Soul* 

- **Principe :** Simuler pour optimiser la politique de gestion de l'infection 
- **Question(s):** 
    - 1. Dans un contexte de ressources limitées, faut-il faire porter l'effort de formation sur les civils ou les militaires ? 
    - 2. Pour les civils, faut-il former à l'évacuation ou au combat ? 
- **Méthode(s) :** Analyse de sensibilité, Calibration et variations de scénarios
- **Résultats :** Simulations peu sensibles à la taille de la population. Armée et civils sont formé de façon indépendantes, il n'y a pas de trade-off entre la formation des civils et celle de l'armée 


---

#### Groupe 3 / *Coexistence between H and Z*

- **Principe :** Ce que tu ne peux pas changer , il faut l'accepter  ...
- **Question :** Dans quelles conditions pourrait-on vivre avec les Z à long terme en jouant sur la structure de l'environnement ?
- **Objectif :** Maintenir la population d'H. constante en jouant sur la tailles de l'environnement et des issues
- **Méthode(s) :** PSE, Calibration (NSGA2)
- **Résultats :** Modèle démographique par l'espace et une marche aléatoire

---

#### Groupe 4 / *Slow Food*

- **Principe :** Les "slow food" , i.e. H. qui connaissent l'emplacement des issues, sont très lents, et sont les seuls à pouvoir diffuser l'information. Pour s'enfuir, les **H doivent coopérer !** 
- **Question/Objectif :** Evaluer le coût humain de la coopération en contraignant la diffusion de l'information entre H. 
- **Méthode(s) :** Echantillonage direct de l'espace de paramètres, Calibration (NSGA2)
- **Résultats:** Trade-off entre le nombre d'infection et le nombre d'H. "slow food"

---

## Feedback OpenMOLE <-> CRIANN 


### <img height="60px" src="https://miniocodimd.openmole.org:443/codimd/uploads/upload_1608f62e7ea99855ad1a57c510a991ea.png"> 
<strong>Méso-centre Normandie, partenaires d'eX Modelo !!</strong>
    
<img height="200px" align="center" src="https://miniocodimd.openmole.org:443/codimd/uploads/upload_a64c548d6b79a79aaf14311b3ea4c1b7.png">

<div style="text-align:left";>
<small>
<b>Myria (600 TFlops): </b> <br>
- 11144 coeurs Intel Broadwell <br>
- 20 GPU nodes <br>
- 100 Gbps réseau <br>
- 2.5 Po de stockage<br>
</small>
</div>

---

## Feedback OpenMOLE

- Cas d'utilisation différent de la grille
    - amélioration support SLURM ds gridscale 
        - WallTime, Reservation, Nodes, etc.
    - fiabilité forte => resoumission automatique inutile...
    - gestion thread => + controle sur Java ... 
    - Sécurité => Container impossible
    - NFS => Ecriture fichiers => workdirectory autre que /home.  
    - meilleure gestion des connexions SSH
- Futur développements ? 
    - Outils de monitoring + poussés
    - Container cluster-compatible : singularity, charliecloud
    - GPU (déjà en test) 

---

## Feedback CRIANN

**Environnement de tests et formation**
  - 1 compte par formateur + 8 comptes élèves (1 compte = 1 groupe)
  - accès au cluster pour les formateurs courant mai 2019
    - tests sur Myria avec surveillance de l'équipe Calcul sur le comportement des calculs
    - mises en place de réservations 1008 coeurs afin de tester la montée en charge des calculs
  - Semaine de cours
    - 1008 coeurs dédiés pendant une semaine pour les comptes formateurs + élèves

---

## Feedback CRIANN

**Contraintes OpenMOLE sur le cluster Myria**
  - milliers de tous petits calculs très courts sur 1 coeur (~200 jobs simultanés par utilisateurs)
    - regroupement des calculs pour durer au moins 5-10 minutes
    - démarrage de 28 jobs simultanés par identifiant (au lieu de 2)
  - problème de charge sur les noeuds (`load=300` pour 28 coeurs)
    - application java réalisant des IO mal gérées par GPFS
    - écriture dans /tmp au lieu du home-dir GPFS
  - problème d'arrêt des applications Java
    - augmentation de la durée max d'agonie des processus (UnkillableStepTimeout=180)
  - nombre de fichiers dans les dossiers
    - nettoyage automatique en fin de calculs

---

## Feedback CRIANN 

**Bilan très positif coté CRIANN**
  - **125 377 h 05 min** consommées par les tests + la formation
  - **1 526 921 calculs** exécutés par les tests + la formation
    - nombre incrémenté des calculs augmenté de 6M. "Faux" calculs pour estimer les temps d'attente ?
  - pas de problèmes/pannes de Slurm pendant la semaine de formation
  - nombre de coeurs réservés supérieur au nombre de coeurs utilisé par les calculs
    - pas de temps d'attente pour les calculs
  - effet de bord pour la base de données...
    - passage de 800k à 2.3M calculs 
    - plus de lenteurs d'interrogation de la base de données 

---

## Conclusion OpenMOLE <-> CRIANN

- Bilan plus que positif, avec des gains au delà de l'expérience eX Modelo
    - OpenMOLE "proof of concept" fonctionnel sur cluster
        => ouverture cluster à de nouveaux publics !
    - Expérience collaboration à renouveller
    - Canal de communication opérationnel OpenMOLE <-> CRIANN 
    - Dédramatise les aspects administratifs => pédagogie in situ

---

## Perspectives

- Suivi des participants (deux sessions de travail de 3 jours en Septembre et Janvier)
- eX Modelo II (25-29 Mai 2020)

---

## Questions

### exmodelo.org // openmole.org
### criann.fr // umr-idees.fr

<img height="350px" src="https://miniocodimd.openmole.org:443/codimd/uploads/upload_8d3b9956d84ce3a2ebd8d61577de6897.jpg">

