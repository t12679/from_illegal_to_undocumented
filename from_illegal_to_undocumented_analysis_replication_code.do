import delimited "/Users/humanity/Documents/from_Illegal_to_Undocumented New/~xcx.csv"

encode polview, generate(polview_c1) force
drop polview
rename polview_c1 polview

destring immrights_c, generate(immrights_c1) force
drop immrights_c
rename immrights_c1 immrights_c

destring age, generate(age_c1) force
drop age
rename age_c1 age


destring south, generate(south_c1) force
drop south
rename south_c1 south

destring west, generate(west_c1) force
drop west
rename west_c1 west

destring northeast, generate(northeast_c1) force
drop northeast
rename northeast_c1 northeast

destring midwest, generate(midwest_c1) force
drop midwest
rename midwest_c1 midwest

destring log_income, generate(log_income_c1) force
drop log_income
rename log_income_c1 log_income

destring birthyear, generate(birthyear_c1) force
drop birthyear
rename birthyear_c1 birthyear


*mark non-missing cases:
mark good if immrights_c!=. & immfavor_c!=. & age!=. & south!=.& midwest!=. & northeast!=. & log_income!=. 


ologit letin_c undocumented , vce(robust) or

regress letin_c undocumented , vce(robust)



/*

margins, dydx(*) predict(pr) post

Average marginal effects                        Number of obs     =        391
Model VCE    : OIM

Expression   : Pr(letin_c==0), predict(pr)
dy/dx w.r.t. : undocumented female hispanic white birthyear1 northeast1 south1 midwest1 west1
               log_income1 educ born_usa democrat republican media polview auth ethnocentrism

-------------------------------------------------------------------------------
              |            Delta-method
              |      dy/dx   Std. Err.      z    P>|z|     [95% Conf. Interval]
--------------+----------------------------------------------------------------
 undocumented |    .052831   .0303876     1.74   0.082    -.0067276    .1123897
       female |  -.0347657   .0313226    -1.11   0.267    -.0961569    .0266254
     hispanic |  -.0512412   .0509496    -1.01   0.315    -.1511006    .0486182
        white |  -.0067312   .0371867    -0.18   0.856    -.0796158    .0661533
   birthyear1 |   -.000714   .0009132    -0.78   0.434    -.0025039    .0010759
   northeast1 |   .0328073   .0467342     0.70   0.483      -.05879    .1244045
       south1 |   .0533581    .041485     1.29   0.198     -.027951    .1346672
     midwest1 |   .0316242   .0466874     0.68   0.498    -.0598813    .1231298
        west1 |          0  (omitted)
  log_income1 |  -.0669348    .022313    -3.00   0.003    -.1106675   -.0232021
         educ |   .0031539    .007974     0.40   0.692    -.0124748    .0187827
     born_usa |  -.1549937   .0933398    -1.66   0.097    -.3379363    .0279488
     democrat |  -.1061107   .0404779    -2.62   0.009     -.185446   -.0267755
   republican |   .0336549   .0497543     0.68   0.499    -.0638617    .1311716
        media |   -.022339   .0149735    -1.49   0.136    -.0516864    .0070085
      polview |   .0644413   .0147165     4.38   0.000     .0355975     .093285
         auth |  -.0080893   .0149671    -0.54   0.589    -.0374242    .0212456
ethnocentrism |   .0406451   .0078445     5.18   0.000     .0252702    .0560201
-------------------------------------------------------------------------------

regress letin_c undocumented female hispanic white age northeast south midwest log_income educ born_usa democrat republican media polview auth ethnocentrism , vce(robust)

regress letin_c undocumented 


ologit letin_c undocumented female hispanic age white northeast south  midwest log_income educ born_usa democrat republican media polview auth ethnocentrism , or


*run the interactions
*polview

*recode polview
recode polview  (-3=0) (-2=1) (-1=2) (0=3) (1=4) (2=5) (3=6), gen(polview_n)

recode polview (0=0) (1=1) (2=4) (3=9) (4=16) (5=25) (6=36) gen(polview_n^2)

recode ethnocentrism  (-10=0) (-9=1) (-8=2) (-7=3) (-6=4) (-5=5) (-6=6) (-5=7) (=-4=8) (-3=9) (-2=10) (=1=11) (0=12) (1=13) (2=14) (3=15) (4=16) (5=17) (6=18) (7=19) (8=20) (9=21) (10=22), gen(ethnocentrism_s)


ologit letin_c undocumented##polview_n female hispanic age white northeast south  midwest lnincome educ born_usa media auth ethnocentrism , or

ologit letin_c undocumented##polview_n female hispanic age white northeast south  midwest lnincome educ born_usa democrat republican media auth ethnocentrism , or

regress letin_c undocumented##polview_n female hispanic age white northeast south  midwest lnincome educ born_usa democrat republican media auth ethnocentrism 

ologit letin_c undocumented##independent female hispanic age white northeast south  midwest lnincome educ born_usa media auth ethnocentrism , or

regress letin_c undocumented##independent female hispanic age white northeast south  midwest lnincome educ born_usa media auth ethnocentrism 

regress letin_c undocumented##media female hispanic age white northeast south  midwest lnincome educ born_usa polview auth ethnocentrism 


regress letin_c undocumented##ethnocentrism_s female hispanic age white northeast south  midwest lnincome educ born_usa polview media auth 



*immimp

ologit immimp_c undocumented , vce(robust) or

margins, dydx(*) predict(pr) post


regress immimp_c undocumented, vce(robust)


ologit immimp_c undocumented female hispanic white age northeast south midwest lnincome educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or

margins, dydx(*) predict(pr) post

regress immimp_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust)








*immright

ologit immrights_c undocumented , or vce(robust)

margins, dydx(*) predict(pr) post




regress immrights_c undocumented, vce(robust)


ologit immrights_c undocumented female hispanic white age northeast south midwest lnincome educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or


coefplot
margins, dydx(*) predict(pr) post

regress immrights_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust)






*immfav

ologit immfavor_c undocumented , or vce(robust)

margins, dydx(*) predict(pr) post


regress immfavor_c undocumented, vce(robust)


ologit immfavor_c undocumented female hispanic white age northeast south midwest lnincome educ born_usa democrat republican media polview auth ethnocentrism ,  or vce(robust)


margins, dydx(*) predict(pr) post

regress immfavor_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust)



*immcrime

ologit immcrime_c undocumented , vce(robust)

margins, dydx(*) predict(pr) post


regress immcrime_c undocumented, vce(robust)


*model 2
ologit immcrime_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or

coefplot, coeflabels(log_income1="income" media="conservative media diet" polview="right-wing ideology" auth="authoritarianism") xline(1) eform xtitle(Figure 4: ORs for Agree Immigration Results in More Crime)

margins, dydx(*) predict(pr) post

regress immcrime_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust)




*immlang

ologit immlang_c undocumented , or vce(robust)

margins, dydx(*) predict(pr) post


regress immlang_c undocumented  , vce(robust)


ologit immlang_c undocumented female hispanic white age northeast south midwest lnincome educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or



margins, dydx(*) predict(pr) post

regress immlang_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust)


margins, authoritarian


*job_c

ologit immjob_c undocumented  , or vce(robust)

margins, dydx(*) predict(pr) post


regress immjob_c undocumented  , vce(robust)


ologit immjob_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or

coefplot, coeflabels(log_income1="income" media="conservative media diet" polview="right-wing ideology" auth="authoritarianism") xline(1) eform xtitle(Figure 5: ORs For Agree That Immigration Reduces Jobs)


margins, dydx(*) predict(pr) post

regress immjob_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or

drop ethnocentrismnew
generate ethnocentrismnew = ethnocentrism

recode ethnocentrismnew (-9=0) (-8=0) (-7=0) (-6=0) (-5=0) (-4=0) (-3=1) (-2=1) (-1=1) (0=1) (0=1) (1=1) (2=2) (3=12) (4=12) (5=12) (6=2) (7=2) (8=2) (9=2) (12=2)

ologit immjob_c undocumented##ethnocentrismnew female hispanic white age northeast south midwest lnincome educ born_usa democrat republican media polview auth  , vce(robust) or




*immunit_c

ologit immunit_c undocumented  , or vce(robust)

margins, dydx(*) predict(pr) post


regress immunit_c undocumented  , vce(robust)


ologit immunit_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or

coefplot, coeflabels(log_income1="income" media="conservative media diet" polview="right-wing ideology" auth="authoritarianism") xline(1) eform xtitle(Figure 3: ORs for Agree Immigration Increases National Unity)



margins, dydx(*) predict(pr) post


regress immunit_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or


ologit immunit_c undocumented#born_usa female hispanic white age northeast south midwest lnincome educ born_usa media auth ethnocentrism, vce(robust) or

margins
#maybe report this
#undocumented#|
     #born_usa |
     #    0 1  |   .6461169   .1241964    -2.27   0.023     .4432956    .9417352
      #   1 0  |   .3421897   .3603277    -1.02   0.308     .0434457    2.695176
      #   1 1  |          1  (omitted)

		 

*immideas_c

ologit immideas_c undocumented , or vce(robust)

margins, dydx(*) predict(pr) post


regress immideas_c undocumented  , vce(robust)


ologit immideas_c undocumented female hispanic white age northeast south midwest lnincome educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or
margins, dydx(*) predict(pr) post

regress immideas_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or



*immgrowth_c

ologit immgrowth undocumented , or vce(robust)

margins, dydx(*) predict(pr) post



ologit immgrowth_c  undocumented female hispanic white age northeast south midwest lnincome educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or

margins, dydx(*) predict(pr) post

regress immgrowth_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or



*transport coefficient
logistic transport undocumented, vce(robust) or

regress transport undocumented, vce(robust)





logistic transport undocumented female hispanic white age northeast south midwest lnincome educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or


margins, dydx(*) predict(pr) post

regress transport undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or





#generate predicted values from equation

regress immunit_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust)

prvalue, x(undocumented=0 female=0 hispanic=0 white=0 age=75 south=1 northeast=0 midwest=0 log_income=10 educ=12 born_usa=1 democrat=0 republican=1 media=7 auth=2 ethnocentrism=9)

gen predicted_anti-immigrant = -0.07-0.013*75-0.07+0.029+10*0.03-0.007*12+0.045-0.03+0.024*7+0.09*3+0.018*2-0.027*9
sum predicted_anti-immigrant if undocumented==0
predict predicted_anti-immigrant
sum predicted_anti-immigrant if undocumented==1
predict predicted_anti-immigrant



#genereate predicted values of all response variables when word "undocumented immigrant" and "illegal immigrant"
read  by three ideal type of respondents : 1) anti immigrant, 2) pro immigrant, 3) moderate immigrant


ologit letin_c undocumented female hispanic white age northeast south west log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust)


margins, at(undocumented=0)

margins, at(undocumented=1)

*for stereotypical anti-immigration US resident
margins, at(undocumented=0 female=0 hispanic=0 white=1 age=75 south=1 west=0 midwest=0 log_income=10 educ=12 born_usa=1 democrat=0 republican=1 media=7 auth=2 ethnocentrism=9)

*for stereotypical anti-immigration US resident
margins, at(undocumented=0 female=0 hispanic=0 white=1 age=75 south=1 west=0 midwest=0 log_income=10 educ=12 born_usa=1 democrat=0 republican=1 media=7 auth=2 ethnocentrism=9)

*for stereotypical pro-immigration US resident
margins, at(undocumented=0 female=1 hispanic=1 white=0 age=25 south=0 west=1 midwest=0 log_income=12 educ=18 born_usa=0 democrat=1 republican=0 media=-7 auth=-2 ethnocentrism=-9)

*for stereotypical pro-immigration US resident
margins, at(undocumented=0 female=1 hispanic=1 white=0 age=25 south=0 west=1 midwest=0 log_income=12 educ=18 born_usa=0 democrat=1 republican=0 media=-7 auth=-2 ethnocentrism=-9)

*for stereotypical moderate immigration US resident
margins, at(undocumented=0 female=1 hispanic=1 white=1 age=50 south=0 west=0 midwest=1 log_income=11 educ=16 born_usa=1 democrat=0 republican=0 media=0 auth=0 ethnocentrism=0)

*for stereotypical moderate immigration US resident
margins, at(undocumented=1 female=1 hispanic=1 white=1 age=50 south=0 west=0 midwest=1 log_income=11 educ=16 born_usa=1 democrat=0 republican=0 media=0 auth=0 ethnocentrism=0)





regress letin_c undocumented female hispanic white age northeast south west log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) 


margins, at(undocumented=0)

margins, at(undocumented=1)

*for stereotypical anti-immigration US resident
margins, at(undocumented=0 female=0 hispanic=0 white=1 age=75 south=1 west=0 midwest=0 log_income=10 educ=12 born_usa=1 democrat=0 republican=1 media=7 auth=2 ethnocentrism=9)

*for stereotypical anti-immigration US resident
margins, at(undocumented=0 female=0 hispanic=0 white=1 age=75 south=1 west=0 midwest=0 log_income=10 educ=12 born_usa=1 democrat=0 republican=1 media=7 auth=2 ethnocentrism=9)

*for stereotypical pro-immigration US resident
margins, at(undocumented=0 female=1 hispanic=1 white=0 age=25 south=0 west=1 midwest=0 log_income=12 educ=18 born_usa=0 democrat=1 republican=0 media=-7 auth=-2 ethnocentrism=-9)

*for stereotypical pro-immigration US resident
margins, at(undocumented=0 female=1 hispanic=1 white=0 age=25 south=0 west=1 midwest=0 log_income=12 educ=18 born_usa=0 democrat=1 republican=0 media=-7 auth=-2 ethnocentrism=-9)

*for stereotypical moderate immigration US resident
margins, at(undocumented=0 female=1 hispanic=1 white=1 age=50 south=0 west=0 midwest=1 log_income=11 educ=16 born_usa=1 democrat=0 republican=0 media=0 auth=0 ethnocentrism=0)

*for stereotypical moderate immigration US resident
margins, at(undocumented=1 female=1 hispanic=1 white=1 age=50 south=0 west=0 midwest=1 log_income=11 educ=16 born_usa=1 democrat=0 republican=0 media=0 auth=0 ethnocentrism=0)






regress immunit_c undocumented female hispanic white age northeast south west log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) 


margins, at(undocumented=0)

margins, at(undocumented=1)

*for stereotypical anti-immigration US resident
margins, at(undocumented=0 female=0 hispanic=0 white=1 age=75 south=1 west=0 midwest=0 log_income=10 educ=12 born_usa=1 democrat=0 republican=1 media=7 auth=2 ethnocentrism=9)

*for stereotypical anti-immigration US resident
margins, at(undocumented=0 female=0 hispanic=0 white=1 age=75 south=1 west=0 midwest=0 log_income=10 educ=12 born_usa=1 democrat=0 republican=1 media=7 auth=2 ethnocentrism=9)

*for stereotypical pro-immigration US resident
margins, at(undocumented=0 female=1 hispanic=1 white=0 age=25 south=0 west=1 midwest=0 log_income=12 educ=18 born_usa=0 democrat=1 republican=0 media=-7 auth=-2 ethnocentrism=-9)

*for stereotypical pro-immigration US resident
margins, at(undocumented=0 female=1 hispanic=1 white=0 age=25 south=0 west=1 midwest=0 log_income=12 educ=18 born_usa=0 democrat=1 republican=0 media=-7 auth=-2 ethnocentrism=-9)

*for stereotypical moderate immigration US resident
margins, at(undocumented=0 female=1 hispanic=1 white=1 age=50 south=0 west=0 midwest=1 log_income=11 educ=16 born_usa=1 democrat=0 republican=0 media=0 auth=0 ethnocentrism=0)

*for stereotypical moderate immigration US resident
margins, at(undocumented=1 female=1 hispanic=1 white=1 age=50 south=0 west=0 midwest=1 log_income=11 educ=16 born_usa=1 democrat=0 republican=0 media=0 auth=0 ethnocentrism=0)


ologit letin undocumented female hispanic white age northeast south midwest lnincome educ born_usa democrat republican media polview auth ethnocentrism, or vce(robust)


margins, at(undocumented=0)

margins, at(undocumented=1)

*for stereotypical anti-immigration US resident
margins, at(undocumented=0 female=0 hispanic=0 white=1 age=75 south=1 northeast=0 midwest=0 lnincome=10 educ=12 born_usa=1 democrat=0 republican=1 media=7 auth=2 ethnocentrism=9)

*for stereotypical anti-immigration US resident
margins, at(undocumented=1 female=0 hispanic=0 white=1 age=75 south=1 northeast=0 midwest=0 lnincome=10 educ=12 born_usa=1 democrat=0 republican=1 media=7 auth=2 ethnocentrism=9)

*for stereotypical pro-immigration US resident
margins, at(undocumented=0 female=1 hispanic=1 white=0 age=25 south=0 west=1 midwest=0 log_income=12 educ=18 born_usa=0 democrat=1 republican=0 media=-7 auth=-2 ethnocentrism=-9)

*for stereotypical pro-immigration US resident
margins, at(undocumented=0 female=1 hispanic=1 white=0 age=25 south=0 west=1 midwest=0 log_income=12 educ=18 born_usa=0 democrat=1 republican=0 media=-7 auth=-2 ethnocentrism=-9)

*for stereotypical moderate immigration US resident
margins, at(undocumented=0 female=1 hispanic=1 white=1 age=50 south=0 west=0 midwest=1 log_income=11 educ=16 born_usa=1 democrat=0 republican=0 media=0 auth=0 ethnocentrism=0)

*for stereotypical moderate immigration US resident
margins, at(undocumented=1 female=1 hispanic=1 white=1 age=50 south=0 west=0 midwest=1 log_income=11 educ=16 born_usa=1 democrat=0 republican=0 media=0 auth=0 ethnocentrism=0)





regress immcrime_c undocumented##media  female hispanic white age northeast south midwest lnincome educ born_usa democrat republican  polview auth ethnocentrism 

margins undocumented, at(media=(1 6))

marginsplot

margins, at(undocumented=0)

margins, at(undocumented=1)

*for stereotypical anti-immigration US resident
margins, at(undocumented=0 female=0 hispanic=0 white=1 age=75 south=1 northeast=0 midwest=0 lnincome=10 educ=12 born_usa=1 democrat=0 republican=1 media=7 auth=9 ethnocentrism=9)

*for stereotypical anti-immigration US resident
margins, at(undocumented=1 female=0 hispanic=0 white=1 age=75 south=1 northeast=0 midwest=0 lnincome=10 educ=12 born_usa=1 democrat=0 republican=1 media=7 auth=9 ethnocentrism=9)

*for stereotypical pro-immigration US resident
margins, at(undocumented=0 female=1 hispanic=1 white=0 age=25 south=0 northeast=1 midwest=0 lnincome=12 educ=18 born_usa=0 democrat=1 republican=0 media=-7 auth=-2 ethnocentrism=-9)

*for stereotypical pro-immigration US resident
margins, at(undocumented=1 female=1 hispanic=1 white=0 age=25 south=0 northeast=1 midwest=0 lnincome=12 educ=18 born_usa=0 democrat=1 republican=0 media=-7 auth=-2 ethnocentrism=-9)

*for stereotypical moderate immigration US resident
margins, at(undocumented=0 female=1 hispanic=1 white=1 age=50 south=0 northeast=0 midwest=1 lnincome=11 educ=16 born_usa=1 democrat=0 republican=0 media=0 auth=0 ethnocentrism=0)

*for stereotypical moderate immigration US resident
margins, at(undocumented=1 female=1 hispanic=1 white=1 age=50 south=0 northeast=0 midwest=1 lnincome=11 educ=16 born_usa=1 democrat=0 republican=0 media=0 auth=0 ethnocentrism=0)

marginsplot, dydx(polview_n) over(undocumented)

ologit immcrime_c undocumented female hispanic white age northeast south west log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust)


generate authnew = auth


recode authnew (-2=0) (-1=1) (0=2) (1=3) (2=4) 



ologit immcrime_c undocumented##authnew female hispanic white age northeast south midwest lnincome educ born_usa democrat republican media ethnocentrism polview , vce(robust) or


  undocumented#|
     polview_n |
          1 1  |   .2542592     .16317    -2.13   0.033     .0722804    .8944016
          1 2  |   .3679542   .2350823    -1.56   0.118     .1051888    1.287117
          1 3  |   .2315747   .1518469    -2.23   0.026      .064054    .8372136
          1 4  |   .2385112   .2078717    -1.64   0.100     .0432169    1.316327
          1 5  |   .5862376   .5509208    -0.57   0.570      .092929     3.69825
          1 6  |    .469799   .5733732    -0.62   0.536     .0429586    5.137758
               |
 undocumented#|
         white |
          1 1  |   .2634221    .127761    -2.75   0.006     .1018159    .6815364
               |


ologit immcrime_c i.undocumented##c.polview_n female hispanic white age northeast south midwest lnincome educ born_usa democrat republican media  polview auth ethnocentrismnew, vce(robust) or
			   
			   
			   1.undocumented |   1.789702   .7833658     1.33   0.184     .7589334    4.220442
               |
       authnew |
            1  |   1.376056   .5484612     0.80   0.423     .6300406    3.005409
            3  |   3.692397   1.558151     3.10   0.002      1.61477    8.443181
            4  |   1.737249   1.977549     0.49   0.628     .1866037    16.17349

undocumented#|
      polview_n |
           1 1  |   .2456584   .1591212    -2.17   0.030     .0690208    .8743465
           1 2  |    .305422   .1986729    -1.82   0.068     .0853503    1.092938
           1 3  |   .2065134   .1337378    -2.44   0.015     .0580379    .7348269
           1 4  |    .284125   .2563175    -1.39   0.163     .0484859    1.664958
           1 5  |   .5146559   .4882962    -0.70   0.484     .0801517     3.30462
           1 6  |   .4400567   .5987817    -0.60   0.546     .0305693    6.334784
                |

margins, dydx(polview_n) over(undocumented)
				
				
≈		
			   
margins undocumented, dydx(polview_n) pwcompare(effects)
margins, dydx(undocumented) at(polview_n=(0 2 4 6))


margins, dydx(gender) at(polview_n=(0 2 4))
*seems like more conservative ideologically people are more likley to think immigrants cause crime when they see the term illegal

margins, at(undocumented=1)

*for stereotypical anti-immigration US resident
margins, at(undocumented=0 female=0 hispanic=0 white=1 age=75 south=1 northeast=0 midwest=0 lnincome=10 educ=12 born_usa=1 democrat=0 republican=1 media=7 auth=2 ethnocentrism=9)

*for stereotypical anti-immigration US resident
margins, at(undocumented=0 female=0 hispanic=0 white=1 age=75 south=1 west=0 midwest=0 log_income=10 educ=12 born_usa=1 democrat=0 republican=1 media=7 auth=2 ethnocentrism=9)

*for stereotypical pro-immigration US resident
margins, at(undocumented=0 female=1 hispanic=1 white=0 age=25 south=0 west=1 midwest=0 log_income=12 educ=18 born_usa=0 democrat=1 republican=0 media=-7 auth=-2 ethnocentrism=-9)

*for stereotypical pro-immigration US resident
margins, at(undocumented=0 female=1 hispanic=1 white=0 age=25 south=0 west=1 midwest=0 log_income=12 educ=18 born_usa=0 democrat=1 republican=0 media=-7 auth=-2 ethnocentrism=-9)

*for stereotypical moderate immigration US resident
margins, at(undocumented=0 female=1 hispanic=1 white=1 age=50 south=0 west=0 midwest=1 log_income=11 educ=16 born_usa=1 democrat=0 republican=0 media=0 auth=0 ethnocentrism=0)

*for stereotypical moderate immigration US resident
margins, at(undocumented=1 female=1 hispanic=1 white=1 age=50 south=0 west=0 midwest=1 log_income=11 educ=16 born_usa=1 democrat=0 republican=0 media=0 auth=0 ethnocentrism=0)









regress immfavor_c undocumented female hispanic white age northeast south west log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) 


margins, at(undocumented=0)

margins, at(undocumented=1)



#interactions:

regress immjob_c undocumented#ethnocentrismnew female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth , vce(robust)


drop conservative_media
generate conservative_media = media
recode conservative_media (1=1) (2=1) (3=2) (4=2) (5=2) (6=3) (7=3)
margins undocumented#conservative_media



regress immjob_c undocumented#conservative_media female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican polview auth ethnocentrism , vce(robust)

margins undocumented#conservative_media
marginsplot, xtitle("impact of 'undocumented' on xenophobia by conservative media consumed")



regress immunit_c undocumented#conservative_media female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican polview auth ethnocentrism , vce(robust)

margins undocumented#conservative_media
marginsplot, xtitle("impact of 'undocumented' on xenophobia by conservative media consumed")

regress immcrime_c undocumented#conservative_media female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican polview auth ethnocentrism , vce(robust)

margins undocumented#conservative_media
marginsplot, xtitle("impact of 'undocumented' on xenophobia by conservative media consumed")


logit immjob_c undocumented#conservative_media female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican polview auth ethnocentrism , vce(robust) or

margins undocumented#conservative_media
marginsplot, xtitle("impact of 'undocumented' on xenophobia by conservative media consumed")



logit immunit_c undocumented#conservative_media female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican polview auth ethnocentrism , vce(robust) or

margins undocumented#conservative_media
marginsplot, xtitle("impact of 'undocumented' on xenophobia by conservative media consumed")

logit immcrime_c undocumented#conservative_media female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican polview auth ethnocentrism , vce(robust) or

margins undocumented#conservative_media
marginsplot, xtitle(Figure 5: "impact of 'undocumented' on xenophobia by conservative media consumed")







drop authnew
generate authnew=auth
recode authnew (-2=0) (-1=1)(1=2) (2=3)
margins undocumented#authnew
marginsplot

ologit immjob_c undocumented##ethnocentrismnew , or vce(robust

marginsplot





ologit immunit_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or


margins, at(undocumented=(0 1)) atmeans vsquish post
marginsplot


ologit letin_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or

margins, at(undocumented=(0 1)) atmeans vsquish post
marginsplot

ologit immfavor_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or

margins, at(undocumented=(0 1)) atmeans vsquish post
marginsplot

ologit immrights_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or

margins, at(undocumented=(0 1)) atmeans vsquish post
marginsplot

ologit immcrime_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or

margins, at(undocumented=(0 1)) atmeans vsquish post
marginsplot

ologit immjob_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or

margins, at(undocumented=(0 1)) atmeans vsquish post
marginsplot

ologit immgrowth_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or

margins, at(undocumented=(0 1)) atmeans vsquish post
marginsplot

ologit immideas_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or

margins, at(undocumented=(0 1)) atmeans vsquish post
marginsplot

ologit immfavor_c undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or

margins, at(undocumented=(0 1)) atmeans vsquish post
marginsplot

logistic transport undocumented female hispanic white age northeast south midwest log_income1 educ born_usa democrat republican media polview auth ethnocentrism , vce(robust) or

margins, at(undocumented=(0 1)) atmeans vsquish post
marginsplot









