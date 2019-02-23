//
//  MatchedView.swift
//  Hsin_Resume
//
//  Created by Chung Han Hsin on 2019/2/24.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import JGProgressHUD

class MatchedView: UIView {
    
    
    var cardUser: User?
    var cardUserUid: String!{
        didSet{
            let query = Firestore.firestore().collection("users")
            query.document(cardUserUid).getDocument { (snapshot, error) in
                if let error = error{
                    print("Failed to fetch card user: \(error)")
                    return
                }
                guard let dictionart = snapshot?.data() else {return}
                self.cardUser = User.init(dictionary: dictionart)
                
                self.descriptionLabel.text = "\(self.cardUser!.name ?? "") hired Chung-Han, please!"
                
//                guard let cardUrl = URL(string: user.imageUrl1 ?? "") else {return}
//                self.cardUserImageView.sd_setImage(with: cardUrl)
            }
        }
    }
    
    var cardUserImage: UIImage!{
        didSet{
            cardUserImageView.image = cardUserImage
        }
    }
    
    fileprivate let itsAMatchImageView: UIImageView = {
        let iv = UIImageView.init(image: #imageLiteral(resourceName: "itsamatch"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    fileprivate let descriptionLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let imageViewWidth: CGFloat = 140
    
    fileprivate let currentUserImageView: UIImageView = {
        let imv = UIImageView()
        imv.image = #imageLiteral(resourceName: "user")
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        imv.layer.borderWidth = 2.0
        imv.layer.borderColor = UIColor.white.cgColor
        return imv
    }()
    
    fileprivate let cardUserImageView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.image = #imageLiteral(resourceName: "you")
        imv.clipsToBounds = true
        imv.layer.borderWidth = 2.0
        imv.layer.borderColor = UIColor.white.cgColor
        imv.alpha = 0.0
        return imv
    }()
    
    lazy var hireMeButton: SendMessageButton = {
        let btn = SendMessageButton(type: .system)
        btn.setTitle("HIRE ME, PLEASE!", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(saveHireInfo), for: .touchUpInside)
        return btn
    }()
    
    @objc func saveHireInfo(){
        let hud = JGProgressHUD.init(style: .dark)
        hud.textLabel.text = "Thank you for your support!\nI am gonna send you information into Firebase!\nThen, I'll contact with you ASAP^^"
        let documentData: [String : Any] = [
            "name": cardUser?.name ?? "",
            "uid": cardUserUid,
            "email": cardUser?.email ?? ""
        ]
        
        
        Firestore.firestore().collection("HireMe").document(cardUserUid).getDocument { [unowned self](snapshot, error) in
            if let error = error{
                print("Failed to fetch swipes document from firebase: \(error)")
                return
            }
            
            //如果swipes/uid這個document是存在的
            if snapshot?.exists == true{
                //用update的方式，不要去覆寫原本的資料
                Firestore.firestore().collection("HireMe").document(self.cardUserUid).updateData(documentData) { (error) in
                    if let error = error{
                        print("Failed to save swiped data in Firebase: \(error)")
                        return
                    }
                    print("Successfully updated swipe...")
                }
            }else{
                //否則新創一個swipes/uid document
                Firestore.firestore().collection("HireMe").document(self.cardUserUid).setData(documentData) { (error) in
                    if let error = error{
                        print("Failed to save swiped data in Firebase: \(error)")
                        return
                    }
                }
            }
        }
    }
    
    lazy var keepSwipingButton: KeepSwipingButton = {
        let btn = KeepSwipingButton(type: .system)
        btn.setTitle("DO NOT GO AWAY!", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return btn
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBluredView()
        setupLayout()
        setupAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var views = [
        currentUserImageView,
        cardUserImageView,
        descriptionLabel,
        itsAMatchImageView,
        hireMeButton,
        keepSwipingButton
    ]
    
    
    fileprivate func setupLayout(){
        views.forEach { (view) in
            addSubview(view)
            view.alpha = 0.0
        }
        
        
        currentUserImageView.anchor(top: nil, bottom: nil, leading: nil, trailing: centerXAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16) , size: .init(width: imageViewWidth, height: imageViewWidth))
        currentUserImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        currentUserImageView.layer.cornerRadius = imageViewWidth / 2
        
        cardUserImageView.anchor(top: nil, bottom: nil , leading: centerXAnchor, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: imageViewWidth, height: imageViewWidth))
        cardUserImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cardUserImageView.layer.cornerRadius = imageViewWidth/2
        
        
        descriptionLabel.anchor(top: nil, bottom: cardUserImageView.topAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 32), size: .init(width: 0, height: 50))
        
        itsAMatchImageView.anchor(top: nil, bottom: descriptionLabel.topAnchor, leading: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 16, right: 0), size: .init(width: 300, height: 80))
        itsAMatchImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        hireMeButton.anchor(top: cardUserImageView.bottomAnchor, bottom: nil, leading: currentUserImageView.leadingAnchor, trailing: cardUserImageView.trailingAnchor, padding: .init(top: 32, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 60))
        
