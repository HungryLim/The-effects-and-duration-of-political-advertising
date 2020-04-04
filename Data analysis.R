rm(list = ls())

##################
# CCES Analysis ##
##################
ccesdisaster <- read.csv("C:/Users/wooki/Desktop/cces_final.csv")# - done
ccesdisaster <- ccesdisaster[,-c(1,2)]
names(ccesdisaster)

# Note: Outcome variables: 
# 1) Obama's approval rating 
# 2) Governor's approval rating 
# 3) turnout in election (10-12-14)
# 4) Vote for Obama in 2012
# 5) Vote change ~ receiving disaster declaration



library(dplyr)
# Create lagged variables
ccesdisaster <- ccesdisaster %>%
  group_by(caseid) %>%
  mutate(lag.apprObama_year = lag(apprObama_year),
         lag.apprGov_year = lag(apprGov_year),
         lag.turnout_year = lag(turnout_year)
  )
ccesdisaster$chng.apprObama_year <- ccesdisaster$apprObama_year-ccesdisaster$lag.apprObama_year
ccesdisaster$chng.apprGov_year <- ccesdisaster$apprGov_year-ccesdisaster$lag.apprGov_year
ccesdisaster$chng.turnout_year <- ccesdisaster$turnout_year-ccesdisaster$lag.turnout_year


## change vars as binary vars
ccesdisaster$chng.apprObama.3point <- NA
ccesdisaster$chng.apprObama.3point[ccesdisaster$chng.apprObama_year >0 ] <- 1
ccesdisaster$chng.apprObama.3point[ccesdisaster$chng.apprObama_year <0 ] <- -1
ccesdisaster$chng.apprObama.3point[ccesdisaster$chng.apprObama_year ==0 ] <- 0
table(ccesdisaster$chng.apprObama.3point)



ccesdisaster$chng.apprGov.3point <- NA
ccesdisaster$chng.apprGov.3point[ccesdisaster$chng.apprGov_year >0 ] <- 1
ccesdisaster$chng.apprGov.3point[ccesdisaster$chng.apprGov_year <0 ] <- -1
ccesdisaster$chng.apprGov.3point[ccesdisaster$chng.apprGov_year ==0 ] <- 0
table(ccesdisaster$chng.apprGov.3point)


#variables summary
table(ccesdisaster$apprObama_year)
table(ccesdisaster$dec_1month)
table(ccesdisaster$dec_6month)
table(ccesdisaster$dem)
table(ccesdisaster$rep)
table(ccesdisaster$female)
table(ccesdisaster$white)
table(ccesdisaster$educ)
table(ccesdisaster$age_2010)
table(ccesdisaster$income)
table(ccesdisaster$newsint)
table(ccesdisaster$ideo3)
table(ccesdisaster$turnout_year)

# create pid var
table(as.factor(ccesdisaster$ideo5_10))
ccesdisaster$ideo5 <- rep(NA, nrow(ccesdisaster))
ccesdisaster$ideo5[ccesdisaster$ideo5_10=="Very liberal"] <- 1
ccesdisaster$ideo5[ccesdisaster$ideo5_10=="Liberal"] <- 2
ccesdisaster$ideo5[ccesdisaster$ideo5_10=="Moderate"] <- 3
ccesdisaster$ideo5[ccesdisaster$ideo5_10=="Conservative"] <- 4
ccesdisaster$ideo5[ccesdisaster$ideo5_10=="Very Conservative"] <- 5

table(ccesdisaster$ind)


# panel analysis
library(plm)
library(stargazer)
#base
plm.mod.obama1 <- plm(apprObama_year ~ dec_1month + damage_1month +dem + rep+ female + white + educ + age_2010 + income+ newsint + factor(state10)-1, 
                      index = c("caseid", "year"), data=ccesdisaster, model = 'within')
plm.mod.obama2 <- plm(apprObama_year ~ dec_3month + damage_3month +dem + rep+ female + white + educ + age_2010 + income+ newsint + factor(state10)-1, 
                      index = c("caseid", "year"), data=ccesdisaster, model = 'within')
