//
//  QRcodeReaderViewController.swift
//  Fidelity-ios
//
//  Created by Santiago del Castillo Gonzaga on 15/10/21.
//

import AVFoundation
import UIKit

class QRcodeReaderViewController: UIViewController {
    private var captureSession: AVCaptureSession!
    private var previewLayer = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Background")
        configureSubViews()
        scanner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func configureSubViews() {
        view.addSubview(previewLayer)
    }
}

extension QRcodeReaderViewController: AVCaptureMetadataOutputObjectsDelegate {
    func scanner() {
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        let scannerOverlayPreviewLayer = ScannerOverlayPreviewLayer(session: captureSession)
        scannerOverlayPreviewLayer.frame = view.layer.bounds
        scannerOverlayPreviewLayer.maskSize = CGSize(width: 200, height: 200)
        scannerOverlayPreviewLayer.backgroundColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        metadataOutput.rectOfInterest = scannerOverlayPreviewLayer.rectOfInterest
        previewLayer.layer.addSublayer(scannerOverlayPreviewLayer)
        
        captureSession.startRunning()
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
        dismiss(animated: true)
    }
    
    func found(code: String) {
        print(code)
    }
}
