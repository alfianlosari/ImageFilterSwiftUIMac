//
//  FilterView.swift
//  ImageFilterMac
//
//  Created by Alfian Losari on 25/02/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import Cocoa

struct CarouselFilterView: View {
    
    let image: NSImage?
    let onImageFilterSelected: (NSImage) -> Void
    
    let imageFilters: [ImageFilter] = ImageFilter.allCases
    
    var body: some View {
        VStack {
            if image != nil {
                Text("Select Filter")
                    .font(.headline)
                
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(imageFilters) { filter in
                            ImageFilterView(observableImageFilter: ImageFilterObservable(image: self.image!, filter: filter), onImageSelected: self.onImageFilterSelected)
                                .padding(.leading, 16)
                                .padding(.trailing, self.imageFilters.last == filter ? 16 : 0)
                        }
                    }
                    .frame(height: 140)
                }
            }
        }
    }
}

extension CarouselFilterView: Equatable {

    static func == (lhs: CarouselFilterView, rhs: CarouselFilterView) -> Bool {
        return lhs.image == rhs.image
    }
}


struct ImageFilterView: View {
    
    @ObservedObject var observableImageFilter: ImageFilterObservable
    let onImageSelected: (NSImage) -> ()
    
    var body: some View {
        VStack {
            ZStack {
                Image(nsImage: observableImageFilter.filteredImage != nil ? observableImageFilter.filteredImage! : observableImageFilter.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .cornerRadius(8)
                
                if observableImageFilter.filteredImage == nil {
                    ProgressView()
                }
            }
            
            Text(observableImageFilter.filter.rawValue)
                .font(.subheadline)
        }
        .onTapGesture(perform: handleOnTap)
    }
    
    private func handleOnTap() {
        guard let filteredImage = observableImageFilter.filteredImage else {
            return
        }
        onImageSelected(filteredImage)
    }
    
    func filterImage() {
        self.observableImageFilter.filter.performFilter(with: observableImageFilter.image) {
            self.observableImageFilter.filteredImage = $0
        }
    }
}
