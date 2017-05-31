# Project P1: Stroop Effect

Note: I will use R for this project

## Tidy Data

* The given data is:

~~~r
   Congruent Incongruent
1     12.079      19.278
2     16.791      18.741
3      9.564      21.214
...
~~~

However, the raw data is hard to figure out observations and variables. Therefore, we need to tidy the data.

There are many ways to structure the data. I will use the structure in which each observation is on each row, each column stands for 1 variable. This data structure is given by Hadley Wickham in his *Tidy Data* paper.[1]

~~~r
stroop = stroop %>%
            mutate(person = 1:nrow(stroop)) %>%
            gather(condition, response_time, -person)
~~~

The new dataset will looks like this:

~~~r
  person condition reponse_time
1      1 Congruent       12.079
2      2 Congruent       16.791
3      3 Congruent        9.564
...
~~~


##1. What is our independent variable? What is our dependent variable?

* The **independent variable** of this experiment is the **condition** of each task: *congruent* (color matches word) and *incongruent* (color does not match word). 

* The **dependent variable** is the ***reaction time*** of each task ( the time is taken to name the ink color in equally-sized list).

##2. What is an appropriate set of hypotheses for this task? What kind of statistical test do you expect to perform? Justify your choices.

Based on my experience after taking the test of **Interactive Stroop Effect Experiment**, I found that the time I took to finish naming the congruent list is shorter than the time I did with incongruent list. Therefore my hypothesis is : _The population mean reaction time of congruent group is shorter than the population mean reaction time of incongruent group_. So it is a one-tailed test. However, one-tailed test could be inappropriate if we fail to reject the null hypothesis after performing two tailed test. Therefor we have to test this following hypothesis first: _The population mean reaction time of congruent group is different from the population mean reaction time of incongruent group_. Hence, I will perform two hypothesis tests as the following order:

* **_Hypothesis 1_**:
	
	$H_o: \mu_{congruent} = \mu_{incongruent} \\
	 H_a: \mu_{congruent} \neq \mu_{incongruent}$
	 
	 ***or in words:***
	 
	 $H_o$: `there is no difference between two population means.`
	 
	 $H_a$: `there is difference between two population means.`
	 
* **_Hypothesis 2_**:

	$H_o: \mu_{congruent} \geq \mu_{incongruent} \\
	 H_a: \mu_{congruent} < \mu_{incongruent}$
	 
	 Let's call mean difference as $\mu_d = \mu_{congruent} - \mu_{incongruent} $, we have:
	 
	 $H_o: \mu_d \geq 0 \\
	 H_a: \mu_d < 0 $
	 
	 
	  ***or in words:***
	 
	 $H_o$: `The mean difference between paired observation is larger than or equal to 0.`
	 
	 $H_a$: `The mean difference between paired observation is less than 0.`


### Q2b: A statistical test is proposed which will distinguish the proposed hypotheses. Any assumptions made by the statistical test are addressed.

* For each observation, the reaction time of two congruency conditions came from 1 experimental person. => **_congruent sample and incongruent sample are paired samples._** => The test of single mean ($\mu_d$)
* The population's standard deviation $\sigma_d$ is unknown.
* The sample's standard deviation $s_d$ is known
* We have less than 30 samples
* The distribution of $x_d$ is quite symmetric and not highly skewed (explained by the below histogram)

