# README (VISUALIZATION OF PISA DATA)

[Link of Gist Page](https://gist.github.com/ndvo2710/b53f5a00ec3a91701f900ba6fca53147)

## How to read My Gist for Visualization of PISA data:

* `index.html` : this file contains the final version of my visualization. The visualization contains two chart: Chart 1 and Chart 2. There are many different verions and sub-versions of Chart 1 and Chart 2.
* **Chart 1** : `slope1.html`, `slope2.html`, `slope3.html`, `slope4.html`
* **Chart 2** : `bell1.html`, `bell2.html`, `bell3.html`

## Summary

### Story behind the charts

While finding resources for my visualization, I have seen a visualization for PISA data, which is the OECD rankings slopegraph. However, I feel that this ranking chart does not reflect how much superior one country education system compares to others. Also we cannot know how many percentage of students between two countries are sharing the same score. The answer for this question is effect size, which is immensely popular in medical and psychology. Even though effect size is a good approach to compare two country educational system, visualizing effect size is a very tough problem. Fortunately, I found this article [Interpreting Cohen's d effect size- interactive visualization -Created by Kristoffer Magnusson](http://rpsychologist.com/d3/cohend/). This ineractive visualization of two bell curves to intepret effect size is exactly what I need to apply for visualization of PISA data. Therefore I decide to create:

* A slopegraph contains country ranking for each subject (OECD rankings)
* Two bell curves share an overlapping parts in order to depict the percentage of overlap of students scores between two countries.

### Data Mining Before Visualization
* Use R to import large file as `pisa2012.csv` (File Size > 2GB). Calculate and extract useful information into `country_rank.csv` file.
* The `country_rank.csv` contains these columns:

```
CNT : each row of this column is the name of a certain country
(All the following columns are data corresponding to each country(each row))
math: math ranking.
read: reading ranking.
sci: science ranking.
math_score: average math score.
sd_math_score: standard deviation of math score distribution
read_score: average reading score.
sd_read_score: standard deviation of reading score distribution
sci_score: average science score.
sd_sci_score: standard deviation of science score distribution
```

* Use math, read, sci columns to create the first chart.
* Use information of all the columns to create the second chart.

Note: I have compared the average scores and standard deviation between my data and OECD report. The values(PV1) are similar.

## Design

* During the designation of the first chart, I have problem with flickering text when mouseover a rect and a text inside a svg. Myles (Udacity Forum Mentor) has given me feedback to change from using 'visibility' to 'opacity'
* A feedback tells me that I should reduce the amount of scrolling page. So I change to smaller font size to solve this.
* My first chart is the slopegraph. At the beginning, I have to use so many lines of code to create the slopegraph. The code and my design are not so consistent. It takes a lot of time to write the code if I want to change something in my graph. When I had created my 2nd chart, I had to learn multi-series line chart of Mike Bostock. After that, it gives me an idea to create a slopegraph by using multi-series line chart method. Therefore I redesign chart 1 from scratch.

### Chart details:

*Chart 1 (OECD rankings):*

* Chart type : slopegraph
* The reason to choose slopegraph is to replicate the same chart as OECD ranking.
* There are many ways to implement slopegraph. However, if we use multi-series line, it can be easily updated and reusable with new PISA data. There are three variables for this chart: ranking, subject and country. We can encode X axis for ranking. However, it's not good to stretch the x axis when ranking is ranged from 1 to 68. Therefore y axis should be used to encode ranking. And then X axis is for subject and country is used as a legend.
        
*Chart 2 ( Two Bell Curves):*

* Chart type: bell curves ( Also this is multi-series line chart)
* The reason to choose bell curve is to visualize the effect size and the percentage overlap between two groups.
* Each curve is the normal distribution. So x axis is quantile value, y axis is p value in normal distribution pdf. Color is encoded for country. Legend is country name.
       


## Feedback

#### Feedback 1:

Instead of using 'visibility' you can use 'opacity', and you can add a transition (to slow the change in styles).

##### My response: I have change my chart 1 to a new design. And I also use opacity too.But the opacity feature appears multiple places in my code. So I don't insert them here.

#### Feeedback 2:

Your visualization looks stunning. You have given much information the visualization. Howerver, I have a couple of observations here. 
- Though it is narrating a story, it is not properly organized. So you can start off some text/description, you mentioned below the chart, on the head of the graph.
- Also, it would be great if the scrolling is minimized.

### Feedback 3:
For your visualization, it is very nice.
- For the first plot, you could extend the x-axis to take more space in the page.
- Your explanation is down on the page so not visible when you open the page, maybe be you can put it directly in front of the plot (both plots).

##### My response: I have change the width and height of each div (Also its padding in css)

```
        main_title = d3.select('body').append('div')
            .attr('id', 'title')
            .attr("width", window.outerWidth)
            .attr("height", 50)
            .append('svg')
            .attr("width", window.outerWidth)
            .attr("height", 50)
            .append('g');

        main_title.append('rect')
            .attr("width", window.outerWidth)
            .attr("height", 50)
            .attr('fill', '#9FC9C9');

        main_title.append('text')
            .attr({
                'x': window.outerWidth / 2,
                'y': 30,
                'font-size': '26px',
                'font-weight': 'bold',
                'text-anchor': 'middle',
                'fill': 'Black'
            })
            .text('VISUALIZATION OF PISA DATA');

        d3.select('body')
            .append('div')
            .attr('id', 'container')
            .attr('width', window.outerWidth)
            .attr('height', 1500);

        vis = d3.select('#container')
            .append('div')
            .attr('id', 'vis')
            .style("width", arc_width + bell_width - 250 + 'px')
            .style("height", 1500 + 'px');

        vis.append('div')
            .attr('id', 'main_chart1')
            .style("width", slope_width + slope_margin.left + slope_margin.right - 50 + 'px')
            .style("height", slope_height + slope_margin.top + slope_margin.bottom + 'px')
            .style('display', 'block');

        vis.append('div')
            .attr('id', 'main_chart2')
            .style("width", arc_width + bell_width - 250 + 'px')
            .style("height", 1500 + 'px')
            .style('display', 'none');

        d3.select('#container')
            .append('div')
            .attr('id', 'content')
            .style("width", 1920 - 300 - 1050 + 'px')
            .style("height", 1500 + 'px');
```


### Feedback 4:
The second step of the viz is a bit complex to understand.  I would suggest to reformat the text and make it smaller with only the key ingredients to the understanding of the concept.  Also you should maybe run some inferential test to check if the differences between two countries are statistically significant or not.

##### My response: Since I have used effect size to depict the percentage of overlap, I don't think it is necessary to use any significant test. You can review more about cohen's d effect size with the link in the Resources section below.


### Feedback 5:
Could you make the sort order consistent? If if I select Albania in the Left hand Box, it should be the left hand curve (red) and the left hand country below (red). At the moment it is the wrong way round? If you do this there is no need for the colour coding on the chart? This is also slightly confusing as the colours are a slightly different hue.

##### My response: There are three parts on my second chart: dropdown select, bell shape and tooltip. I organize it in the following way: Country has higher ranking in a selected subject is on the right side and vice versa. I know sometimes it might be sometimes confusing when the the selected country in the left dropdown shows information on the right side. However, if I change the order as described as the above feedback, in some situation the country on the left will have the bell shape on the right side. 

### Feedback 6:
For the extra impact could you default to Hong Kong v Massachusetts instead of Albania v Albania? It would nicely follow on from the story on page one and save the reader from searching themselves?

##### My response: Instead of creating another version, I change it directly in the index.html


## Resources

[Visualization of PISA Ranking of The Guardian](https://static.guim.co.uk/sys-images/Guardian/Pix/pictures/2013/12/5/1386241291926/PISAFULLLITERACYWEB.png)

[Multi-Series Line Chart - Mike Bostock](https://bl.ocks.org/mbostock/3884955)

[Plottting a bell(Gaussian) curve- phil pedruco](http://bl.ocks.org/phil-pedruco/88cb8a51cdce45f13c7e)

[Intepreting Cohen's d effect size](http://rpsychologist.com/d3/cohend/)

## List of Links of all charts and versions of my visualization:

[index.html](http://bl.ocks.org/ndvo2710/raw/b53f5a00ec3a91701f900ba6fca53147/) with [code](https://gist.github.com/ndvo2710/b53f5a00ec3a91701f900ba6fca53147/raw/e235b1e98f74c5d70f49d8ef400873920df80bfa/index.html)

[bell1](http://bl.ocks.org/ndvo2710/raw/b53f5a00ec3a91701f900ba6fca53147/bell1.html) with [code](https://gist.github.com/ndvo2710/b53f5a00ec3a91701f900ba6fca53147/raw/e235b1e98f74c5d70f49d8ef400873920df80bfa/bell1.html)

[bell2](http://bl.ocks.org/ndvo2710/raw/b53f5a00ec3a91701f900ba6fca53147/bell2.html) with [code](https://gist.github.com/ndvo2710/b53f5a00ec3a91701f900ba6fca53147/raw/e235b1e98f74c5d70f49d8ef400873920df80bfa/bell2.html)

[bell3](http://bl.ocks.org/ndvo2710/raw/b53f5a00ec3a91701f900ba6fca53147/bell3.html) with [code](https://gist.github.com/ndvo2710/b53f5a00ec3a91701f900ba6fca53147/raw/e235b1e98f74c5d70f49d8ef400873920df80bfa/bell3.html)

[slope1](http://bl.ocks.org/ndvo2710/raw/b53f5a00ec3a91701f900ba6fca53147/slope1.html) with [code](https://gist.github.com/ndvo2710/b53f5a00ec3a91701f900ba6fca53147/raw/e235b1e98f74c5d70f49d8ef400873920df80bfa/slope1.html)

[slope2](http://bl.ocks.org/ndvo2710/raw/b53f5a00ec3a91701f900ba6fca53147/slope2.html) with [code](https://gist.github.com/ndvo2710/b53f5a00ec3a91701f900ba6fca53147/raw/e235b1e98f74c5d70f49d8ef400873920df80bfa/slope2.html)

[slope3](http://bl.ocks.org/ndvo2710/raw/b53f5a00ec3a91701f900ba6fca53147/slope3.html) with [code](https://gist.github.com/ndvo2710/b53f5a00ec3a91701f900ba6fca53147/raw/e235b1e98f74c5d70f49d8ef400873920df80bfa/slope3.html)

[slope4](http://bl.ocks.org/ndvo2710/raw/b53f5a00ec3a91701f900ba6fca53147/slope4.html) with [code](https://gist.github.com/ndvo2710/b53f5a00ec3a91701f900ba6fca53147/raw/e235b1e98f74c5d70f49d8ef400873920df80bfa/slope4.html)

