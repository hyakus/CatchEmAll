//
//  ModalPresentationController.swift
//
//  Created by Bryan Carter on 20/11/2019.
//  Copyright © 2019 Bryan Carter. All rights reserved.
//  source: https://stackoverflow.com/questions/42106980/how-to-present-a-viewcontroller-on-half-screen
//

import UIKit

class SmallPresentationController: UIPresentationController
{
    let blurEffectView: UIVisualEffectView!
    
    var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    
    public override init(presentedViewController: UIViewController,
                  presenting presentingViewController: UIViewController?)
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            blurEffectView = UIVisualEffectView(effect: blurEffect)
            super.init(presentedViewController: presentedViewController,
                       presenting: presentingViewController)
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismiss))
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView.isUserInteractionEnabled = true
        self.blurEffectView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @objc func dismiss()
    {
        self.presentedViewController.dismiss(animated: true,
                                             completion: nil)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect
    {
        
        if (UI_USER_INTERFACE_IDIOM() == .phone)
        {
            return CGRect(origin: CGPoint(x: self.containerView!.frame.width/12,
                                          y: (self.containerView!.frame.height/8)),
                          size: CGSize(width: self.containerView!.frame.width/1.2,
                                       height: self.containerView!.frame.height/1.5))

        }
        else
        {
            return CGRect(origin: CGPoint(x: self.containerView!.frame.width/3,
                            y: (self.containerView!.frame.height/4)),
            size: CGSize(width: self.containerView!.frame.width/3,
                         height: self.containerView!.frame.height/6))

        }
    }
    
    override func dismissalTransitionWillBegin()
    {
            self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
//                self.blurEffectView.alpha = 0
            }, completion: { (UIViewControllerTransitionCoordinatorContext) in
                self.blurEffectView.removeFromSuperview()
            })
    }
    
    override func presentationTransitionWillBegin()
    {
            self.containerView?.addSubview(blurEffectView)
            self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            }, completion: { (UIViewControllerTransitionCoordinatorContext) in

            })
    }
        
    override func containerViewWillLayoutSubviews()
    {
            super.containerViewWillLayoutSubviews()
            presentedView!.layer.masksToBounds = true
            presentedView!.layer.cornerRadius = 10
    }
    
    override func containerViewDidLayoutSubviews()
    {
            super.containerViewDidLayoutSubviews()
            self.presentedView?.frame = frameOfPresentedViewInContainerView
            blurEffectView.frame = containerView!.bounds
    }
}
