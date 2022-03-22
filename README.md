The code of [Local density adaptive similarity measurement for spectral clustering](https://doi.org/10.1137/S0895479801384937)



The translation of the paper is in [Local density adaptive similarity measurement for spectral clustering](https://blog.csdn.net/qq_34179307/article/details/123393675?spm=1001.2014.3001.5501)



此论文仅对相似性度量方式进行了改进，利用新的相似性度量 ![](http://latex.codecogs.com/svg.latex?S_{L)代替了原始的高斯核函数![](http://latex.codecogs.com/svg.latex?S_{G})。使用的NCUT，以及对称正则化拉普拉斯![](http://latex.codecogs.com/svg.latex?L=D^{-\frac{1}{2}} S D^{-\frac{1}{2}})。

![](http://latex.codecogs.com/svg.latex?S_{L}\left(x_{i}, x_{j}\right)= \begin{cases}\exp \left(-\frac{d\left(x_{i}, x_{j}\right)^{2}}{2 \sigma^{2}\left(C N N\left(x_{i}, x_{j}\right)+1\right)}\right) & i \neq j \\ 0 & i=j\end{cases})

![](http://latex.codecogs.com/svg.latex?S_{G}\left(x_{i}, x_{j}\right)= \begin{cases}\exp \left(-\frac{d\left(x_{i}, x_{j}\right)^{2}}{2 \sigma^{2}\left(C N N\left(x_{i}, x_{j}\right)+1\right)}\right) & i \neq j \\ 0 & i=j\end{cases})


data.mat 为甜甜圈合成数据

