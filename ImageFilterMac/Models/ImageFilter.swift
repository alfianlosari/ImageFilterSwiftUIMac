//
//  ImageFilter.swift
//  ImageFilterMac
//
//  Created by Alfian Losari on 25/02/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Cocoa
import GPUImage

let serialQueue = DispatchQueue(label: "com.alfianlosari.imagefilter")

enum ImageFilter: String, Identifiable, Hashable, CaseIterable {
    
    var id: ImageFilter { self }
    
    case `default` = "Default"
    case smoothToon = "Smooth Toon"
    case polkadot = "Polkadot"
    case vignette = "Vignette"
    case swirlDistortion = "Swirl Distortion"
    case solarize = "Solarize"
    case sketchFilter = "Sketch Filter"
    case zoomBlur = "Zoom Blur"
    case colorInversion = "Color Inversion"
    case emboss = "Emboss"
    case halftone = "Halftone"
    case haze = "Haze"
    case kuwahara = "Kuwahara"
    case luminance = "Luminance"
    case monochrome = "Monochrome"
    case pixellate = "Pixellate"
    case posterize = "Posterize"
    case sepia = "Sepia"
    case vibrance = "Vibrance"
    
    
    
    func performFilter(with image: NSImage, queue: DispatchQueue = serialQueue, completion: @escaping(NSImage) -> ()) {
        queue.async {
            let pictureInput = PictureInput(image: image)
            let pictureOutput = PictureOutput()
            switch self {
            case .default:
                DispatchQueue.main.async {
                    completion(image)
                }
                return
                
            case .smoothToon:
                pictureInput --> SmoothToonFilter() --> pictureOutput
            case .polkadot:
                pictureInput --> PolkaDot() --> pictureOutput
            case .vignette:
                pictureInput --> Vignette() --> pictureOutput
            case .swirlDistortion:
                pictureInput --> SwirlDistortion() --> pictureOutput
            case .solarize:
                pictureInput --> Solarize() --> pictureOutput
            case .sketchFilter:
                pictureInput --> SketchFilter() --> pictureOutput
            case .zoomBlur:
                pictureInput --> ZoomBlur() --> pictureOutput

            case .colorInversion:
                pictureInput --> ColorInversion() --> pictureOutput

            case .emboss:
                pictureInput --> EmbossFilter() --> pictureOutput

            case .halftone:
                pictureInput --> Halftone() --> pictureOutput

            case .haze:
                pictureInput --> Haze() --> pictureOutput

            case .kuwahara:
                pictureInput --> KuwaharaFilter() --> pictureOutput

            case .luminance:
                pictureInput --> Luminance() --> pictureOutput

            case .monochrome:
                pictureInput --> MonochromeFilter() --> pictureOutput

            case .pixellate:
                pictureInput --> Pixellate() --> pictureOutput

            case .posterize:
                pictureInput --> Posterize() --> pictureOutput

            case .sepia:
                pictureInput --> SepiaToneFilter() --> pictureOutput

            case .vibrance:
                pictureInput --> Vibrance() --> pictureOutput

            }
            
            pictureOutput.imageAvailableCallback = { image in
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            
            pictureInput.processImage(synchronously:true)
        }
    }
    
}
