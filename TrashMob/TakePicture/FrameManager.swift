//
//  FrameManager.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/9/22.
//

import AVFoundation

class FrameManager: NSObject, ObservableObject {
    // make the frame manager a singleton
    static let shared = FrameManager()
    // adds a published property for the current frame of the camera
    @Published var current: CVPixelBuffer?
    // creates a queue on which to receive the data
    let videoOutputQueue = DispatchQueue(
        label: "com.academy.VideoOutputQ",
        qos: .userInitiated,
        attributes: [],
        autoreleaseFrequency: .workItem)
    // set FrameManager as the delegate to AVCaptureVideoDataOutput
    private override init() {
        super.init()
        CameraManager.shared.set(self, queue: videoOutputQueue)
    }
}

extension FrameManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        if let buffer = sampleBuffer.imageBuffer {
            DispatchQueue.main.async {
                self.current = buffer
            }
        }
    }
}
