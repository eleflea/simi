图片相关性
=========

## 用途

比较两张图片的相似度。

## 函数

### [simi_corr2]

#### 描述

基于MATLAB中的[corr2]函数，返回双精度结果越接近于1图片越相似（可能出现负值）。

#### 用法

```
rate = simi_corr2('path\to\image1','path\to\image2')
rate = simi_corr2(image_data,image2_data)
```

### [simi_hist]

#### 描述

基于[直方图]，分为64区，每区有4个灰度等级，返回双精度结果（0~1）越接近于1图片越相似。

#### 用法

```
rate = simi_hist('path\to\image1','path\to\image2'[,opt])
rate = simi_hist(image1_data,image2_data[,opt])
```
##### opt参数：
+ r: RGB 模式，默认。
+ g: 灰度模式。
+ o: 计算[余弦相似度]，默认。
+ c: [corr2]函数。
+ n: 无图模式。

### [simi_phist]

#### 描述

基于[simi_hist]，把图片分为n\*n个小份，分别用[simi_hist]比较，结果取平均值。返回双精度结果（0~1）越接近于1图片越相似。
依赖[splitter]。

#### 用法

```
rate = simi_phist('path\to\image1','path\to\image2',pieces[,opt])
rate = simi_phist(image1_data,image2_data,pieces[,opt])
```
##### pieces参数:
每行每列分为pieces份。
##### opt参数：
+ r: RGB 模式，默认。
+ g: 灰度模式。
+ o: 计算[余弦相似度]，默认。
+ c: [corr2]函数。

### [simi_map]

#### 描述

基于[simi_phist]和[图像显著性模型]，将图片的saliency map用[simi_phist]比较。返回双精度结果（0~1）越接近于1图片越相似。
依赖[samap]和[splitter]。

#### 用法

```
rate = simi_phist('path\to\image1','path\to\image2',pieces[,opt])
rate = simi_phist(image1_data,image2_data,pieces[,opt])
```
##### pieces参数:
每行每列分为pieces份。
##### opt参数：
+ o: 计算[余弦相似度]，默认。
+ c: [corr2]函数。
+ n: 无图模式。

### [splitter]

#### 描述

把图像均分成n\*n小份，返回n\*n大小的cell，存有图像信息。

#### 用法

```
IMdata = splitter('path\to\image', dimension)
IMdata = splitter(image_data, dimension)
```
##### dimension参数:
每行每列分为dimension份。

### [samap]

#### 描述

计算图像的saliency map（灰度），返回图像数据。

#### 用法

```
map_data = samap('path\to\image')
map_data = samap(image_data)
```

[simi_corr2]: ./simi_corr2.m
[corr2]: http://cn.mathworks.com/help/images/ref/corr2.html
[simi_hist]: ./simi_hist.m
[直方图]: http://blog.csdn.net/qq_23100787/article/details/51175775
[余弦相似度]: https://zh.wikipedia.org/wiki/%E4%BD%99%E5%BC%A6%E7%9B%B8%E4%BC%BC%E6%80%A7
[simi_phist]: ./simi_phist.m
[splitter]: ./splitter.m
[simi_map]: ./simi_map.m
[图像显著性模型]: http://www.cnblogs.com/CCBB/archive/2011/05/19/2051442.html
[samap]: ./samap.m
