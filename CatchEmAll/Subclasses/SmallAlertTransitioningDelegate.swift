//
//  ModalTransitioningDelegate.swift
//  Dicam 2
//
//  Created by Bryan Carter on 20/11/2019.
//  Copyright © 2019 Bryan Carter. All rights reserved.
//

import UIKit

class SmallAlertTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate
{
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
    {
        return SmallAlertPresentationController(presentedViewController: presented,
                                           presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SmallAlertPresentationAnimator()
    }
}
