//
//  ChannelCollectionViewCell.swift
//  TVChannels
//
//  Created by Pablo Paciello on 19/11/2019.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import SwiftUI
import PresentationLayer

class ChannelCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var circleContainerView: UIView!
    @IBOutlet private weak var progressLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    private let defaultAlpha: CGFloat = 0.65
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        progressLabel.text = nil
        titleLabel.text = nil
        
        circleContainerView.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.alpha = defaultAlpha
        layer.cornerRadius = 10
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        
        contentView.alpha = isFocused ? 1.0 : defaultAlpha
        backgroundColor = isFocused ? UIColor.darkGray : .clear
        backgroundColor = backgroundColor?.withAlphaComponent(defaultAlpha)
        titleLabel.textColor = isFocused ? .white : .darkGray
        
        guard let nextFocusedView = context.nextFocusedView else { return }
        
        UIView.animate(withDuration: 0.15, animations: {
            let circleScale: CGFloat = nextFocusedView == self ? 1.15 : 1.0
            let labelScale: CGFloat = nextFocusedView == self ? 1.0 : 0.1
            
            self.circleContainerView.transform = CGAffineTransform(scaleX: circleScale, y: circleScale)
            self.progressLabel.transform = CGAffineTransform(scaleX: labelScale, y: labelScale)
        }) { (finished) in
            self.progressLabel.isHidden = nextFocusedView != self
        }
    }
    
    func populateCell(withDisplayData displayData: ChannelDisplayData) {
        //Add ProgressCircleView
        let circleView = UIHostingController(rootView: ProgressCircleView(progress: displayData.progress, lineWidth: 9))
        circleView.view.frame = circleContainerView.bounds
        circleView.view.sizeToFit()
        circleContainerView.addSubview(circleView.view)
        
        //Set Progress Label
        progressLabel.text = displayData.roundedProgress()
        progressLabel.textColor = UIColor.loadingRedToGreenColor(progress: displayData.progress)
        //Set Title Label
        titleLabel.text = displayData.name
    }
    
    func viewForTransition() -> UIView? {
        return circleContainerView
    }
}
