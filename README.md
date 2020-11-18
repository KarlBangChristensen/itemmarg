# itemmarg

A sas macro for item analysis. Specify the name of a data set `data`, a list of items `items` and the number of response option for the 
items (2 for dichotomous items, etc., macro does not work well with scales where the items do not have the same number of response options). For each item the macro reports the mean and SD, the range of inter-item correlations the floor and cieling effect and the correlation with the total score. Example:

```
%scaletest(data=sasuser.CAT, items=hoster slim etage hjemme, ncat=6);
```


