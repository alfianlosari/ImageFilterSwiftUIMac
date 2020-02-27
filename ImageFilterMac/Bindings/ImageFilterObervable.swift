//
//  ImageFilterObervable.swift
//  ImageFilterMac
//
//  Created by Alfian Losari on 25/02/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Combine
import Cocoa

class ImageFilterObservable: ObservableObject {
    
    @Published var filteredImage: NSImage? = nil

    let image: NSImage
    let filter: ImageFilter
    
    init(image: NSImage, filter: ImageFilter) {
        self.image = image
        self.filter = filter
        self.filterImage()
    }
    
    func filterImage() {
        self.filter.performFilter(with: self.image) {
            self.filteredImage = $0
        }
    }
}
