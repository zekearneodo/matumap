# matumap
Easy install of matlab bindings for UMAP package (https://github.com/lmcinnes/umap) using anaconda/pip.
Tested on Win/linux/macOS, matlab2018a

## Installation:

#### Via conda:
```
conda env create -n mumap py=3.6
conda activate mumap
conda install -c hahnloserlab matumap
```  

#### With the provided environment:
Donwload the file environment.yaml, then run (in a terminal/Anaconda prompt)
```
conda env create -f environment.yaml
```  
This will automatically create a mumap environment, and install the package and dependencies

## Matlab configuration and initialization:
### Windows/MacOs/Linux
The only way I know is to start matlab from within the environment.
```
conda activate mumap
matlab
```
Then, on matlab, run 
```
umap_mod = init_umap()
```

### MacOs/Linux
As far as I know, in unix systems you can also activate the environment by pointing at it. 
You can open matlab normally, and you need to pass the path to the python in your environment (the binary) to 'init_umap()'.
You cand find it out by running 'which python' within the environment.
Then, on matlab, run
```
umap_mod = init_umap(path_to_python)
```

## Testing and usage example
In matlab, run:
```
umap_mod = init_umap(path_to_python)
test_umap(umap_mod)
```

## Where credit is due
I only did the packaging.
The matlab code was written by Gagan Narula from the Hahnloser group at Institute of Neuroinformatics UZH/ETHZ