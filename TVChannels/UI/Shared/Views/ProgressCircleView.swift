//
//  ProgressCircleView.swift
//  TVChannels
//
//  Created by Pablo Paciello on 19/11/2019.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import SwiftUI

struct ProgressCircleView: View {
    let progress: Double
    let lineWidth: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(Color(UIColor.darkGray), lineWidth: lineWidth)
            
            //We need to implement .inset as we cannot use .strokeBorder with .trim
            Circle()
                .inset(by: lineWidth/2)
                .rotation(Angle(degrees: -90))
                .trim(from: 0.0, to:CGFloat(progress))
                .stroke(Color(UIColor.loadingRedToGreenColor(progress: progress)), lineWidth: lineWidth)
        }
    }
}

struct ProgressCircleView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircleView(progress: 0.80, lineWidth: 10)
            .previewLayout(PreviewLayout.fixed(width: 275, height: 325))
    }
}
