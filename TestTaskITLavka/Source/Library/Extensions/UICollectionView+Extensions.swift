//
//  UICollectionView+Extensions.swift
//  TestTaskCrassula
//
//  Created by Oleg Soloviev on 06.03.2019.
//  Copyright © 2019 varton. All rights reserved.
//

import UIKit

extension UICollectionView {

    func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
    }
    
    func register(cellType: UICollectionViewCell.Type) {
        register(cellType, forCellWithReuseIdentifier: String(describing: cellType.self))
    }
}
