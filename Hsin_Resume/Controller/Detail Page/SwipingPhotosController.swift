//
//  SwipingPhotosController.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/2/18.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit
import SDWebImage

protocol SwipingPhotosControllerDelegate {
    func setupCardViewsLabel(cardIndex: Int)
}

class SwipingPhotosController: UIPageViewController {
    var swipingPhotosControllerDelegate: SwipingPhotosControllerDelegate?
    var observer: Observer? = Observer()
    var cardViewModel: IntroductionCardViewModel!{
        
        didSet{
            print(cardViewModel.imageUrls)
            controllers = cardViewModel.imageUrls.map({ (imageUrlStr) -> PhotoController in
                let photoController = PhotoController.init(imageUrlStr: imageUrlStr)
                return photoController
            })
            
            controllers.forEach { (controller) in
                print(controller)
            }
            
            //這邊的controllers參數很怪，只可傳一個controller進去
            setViewControllers([controllers.first!], direction: .forward, animated: false, completion: nil)
            
            setupBarView()
            setupImageIndexObserver()
        }
    }
    
    fileprivate func setupImageIndexObserver(){
        cardViewModel.bindableCardIndex.addObserver(observer: observer!, removeIfExist: true, options: [.new]) { (cardIndex, change) in
            guard let cardIndex = cardIndex else {return}
            self.swipingPhotosControllerDelegate?.setupCardViewsLabel(cardIndex: cardIndex)
        }
    }
    
    fileprivate let barsStackView = UIStackView.init(arrangedSubviews: [])
    fileprivate let deselectedBarColor = UIColor.init(white: 0, alpha: 0.1)
    
    var controllers = [PhotoController]()
    
    fileprivate let isCardViewMode: Bool
    init(isCardViewMode: Bool = false){
        self.isCardViewMode = isCardViewMode
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        dataSource = self
        delegate = self
        
        if isCardViewMode{
            disableSwipingAbility()
        }
        
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(handleTap)))
    }
    
    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer){
        let currentController = viewControllers!.first!
        if let index = controllers.firstIndex(of: currentController as! PhotoController){
            barsStackView.arrangedSubviews.forEach { (view) in
                view.backgroundColor = deselectedBarColor
            }
            if gesture.location(in: view).x > view.frame.width/2{
                let nextIndex = min(index + 1, controllers.count - 1)
                let nextController = controllers[nextIndex]
                setViewControllers([nextController], direction: .forward, animated: false, completion: nil)
                barsStackView.arrangedSubviews[nextIndex].backgroundColor = .white
                cardViewModel.fetchCurrentCardIndex(cardIndex: nextIndex)
//                cardViewModel.advanceToNextPhoto()
            }else{
                let previousIndex = max(index - 1, 0)
                let nextController = controllers[previousIndex]
                setViewControllers([nextController], direction: .forward, animated: false, completion: nil)
                barsStackView.arrangedSubviews[previousIndex].backgroundColor = .white
                cardViewModel.fetchCurrentCardIndex(cardIndex: previousIndex)
//                cardViewModel.previousToLastPhoto()
            }
        }
        
    }
    
    fileprivate func disableSwipingAbility(){
        view.subviews.forEach { (view) in
            if let view = view as? UIScrollView{
                view.isScrollEnabled = false
            }
        }
    }
    
    fileprivate func setupBarView(){
        cardViewModel.imageUrls.forEach { (_) in
            let barView = UIView()
            barView.backgroundColor = .white
            barView.layer.cornerRadius = 2
            barView.backgroundColor = deselectedBarColor
            barsStackView.addArrangedSubview(barView)
        }
        
        if cardViewModel.imageUrls.count > 1{
            view.addSubview(barsStackView)
            barsStackView.axis = .horizontal
            barsStackView.spacing = 4
            barsStackView.distribution = .fillEqually
            //先預設第一個bar的顏色為白色
            barsStackView.arrangedSubviews.first?.backgroundColor = .white
            var paddingTop: CGFloat = 8
            if !isCardViewMode{
                paddingTop += UIApplication.shared.statusBarFrame.height
            }
            barsStackView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: paddingTop, left: 8, bottom: 8, right: 8), size: .init(width: 0, height: 4))
        }
        
    }
    
}


extension SwipingPhotosController: UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //會回傳目前的controller在controllers中的index
        let index = self.controllers.firstIndex(where: {$0 == viewController}) ?? 0
        if index == 0{
            return nil
        }
        return controllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = self.controllers.firstIndex(where: {$0 == viewController}) ?? 0
        if index == controllers.count - 1{
            return nil
        }
        return controllers[index + 1]

    }
    
    public func setBarColor(_ currentCardIndex: Int) {
        barsStackView.arrangedSubviews.forEach { (view) in
            view.backgroundColor = deselectedBarColor
        }
        barsStackView.arrangedSubviews[currentCardIndex].backgroundColor = .white
    }
}

extension SwipingPhotosController: UIPageViewControllerDelegate{
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentPhotoController = viewControllers?.first
        if let index = controllers.firstIndex(where: { (controller) -> Bool in controller == currentPhotoController}){
            setBarColor(index)
            cardViewModel.fetchCurrentCardIndex(cardIndex: index)
        }
        
        print("Page transition complete!")
    }
}








