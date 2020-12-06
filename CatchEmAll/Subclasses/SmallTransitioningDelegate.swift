//
//  ModalTransitioningDelegate.swift
//
//  Created by Bryan Carter on 20/11/2019.
//  Copyright © 2019 Bryan Carter. All rights reserved.
//

import UIKit

class SmallTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate
{
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
    {
        return SmallPresentationController(presentedViewController: presented,
                                           presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SmallPresentationAnimator()
    }
}
