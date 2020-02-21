**Replication file for Social Esteem and Participation in Contentious Politics

* This section runs t-tests (which are mean-comparison tests) on the number of actual participants and intended participants, dependent on whether or not they recieved a newsletter. 

*Table 1

* T-Test on those who recieved an esteem newsletter and intended on coming, but did not.

ttest intended if newsletter==1|control==1, by(newsletter) unequal

* T-Test on those who recieved information-only and intended on coming, but did not.

ttest intended if facebook==1|control==1, by(facebook) unequal

* I'm not sure what this does

ttest intended, by(esteem) unequal

* T-Test on those who recieved an esteem newsletter and attended.

ttest attended if newsletter==1|control==1, by(newsletter) unequal

* T-Test on those who recieved information-only and attended. 

ttest attended if facebook==1|control==1, by(facebook) unequal

* I'm not sure what this does

ttest attended, by(esteem) unequal

* I believe this piece of code is bootstrapping for standard errors on the groups who attended and the groups who intended to attend but did not come. I believe it's only for the group who recieved social esteem emails.

*Table 2
bootstrap, reps(2000) dots: ivregress 2sls intended (openedesteem=esteem)
bootstrap, reps(2000) dots: ivregress 2sls attended (openedesteem=esteem)

* Showing the mean who were reported to have attended the event for both newsletter and facebook-invite recipients

*Table 3
ttest reported_attended if (newsletter==1 | control==1), by(newsletter) unequal
ttest reported_attended if (facebook==1 | control==1), by(facebook) unequal
ttest reported_attended, by(esteem) unequal

* "No-pickup" is defined in the paper as those who actually did attend the event but did not pickup their ticket. This piece of code checks for "no-pickups" within the different variables.

**no pickup robustness check

* Automatically set nopickup equal to 0

gen nopickup=0

* If they reported that they attended in the post-event survey but were previously said to have not attending, changing no-pickup to one, because that person did not pick up their raffle ticket.  

replace nopickup=1 if reported_attended==1 & attended==0

* Calculating the no-pickup rate for the control group, the treatment group, and those who recieved a facebook invitation

tab nopickup control
tab nopickup newsletter
tab nopickup facebook

* This is running a t-test on those who attended based on their replies to the post-event survey, where they were asked why they attended (for a good cause, for social inclusion, for fun, for free time, etc). by(esteem) split the answers into two columns: the average response for those who recieved information-only and for those who recieved the social esteem invitation. 

*Table 4
ttest forcause if reported_attended==1, by(esteem) unequal
ttest forsocial if reported_attended==1, by(esteem) unequal
ttest forfun if reported_attended==1, by(esteem) unequal
ttest fortime if reported_attended==1, by(esteem) unequal
ttest foradmiration if reported_attended==1, by(esteem) unequal
ttest forleadership if reported_attended==1, by(esteem) unequal
ttest forimportant if reported_attended==1, by(esteem) unequal

* This is running a t-test on those who did not attend based on their replies to the post-event survey, where they were asked why they did not attended (because they did not believe in the cause, because they did not know anyone going, because it would not be fun fun, because they didn't have the free time free time, etc). by(esteem) split the answers into two columns: the average response for those who recieved information-only and for those who recieved the social esteem invitation. 

ttest forcause if reported_attended==0, by(esteem) unequal
ttest forsocial if reported_attended==0, by(esteem) unequal
ttest forfun if reported_attended==0, by(esteem) unequal
ttest fortime if reported_attended==0, by(esteem) unequal
ttest foradmiration if reported_attended==0, by(esteem) unequal
ttest forleadership if reported_attended==0, by(esteem) unequal
ttest forimportant if reported_attended==0, by(esteem) unequal


* THIS IS THE APPENDIX, not the main tables used in the study. I still commented on them though. 

* This table shows the raw number of participants and the number of participants who were within a 5-mile radius, who were women, who were democrats, who were of a certain education level, who were retired, ETC.  

**Appendix
*Table 5
sum female fivemiles yearshpccpreexp intended attended
sum female fivemiles groupwarmth yearshpccpreexp age education unemployed retired vote_08 vote_09 vote_10 democrat reported_attended attended if surveyrespondent==1


* This test hows the demographic breakdown by age, education level, gender, political leaning of those who recieved the esteem invite and those who recieved the information-only invite.  

*Table 6
ttest age, by(esteem) unequal
ttest female if surveyrespondent==1, by(esteem) unequal
ttest education, by(esteem) unequal
ttest unemployed, by(esteem) unequal
ttest retired, by(esteem) unequal
ttest vote_08, by(esteem) unequal
ttest vote_09, by(esteem) unequal
ttest vote_10, by(esteem) unequal
ttest democrat, by(esteem) unequal

* Running regression to see the relation between those who intended/attended and whether or not they received the social esteem newsletter, as well as the relation to other demographic features. 

*Table 7
regress intended newsletter facebook female fivemiles fouryears, vce(robust)
regress attended newsletter facebook female fivemiles fouryears, vce(robust)
**robustness to logit:
logit intended newsletter facebook female fivemiles fouryears, vce(robust)
logit attended newsletter facebook female fivemiles fouryears, vce(robust)

* This table confuses me, I'm not sure what it is bootstrapping for. 

*Table 8
bootstrap, reps(2000) dots: ivregress 2sls intended (openednewsletter=newsletter) if newsletter==1 | control==1
bootstrap, reps(2000) dots: ivregress 2sls attended (openednewsletter=newsletter) if newsletter==1 | control==1
bootstrap, reps(2000) dots: ivregress 2sls intended (openedfacebook=facebook) if facebook==1 | control==1
bootstrap, reps(2000) dots: ivregress 2sls attended (openedfacebook=facebook) if facebook==1 | control==1

* I believe this is just documenting the number of survey respondents who recieved each treatment. 

*Table 9
tab surveyrespondent control 
tab surveyrespondent newsletter 
tab surveyrespondent facebook

* This table confuses me, I'm not sure what it is bootstrapping for. 

*Table 10
bootstrap, reps(2000) dots: ivregress 2sls intended (openedesteem=esteem) female fivemiles fiveyears
bootstrap, reps(2000) dots: ivregress 2sls attended (openedesteem=esteem) female fivemiles fiveyears

* Running regression to see the relation between those who REPORTED as attended and having received the social esteem newsletter, as well as the relation to other demographic features. 

*Table 11
regress reported_attended newsletter facebook female previous_attend vote_10 young unemployed democrat if surveyrespondent==1
**robustness to logit:
logit reported_attended newsletter facebook female previous_attend vote_10 young unemployed democrat if surveyrespondent==1

