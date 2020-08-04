Do the following steps on monsoon to install phenor, for the first time. 

```console
module purge
module load gdal anaconda3/2020.07 R
conda create --name phenor
conda activate phenor
conda install -c conda-forge r-sf
```

 Once conda portions complete
 Start R and do the following:

```console
 install.packages("devtools")
 devtools::install_github("bluegreen-labs/phenor")
 ```
If phenor installation fails, check the output and reintsall any dependencies that has failed. Then try the last step again.
