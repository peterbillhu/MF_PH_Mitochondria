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

## References
[1] Konstantin Mischaikow and Vidit Nanda. Morse Theory for Filtrations and Efficient Computation of Persistent Homology. Discrete & Computational Geometry, Volume 50, Issue 2, pp 330-353, September 2013.
