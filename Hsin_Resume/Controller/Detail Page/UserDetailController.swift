//
//  MoreInfoViewController.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/2/18.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit
import SDWebImage

protocol UserDetailControllerDelegate {
    func nope(userDetailController: UserDetailController)
    func like(userDetailController: UserDetailController)
}

class UserDetailController: UIViewController {
    
    var delegate: UserDetailControllerDelegate?
    
    //You should really create a differnet viewModel for UserDetail Viewmodel
    var introductionCardViewModel: IntroductionCardViewModel?{
        didSet{
            swipingPhotosController.cardViewModel = introductionCardViewModel
            infoLabel.attributedText = introductionCardViewModel?.attributedStrs.first
            setupImageIndexObserver()
        }
    }
    
    var observer: Observer? = Observer()
    
    fileprivate func setupImageIndexObserver(){
        introductionCardViewModel?.bindableCardIndex.addObserver(observer: observer!, removeIfExist: true, options: [.new]) { (cardIndex, change) in
            guard let cardIndex = cardIndex else {return}
            self.infoLabel.attributedText = self.introductionCardViewModel?.attributedStrs[cardIndex]
        }
    }
    
    lazy var scrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.contentInsetAdjustmentBehavior = .never
        sv.delegate = self
        return sv
    }()
    
    //how do I swap a UIImageView with a UIViewController component
    let swipingPhotosController = SwipingPhotosController()
    
    let infoLabel: InformationLabel = {
        let label = InformationLabel()
        label.text = "User name GG \nDoctor\nbio text doen below"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .left
        return label
    }()
    
    lazy var dismissButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "dismiss_down_arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleTapDismiss(sender:)), for: .touchUpInside)
        return btn
    }()
    
    @objc func handleTapDismiss(sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    //3 bottom control buttons
    lazy var dislikeButton = self.createButton(image: #imageLiteral(resourceName: "dismiss_circle"), selector: #selector(handleDislike))
    @objc func handleDislike(){
        delegate?.nope(userDetailController: self)
    }
    
    lazy var superlikeButton = self.createButton(image: #imageLiteral(resourceName: "super_like_circle"), selector: #selector(handleDislike))
    
    lazy var likeButton = self.createButton(image: #imageLiteral(resourceName: "like_circle"), selector: #selector(handleLike))
    @objc func handleLike(){
        delegate?.like(userDetailController: self)
    }
    
    
    fileprivate func createButton(image: UIImage, selector: Selector) -> UIButton{
        let button = UIButton.init(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLayout()
    }
    
    
    fileprivate func setupLayout(){
        view.addSubview(scrollView)
        scrollView.fillSuperView()
        
        let swipingView = swipingPhotosController.view!
        
        scrollView.addSubview(swipingView)
        
        scrollView.addSubview(infoLabel)
        infoLabel.anchor(top: swipingView.bottomAnchor, bottom: nil, leading: scrollView.leadingAnchor, trailing: nil, padding: .init(top: 25, left: 0, bottom: 0, right: 0), size: .init(width: UIScreen.main.bounds.width, height: 120))
        
        scrollView.addSubview(dismissButton)
        dismissButton.anchor(top: swipingView.bottomAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, padding: .init(top: -25, left: 0, bottom: 0, right: 25), size: CGSize.init(width: 50, height: 50))
        
        setupVisualEffectView()
        
        setupBottomButtonControls()
    }
    
    
    //讓圖片不要是正方形的
    fileprivate let extraSwipingHeight: CGFloat = 80
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let swipingView = swipingPhotosController.view!
        swipingView.frame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.width + extraSwipingHeight)

    }
    
    
    fileprivate func setupBottomButtonControls(){
        let stackView = UIStackView.init(arrangedSubviews: [dislikeButton, superlikeButton, likeButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = -32
        view.addSubview(stackView)
        stackView.anchor(top: nil, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 300, height: 80))
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    fileprivate func setupVisualEffectView(){
        let blurEffect = UIBlurEffect.init(style: .regular)
        let visualEffectView = UIVisualEffectView.init(effect: blurEffect)
        
        view.addSubview(visualEffectView)
        visualEffectView.anchor(top: view.topAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
    }
}


extension UserDetailController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let changeY = -scrollView.contentOffset.y
        let width = max(view.frame.width + changeY * 2, view.frame.width)
        let swipingView = swipingPhotosController.view!
        swipingView.frame = CGRect.init(x: min(-changeY, 0) , y: min(-changeY, 0), width: width, height: width + extraSwipingHeight)
    }
}


class InformationLabel: UILabel {
    override func draw(_ rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: 16, dy: 0))
    }
}
