//
//  GridLayout.swift
//  SalesForceDemo
//
//  Created by Saikumar Kankipati on 2/15/20.
//  Copyright © 2020 Saikumar Kankipati. All rights reserved.
//

import UIKit

class GridLayout: UICollectionViewFlowLayout {
    
    var numberOfColumns: Int = 2
    
    init(numberOfColumns: Int) {
        super.init()
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
        self.numberOfColumns = numberOfColumns
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var itemSize: CGSize {
        get {
            if let collectionView = collectionView {
                let itemWidth: CGFloat = (collectionView.frame.width / CGFloat(self.numberOfColumns)) - self.minimumInteritemSpacing
                let itemHeight: CGFloat = 250.0
                return CGSize(width: itemWidth, height: itemHeight)
            }
            // Default fallback
            return CGSize(width: 100, height: 150)
        }
        set {
            super.itemSize = newValue
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return proposedContentOffset
    }
}
