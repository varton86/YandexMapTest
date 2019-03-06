//
//  Adapter.swift
//  TestTaskCrassula
//
//  Created by Oleg Soloviev on 06.03.2019.
//  Copyright © 2019 varton. All rights reserved.
//

import UIKit

final class Adapter<T, Cell: UICollectionViewCell>: NSObject,
UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var items: [T] = []
    var configure: ((T, Cell) -> Void)?
    var cellHeight: CGFloat = 46
    var cellWidth: CGFloat = 46

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.item]
        
        let cell: Cell = collectionView.dequeue(indexPath: indexPath)
        configure?(item, cell)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
