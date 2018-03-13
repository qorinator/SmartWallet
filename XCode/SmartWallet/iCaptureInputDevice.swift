//
//  iCaptureInputDevice.swift
//  SmartWallet
//
//  Created by Qorin Wu on 20/02/2018.
//  Copyright © 2018 qorinator. All rights reserved.
//

import Foundation
import AVFoundation

class iCaptureInputDevice {
    private let videoCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)
    private var videoInput: AVCaptureDeviceInput?
    
    
    func InitializeVideoCaptureSession(captureSession : AVCaptureSession) {
        //captureSession = AVCaptureSession()
        
        if InitializeCaptureInputDevice(captureActivityObject: captureSession) {
            // Is the reference of the object is passed or it is being copied???
            //InitializeCaptureMetaDataOutput(captureActivityObject: captureSession!)
            //InitializeVideoPreviewLayer(captureActivityObject: captureSession!)
        }
        
        captureSession.startRunning()
    }
    
    func InitializeCaptureInputDevice(captureActivityObject : AVCaptureSession) -> Bool {
        // Find device that supports AVMediaTypeVideo
        do {
            videoInput = try AVCaptureDeviceInput(device: (videoCaptureDevice)!)
        }
        catch {
            print("no video input")
            return false
        }
        
        // Coordinate the flow of data from video input device to ouput
        if (captureActivityObject.canAddInput(videoInput!)) {
            captureActivityObject.addInput(videoInput!)
        }
        else {
            //ScanningNotPossible()
            return false
        }
        
        return true
    }
}
