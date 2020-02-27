//
//  ProgressView.swift
//  ImageFilterMac
//
//  Created by Alfian Losari on 25/02/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import Cocoa

struct ProgressView: NSViewRepresentable {
    
    func updateNSView(_ nsView: NSProgressIndicator, context: NSViewRepresentableContext<ProgressView>) {
        nsView.style = .spinning
        nsView.startAnimation(self)
    }
    
    func makeNSView(context: NSViewRepresentableContext<ProgressView>) -> NSProgressIndicator {
        let progressIndicator = NSProgressIndicator()
        return progressIndicator
    }
    
}
