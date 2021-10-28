//
//  QRcodeReaderViewController.swift
//  VerasStore
//
//  Created by Santiago del Castillo Gonzaga on 28/10/21.
//

import AVFoundation
import UIKit

class QRcodeReaderViewController: UIViewController {
    
    private var captureSession: AVCaptureSession!
    var scannerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Background")
        configureViewConstraints()
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scanner()
    }
    
    func configureViewConstraints() {
        view.addSubview(scannerView)

        scannerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scannerView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scannerView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
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
        scannerOverlayPreviewLayer.frame = scannerView.bounds
        scannerOverlayPreviewLayer.maskSize = CGSize(width: 250, height: 250)
        scannerOverlayPreviewLayer.videoGravity = .resizeAspectFill
        scannerOverlayPreviewLayer.backgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        scannerView.layer.addSublayer(scannerOverlayPreviewLayer)
        metadataOutput.rectOfInterest = scannerOverlayPreviewLayer.rectOfInterest
        
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
            print(stringValue)
            
        }
        
        dismiss(animated: true)
    }
}
