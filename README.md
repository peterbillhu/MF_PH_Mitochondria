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

The folder ``code'' consists of four Matlab M files: **ConnectivityIndex.m**, **NormalizedBettiNumberCurve.m**, **SizeDistrBettiNumber.m**, and **runPerseus.m**, where **runPerseus.m** is the code for computing the pesistent homology of cubical complexes (i.e., image data). Especially, the command 

```matlab
cmd = ['././perseusWin cubtop ' fname ' ' fname]
````

as a string in Matlab is 






The code for computing the connectivity index of an input image with threshold T. 




The code for computing the normalized Betti number curve of a given image, based on the opening operations.


The code for computing the size distribution of Betti numbers of a given image and the threshold.

## References
[1] Konstantin Mischaikow and Vidit Nanda. Morse Theory for Filtrations and Efficient Computation of Persistent Homology. Discrete & Computational Geometry, Volume 50, Issue 2, pp 330-353, September 2013.
