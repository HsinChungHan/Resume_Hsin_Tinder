//
//  Introduction.swift
//  Hsin_Resume
//
//  Created by Chung Han Hsin on 2019/2/22.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import Foundation
import UIKit
class Introduction{
    var name: String, profession: String, email: String, imageUrls: [String], textAligment: NSTextAlignment
    var descriptions: [String] = [""]
    
    init(dictionary: [String: Any], textAligment: NSTextAlignment){
        self.name = dictionary["name"] as? String ?? ""
        self.profession = dictionary["profession"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.imageUrls = dictionary["images"] as? [String] ?? [String]()
        self.descriptions = dictionary["descriptions"] as? [String] ?? [String]()
        self.textAligment = textAligment
    }
    
    init(name: String, profession: String, email: String, imageUrls: [String], textAligment: NSTextAlignment, descriptions: [String]) {
        self.name = name
        self.profession = profession
        self.email = email
        self.imageUrls = imageUrls
        self.textAligment = textAligment
        self.descriptions = descriptions
    }
    
    
    var overallAttributeTexts = [NSMutableAttributedString]()
    func transformUserInfoToAttributedString(){
        let nameAttributedText = NSAttributedString.init(string: name, attributes:
            [.font : UIFont.systemFont(ofSize: 24, weight: .heavy)])
        let professionAttributedText = NSAttributedString.init(string: "\n\(profession)", attributes: [.font : UIFont.systemFont(ofSize: 18, weight: .heavy)])
        let emailAttributedText = NSAttributedString.init(string: "\n\(email)", attributes: [.font : UIFont.systemFont(ofSize: 18, weight: .regular)])
        let attributedTexts = [nameAttributedText, professionAttributedText, emailAttributedText]
        let attributedText = NSMutableAttributedString.init()
        attributedTexts.forEach { (attributedString) in
            attributedText.append(attributedString)
        }
        overallAttributeTexts.append(attributedText)
    }
    
    func transformAttributedStrings() -> [NSMutableAttributedString]{
        transformUserInfoToAttributedString()
        descriptions.forEach { (description) in
            let descriptionAttributedText = NSMutableAttributedString.init(string: description, attributes:
                [.font : UIFont.systemFont(ofSize: 24, weight: .heavy)])
            overallAttributeTexts.append(descriptionAttributedText)
        }
        return overallAttributeTexts
    }
    
    
    
    
    
    func toIntroductionCardViewModel() -> IntroductionCardViewModel{
        
        return IntroductionCardViewModel.init(imageUrls: imageUrls, attributedStrs: transformAttributedStrings(), textAlignment: textAligment)
    }
    
}


