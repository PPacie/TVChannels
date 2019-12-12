//
//  MainTransitionAnimator.swift
//  TVChannels
//
//  Created by Pablo Paciello on 20/11/2019.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import UIKit

class MainTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let duration = 0.4
    private var isPresenting = true
    private var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //We need to get the BigCircleView from DetailsVC and its frame
        guard let toView = transitionContext.view(forKey: .to), let detailVC = (isPresenting ? transitionContext.viewController(forKey: .to) : transitionContext.viewController(forKey: .from)) as? DetailViewController else { return }
        
        let containerView = transitionContext.containerView
        let bigCircleView = detailVC.viewForTransition()
        
        //Initial and Final Frames
        let initialFrame = isPresenting ? originFrame : detailVC.viewForTransition().frame
        let finalFrame = isPresenting ? detailVC.viewForTransition().frame : originFrame
        
        //Set Scale
        let xScaleFactor = isPresenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFactor = isPresenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        containerView.addSubview(toView)
        //Push Animation
        if isPresenting {
            bigCircleView.transform = scaleTransform
            bigCircleView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            bigCircleView.clipsToBounds = true
            
            //Hide DetailsVC Labels
            detailVC.changeLabelsVisibility(isHidden: true)
            
            UIView.animate(withDuration: duration*2, delay: 0.0, usingSpringWithDamping: CGFloat(duration*2), initialSpringVelocity: CGFloat(duration*2), options: .curveEaseIn, animations: {
                bigCircleView.transform = .identity
                bigCircleView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            })
            
            UIView.animate(withDuration: duration*4, delay: duration*2, animations: {
                detailVC.changeLabelsVisibility(isHidden: false)
            }, completion: { _ in
                transitionContext.completeTransition(true)
            })
        } else { //Pop Animation
            toView.alpha = 0.0
            
            UIView.animate(withDuration: duration/2, delay: duration/2, usingSpringWithDamping: CGFloat(duration*2), initialSpringVelocity: CGFloat(duration*2), options: .curveEaseOut, animations: {
                bigCircleView.transform = scaleTransform
                bigCircleView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
                detailVC.changeLabelsVisibility(isHidden: true)
            })
            
            UIView.animate(withDuration: duration, delay: duration*2, animations: {
                toView.alpha = 1.0
            }, completion: { _ in
                transitionContext.completeTransition(true)
            })
        }
    }
    
    func present(withFrame frame: CGRect) {
        originFrame = frame
        isPresenting = true
    }
    
    func dismiss() {
        isPresenting = false
    }
}
