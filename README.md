# Morphological multiparameter filtration and persistent homology in mitochondrial image analysis

Implementation of the paper "Morphological multiparameter filtration and persistent homology in mitochondrial image analysis" by Yu-Min Chung, Chuan-Shen Hu, Emily Sun, Henry C. Tseng

![image](https://github.com/user-attachments/assets/f9e53644-d90e-4407-b679-bfba70e7b81c)

## Abstract
The complexity of branching and curvilinear morphology of a complete mitochondrial network within each cell is challenging to analyze and quantify. To address this challenge, we developed an image analysis technique using persistent homology with a multiparameter filtration framework, combining image processing techniques in mathematical morphology. We show that such filtrations contain both topological and geometric information about complex cellular organelle structures, which allows a software program to extract meaningful features. Using this information, we also develop a connectivity index that describes the morphology of the branching patterns. As proof of concept, we utilize this approach to study how mitochondrial networks are altered by genetic changes in the Optineurin gene. Mutations in the autophagy gene Optineurin (OPTN) are associated with primary open-angle glaucoma (POAG), amyotrophic lateral sclerosis (ALS), and Paget’s disease of the bone, but the pathophysiological mechanism is unclear.  We utilized the proposed mathematical morphology-based multiparameter filtration and persistent homology approach to analyze and quantitatively compare how changes in the OPTN gene alter mitochondrial structures from their normal interconnected, tubular morphology into scattered, fragmented pieces.

## Image Data
There are a total of 15 grayscale images in the folder "data," encoded in the Portable Network Graphics (PNG) format, which can be freely accessed. Images classified as WT and KO are stored in the repository in their respective folders ("data/WT" and "data/KO"). Please contact the authors if further technical support is needed.

## Released Code

### Code Versions
Last released date (YYYY.MM.DD): 2024.08.05 (Matlab version)

### Code Dependence

The code is programmed in Matlab version 2019 and can be run on both Windows and Mac systems. 

For the persistent homology computation, the software Perseus (https://people.maths.ox.ac.uk/nanda/perseus/index.html) [1] is utilized. To ensure the calculation of persistent homology can be performed on your system, please download the executable file from the website that corresponds to your operating system (Windows, Mac, or Linux). The released code (**runPerseus.m**) version (2024.08.05) is designed to run on the Windows system. See the code description for more details.

### Code Description

The folder ``code'' consists of four Matlab M files: **ConnectivityIndex.m**, **NormalizedBettiNumberCurve.m**, **SizeDistrBettiNumber.m**, and **runPerseus.m**, where **runPerseus.m** is the code for computing the persistent homology of cubical complexes (i.e., image data). 

```matlab
cmd = ['././perseusWin cubtop ' fname ' ' fname]
````

as a string in Matlab. Specifically, this command is used to call the executable file of the Perseus software. Note that this command is for the Windows version of the Perseus software. If you are using Perseus on a Mac system, please download the **perseusMac** file from the official Perseus website and update the command accordingly. Please also ensure that the executable Perseus file is located in the same folder as the four M files.

The M file **NormalizedBettiNumberCurve.m** defines a Matlab function to compute the Normalized Betti Number Curve of a given image based on the opening operations.

```matlab
NormalizedBettiNumberCurve(img, O)
````

where the object img is a matrix by using **imread()** and O is the size of the structuring element. Here, the base structuring element is assumed to be an O $\times$ O square.

The M file **SizeDistrBettiNumber.m** defines a Matlab function to compute the Size Distribution of Betti Numbers of a given image based on the opening filtration.

```matlab
SDB = SizeDistrBettiNumber(img, T)
````

where the object img is a matrix by using **imread()** and T is a given image threshold from 0, 1, ..., to 255.

The M file **ConnectivityIndex.m** defines a Matlab function to compute the Connectivity Index of a given image based on the opening filtration.

```matlab
CI = ConnectivityIndex(img, T)
````

where the object img is a matrix by using **imread()** and T is a given image threshold from 0, 1, ..., to 255.

## Statistical Analysis

Hypothesis tests of the proposed features of the sampled WT and KO mitochondria images can be demonstrated by the following example codes. Based on the behaviors of normalized Betti curves (NBCs), size distributions (SDs), and connectivity index curves (CI), the statistics of the hypothesis tests are the average values of the WT and KO curves over the range $[a, b]$, where the ranges are selected as [100, 150] (for NBC and CI) and [5,15] (for SD). The test samples consist of 5 curves each from WT and KO mitochondria images.  The null hypothesis, \( H_0 \), states that the distribution of mean values of the WT and KO curves over the range \([a, b]\) are the same. The permutation hypothesis test is performed by the python package {\tt {mlxtend}}~\cite{raschkas_2018_mlxtend}. The $p$-value serves as the target value for determining the test results, and the decision value $\alpha$ is set to be $0.05$. The hypotheses are repeated $100$ times with different random seeds, and average values and standard deviations present the results. Folder ``computed_features'' contains the computed normalized Betti curves, size distributions, and connectivity index curves of WT and KO mitochondria images. The following is Python code for the demonstrations.

### Permutation test for the NBC curve $\rho_1^{H,3}$ (with key values 'r_pc_KO_o3' and 'r_pc_WT_o3')

```python
from scipy.io import loadmat
import numpy as np
import pandas as pd
import math
import random
from scipy import stats
from mlxtend.evaluate import permutation_test

D = loadmat("Mitochondial_data/NormalizedBettiCurvesWTKO.mat")
## dict_keys(['__header__', '__version__', '__globals__', 'r_pc_KO', 'r_pc_KO_o3', 'r_pc_KO_o5', 'r_pc_WT', 'r_pc_WT_o3', 'r_pc_WT_o5'])

################################################################################
################################################################################
#Sample Size
N = 5
alpha = 0.05
################################################################################
################################################################################

KO_NBC = []
WT_NBC = []

for i in range(N):
  KO_NBC.append(np.mean(np.nan_to_num(D['r_pc_KO_o3'][i,100:151])))
  WT_NBC.append(np.mean(np.nan_to_num(D['r_pc_WT_o3'][i,100:151])))

print(KO_NBC)
print(WT_NBC)

################################################################################
################################################################################
p_values=[]

for i in range(100):
  p_value = permutation_test(KO_NBC, WT_NBC, method='approximate', seed=int(random.randint(0,1000)))
  p_values.append(p_value)

print("Average of p-values: ", np.mean(p_values).round(4))
print("Standard deviation of p-values: ", np.std(p_values).round(4))
################################################################################
################################################################################

## Direct test
if (np.mean(p_values).round(4) < alpha):
  print("Reject the null hypothesis")
else:
  print("Fail to reject the null hypothesis")

## Strong test
if (np.mean(p_values).round(4) + np.std(p_values).round(4) < alpha):
  print("Reject the null hypothesis")
else:
  print("Fail to reject the null hypothesis")
````

### Permutation test for the  $\phi(D_{128})$

````python
from scipy.io import loadmat
import numpy as np
import pandas as pd
import math
import random
from scipy import stats
from mlxtend.evaluate import permutation_test

## Define 2 random distributions
#Sample Size
N = 5
alpha = 0.05

file_name_size_distribution_KO = 'Mitochondial_data/size_dist_KO.csv'
file_name_size_distribution_WT = 'Mitochondial_data/size_dist_WT.csv'

#sheet =  # sheet name or sheet number or list of sheet numbers and names
#df = pd.read_excel(file_name, sheet_name=sheet)
df_KO = pd.read_csv(file_name_size_distribution_KO)
#df_E50K = pd.read_csv(file_name_size_distribution_E50K)
df_WT = pd.read_csv(file_name_size_distribution_WT)
np_array_KO = df_KO.to_numpy()
np_array_WT = df_WT.to_numpy()

KO_sd = []
WT_sd = []

for i in range(N):
  KO_sd.append(np.mean(np_array_KO[i,4:16]))
  WT_sd.append(np.mean(np_array_WT[i,4:16]))

KO_sd = np.array(KO_sd)
WT_sd = np.array(WT_sd)

print(KO_sd)
print(WT_sd)

p_values = []

for i in range(100):
  p_value = permutation_test(KO_sd, WT_sd, method='approximate', seed=int(random.randint(0,1000)))
  p_values.append(p_value)

print("Average of p-values: ", np.mean(p_values).round(4))
print("Standard deviation of p-values: ", np.std(p_values).round(4))


## Direct test
if (np.mean(p_values).round(4) < alpha):
  print("Reject the null hypothesis")
else:
  print("Fail to reject the null hypothesis")

## Strong test
if (np.mean(p_values).round(4) + np.std(p_values).round(4) < alpha):
  print("Reject the null hypothesis")
else:
  print("Fail to reject the null hypothesis")
````

### Permutation test for the connectivity index  $C_t$

````python
from scipy.io import loadmat
import numpy as np
import pandas as pd
import math
import random
from scipy import stats
from mlxtend.evaluate import permutation_test

## Define 2 random distributions
#Sample Size
N = 5
alpha = 0.05

file_name_CI_KO = 'Mitochondial_data/Connectivity_index_KO.csv'
file_name_CI_WT = 'Mitochondial_data/Connectivity_index_WT.csv'

#sheet =  # sheet name or sheet number or list of sheet numbers and names
#df = pd.read_excel(file_name, sheet_name=sheet)
df_KO = pd.read_csv(file_name_CI_KO)
#df_E50K = pd.read_csv(file_name_size_distribution_E50K)
df_WT = pd.read_csv(file_name_CI_WT)
np_array_KO = df_KO.to_numpy()
np_array_WT = df_WT.to_numpy()

KO_ci = []
WT_ci = []

#print(np_array_KO)
#print(np_array_WT)

for i in range(N):
  KO_ci.append(np.mean(np_array_KO[i,100:151]))
  WT_ci.append(np.mean(np_array_WT[i,100:151]))

KO_ci = np.array(KO_ci)
WT_ci = np.array(WT_ci)

print(KO_ci)
print(WT_ci)

p_values = []

for i in range(100):
  p_value = permutation_test(KO_ci, WT_ci, method='approximate', seed=int(random.randint(0,1000)))
  p_values.append(p_value)

print("Average of p-values: ", np.mean(p_values).round(4))
print("Standard deviation of p-values: ", np.std(p_values).round(4))

## Direct test
if (np.mean(p_values).round(4) < alpha):
  print("Reject the null hypothesis")
else:
  print("Fail to reject the null hypothesis")

## Strong test
if (np.mean(p_values).round(4) + np.std(p_values).round(4) < alpha):
  print("Reject the null hypothesis")
else:
  print("Fail to reject the null hypothesis")
````

## References
[1] Konstantin Mischaikow and Vidit Nanda. Morse Theory for Filtrations and Efficient Computation of Persistent Homology. Discrete & Computational Geometry, Volume 50, Issue 2, pp 330-353, September 2013.