![](https://dl.dropboxusercontent.com/u/27868566/Screenshot%202016-07-15%2001.31.19.png)


=> Based on the above relevant assumptions, the statistical test that we expect to perform is **paired t-test**: two-tailed test for the Hypothesis 1 and one-tailed test for the Hypothesis 2.


##3. Report some descriptive statistics regarding this dataset. Include at least one measure of central tendency and at least one measure of variability.

* The _measure of central tendency_: `mean` and  `median`.
* The _measure of variability_: `variance` and `standard deviation`.

| Condition   | Mean        | Median  | Variance    | SD          |
|-------------|-------------|---------|-------------|-------------|
| Congruent   | 14.051125   | 14.3565 | 12.66902907 | 3.559357958 |
| Incongruent | 22.01591667 | 21.0175 | 23.01175704 | 4.797057122 |



##4. Provide one or two visualizations that show the distribution of the sample data. Write one or two sentences noting what you observe about the plot or plots.

There are multiple ways to show distributions. But the more traditional plot types are box-plots and histograms.

![Box_plot](https://dl.dropboxusercontent.com/u/27868566/Screenshot%202016-07-14%2004.31.19.png)

=> The box-plot shows difference between the median reaction time of congruent group and the median reaction time of incongruent group. Also we realize that two groups have different range and the IQR of two boxes do not overlap.

![Histogram](https://dl.dropboxusercontent.com/u/27868566/Screenshot%202016-07-14%2004.54.09.png)

The histogram confirms our previous observations.

##5. Now, perform the statistical test and report your results. What is your confidence level and your critical statistic value? Do you reject the null hypothesis or fail to reject it? Come to a conclusion in terms of the experiment task. Did the results match up with your expectations?

Let $\mu_d = \mu_{congruent} - \mu_{incongruent}$

We have :
	
$\bar{x_d} = -7.96 \\
s_d = 4.86 \\
SE = \frac{s_d}{\sqrt{n}} = 0.99 \\
df = n - 1 = 23 \\
t-statistics = \frac{\bar{x_d}-0}{SE} = -8.02$

* **_Hypothesis 1_**:

	$H_o: \mu_{congruent} = \mu_{incongruent} \\
	 H_a: \mu_{congruent} \neq \mu_{incongruent}$

	t-statistics= -8.02
	
	t-critical = $\pm2.068$ at $\alpha = 0.05$ and df =23
	
	Since -8.02 < - 2.068 => p < 0.05 => Reject $H_o$
	
	**Conclusion:** Based on the given data, we are 95% confident to conclude that there is the difference between the reaction time of congruent and the reaction time of incongruent.
	
	
* **_Hypothesis 2_**:
	
	$H_o: \mu_{congruent} \geq \mu_{incongruent} \\
	 H_a: \mu_{congruent} < \mu_{incongruent}$
	 
	t-statistics= -8.02
	
	t-critical = -1.71 at $\alpha = 0.05$ and df =23
	
	Since -8.02 < -1.71 => p < 0.05 => Reject $H_o$
	
	**Conclusion:** Based on the given data, we are 95% confident to conclude that the reaction time of congruent group is shorter than the reaction time of incongruent group.

##6. Optional: What do you think is responsible for the effects observed? Can you think of an alternative or similar task that would result in a similar effect? Some research about the problem will be helpful for thinking about these two questions!

When our brain detect the color of the word, it also capture the image of the word at the same time. Therefore, within incongruent condition, the color and the meaning of the word is mismatched, we have to slow down to confirm whether the color we recognize is right 

=> **Distraction** is responsible for the effects observed. 

I think we can have the similar effect with the following experiment: 

* We will have 4 basic geometric shapes: circle, square, triangle, diamond and 4 labels: circle, square, triangle, diamond.
* First list: there are 30 shapes drawing from the above 4 types. Each shape contains each label. The label has to match the shape exactly.
* Second list: 30 shapes, but for each shape, the label does not match the shape.
* For each list, the person who takes this experiment has to say out loud the type of the shapes. The time is recorded for each list.

We might see that the record time between the first list and second list could be different.


## R Code for this project

~~~r
library(colorout)
stroop = read.csv("/Users/ndvo/Dropbox/Udacity\ Nanodegree/Project\ P2/stroopdata.csv")
stroop

library(tidyr)
library(dplyr)

stroop = stroop %>%
            mutate(person = 1:nrow(stroop)) %>%
            gather(condition, response_time, -person)
stroop

stroop %>%
    group_by(condition) %>%
    summarise(Mean = mean(response_time), Median = median(response_time),
        Variance = var(response_time), SD = sd(response_time)) %>%
    as.data.frame %>%
    write.csv(file="foo.csv")

library(ggplot2)

b = ggplot(stroop, aes(x= condition, y = response_time, fill= condition))
b + geom_boxplot()

h = ggplot(stroop, aes(x = response_time, fill = condition))
h + geom_histogram()

diff = stroop %>%
            spread(condition,response_time) %>%
            mutate(diff= Congruent - Incongruent) %>%
            select(diff) %>%
            unlist %>% as.vector

diff
diff_bar = mean(diff)
diff_sd = sd(diff)
SE = diff_sd/sqrt(length(diff))
df = length(diff) - 1
t_statistics = (diff_bar- 0)/SE
diff_bar
diff_sd
SE
df
t_statistics
qt(1-0.05/2,df)
qt(0.05,df)

~~~

### Reference:

[Stroop Effect](https://en.wikipedia.org/wiki/Stroop_effect)

[Ineractive Stroop Effect Experiment](https://faculty.washington.edu/chudler/java/ready.html)

[What are the differences between one-tailed and two-tailed tests](http://www.ats.ucla.edu/stat/mult_pkg/faq/general/tail_tests.htm)

[Tidy Data](http://vita.had.co.nz/papers/tidy-data.pdf)

[Paired Samples](http://www.sjsu.edu/faculty/gerstman/StatPrimer/paired.pdf)