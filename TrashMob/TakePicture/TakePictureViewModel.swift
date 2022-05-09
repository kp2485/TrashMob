//
//  TakePictureViewModel.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/9/22.
//

import CoreImage

class TakePictureViewModel: ObservableObject {
    
    // holds the image that FrameView displays
    @Published var frame: CGImage?
    // data used to generate frame will come from FrameManager
    private let frameManager = FrameManager.shared
    
    @Published var error: Error?
    private let cameraManager = CameraManager.shared
    
    var comicFilter = false
    var monoFilter = false
    var crystalFilter = false
    private let context = CIContext()
    
    init() {
        setupSubscriptions()
    }
    
    // Combine pipelines to set up subscriptions
    func setupSubscriptions() {
        
        // Tap into the publisher provided automatically for the published CameraManager.error
        cameraManager.$error
        // receive it on the main thread
            .receive(on: RunLoop.main)
        // map it to itself and assign the error
            .map { $0 }
            .assign(to: &$error)
        
        // tap into the publisher
        frameManager.$current
            .receive(on: RunLoop.main)
            .compactMap { $0 }
            .compactMap { buffer in
                // convert CVPixelBuffer to a CGImage (if it fails, return early)
                guard let image = CGImage.create(from: buffer) else {
                    return nil
                }
                // Convert CGImage to a CIImage
                var ciImage = CIImage(cgImage: image)
                // 3
                if self.comicFilter {
                    ciImage = ciImage.applyingFilter("CIComicEffect")
                }
                if self.monoFilter {
                    ciImage = ciImage.applyingFilter("CIPhotoEffectNoir")
                }
                if self.crystalFilter {
                    ciImage = ciImage.applyingFilter("CICrystallize")
                }
                // 4
                return self.context.createCGImage(ciImage, from: ciImage.extent)
            }
            .assign(to: &$frame)
        
        
    }
}
