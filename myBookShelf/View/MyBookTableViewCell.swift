//
//  MyBookTableViewCell.swift
//  myBookShelf
//
//  Created by 仲里和也 on 2020/05/05.
//  Copyright © 2020 仲里和也. All rights reserved.
//

import UIKit

class MyBookTableViewCell: UITableViewCell {

    var bookTitle: UILabel?
    var bookImg: UIImageView?
    var bookCategory: UILabel?
    var bookBeBoughtAt: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setBookTitle()
        setBookImg()
        setBookCategory()
        setBookBeBoughtAt()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let textPointX = CGFloat(contentView.frame.width / 3 + 30)
        let textWidth = CGFloat(contentView.frame.width / 2 - 30)
        bookImg?.frame = CGRect(x: 15,
                                y: 15,
                                width: contentView.frame.width / 3,
                                height: 120)
        
        bookTitle?.frame = CGRect(x: textPointX,
                                  y: 15,
                                  width: textWidth,
                                  height: 30)
        
        bookCategory?.frame = CGRect(x: textPointX,
                                     y: 50,
                                     width: textWidth,
                                     height: 30)
        
        bookBeBoughtAt?.frame = CGRect(x: textPointX,
                                       y: 85,
                                       width: textWidth,
                                       height: 30)
    }
    
    func setBookTitle(){
        bookTitle = UILabel(frame: .zero)
        bookTitle?.textColor = .black
        bookTitle?.font = UIFont.boldSystemFont(ofSize: 17)
        bookTitle?.sizeToFit()
        bookTitle?.tag = 1
        contentView.addSubview(bookTitle!)
    }
    
    func setBookImg(){
        bookImg = UIImageView(frame: .zero)
        bookImg?.contentMode = .scaleAspectFit
        bookImg?.tag = 2
        contentView.addSubview(bookImg!)
    }
    
    func setBookCategory(){
        bookCategory = UILabel(frame: .zero)
        bookCategory?.textColor = .black
        bookCategory?.font = UIFont.systemFont(ofSize: 14)
        bookCategory?.sizeToFit()
        bookCategory?.tag = 3
        contentView.addSubview(bookCategory!)
    }
    
    func setBookBeBoughtAt(){
        bookBeBoughtAt = UILabel(frame: .zero)
        bookBeBoughtAt?.textColor = .black
        bookBeBoughtAt?.font = UIFont.systemFont(ofSize: 14)
        bookBeBoughtAt?.sizeToFit()
        bookBeBoughtAt?.tag = 4
        contentView.addSubview(bookBeBoughtAt!)
    }

}
