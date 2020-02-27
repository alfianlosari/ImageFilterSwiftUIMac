//
//  ContentView.swift
//  ImageFilterMac
//
//  Created by Alfian Losari on 23/02/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 16) {
            InputView(image: appState.image, onSaveHandler: saveToFile, onSelectHandler: selectFile)
            Divider()
            
            CarouselFilterView(image: appState.image) {
                self.appState.filteredImage = $0
            }
            .equatable()
            
            Spacer()
        }
        .padding(.top, 32)
        .padding(.bottom, 16)
        .frame(minWidth: 768, idealWidth: 768, maxWidth: 1024, minHeight: 648, maxHeight: 648)
    }
    
    private func saveToFile() {
        guard let image = self.appState.filteredImage ?? self.appState.image else {
            return
        }
        NSSavePanel.saveImage(image, completion: { _ in  })
    }
    
    private func selectFile() {
        NSOpenPanel.openImage { (result) in
            if case let .success(image) = result {
                self.appState.image = image
            }
        }
    }
    
}

struct InputView: View {
    
    let image: NSImage?
    let onSaveHandler: () -> ()
    let onSelectHandler: () -> ()
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Input image")
                    .font(.headline)
                Button(action: onSelectHandler) {
                    Text("Select image")
                }
            }
            
            InputImageView()
            
            if image != nil {
                Button(action: onSaveHandler) {
                    Text("Save image")
                }
            }
        }
    }

}

struct InputImageView: View {
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            if appState.image != nil {
                Image(nsImage: appState.filteredImage != nil ? appState.filteredImage! : appState.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("Drag and drop image file")
                    .frame(width: 320)
            }
        }
        .frame(height: 320)
        .background(Color.black.opacity(0.5))
        .cornerRadius(8)
        .onDrop(of: ["public.file-url"], isTargeted: nil, perform: handleOnDrop(providers:))
        
    }
    
    private func handleOnDrop(providers: [NSItemProvider]) -> Bool {
        if let item = providers.first {
            item.loadItem(forTypeIdentifier: "public.file-url", options: nil) { (urlData, error) in
                DispatchQueue.main.async {
                    if let urlData = urlData as? Data {
                        let url = NSURL(absoluteURLWithDataRepresentation: urlData, relativeTo: nil) as URL
                        guard let image = NSImage(contentsOf: url) else {
                            return
                        }
                        self.appState.image = image
                    }
                }
            }
            return true
        }
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
