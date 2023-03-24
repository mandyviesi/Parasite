The perks of being in good conditions: how does female parasitism affect male mate choice in an orb-web spider?
Amanda Vieira da Silva¹², Joao Gabriel Lacerda de Almeida³
¹Federal University of ABC (Brazil), ² University of Michigan (USA), ³ Federal University of Minas Gerais (Brazil)
E-mail: amanda.vieira@ufabc.edu.br
E-mail: jgabriel.bio2@gmail.com

----------------------------------------------------------------------------------------------
# General information

### Date of data collection (can be a single date, or a range)
From December 2018 to April 2019.

### Information about geographic location of data collection
We performed this study at the Ecological Station of the Federal University of Minas Gerais (19.8737° S, 43.9725° W), Minas Gerais State, Brazil. The Ecological station is a 114-ha area covered by a semi-deciduous Atlantic Forest, Cerrado (i.e., Brazilian savanna), and invasive plant species.

### Keywords used to describe the data topic
male mate choice, male fitness, sexual selection, mate search, ectoparasitism, Trichonephila clavipes.

### Language information
English

### Information about funding sources that supported the collection of the data
A.V.S. thanks Conselho Nacional de Desenvolvimento Científico e Tecnológico do Brasil for support (process nº 130948/2018-7).
J.G.L.A. thanks Pró-reitoria de Pesquisa (PRPQ-UFMG) for providing a scholarship.

----------------------------------------------------------------------------------------------
# DATA AND FILE OVERVIEW

PARASITE.XLSX

### Description
Sheet1 (data): Dataset containing information about field observation on females webs of Trichonephila clavipes. We recorded parasite presence on female, the occurrence of attempts to mate and copulation on each female web, as well as the number of males on each female web.
Sheet2 (metadata): information about the variables included in the dataset.

### Date that the file was created
May 2019

### Date(s) that the file(s) was updated (versioned) and the nature of the update(s)
2023-03-20 (rename variables)

### Information about related data collected but that is not in the described dataset
This data collection was part of Amanda's masters and Joao Gabriel undergraduate research.

----------------------------------------------------------------------------------------------
# SHARING AND ACCESS INFORMATION

### Links to publications
Article under review

----------------------------------------------------------------------------------------------
# METHODOLOGICAL INFORMATION

### Description of methods for data collection
We conducted field observations between December 2018 and March 2019 at the Ecological Station of the Federal University of Minas Gerais (19.8737° S, 43.9725° W), Minas Gerais State, Brazil. We searched for Trichonephila clavipes female webs along three trails of approximately 20 m, 300 m, and 400 m in length, between 09:00 AM and 05:00 PM, which is the period when spiders are most active (pers. obs.). We observed the spiders daily during the reproductive season.  We focused on webs located no more than 2 m from the ground, so we could observe and mark the spiders. In each female web, we searched for the presence of the larvae or an egg of the wasp Hymenoepimecis spp. attached to the female abdomen. Then, we determined the female life stage as juvenile, penultimate, and adult. We could distinguish adult females from juveniles by the presence of a swollen and sclerotized epigynum with two distinct openings. This distinction could be perceived by the naked eye. Penultimate females have a different web structure because, during molting, they remove the sticky spirals from the web and maintain only the radii lines.


### Description of methods used for data processing (describe how the data were generated from the raw or collected data)
Any software or instrument-specific information needed to understand or interpret the data, including software and hardware version numbers
We ran our statistical analysis using R v. 4.1.2. To check the model assumptions and possible zero inflation in our models, we used the DHARMa package v. 0.4.1. To ran the models, we used the lme4 v. 1.1-26. To generate the pseudo-R squares for mixed models, we used the MuMIn package v. 1.43.17. Finally, we used ggplot2 package v. 3.3.5 to build the figures.

### People involved with sample collection, processing, analysis and/or submission
We also thank the staff of Estação Ecológica da Universidade Federal de Minas Gerais, Stefania Pereira Ventura dos Reis, Douglas Fernandes Maciel Costa, Daniel Vieira Soares, and Paulo Enrique Cardoso Peixoto for support in the field, Stefania Pereira Ventura dos Reis for comments in the previous versions of this manuscript, and Lucas Rosado Mendonça for the graphical abstract.

----------------------------------------------------------------------------------------------
# DATA INFORMATION

### Count of number of variables, and number of cases or rows
Number of variables: 11
Number of observations: 189

### Variable list, including full names and definitions (spell out abbreviated words) of column headings for tabular data
date: date of observation (format: DD-MM). For December, the samples were in 2018, while for January to April, 2019.
hour: hour of observation
area_web: trail and ID of the web
ID_female: unique ID for each female
female_stage: reproductive stage of female (juvenile or adult)
parasite: female infected by parasites (yes or no)
nmales_web: number of males on females web
ID_cmale: ID for central male
ID_periphmale: ID for peripheral male
attempts: occurence of attempts to mate (0 for no, 1 for yes or NA)
copulations: occurrence of copulations (no or yes)

### Definitions for codes used to record missing data
NA
