//
//  ImageCell.swift
//  TestTaskCrassula
//
//  Created by Oleg Soloviev on 06.03.2019.
//  Copyright © 2019 varton. All rights reserved.
//

import UIKit

final class ImageCell: UICollectionViewCell {
    private(set) lazy var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.addSubview(imageView)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1)
            ])
    }
}
