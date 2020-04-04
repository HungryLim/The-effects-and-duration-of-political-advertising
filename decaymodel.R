#decay model: closed form non linear model
setwd("C:/Users/Dell/Desktop/experiments/final/")
allad_seven<-read.csv("allads_testready.csv",header=TRUE)


power<-nls(Repadvantage~k+g*lagged.poll+(h)*(ad1/2^d)+(h)*(ad2/3^(d))+h*(ad3/4^d)+h*(ad4/5^d)+h*(ad5/6^d)+h*(ad6/7^d)+h*(ad7/8^d)+h*(ad8/9^d)+h*(ad9/10^d)+h*(ad10/11^d)+h*(ad11/12^d)+h*(ad12/13^d)+h*(ad13/14^d)+h*(ad14/15^d)+h*(ad15/16^d)+h*(ad16/17^d)+h*(ad17/18^d)+h*(ad18/19^d)+h*(ad19/20^d)+h*(ad20/21^d)+h*(ad21/22^d)+h*(ad22/23^d)+h*(ad23/24^d)+h*(ad24/25^d)+h*(ad25/26^d)+h*(ad26/27^d)+h*(ad27/28^d)+h*(ad28/29^d) +h*(ad29/30^d) +h*(ad30/31^d) +(h)*(ad31/32^d) +(h)*(ad32/33^(d)) +h*(ad33/34^d) +h*(ad34/35^d) +h*(ad35/36^d) +h*(ad36/37^d) +h*(ad37/38^d) +h*(ad38/39^d) +h*(ad39/40^d)  +h*(ad40/41^d) +(ad41/42^d) +(h)*(ad42/43^(d)) +h*(ad43/44^d) +h*(ad44/45^d) +h*(ad45/46^d) +h*(ad46/47^d) +h*(ad47/48^d) +h*(ad48/49^d) +h*(ad49/50^d) +h*(ad50/51^d) , data=allad_seven, start = list(k=0.5,g=0.5,h=0.5,d=0.5))
weibull<-nls(Repadvantage~k+g*lagged.poll+h*(ad1/exp(d))+h*(ad2/exp((d)*2^(0.5)))+h*(ad3/exp((d)*3^(0.5)))+h*(ad4/exp((d)*4^(0.5)))+h*(ad5/exp((d)*5^(0.5)))+h*(ad6/exp(d*6^(0.5)))+h*(ad7/exp(d*7^(0.5)))+h*(ad8/exp(d*8^(0.5)))+h*(ad9/exp(d*9^(0.5)))+h*(ad10/exp(d*10^(0.5)))+h*(ad11/exp(d*11^(0.5)))+h*(ad12/exp(d*12^(0.5)))+h*(ad13/exp(d*13^(0.5)))+h*(ad14/exp(d*14^(0.5)))+h*(ad15/exp(d*15^(0.5)))+h*(ad16/exp(d*16^(0.5)))+h*(ad17/exp(d*17^(0.5)))+h*(ad18/exp(d*18^(0.5)))+h*(ad19/exp(d*19^(0.5)))+h*(ad20/exp(d*20^(0.5)))+h*(ad21/exp(d*21^(0.5)))+h*(ad22/exp(d*22^(0.5)))+h*(ad23/exp(d*23^(0.5)))+h*(ad24/exp(d*24^(0.5)))+h*(ad25/exp(d*25^(0.5)))+h*(ad26/exp(d*26^(0.5)))+h*(ad27/exp(d*27^(0.5)))+h*(ad28/exp(d*28^(0.5)))+h*(ad29/exp(d*29^(0.5)))+h*(ad30/exp(d*30^(0.5)))+ h*(ad31/exp(d*31^(0.5)))+ h*(ad32/exp(d*32^(0.5)))+ h*(ad33/exp(d*33^(0.5)))+ h*(ad34/exp(d*34^(0.5)))+ h*(ad35/exp(d*35^(0.5)))+ h*(ad36/exp(d*36^(0.5)))+ h*(ad37/exp(d*37^(0.5)))+ h*(ad38/exp(d*38^(0.5)))+ h*(ad39/exp(d*39^(0.5)))+ h*(ad40/exp(d*40^(0.5)))+ h*(ad41/exp(d*41^(0.5))) + h*(ad42/exp(d*42^(0.5))) + h*(ad43/exp(d*43^(0.5)))+ h*(ad44/exp(d*44^(0.5)))+ h*(ad45/exp(d*45^(0.5)))+ h*(ad46/exp(d*46^(0.5)))+ h*(ad47/exp(d*47^(0.5)))+ h*(ad48/exp(d*48^(0.5)))+ h*(ad49/exp(d*49^(0.5)))+ h*(ad50/exp(d*50^(0.5))), data=allad_seven, start=list(k=0, g=0.5, h=0.5, d=0.5))
exponential<-nls(Repadvantage~k+g*lagged.poll +h*(ad1/exp(d))+h*(ad2/exp(d*2)) +h*(ad3/exp(d*3)) +h*(ad4/exp(d*4)) +h*(ad5/exp(d*5)) +h*(ad6/exp(d*6)) +h*(ad7/exp(d*7)) +h*(ad8/exp(d*8)) +h*(ad9/exp(d*9)) +h*(ad10/exp(d*10)) +h*(ad11/exp(d*11)) +h*(ad12/exp(d*12)) +h*(ad13/exp(d*13)) +h*(ad14/exp(d*14)) +h*(ad15/exp(d*15)) +h*(ad16/exp(d*16)) +h*(ad17/exp(d*17)) +h*(ad18/exp(d*18)) +h*(ad19/exp(d*19)) +h*(ad20/exp(d*20)) +h*(ad21/exp(d*21)) +h*(ad22/exp(d*22)) +h*(ad23/exp(d*23)) +h*(ad24/exp(d*24)) +h*(ad25/exp(d*25)) +h*(ad26/exp(d*26)) +h*(ad27/exp(d*27)) +h*(ad28/exp(d*28)) +h*(ad29/exp(d*29)) +h*(ad30/exp(d*30)) +h*(ad31/exp(d*31)) +h*(ad32/exp(d*32)) +h*(ad33/exp(d*33)) +h*(ad34/exp(d*34)) +h*(ad35/exp(d*35)) +h*(ad36/exp(d*36)) +h*(ad37/exp(d*37)) +h*(ad38/exp(d*38)) +h*(ad39/exp(d*39)) +h*(ad40/exp(d*40)) +h*(ad41/exp(d*41))+h*(ad42/exp(d*42)) +h*(ad43/exp(d*43)) +h*(ad44/exp(d*44)) +h*(ad45/exp(d*45)) +h*(ad46/exp(d*46)) +h*(ad47/exp(d*47)) +h*(ad48/exp(d*48)) +h*(ad49/exp(d*49)) +h*(ad50/exp(d*50)), data=allad_seven, start=list(k=0, g=0.5, h=0.5, d=0.5))

