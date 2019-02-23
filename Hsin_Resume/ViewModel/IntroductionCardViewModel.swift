//
//  IntroductionCardViewModel.swift
//  Hsin_Resume
//
//  Created by Chung Han Hsin on 2019/2/22.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import Foundation
import UIKit
class IntroductionCardViewModel{
    let imageUrls: [String]
    let attributedStrs: [NSAttributedString]
    let textAlignment: NSTextAlignment

    var bindableCardIndex = Observable<Int>.init(value: 0)
    
    init(imageUrls: [String], attributedStrs: [NSAttributedString], textAlignment: NSTextAlignment) {
        self.imageUrls = imageUrls
        self.attributedStrs = attributedStrs
        self.textAlignment = textAlignment
    }
    
    //Reactive programming
    var imageIndexObserver: ((_ image: UIImage, _ attributedStr: NSAttributedString, _ cardIndex: Int) -> ())?
    func advanceToNextPhoto(){
        bindableCardIndex.value = min(bindableCardIndex.value! + 1, imageUrls.count - 1)
    }
    
    func previousToLastPhoto(){
        bindableCardIndex.value = max(bindableCardIndex.value! - 1, 0)
    }
    
   
    //For SwipingPhotosController
    func fetchCurrentCardIndex(cardIndex: Int){
        bindableCardIndex.value = cardIndex
    }
    
}