plm.mod.obama3 <- plm(apprObama_year ~ dec_6month + damage_6month +dem + rep+ female + white + educ + age_2010 + income+ newsint + factor(state10)-1, 
                      index = c("caseid", "year"), data=ccesdisaster, model = 'within')

difference_models <- list(plm.mod.obama1, plm.mod.obama2,plm.mod.obama3)

stargazer(difference_models,
          type="latex",
          style="apsr",
          title="Panel Analyses on the Effect of Issuing Disaster Declaration (Fixed Effects of Individuals)",
          keep.stat=c("n","rsq"),
          label="tab:differences")


#knowledge
plm.mod.obama11 <- plm(apprObama_year ~ dec_1month*total + damage_1month +dem + rep+ female + white + educ + age_2010 + income+ newsint + factor(state10)-1, 
                       index = c("caseid", "year"), data=ccesdisaster, model = 'within')

plm.mod.obama12 <- plm(apprObama_year ~ dec_3month*total + damage_3month +dem + rep+ female + white + educ + age_2010 + income+ newsint + factor(state10)-1, 
                       index = c("caseid", "year"), data=ccesdisaster, model = 'within')

plm.mod.obama13 <- plm(apprObama_year ~ dec_6month*total + damage_6month +dem + rep+ female + white + educ + age_2010 + income+ newsint + factor(state10)-1, 
                       index = c("caseid", "year"), data=ccesdisaster, model = 'within')

difference_models <- list(plm.mod.obama11, plm.mod.obama12,plm.mod.obama13)

stargazer(difference_models,
          type="latex",
          style="apsr",
          title="Panel Analyses on the Effect of Issuing Disaster Declaration (Fixed Effects of Individuals)",
          keep.stat=c("n","rsq"),
          label="tab:differences")

#news interest
plm.mod.obama21 <- plm(apprObama_year ~ dec_1month*newsint + damage_1month +dem + rep+ female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                       index = c("caseid", "year"), data=ccesdisaster, model = 'within')
plm.mod.obama22 <- plm(apprObama_year ~ dec_3month*newsint + damage_3month +dem + rep+ female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                       index = c("caseid", "year"), data=ccesdisaster, model = 'within')
plm.mod.obama23 <- plm(apprObama_year ~ dec_6month*newsint + damage_6month +dem + rep+ female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                       index = c("caseid", "year"), data=ccesdisaster, model = 'within')

difference_models <- list(plm.mod.obama21, plm.mod.obama22,plm.mod.obama23)

stargazer(difference_models,
          type="latex",
          style="apsr",
          title="Panel Analyses on the Effect of Issuing Disaster Declaration (Fixed Effects of Individuals)",
          keep.stat=c("n","rsq"),
          label="tab:differences")

#partisan: democrat
plm.mod.obama31 <- plm(apprObama_year ~ dec_1month*dem + damage_1month + female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                       index = c("caseid", "year"), data=ccesdisaster, model = 'within')
plm.mod.obama32 <- plm(apprObama_year ~ dec_3month*dem + damage_3month + female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                       index = c("caseid", "year"), data=ccesdisaster, model = 'within')
plm.mod.obama33 <- plm(apprObama_year ~ dec_6month*dem + damage_6month + female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                       index = c("caseid", "year"), data=ccesdisaster, model = 'within')


difference_models <- list(plm.mod.obama31, plm.mod.obama32,plm.mod.obama33)

stargazer(difference_models,
          type="latex",
          style="apsr",
          title="Panel Analyses on the Effect of Issuing Disaster Declaration (Fixed Effects of Individuals)",
          keep.stat=c("n","rsq"),
          label="tab:differences")

#partisan: republican
plm.mod.obama41 <- plm(apprObama_year ~ dec_1month*rep + damage_1month + female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                       index = c("caseid", "year"), data=ccesdisaster, model = 'within')
plm.mod.obama42 <- plm(apprObama_year ~ dec_3month*rep + damage_3month + female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                       index = c("caseid", "year"), data=ccesdisaster, model = 'within')
plm.mod.obama43 <- plm(apprObama_year ~ dec_6month*rep + damage_6month + female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                       index = c("caseid", "year"), data=ccesdisaster, model = 'within')

