//
//  CameraManager.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/9/22.
//

import Foundation
import AVFoundation

class CameraManager: ObservableObject {
    
    // Published so other objects can subscribe to this stream and handle errors
    @Published var error: CameraError?
    // Coordinates sending camera images to appropriate data outputs
    let session = AVCaptureSession()
    // used to change camera configurations
    private let sessionQueue = DispatchQueue(label: "com.academy.SessionQ")
    // video data output that will connect to AVCaptureSession
    private let videoOutput = AVCaptureVideoDataOutput()
    // current status of the camera
    private var status = Status.unconfigured
    
    
    enum Status {
        case unconfigured
        case configured
        case unauthorized
        case failed
    }
    // includes static instance of CameraManager to make it more accessible
    static let shared = CameraManager()
    // turns camera manager into a singleton by making init private
    private init() {
        configure()
    }
    //
    private func configure() {
        checkPermissions()
        sessionQueue.async {
            self.configureCaptureSession()
            self.session.startRunning()
        }
        
    }
    
    private func set(error: CameraError?) {
        DispatchQueue.main.async {
            self.error = error
        }
    }
    
    private func checkPermissions() {
        // switch on the camera's auth status for video
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            // suspends session queue and request permission if device status is undetermined
            sessionQueue.suspend()
            AVCaptureDevice.requestAccess(for: .video) { authorized in
                // if user denies access, set status to unauthorized
                if !authorized {
                    self.status = .unauthorized
                    self.set(error: .deniedAuthorization)
                }
                self.sessionQueue.resume()
            }
            // conform restricted and denied to unauthorized
        case .restricted:
            status = .unauthorized
            set(error: .restrictedAuthorization)
        case .denied:
            status = .unauthorized
            set(error: .deniedAuthorization)
            // break out of switch if already authorized
        case .authorized:
            break
            // conform default to unauthorized for additional unreleased cases
        @unknown default:
            status = .unauthorized
            set(error: .unknownAuthorization)
        }
    }
    
    private func configureCaptureSession() {
        guard status == .unconfigured else {
            return
        }
        session.beginConfiguration()
        defer {
            session.commitConfiguration()
        }
        
        let device = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: .front)
        guard let camera = device else {
            set(error: .cameraUnavailable)
            status = .failed
            return
        }
        
        do {
            // try to create an AVCaptureDeviceInput based on the camera
            let cameraInput = try AVCaptureDeviceInput(device: camera)
            // add the camera input to AVCaptureSession, if possible
            if session.canAddInput(cameraInput) {
                session.addInput(cameraInput)
            } else {
                set(error: .cannotAddInput)
                status = .failed
                return
            }
        } catch {
            set(error: .createCaptureInput(error))
            status = .failed
            return
        }
        
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
            // set format type for video output
            videoOutput.videoSettings =
            [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
            // force orientation to portrait
            let videoConnection = videoOutput.connection(with: .video)
            videoConnection?.videoOrientation = .portrait
        } else {
            set(error: .cannotAddOutput)
            status = .failed
            return
        }
        status = .configured
    }
    
    func set(
        _ delegate: AVCaptureVideoDataOutputSampleBufferDelegate,
        queue: DispatchQueue
    ) {
        sessionQueue.async {
            self.videoOutput.setSampleBufferDelegate(delegate, queue: queue)
        }
    }
    
}
