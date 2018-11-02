//
//  RatingView.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 01/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class RatingView: UIView {

    @IBOutlet var ratingViewArray: [UIView]!
    @IBOutlet var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("RatingXIB", owner: self, options: nil)
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        for view in ratingViewArray{
            stackView.addArrangedSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
        
        
    }
    

}
