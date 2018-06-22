//
//  CustomLayout.swift
//  ScrollItemView
//
//  Created by 冷少白 on 2018/5/11.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import UIKit

class CustomLayout: UICollectionViewLayout {
    var edgeMargin: CGFloat = 15   // 边界的间距
    var padding: CGFloat = 10     // 内部每个cell的间距
    var column: Int = 4      // 每页有多少列
    var row: Int = 1        // 每页有多少行
    var pageControl: UIPageControl!
    
    private var layoutAttr: [UICollectionViewLayoutAttributes] = []
    
    var totalCount: Int {  // 有多少cell
        get {
            return collectionView!.numberOfItems(inSection: 0)
        }
    }
    
    var page: Int {
        get {
            let numOfPage: Int = column * row
            return totalCount / numOfPage
        }
    }
    
    // 重写此方法，自定义想要的布局
    override func prepare() {
        super.prepare()
        
        // 这个方法最主要的任务是计算出每个cell的位置
        layoutAttr = []
        var indexPath: NSIndexPath
        for index in 0..<totalCount {
            indexPath = NSIndexPath(row: index, section: 0)
            let attributes = layoutAttributesForItem(at: indexPath as IndexPath)!
            
            layoutAttr.append(attributes)
        }
    }

    
    
    override var collectionViewContentSize: CGSize { // 返回滚动的Size，根据页数计算出来
        return CGSize(width:collectionView!.frame.size.width * CGFloat(page), height:collectionView!.frame.size.height)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
   override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        // 这个方法用来计算每一个cell的位置
        let att: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
        
        let collectW: CGFloat = collectionView!.frame.size.width   // collection view 宽度
        let numOfPage: Int = column * row
        let pageIndex: Int = indexPath.row / numOfPage    // 当前cell处在哪一个页
        let columnInPage: Int = indexPath.row % numOfPage % column   // 当前cell 在当前页的哪一列，用来计算位置
        let rowInPage: Int = indexPath.row % numOfPage / column  // 当前cell 在当前页的哪一行，用来计算位置
        // 计算宽度
        let cellW: CGFloat = (collectW - edgeMargin * 2 - CGFloat(column - 1) * padding) / CGFloat(column)
        // 高度
        let cellH: CGFloat = cellW*CGFloat(column)*0.2
        // x
        let cellX: CGFloat = collectW * CGFloat(pageIndex) + edgeMargin + (cellW + padding) * CGFloat(columnInPage)
        // y
        let cellY :CGFloat = edgeMargin + (cellH + padding) * CGFloat(rowInPage)
        
        att.frame = CGRect(x:cellX, y:cellY, width:cellW, height:cellH)
        return att
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttr
    }
    
    
}
//extension CustomLayout: UICollectionViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offset = scrollView.contentOffset
//        // 随着滑动改变pageControl的状态
//        pageControl.currentPage = Int(offset.x / SCREEN_WIDTH)
//        // 选中圆点颜色
//        pageControl.currentPageIndicatorTintColor = UIColor.Main
//        // 未选中圆点颜色
//        pageControl.pageIndicatorTintColor = UIColor.gray
//        
//    }
//    
//}
