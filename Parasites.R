## Effects of parasitism on reproduction of a spider species
## 11/01/2022


# Packages -----------------------------

library(lme4)
library(MuMIn)
library(dplyr)
library(ggplot2)
library(DHARMa)


# Data ------------------------------

parasite <- readxl::read_xlsx("parasites.xlsx", na = c(" ", "NA"), sheet = 1)

# Checking data
glimpse(parasite)
summary(parasite)

# Transforming characters into factor
parasite <- parasite |> 
  mutate_if(is.character, as.factor)
  

# Descriptive statistics  --------------------------------

# Duration of observations: 30 min per female
parasite |> 
  distinct(ID_female) #152 females -> 76h of observations


# Number of parasitized and non-parasitized females
table(parasite$parasite) #number of non-parasitized and parasitized

# Percentage of parasitized females
table(parasite$parasite)[2]/sum(table(parasite$parasite))

# Mean number of males on parasitized and non-parasitized webs
parasite |> 
  group_by(parasite) |> 
  summarise(mean(nmales_web, na.rm = TRUE), 
            sd(nmales_web, na.rm = TRUE))

# Percentage of attempts to mate in parasitized females
parasite |> 
  filter(parasite == "yes") |> 
  group_by(try) |> 
  count()

6/28

# Percentage of attempts to mate in non-parasitized females
parasite |> 
  filter(parasite == "no") |> 
  group_by(try) |> 
  count()

51/(51+105)

# Percentage of copulations in parasitized females
parasite |> 
  filter(maturation == "adult") |> 
  filter(parasite == "yes") |> 
  group_by(mating) |> 
  count()

# Percentage of copulations in non-parasitized females
parasite |> 
  filter(maturation == "adult") |> 
  filter(parasite == "no") |> 
  group_by(mating) |> 
  count()

28/(28+52)


# Hypothesis 1: number of males ---------------------------------

# Hip: males choose females with better physiological condition
# Prediction1: webs of non-parasitized females will have a greater number of males than webs of parasites parasitized females


## With outlier  ------------------------------------------------------

# Model
hyp1 <- glmer(nmales_web ~  parasite + 
                   (1|date) + (1|hour) + (1|area_web) + (1|ID_female),
                 family = "poisson",
                 data = parasite)

# Checking model assumptions
summary(hyp1) # no apparent problem with dispersion

simulateResiduals(fittedModel = hyp1, plot = TRUE) # no apparent problem with residuals

# Null model
hyp1n <- glmer(nmales_web ~  1 + 
                  (1|date) + (1|hour) + (1|area_web) + (1|ID_female),
                family = "poisson",
                data = parasite)

# Comparing models
anova(hyp1, hyp1n, test = "Chi")

# Checking pseudo-R
r.squaredGLMM(hyp1, hyp1n)

# Effect size
m1 <- mean(parasite$nmales_web[parasite$parasite == "no"], na.rm = TRUE)
m2 <- mean(parasite$nmales_web[parasite$parasite == "yes"], na.rm = TRUE)
m1/m2

# Plot
#jpeg("fig1_nmales.jpg", width = 1200, height = 1000, res = 300)
#tiff("f1g_nmales.tif", width = 1800, height = 1300, res = 300, compression = "lzw")
ggplot(data = parasite, aes(x = parasite, y = nmales_web)) +
  geom_jitter(alpha = 0.7, col = "#C9C9EE", width = 0.4) +
  stat_summary(fun.data = mean_sdl, geom = "errorbar", width = 0.1, fun.args = list(mult=1)) +
  stat_summary(fun = mean, geom = "point", size = 2, col = "black") +
  labs(x = "Occurence of parasites", y = "Number of males on the web") +
  
  scale_x_discrete(labels = c("No", "Yes")) +
  theme_classic() +
  theme(axis.text = element_text(size = 11, color = "black"),
        axis.title = element_text(size = 13))
#dev.off()
  


## Without outlier  --------------------------------------------

parasite2 <- parasite |> 
  filter(!nmales_web == 10)

# Model
hyp1_no <- glmer(nmales_web ~  parasite + 
                 (1|date) + (1|hour) + (1|area_web) + (1|ID_female),
               family = "poisson",
               data = parasite2)

# Checking model assumptions
summary(hyp1_no) # no apparent problem with dispersion

simulateResiduals(fittedModel = hyp1_no, plot = TRUE) # no apparent problem with residuals

# Null model
hyp1n_no <- glmer(nmales_web ~  1 + 
                   (1|date) + (1|hour) + (1|area_web) + (1|ID_female),
                 family = "poisson",
                 data = parasite2)

# Comparing models
anova(hyp1_no, hyp1n_no, test = "Chi")

# Effect size
m1no <- mean(parasite2$nmales_web[parasite2$parasite == "no"], na.rm = TRUE)
m2no <- mean(parasite2$nmales_web[parasite2$parasite == "yes"], na.rm = TRUE)
m1no/m2no

# Checking pseudo-R
r.squaredGLMM(hyp1_no, hyp1n_no)

