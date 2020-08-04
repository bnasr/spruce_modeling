## First time setup on Monsoon
Do the following steps on monsoon to install phenor, only for the first time. 

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


## Clone the project
Go to your `scratch` directory, rename or remove the old directory and the clone the new project:
```console
cd /scratch/cs2737
mv Spruce_modeling Spruce_modeling(old)
git clone https://github.com/bnasr/spruce_modeling
cd spruce_modeling
```

## Edit the files
In your favarite text editor, open the `spruce_array.sh` and `spruce_modeling.R` files and update the following:

1) in `spruce_array.sh`: replace the email address with your email address
2) in `spruce_modeling.R`: replace the NAUID in variable 'project_dir'


## Sumit the job
You can now submit the job using the following command:
```console
sbatch spruce_array.sh
```

You will receive email updates about the progress of the jobs. You can also check these using the following command:
```console
squeue -u YOUR_NAUID
```

You can cancel the jobs using this command:
```console
scancel YOUR_JOB_ID
```


## Allocations
You can always change the allocaiton of CPU and memory or time by editing the job script: `spruce_array.sh`.