        keepSwipingButton.anchor(top: hireMeButton.bottomAnchor, bottom: nil, leading: hireMeButton.leadingAnchor, trailing: hireMeButton.trailingAnchor, padding: .init(top: 32, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 60))
    }
    
    fileprivate func setupAnimation(){
        views.forEach({$0.alpha = 1})
        
        //starting positions
        //會先改變imageView的位置
        let angle = 30 * CGFloat.pi/180
        currentUserImageView.transform = CGAffineTransform.init(rotationAngle: -angle).concatenating(CGAffineTransform.init(translationX: 200, y: 0))
        
        cardUserImageView.transform = CGAffineTransform.init(rotationAngle: angle).concatenating(CGAffineTransform.init(translationX: -200, y: 0))
        
        hireMeButton.transform = CGAffineTransform.init(translationX: -500, y: 0)
        keepSwipingButton.transform = CGAffineTransform.init(translationX: 500, y: 0)
        
        //keyFrame animation for多段式動畫
        //在keyFrame裡面作的動畫，與外面的動畫是分開的
        //這邊會先用1.2秒去把上面的動畫做完(但要裡面有新的動畫可以做才會去做)，才接著做animateKeyframes裡面的動畫
        UIView.animateKeyframes(withDuration: 1.2, delay: 0, options: .calculationModeCubic, animations: {
            //animation 1 - translation back to original position
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.45, animations: {
                //在這邊旋轉的角度還是視為從原先為旋轉的圖片去考慮要旋轉多少
                self.currentUserImageView.transform = CGAffineTransform.init(rotationAngle: -angle)
                self.cardUserImageView.transform = CGAffineTransform.init(rotationAngle: angle)
            })
            
            //animation 2 - rotation
            //會在第一段動畫結束後執行(0.55秒後)
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4, animations: {
                //這邊就是做移掉第一段的動畫
                self.currentUserImageView.transform = .identity
                self.cardUserImageView.transform  = .identity
            })
        })
        
        //在0.65秒後，執行讓button回來的動畫
        UIView.animate(withDuration: 0.75, delay: 0.75, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
            self.hireMeButton.transform = .identity
            self.keepSwipingButton.transform = .identity
        })
    }
    
    
    let visualEffectView = UIVisualEffectView.init(effect: UIBlurEffect.init(style: .dark))
    
    fileprivate func setupBluredView(){
        addSubview(visualEffectView)
        visualEffectView.fillSuperView()
        
        visualEffectView.alpha = 0.0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.visualEffectView.alpha = 1.0
        })
        
        visualEffectView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(handleDismiss)))
        visualEffectView.isUserInteractionEnabled = true
    }
    
    @objc fileprivate func handleDismiss(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.alpha = 0.0
        }){(_) in
            self.removeFromSuperview()
        }
        
    }
}
