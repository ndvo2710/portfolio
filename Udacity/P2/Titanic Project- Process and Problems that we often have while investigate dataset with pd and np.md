# Titanic Project: Process and Problems that we often have while investigate dataset with pd and np

## Process:

* Working with Missing Data: check for NA, NULL
* 

## Problems :

#### Problem 1: Different between apply, applymap and map in Pandas

* **Map:** It iterates over each element of a series.
 
`df[‘column1’].map(lambda x: 10+x)`, this will add 10 to each element of column1.
df[‘column2’].map(lambda x: ‘AV’+x), this will concatenate “AV“ at the beginning of each element of column2 (column format is string).

* **Apply:** As the name suggests, applies a function along any axis of the DataFrame.
`df[[‘column1’,’column2’]].apply(sum)`, it will returns the sum of all the values of column1 and column2.

* **ApplyMap:** This helps to apply a function to each element of dataframe.

```r
func = lambda x: x+2
df.applymap(func)
```
, it will add 2 to each element of dataframe (all columns of dataframe must be numeric type)


#### Problem 2: The differences between ix vs iloc vs loc:

If you were me having the same problem with these, you should take a look at this example:

```
df = pd.DataFrame({'A':['a', 'b', 'c'], 'B':[54, 67, 89]}, index=[100, 200, 300])

df

                        A   B
                100     a   54
                200     b   67
                300     c   89
In [19]:    
df.loc[100]

Out[19]:
A     a
B    54
Name: 100, dtype: object

In [20]:    
df.iloc[0]

Out[20]:
A     a
B    54
Name: 100, dtype: object

In [24]:    
df2 = df.set_index([df.index,'A'])
df2

Out[24]:
        B
    A   
100 a   54
200 b   67
300 c   89

In [25]:    
df2.ix[100, 'a']

Out[25]:    
B    54
Name: (100, a), dtype: int64
```


#### Problem 3: Create a data frame which has name for index and columns:

The data frame that I want to see will look like this:

![](https://dl.dropboxusercontent.com/u/27868566/Screenshot%202016-08-12%2001.39.14.png)

However, what I could do is just:

![](https://dl.dropboxusercontent.com/u/27868566/Screenshot%202016-08-12%2001.04.12.png)

Thanks Myles for showing me how to solve this issue.

```
new_df = pd.DataFrame([[80,97,372],[1136,87,119]], index = ['No','Yes'], columns = ['0-199','220-219','260+'])
new_df.index.names = ['Heart Attack']
new_df.columns.names = ['Serum cholesterol']
new_df
```

I want to learn this because all the scipy.stat result is so boring. It is much better if we can write a function to make those result more interesting to read, such as:

![](https://dl.dropboxusercontent.com/u/27868566/Screenshot%202016-08-12%2001.17.40.png)


### References:

1. Categorical Scatterplots: [https://stanford.edu/~mwaskom/software/seaborn/tutorial/categorical.html](https://stanford.edu/~mwaskom/software/seaborn/tutorial/categorical.html)



<u></u>