difference_models <- list(plm.mod.obama41, plm.mod.obama42,plm.mod.obama43)

stargazer(difference_models,
          type="latex",
          style="apsr",
          title="Panel Analyses on the Effect of Issuing Disaster Declaration (Fixed Effects of Individuals)",
          keep.stat=c("n","rsq"),
          label="tab:differences")

#partisan: ideo5
plm.mod.obama44 <- plm(apprObama_year ~ dec_3month+ damage_3month*ideo5 + female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                       index = c("caseid", "year"), data=ccesdisaster, model = 'within')
stargazer(plm.mod.obama44,
          type="latex",
          style="apsr",
          title="Panel Analyses on the Effect of Issuing Disaster Declaration (Fixed Effects of Individuals)",
          keep.stat=c("n","rsq"),
          label="tab:differences")
#partisan: damage
plm.mod.obama51 <- plm(apprObama_year ~ dec_3month*rep + damage_3month  +female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                       index = c("caseid", "year"), data=ccesdisaster, model = 'within')
plm.mod.obama52 <- plm(apprObama_year ~ dec_3month + damage_3month*rep  + female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                       index = c("caseid", "year"), data=ccesdisaster, model = 'within')
plm.mod.obama53 <- plm(apprObama_year ~ dec_3month*dem + damage_3month  + female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                       index = c("caseid", "year"), data=ccesdisaster, model = 'within')
plm.mod.obama54 <- plm(apprObama_year ~ dec_3month + damage_3month*dem + female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                       index = c("caseid", "year"), data=ccesdisaster, model = 'within')

difference_models <- list(plm.mod.obama51, plm.mod.obama52,plm.mod.obama53,plm.mod.obama54)

stargazer(difference_models,
          type="latex",
          style="apsr",
          title="Panel Analyses on the Effect of Issuing Disaster Declaration (Fixed Effects of Individuals)",
          keep.stat=c("n","rsq"),
          label="tab:differences")

#partisan: independent
plm.mod.obama22 <- plm(apprObama_year ~ dec_3month+ damage_3month*ind + female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                       index = c("caseid", "year"), data=ccesdisaster, model = 'within')

plm.mod.obama23 <- plm(apprObama_year ~ dec_3month*ind+ damage_3month+ female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                       index = c("caseid", "year"), data=ccesdisaster, model = 'within')

difference_models <- list(plm.mod.obama22, plm.mod.obama23)

stargazer(difference_models,
          type="latex",
          style="apsr",
          title="Panel Analyses on the Effect of Issuing Disaster Declaration (Fixed Effects of Individuals)",
          keep.stat=c("n","rsq"),
          label="tab:differences")

#education
plm.mod.obama111 <- plm(apprObama_year ~ dec_3month+ damage_3month*educ  +dem + rep+female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                        index = c("caseid", "year"), data=ccesdisaster, model = 'within')
plm.mod.obama112 <- plm(apprObama_year ~ dec_3month*educ+ damage_3month  +dem + rep+female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                        index = c("caseid", "year"), data=ccesdisaster, model = 'within')
difference_models <- list(plm.mod.obama111, plm.mod.obama112)

stargazer(difference_models,
          type="latex",
          style="apsr",
          title="Panel Analyses on the Effect of Issuing Disaster Declaration (Fixed Effects of Individuals)",
          keep.stat=c("n","rsq"),
          label="tab:differences")





# 3)

# panel analysis


table(ccesdisaster$turnout_year)

#exp(coef(plm.mod.turnout))
#exp(cbind(OR = coef(plm.mod.turnout), confint(plm.mod.turnout)))

plm.mod.turnout1 <- plm(turnout_year ~ dec_1month + damage_1month +dem + rep+ 
                          female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                        index = c("caseid", "year"), data=ccesdisaster, model = 'within')

plm.mod.turnout2 <- plm(turnout_year ~ dec_3month + damage_3month +dem + rep+ 
                          female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                        index = c("caseid", "year"), data=ccesdisaster, model = 'within')

plm.mod.turnout3 <- plm(turnout_year ~ dec_6month + damage_6month +dem + rep+ 
                          female + white + educ + age_2010 + income + newsint+ factor(state10)-1, 
                        index = c("caseid", "year"), data=ccesdisaster, model = 'within')

