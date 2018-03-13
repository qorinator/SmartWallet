//
//  ScannerController.swift
//  SmartWallet
//
//  Created by Qorin Wu on 02/01/2018.
//  Copyright © 2018 qorinator. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession : AVCaptureSession?
    var videoPreviewLayer : AVCaptureVideoPreviewLayer?
    var codeFrameView : UIView?
    private let supportedBarcodeType = [AVMetadataObject.ObjectType.qr,
                       AVMetadataObject.ObjectType.aztec,
                       AVMetadataObject.ObjectType.code128,
                       AVMetadataObject.ObjectType.code39,
                       AVMetadataObject.ObjectType.code39Mod43,
                       AVMetadataObject.ObjectType.code93,
                       AVMetadataObject.ObjectType.dataMatrix,
                       AVMetadataObject.ObjectType.ean13,
                       AVMetadataObject.ObjectType.ean8,
                       AVMetadataObject.ObjectType.face,
                       AVMetadataObject.ObjectType.interleaved2of5,
                       AVMetadataObject.ObjectType.itf14,
                       AVMetadataObject.ObjectType.pdf417,
                       AVMetadataObject.ObjectType.upce]
    //var inputDevice : iCaptureInputDevice?
    
    @IBOutlet var topBar: UIView!
    @IBOutlet var lblMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InitializeVideoCaptureSession()
        InitializeScannerControllerObject()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func InitializeVideoCaptureSession() {
        captureSession = AVCaptureSession()
        
        if InitializeCaptureInputDevice(captureActivityObject: captureSession!) {
            // Is the reference of the object is passed or it is being copied???
            InitializeCaptureMetaDataOutput(captureActivityObject: captureSession!)
            InitializeVideoPreviewLayer(captureActivityObject: captureSession!)
        }
        
        captureSession?.startRunning()
    }
    
    func InitializeCaptureInputDevice(captureActivityObject : AVCaptureSession) -> Bool {
        // Find device that supports AVMediaTypeVideo
        let videoCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        let videoInput: AVCaptureDeviceInput?
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
            ScanningNotPossible()
            return false
        }
        
        return true
    }
    
    func InitializeCaptureMetaDataOutput(captureActivityObject : AVCaptureSession) {
        // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
        let captureMetadataOutput = AVCaptureMetadataOutput()
        if (captureActivityObject.canAddOutput(captureMetadataOutput)) {
            captureActivityObject.addOutput(captureMetadataOutput)
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedBarcodeType
        }
    }
    
    func InitializeVideoPreviewLayer(captureActivityObject : AVCaptureSession) {
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureActivityObject)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
    }
    
    func InitializeScannerControllerObject() {
        // Move the top bar and message label to fron
        view.bringSubview(toFront: topBar)
        view.bringSubview(toFront: lblMessage)
        // Initialize code frame to highlight QRCode
        InitializeCodeFrame()
    }
    
    func InitializeCodeFrame() {
        codeFrameView = UIView()
        if let _codeFrameView = codeFrameView {
            _codeFrameView.layer.borderColor = UIColor.green.cgColor
            _codeFrameView.layer.borderWidth = 2
            view.addSubview(_codeFrameView)
            view.bringSubview(toFront: _codeFrameView)
        }
    }
    
    func ScanningNotPossible() {
        //let alert = UIAlertController(title: "Can't scan",
        //                              message: "Let's try a device equipped with a camera",
        //                              preferredStyle: .alert)
        //alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //[self .present(alert, animated: true, completion: nil)]
        //captureSession = nil
        print("Scanning is not possible")
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                                 didOutput metadataObjects: [AVMetadataObject],
                                 from connection: AVCaptureConnection){
        if CheckMetaDataObject(objects: metadataObjects) {
            GetMetaDataObject(objects: metadataObjects)
        }
    }
    
    func CheckMetaDataObject(objects : [AVMetadataObject]) -> Bool{
        if objects.count == 0 {
            codeFrameView?.frame = CGRect.zero
            lblMessage.text = "No Barcode Code is detected"
            return false
        }
        return true
    }
    
    func GetMetaDataObject(objects : [AVMetadataObject]) {
        let object = objects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedBarcodeType.contains(object.type) {
            let barcodeObject = videoPreviewLayer?.transformedMetadataObject(for: object)
            
            codeFrameView?.frame = barcodeObject!.bounds
            if object.stringValue != nil {
                lblMessage.text = object.stringValue
            }
            
            
        }
    }
}