summary(power)
summary(weibull)
summary(exponential)

RSS.p<-sum(residuals(exponential)^2) 
TSS<-sum((allad_seven$Repadvantage-mean(allad_seven$Repadvantage))^2)
power_r_squared<-1-(RSS.p/TSS)
power_r_squared


rel<-lm(Repadvantage~lagged.poll, data=allad_seven)
summary(rel)

#combined 2010,2012,2014
sevenall<-nls(Repadvantage~k+g*lagged.poll+h*(ad1/exp(d))+h*(ad2/exp((d)*2^(0.5)))+h*(ad3/exp((d)*3^(0.5)))+h*(ad4/exp((d)*4^(0.5)))+h*(ad5/exp((d)*5^(0.5)))+h*(ad6/exp(d*6^(0.5)))+h*(ad7/exp(d*7^(0.5)))+h*(ad8/exp(d*8^(0.5)))+h*(ad9/exp(d*9^(0.5)))+h*(ad10/exp(d*10^(0.5)))+h*(ad11/exp(d*11^(0.5)))+h*(ad12/exp(d*12^(0.5)))+h*(ad13/exp(d*13^(0.5)))+h*(ad14/exp(d*14^(0.5)))+h*(ad15/exp(d*15^(0.5)))+h*(ad16/exp(d*16^(0.5)))+h*(ad17/exp(d*17^(0.5)))+h*(ad18/exp(d*18^(0.5)))+h*(ad19/exp(d*19^(0.5)))+h*(ad20/exp(d*20^(0.5)))+h*(ad21/exp(d*21^(0.5)))+h*(ad22/exp(d*22^(0.5)))+h*(ad23/exp(d*23^(0.5)))+h*(ad24/exp(d*24^(0.5)))+h*(ad25/exp(d*25^(0.5)))+h*(ad26/exp(d*26^(0.5)))+h*(ad27/exp(d*27^(0.5)))+h*(ad28/exp(d*28^(0.5)))+h*(ad29/exp(d*29^(0.5)))+h*(ad30/exp(d*30^(0.5)))+ h*(ad31/exp(d*31^(0.5)))+ h*(ad32/exp(d*32^(0.5)))+ h*(ad33/exp(d*33^(0.5)))+ h*(ad34/exp(d*34^(0.5)))+ h*(ad35/exp(d*35^(0.5)))+ h*(ad36/exp(d*36^(0.5)))+ h*(ad37/exp(d*37^(0.5)))+ h*(ad38/exp(d*38^(0.5)))+ h*(ad39/exp(d*39^(0.5)))+ h*(ad40/exp(d*40^(0.5)))+ h*(ad41/exp(d*41^(0.5))) + h*(ad42/exp(d*42^(0.5))) + h*(ad43/exp(d*43^(0.5)))+ h*(ad44/exp(d*44^(0.5)))+ h*(ad45/exp(d*45^(0.5)))+ h*(ad46/exp(d*46^(0.5)))+ h*(ad47/exp(d*47^(0.5)))+ h*(ad48/exp(d*48^(0.5)))+ h*(ad49/exp(d*49^(0.5)))+ h*(ad50/exp(d*50^(0.5))), data=allad_seven, start=list(k=0, g=0.5, d=0.5,h=0.5),control=nls.control(maxiter=50000,minFactor = 0))
summary(sevenall)

RSS.p<-sum(residuals(sevenall)^2) 
TSS<-sum((allad_seven$Repadvantage-mean(allad_seven$Repadvantage))^2)
power_r_squared<-1-(RSS.p/TSS)
power_r_squared