difference_models <- list(plm.mod.turnout1, plm.mod.turnout2,plm.mod.turnout3
)

stargazer(difference_models,
          type="latex",
          style="apsr",
          title="Effect of Issuing Disaster Declaration on Turnout (Fixed Effects of Individuals)",
          keep.stat=c("n","rsq"),
          label="tab:differences")
#turnout news
plm.mod.turnout4 <- plm(turnout_year ~ dec_1month*newsint + damage_1month +dem + rep+ 
                          female + white + educ + age_2010 + income + factor(state10)-1, 
                        index = c("caseid", "year"), data=ccesdisaster, model = 'within')

plm.mod.turnout5 <- plm(turnout_year ~ dec_3month*newsint + damage_3month +dem + rep+ 
                          female + white + educ + age_2010 + income + factor(state10)-1, 
                        index = c("caseid", "year"), data=ccesdisaster, model = 'within')

plm.mod.turnout6 <- plm(turnout_year ~ dec_6month*newsint + damage_6month +dem + rep+ 
                          female + white + educ + age_2010 + income + factor(state10)-1, 
                        index = c("caseid", "year"), data=ccesdisaster, model = 'within')

difference_models <- list(plm.mod.turnout4, plm.mod.turnout5,plm.mod.turnout6
)

stargazer(difference_models,
          type="latex",
          style="apsr",
          title="Effect of Issuing Disaster Declaration on Turnout (Fixed Effects of Individuals)",
          keep.stat=c("n","rsq"),
          label="tab:differences")
#turnout knowledge
plm.mod.turnout11 <- plm(turnout_year ~ dec_1month*total + damage_1month +dem + rep+ 
                           female + white + educ + age_2010 + income + factor(state10)-1, 
                         index = c("caseid", "year"), data=ccesdisaster, model = 'within')

plm.mod.turnout21 <- plm(turnout_year ~ dec_3month*total + damage_3month +dem + rep+ 
                           female + white + educ + age_2010 + income + factor(state10)-1, 
                         index = c("caseid", "year"), data=ccesdisaster, model = 'within')

plm.mod.turnout31 <- plm(turnout_year ~ dec_6month*total  + damage_6month +dem + rep+ 
                           female + white + educ + age_2010 + income + factor(state10)-1, 
                         index = c("caseid", "year"), data=ccesdisaster, model = 'within')

difference_models <- list(plm.mod.turnout11, plm.mod.turnout21,plm.mod.turnout31
)

#library(interplot)

#interplot(m = plm.mod.turnout21, var1 = "dec_3month", var2 = "total")
#install.packages('TMB', type = 'source')
library(sjPlot)
library(plm)
plot_model(plm.mod.turnout21,type = "int" )
sjp.int(plm.mod.turnout21, type = "eff", showValueLabels = TRUE)

stargazer(difference_models,
          type="latex",
          style="apsr",
          title="Effect of Issuing Disaster Declaration on Turnout (Fixed Effects of Individuals)",
          keep.stat=c("n","rsq"),
          label="tab:differences")


library(sjPlot)
library(sjlabelled)
library(sjmisc)
library(ggplot2)
theme_set(theme_sjplot())
plot_model(plm.mod.turnout)+ylab("Odd ratios")+ggtitle("")


library(stargazer)


difference_models <- list(plm.mod.obama, plm.mod.turnout)

stargazer(difference_models,
          type="latex",
          style="apsr",
          title="Panel Analyses on the Effect of Issuing Disaster Declaration (Fixed Effects of Individuals)",
          dep.var.labels=c("Approval of Obama","Turnout"),
          column.labels=c("model1","model2"),
          covariate.labels=c("3month Disaster Declaration", "3month Property Damage","Democrat",
                             "Republican","Female","White","Education","Age", "Income","News Reader"),
          keep.stat=c("n","rsq"),
          label="tab:differences")


# 3) for 2012 panel
cces2012 <- subset(ccesdisaster, ccesdisaster$year=="2012")
cces2012$partisan <- NA
cces2012$partisan[cces2012$ind==0] <- 1
cces2012$partisan[cces2012$ind==1] <- 0