# Figure
tiff("f1g_nmales.tif", width = 1800, height = 1300, res = 300, compression = "lzw")
ggplot(data = parasite2, aes(x = parasite, y = nmales_web)) +
  geom_jitter(alpha = 0.7, col = "#C9C9EE", width = 0.4) +
  stat_summary(fun.data = mean_sdl, geom = "errorbar", width = 0.1, fun.args = list(mult=1)) +
  stat_summary(fun = mean, geom = "point", size = 2, col = "black") +
  labs(x = "Occurence of parasites", y = "Number of males on the web") +
  
  scale_x_discrete(labels = c("No", "Yes")) +
  theme_classic() +
  theme(axis.text = element_text(size = 11, color = "black"),
        axis.title = element_text(size = 13))
dev.off()


# Hypothesis 2: Mating attempts  -------------------------------

# Hypothesis: males will attempt to mate with females in better physiological conditions
# Prediction: males will attempt to mate with non-parasitized females

# Model
hyp2  <- glmer(try ~ parasite + (1|date) + (1|hour) + (1|area_web) + (1|ID_female), family=binomial, data=parasite)

# Checking model assumptions
summary(hyp2) # no apparent problem with dispersion

simulateResiduals(fittedModel = hyp2, plot = TRUE) # no apparent problem with residuals

# Evaluating zero-values
testDispersion(hyp2)
testZeroInflation(hyp2)
drop1(hyp2, test = "Chi")

# Null model
hyp2n  <- glmer(try ~ 1 + (1|date) + (1|hour) + (1|area_web) + (1|ID_female), family=binomial, data=parasite)


# Comparing models
anova(hyp2, hyp2n, test='Chi')

# Calculating pseudo-R
r.squaredGLMM(hyp2, hyp2n)

# Effect size
table(parasite$try, parasite$parasite)

df_attempt <-   tibble(occurrence = c(108, 22, 43, 6),
                      parasite = c("no", "yes", "no", "yes"),
                      attempt = c("no", "no", "yes", "yes"))

# Figure
attempt <- ggplot(df_attempt,aes(x=parasite,y=occurrence,fill=attempt))+
  geom_bar(stat="identity",position = position_dodge(), width = 0.8) + 
  scale_y_continuous(expand = c(0,0)) +
  labs(y = "Number of attempts to mate", x = "Occurrence of parasites") +
  theme_classic() +
  scale_fill_manual(values = c("black", "gray"), name = "Attempt", labels = c("No", "Yes")) +
  scale_x_discrete(labels = c("No", "Yes")) +
  theme(axis.text = element_text(size = 11, color = "black"),
        axis.title = element_text(size = 13),
        legend.position = "top")



# Hypothesis 3: Copulations  -------------------------------

# Hypothesis: males will prefer to mate with females in better physiological conditions
# Prediction: males will mate with non-parasitized females

# Converting mating into numeric scale
parasite$mating <- as.factor(parasite$mating) 
parasite$mating <- as.numeric(parasite$mating2) - 1

# Selecting only adult females
adults <- parasite |> 
  filter(maturation == "adult")
str(adults)

# Model
hyp3  <- glmer(mating ~ parasite + (1|date) + (1|hour) + (1|area_web) + (1|ID_female), family=binomial, data=adults)


# Checking model assumptions
summary(hyp3) # no apparent problem with dispersion

simulateResiduals(fittedModel = hyp3, plot = T) # no apparent problem with residuals

# Evaluating zero-values
testDispersion(hyp3)
testZeroInflation(hyp3)
drop1(hyp3, test = "Chi")

100 * sum(parasite$mating == 0, na.rm = TRUE) / nrow(parasite)
plot(table(parasite$mating), type = "h", ylab = "Frequency")

# Null model
hyp3n  <- glmer(mating ~ 1 + (1|date) + (1|hour) + (1|area_web) + (1|ID_female), family=binomial, data=adults)

# Comparing models
anova(hyp3, hyp3n, test='Chi')

# Calculating pseudo-R
r.squaredGLMM(hyp3, hyp3n)

# Effect size
table(adults$mating, adults$parasite)


df_mating <-   tibble(occurrence = c(52, 3, 28, 0),
                      parasite = c("no", "yes", "no", "yes"),
                      mating = c("no", "no", "yes", "yes"))

# Figure
mating <- ggplot(df_mating,aes(x=parasite,y=occurrence,fill=mating))+
  geom_bar(stat="identity",position = position_dodge(), width = 0.8) + 
  scale_y_continuous(expand = c(0,0)) +
  labs(y = "Occurrence of mating", x = "Occurrence of parasites") +
  theme_classic() +
  scale_fill_manual(values = c("black", "gray"), name = "Mating", labels = c("No", "Yes")) +
  scale_x_discrete(labels = c("No", "Yes")) +
  theme(axis.text = element_text(size = 11, color = "black"),
        axis.title = element_text(size = 13),
        legend.position = "top")

#jpeg("fig2_mates.jpg", width = 1700, height = 1000, res = 300)
tiff("fig2_mates.tif", width = 1800, height = 1300, res = 300, compression = "lzw")
ggpubr::ggarrange(attempt, mating, labels = c("(A)", "(B)"))
dev.off()
