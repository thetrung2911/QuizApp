//
//  MyCell.swift
//  QuizApp
//
//  Created by Trung Le on 9/11/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import UIKit
import Stevia

class MyCell: UITableViewCell {
    let conView = UIView()
    var label: UILabel = {
        let label = UILabel()
//        label.text = "Đây là Label"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 28)
        label.textAlignment = .center
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.sv(conView)
        self.backgroundColor = .gray
        conView.backgroundColor = .white
        conView.width(100%).centerVertically().top(2).bottom(2)
        conView.sv(label)
        label.centerHorizontally().centerVertically().left(8).right(8)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
