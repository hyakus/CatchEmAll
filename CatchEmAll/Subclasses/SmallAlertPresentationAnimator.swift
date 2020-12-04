//
//  ModalPresentationAnimator.swift
//  Dicam 2
//
//  Created by Bryan Carter on 20/11/2019.
//  Copyright © 2019 Bryan Carter. All rights reserved.
//

import UIKit

class SmallAlertPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning
{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 0.05
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView
        
        let animationDuration = transitionDuration(using: transitionContext)
        
//        toVC.view.transform = CGAffineTransform(translationX: containerView.bounds.width,
//                                                y: 0)
        toVC.view.transform = CGAffineTransform(translationX: 0,
                                                y: containerView.bounds.height)
        toVC.view.layer.shadowColor = UIColor.black.cgColor
        toVC.view.layer.shadowOffset = CGSize(width: 0.0,height: 2.0)
        toVC.view.layer.shadowOpacity = 0.3
        toVC.view.clipsToBounds = true
        
        containerView.addSubview(toVC.view)
        
        UIView.animate(withDuration: animationDuration, animations: {
            toVC.view.transform = CGAffineTransform.identity
        }, completion: { finished in
            transitionContext.completeTransition(finished)
        })
    }
    
    
}
