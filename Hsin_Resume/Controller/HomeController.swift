//
//  HomeControllerViewController.swift
//  Hsin_Resume
//
//  Created by Chung Han Hsin on 2019/2/22.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class HomeController: UIViewController {

    let topStackView = TopNavigationStackView()
    
    let cardsDeckView = UIView()
    let bottomControlsStackView = HomeBottomStackView()
    var topCardView: IntroductionCardView?
    
    
    
    let introductionViewModels: [IntroductionCardViewModel] = [
    ]
    
    fileprivate func fetchIntroImages() {
        Firestore.firestore().collection("Hsin").document("Introduction").getDocument { (snapshot, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            guard let doc = snapshot?.data() else {return}
            (doc["images"] as! [String]).forEach({ (str) in
                print(str)
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        bottomControlsStackView.likeButton.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        bottomControlsStackView.dislikeButton.addTarget(self, action: #selector(handleDislike), for: .touchUpInside)
        bottomControlsStackView.refreshButton.addTarget(self, action: #selector(handleRefresh), for: .touchUpInside)
        topStackView.settingButton.addTarget(self, action: #selector(handleSetting), for: .touchUpInside)

        setupLayout()
        fetchCurrentUser()
//        fetchInfoFromFirebase()
        setupInstructionView()
        
    }
    
    let instructionView = UIImageView.init(image: #imageLiteral(resourceName: "instruction"))
    fileprivate func setupInstructionView(){
        instructionView.alpha = 1.0
        instructionView.contentMode = .scaleAspectFit
        view.addSubview(instructionView)
        instructionView.fillSuperView()
        instructionView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismissView)))
        instructionView.isUserInteractionEnabled = true
    }
    
    @objc func dismissView(){
        
        UIView.animate(withDuration: 1.0, animations: {
            self.instructionView.alpha = 0.0
        }) { (_) in
            self.instructionView.removeFromSuperview()
        }
    }
    
    
    @objc func handleSetting(sender: UIButton){
        let settingVC = SettingController()
        settingVC.delegate = self
        let naviController = UINavigationController.init(rootViewController: settingVC)
        present(naviController, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //you want to kick urser out when they log out
        if Auth.auth().currentUser == nil{
            let registrationController = RegistrationController()
            registrationController.delegate = self
            let navController = UINavigationController(rootViewController: registrationController)
            present(navController, animated: true)
            
        }
    }

    fileprivate let hud = JGProgressHUD(style: .dark)
    fileprivate func fetchInfoFromFirebase(){
        hud.textLabel.text = "Loading Photos from Firebase"
        hud.show(in: view)
        cardsDeckView.subviews.forEach({$0.removeFromSuperview()})
        let query = Firestore.firestore().collection("Hsin").order(by: "tag", descending: false)
        topCardView = nil
        query.getDocuments { (snapshot, error) in
            self.hud.dismiss()
            if let error = error{
                print(error.localizedDescription)
                return
            }
            var previousCardView: IntroductionCardView?
            snapshot?.documents.forEach({ (snapshot) in
                let dictionary = snapshot.data()
                let introduction = Introduction.init(dictionary: dictionary, textAligment: .left)
                let cardView = self.setupCardFromIntroduction(introduction: introduction)
                previousCardView?.nextCardView = cardView
                previousCardView = cardView
                if self.topCardView == nil{
                    self.topCardView = cardView
                }
            })
        }
    }
    
    fileprivate func setupCardFromIntroduction(introduction: Introduction) -> IntroductionCardView{
        let cardView = IntroductionCardView.init(frame: .zero)
        cardView.setupViewModel(viewModel: introduction.toIntroductionCardViewModel())
        cardsDeckView.addSubview(cardView)
        cardsDeckView.sendSubviewToBack(cardView)
        cardView.fillSuperView()
        cardView.delegate = self
        return cardView
    }
    
    
    @objc func handleLike(){
        topCardView?.likeImageView.alpha = 1.0
        performSwipAnimation(translation: 700, angle: 15)
        if !hasHired{
            presentMatchedView()
        }
        
    }
    
    @objc func handleDislike(){
        topCardView?.nopeImageView.alpha = 1.0
        performSwipAnimation(translation: -700, angle: -15)
        
    }
    
    @objc func handleRefresh(sender: UIButton){
        cardsDeckView.subviews.forEach({$0.removeFromSuperview()})
        topCardView = nil
        fetchInfoFromFirebase()
//        setupCardViewFromIntroductionViewModel()
    }
    
    fileprivate func setupLayout(){
        view.backgroundColor = .white
        let overallStackView = UIStackView.init(arrangedSubviews: [topStackView, cardsDeckView, bottomControlsStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        //讓我的cardView永遠都在stackView之上
        overallStackView.bringSubviewToFront(cardsDeckView)
    }
    
    fileprivate func performSwipAnimation(translation: CGFloat, angle: CGFloat) {
        let translationAnimation = CABasicAnimation.init(keyPath: "position.x")
        translationAnimation.toValue = translation
        translationAnimation.duration = 0.5
        //讓topCardView不會回到原位
        translationAnimation.fillMode = .forwards
        //讓你的讓你的animation不會被移除
        translationAnimation.isRemovedOnCompletion = false
        translationAnimation.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
        
        let rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = angle * CGFloat.pi / 180
        rotationAnimation.duration = 0.5
        
        
        let cardView = topCardView
        topCardView = cardView?.nextCardView
        CATransaction.setCompletionBlock {
            cardView?.removeFromSuperview()
        }
        
        cardView?.layer.add(translationAnimation, forKey: "translation")
        cardView?.layer.add(rotationAnimation, forKey: "rotation")
        CATransaction.commit()
        
    }
    
    fileprivate func setupCardViewFromIntroductionViewModel(){
        var previousCardView: IntroductionCardView?
        introductionViewModels.forEach { (viewModel) in
            let cardView = IntroductionCardView.init(frame: .zero)
            cardView.delegate = self
            cardView.setupViewModel(viewModel: viewModel)
            cardsDeckView.addSubview(cardView)
            cardsDeckView.sendSubviewToBack(cardView)
            cardView.fillSuperView()
            previousCardView?.nextCardView = cardView
            previousCardView = cardView
            if self.topCardView == nil{
                self.topCardView = cardView
            }
        }
    }
    
    fileprivate func setupRefreshView(){
        let refreshView = TapRefreshButtonView()
        cardsDeckView.addSubview(refreshView)
        refreshView.fillSuperView()
    }
    
   
    fileprivate func presentMatchedView(){
        let matchedView = MatchedView.init(frame: .zero)
        if let uid = Auth.auth().currentUser?.uid {
            matchedView.cardUserUid = uid
        }
        matchedView.cardUserImage = cardUserImgView.image
//        matchedView.cardUserImage = userImage
        view.addSubview(matchedView)
        matchedView.fillSuperView()
    }
    
    var cardUserImgView = UIImageView()
    func fetchCurrentUser(){
        fetchInfoFromFirebase()
        //fetch user from Firstore
        Firestore.firestore().fetchCurrentUser { [unowned self](user, error) in
            self.hud.dismiss()
            if let error = error{
                print("Failed to fetch current user: ", error.localizedDescription)
                return
            }
            guard let user = user else {return}
            guard let cardUrl = URL(string: user.imageUrl1 ?? "") else {return}
            self.cardUserImgView.sd_setImage(with: cardUrl)
        }
    }
    
    
}


extension HomeController: IntroductionCardViewDelegate{
    func didPressMoreInfoButton(cardViewModel: IntroductionCardViewModel) {
        let userDetailVC = UserDetailController()
        userDetailVC.delegate = self
        userDetailVC.introductionCardViewModel = cardViewModel
        present(userDetailVC, animated: true, completion: nil)
    }
    
    func swipeLike() {
        handleLike()
    }
    
    func swipeDislike() {
        handleDislike()
    }
    
    
}


extension HomeController: UserDetailControllerDelegate{
    func nope(userDetailController: UserDetailController) {
        userDetailController.dismiss(animated: true) {
            self.handleDislike()
        }
    }
    
    func like(userDetailController: UserDetailController) {
        userDetailController.dismiss(animated: true) {
            self.handleLike()
        }
    }
    
}

extension HomeController: LoginControllerDelegate{
    func didFinishLogin() {
        fetchCurrentUser()
    }
}

extension HomeController: SettingControllerDelegate{
    func didSaveSetting() {
        fetchCurrentUser()
    }
    
    
}
