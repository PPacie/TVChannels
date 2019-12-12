//
//  DetailViewController.swift
//  TVChannels
//
//  Created by Pablo Paciello on 20/11/2019.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import UIKit
import PresentationLayer
import SwiftUI

class DetailViewController: UIViewController {
    @IBOutlet private weak var circleContainerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var progressLabel: UILabel!
    
    private let channel: ChannelDisplayData
    
    init?(coder: NSCoder, channel: ChannelDisplayData) {
        self.channel = channel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("ChannelDisplayData object is required")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Add ProgressCircleView
        let circleView = UIHostingController(rootView: ProgressCircleView(progress: channel.progress, lineWidth: 16))
        circleView.view.frame = circleContainerView.bounds
        circleView.view.sizeToFit()
        circleContainerView.addSubview(circleView.view)
        
        titleLabel.text = channel.name
        progressLabel.text = channel.roundedProgress()?.appending(" ").appending(localized(LocalizableKeys.completed))
        progressLabel.textColor = UIColor.loadingRedToGreenColor(progress: channel.progress)
    }
    
    func viewForTransition() -> UIView {
        return circleContainerView
    }
    
    func changeLabelsVisibility(isHidden: Bool) {
        view.subviews.forEach {
            guard $0.tag > 0 else { return }
            $0.alpha = isHidden ? 0.0 : 1.0
        }
    }
}