lm.mod <- lm(voteObama ~ dec_3month + damage_3month + voteObama08 
             + dem + rep + female + white + educ + age_2010 + income + newsint + factor(state10)-1, 
             data=cces2012)
summary(lm.mod)
lm.mod1 <- lm(voteObama ~ dec_1month + damage_1month + voteObama08 
              + dem + rep + female + white + educ + age_2010 + income + newsint + factor(state10)-1, 
              data=cces2012)
summary(lm.mod1)


lm.mod.int<- lm(voteObama ~ dec_3month*partisan + damage_3month + voteObama08  
                + female + white + educ + age_2010 + income + newsint + factor(state10)-1, 
                data=cces2012)
summary(lm.mod)
lm.mod.int1 <- lm(voteObama ~ dec_1month*partisan + damage_1month + voteObama08  
                  + female + white + educ + age_2010 + income + newsint + factor(state10)-1, 
                  data=cces2012)
summary(lm.mod.int1)


stargazer(lm.mod, lm.mod1,lm.mod.int, lm.mod.int1,
          type = "html", 
          out = "Analysis/votechoice_mod.html", star.cutoffs=c(0.05,0.01, 0.001),
          title = "The Effect of Issuing Disaster Declaration on Vote Choice in 2012 Election", 
          dep.var.labels = c("Vote for Obama"),
          notes.align = "l")


# change model

chng.glm.mod1.1 <- lm(chng.turnout_year ~  decbetween + damagebetween 
                      + dem + rep + female + white + educ + income + age_2010 + newsint
                      + factor(state10)-1, data=ccesdisaster)
summary(chng.glm.mod1.1)

chng.glm.mod1.1 <- lm(chng.apprObama_year ~  decbetween + damagebetween 
                      + dem + rep + female + white + educ + income + age_2010 + newsint
                      + factor(state10)-1, data=ccesdisaster)
summary(chng.glm.mod1.1)

chng.obama <- plm(chng.apprObama_year ~  decbetween + damagebetween 
                  + dem + rep + female + white + educ + income + age_2010 + newsint
                  + factor(state10)-1,  index = c("caseid", "year"), data=ccesdisaster, model = 'within')


chng.turnout <- plm(chng.turnout_year ~  decbetween + damagebetween 
                    + dem + rep + female + white + educ + income + age_2010 + newsint+
                      factor(state10)-1,  index = c("caseid", "year"), data=ccesdisaster, model = 'within')

table(ccesdisaster$chng.apprObama_year)
table(ccesdisaster$chng.turnout_year)
table(ccesdisaster$decbetween)

difference_models <- list(chng.obama, chng.turnout)


stargazer(difference_models,
          type="latex",
          style="apsr",
          title="Panel Analyses on the Effect of Issuing Disaster Declaration (Fixed Effects of Individuals)(Change Model)",
          keep.stat=c("n","rsq"),
          label="tab:differences")


chng.obama <- plm(chng.apprObama_year ~  decbetween*newsint + damagebetween 
                  + dem + rep + female + white + educ + income + age_2010 
                  + factor(state10)-1,  index = c("caseid", "year"), data=ccesdisaster, model = 'within')


chng.turnout <- plm(chng.turnout_year ~  decbetween*newsint + damagebetween 
                    + dem + rep + female + white + educ + income + age_2010 +
                      factor(state10)-1,  index = c("caseid", "year"), data=ccesdisaster, model = 'within')

difference_models <- list(chng.obama, chng.turnout)


stargazer(difference_models,
          type="latex",
          style="apsr",
          title="Panel Analyses on the Effect of Issuing Disaster Declaration (Fixed Effects of Individuals)(Change Model)(Interaction Effect)",
          keep.stat=c("n","rsq"),
          label="tab:differences")

library(sjPlot)
library(sjmisc)
library(interplot)

library(ggplot2)

interplot(plm.mod.obama21)
sjp.int(plm.mod.obama21)
plot_model(plm.mod.obama21,type = "eff")
sjp.int(plm.mod.obama21, type = "eff", showValueLabels = TRUE)