# itemmarg

A sas macro for item analysis. Specify the name of a data set `data`, a list of items `items` and the number of response option for the 
items (2 for dichotomous items, etc., macro does not work well with scales where the items do not have the same number of response options). Example

```
%scaletest(data=sasuser.CAT, items=hoster slim etage hjemme, ncat=6);
```

output

| Item   | Mean | SD   | range of inter | item corr. | floor | ceiling | Item   | Corr. with total |
|--------|------|------|----------------|------------|-------|---------|--------|------------------|
| HOSTER | 2.27 | 1.27 | 0.18           | 0.66       | 6.4   | 5.3     | HOSTER | 0.73             |
| SLIM   | 2.27 | 1.35 | 0.28           | 0.66       | 10.0  | 5.7     | SLIM   | 0.78             |
| ETAGE  | 4.03 | 1.30 | 0.18           | 0.56       | 1.4   | 54.4    | ETAGE  | 0.65             |
| HJEMME | 3.01 | 1.44 | 0.31           | 0.56       | 7.8   | 17.8    | HJEMME | 0.75             |

