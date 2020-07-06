//
//  MyBookCollectionViewCell.swift
//  myBookShelf
//
//  Created by 仲里和也 on 2020/07/01.
//  Copyright © 2020 仲里和也. All rights reserved.
//

import UIKit

class MyBookCollectionViewCell: UICollectionViewCell {
    
    private let cellNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 2))
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        return label
    }()
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override func layoutSubviews() {
        
        cellImageView.frame = CGRect(x: 15,
                                     y: 0,
                                     width: contentView.frame.width - 45,
                                     height: contentView.frame.width - 45)
        cellNameLabel.frame = CGRect(x: 15,
                                     y: cellImageView.frame.height,
                                     width: contentView.frame.width - 45,
                                     height: 30)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(cellNameLabel)
        contentView.addSubview(cellImageView)
    }
    
    func setUpContents(_ image: UIImage, _ textName: String){
        cellImageView.image = image
        cellNameLabel.text = textName
    }
}
