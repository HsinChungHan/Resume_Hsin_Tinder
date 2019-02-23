//
//  TapRefreshButtonView.swift
//  Hsin_Resume
//
//  Created by Chung Han Hsin on 2019/2/22.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit

class TapRefreshButtonView: UIView {

    let refreshImgView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "refresh_circle")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(refreshImgView)
        refreshImgView.centerInSuperView(size: .init(width: UIScreen.main.bounds.width / 2, height:  UIScreen.main.bounds.width / 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
