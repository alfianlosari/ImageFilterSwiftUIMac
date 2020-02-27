//
//  AppState.swift
//  ImageFilterMac
//
//  Created by Alfian Losari on 25/02/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Combine
import Cocoa

class AppState: ObservableObject {
    
    static let shared = AppState()
    
    private init() {}
        
    @Published var filteredImage: NSImage?
    @Published var image: NSImage? {
        didSet {
            self.filteredImage = nil
        }
    }
}
