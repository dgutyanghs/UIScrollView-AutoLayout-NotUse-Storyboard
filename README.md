<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#orgheadline2">1. UIScrollView AutoLayout的解决方法</a>
<ul>
<li><a href="#orgheadline1">1.1. 相对于普通的View来说, UIScrollView 的AutoLayout 比较特殊.因为它的 left/right/top/bottom space 是相对于 UIScrollView的 contentSize 而不是 bounds 来确定的.如果你尝试用 UIScrollView和它 subview 的left/right/top/bottom 来互相决定大小的时候，系统会警告你"Has ambiguous scrollable content width/height".</a></li>
</ul>
</li>
</ul>
</div>
</div>

# UIScrollView AutoLayout的解决方法<a id="orgheadline2"></a>

## 相对于普通的View来说, UIScrollView 的AutoLayout 比较特殊.因为它的 left/right/top/bottom space 是相对于 UIScrollView的 contentSize 而不是 bounds 来确定的.如果你尝试用 UIScrollView和它 subview 的left/right/top/bottom 来互相决定大小的时候，系统会警告你"Has ambiguous scrollable content width/height".<a id="orgheadline1"></a>

**解决方法:**
**step 1** : 在scrollView和它的subviews之间,先添加一个 containView,
对齐scrollview的top & leading边界,scrollView的width &height 对齐containView,
从而使scrollView 的 contentSize确定下来. (contentSize的大小等于containView.size)

**step 2**:保存下面的NSLayoutConstraint,
如果scrollView的宽度变化(如:网络请求回来的内容增加了),则需要更新此约束.

**step 3**: 添加scrollView 和它的superView 约束
