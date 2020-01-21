//
//  QRCodeScannerViewController.swift
//  AssignmentEth
//
//  Created by ttg on 18/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import UIKit
import AVFoundation

final class QRCodeScannerViewController: BaseViewController {

    override var prefersNavigationBarHidden: Bool { return true }
    
    var presenter: QRCodeScannerPresenterProtocol!

    // MARK: - QR components
    
    private var captureSession = AVCaptureSession()
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    // MARK: - Component Declaration

    private enum ViewTraits {
        static let marginsTopBar = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 0)
        static let marginsVideo = UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
    }
    
    private var topBar: TopBarView!
    private var videoPreview: UIView!
    
    public enum AccessibilityIds {
        
    }

    // MARK: - ViewLife Cycle
    /*
     Order:
     - viewDidLoad
     - viewWillAppear
     - viewDidAppear
     - viewWillDisapear
     - viewDidDisappear
     - viewWillLayoutSubviews
     - viewDidLayoutSubviews
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.prepareView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewAppear()
    }

    // MARK: - Setup

    override func setupComponents() {

        view.backgroundColor = .white
        
        topBar = TopBarView(type: .navigation, title: NSLocalizedString("qr_code_scanner_title", comment: "QR reader screen title"))
        topBar.delegate = self
        topBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBar)
        
        videoPreview = UIView()
        videoPreview.translatesAutoresizingMaskIntoConstraints = false
        videoPreview.backgroundColor = .black
        view.addSubview(videoPreview)
    }

    override func setupConstraints() {

        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ViewTraits.marginsTopBar.top),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            videoPreview.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: ViewTraits.marginsVideo.top),
            videoPreview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewTraits.marginsVideo.left),
            videoPreview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ViewTraits.marginsVideo.right),
            videoPreview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -ViewTraits.marginsVideo.bottom)
        ])
    }
    
    override func setupAccessibilityIdentifiers() {
        
    }

    // MARK: - Actions

    // MARK: Private Methods
    
    func askForCameraPermissions() {
        
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            DispatchQueue.main.sync {
                if response {
                    self.initVideoView()
                    self.startScanning()
                }
            }
        }
    }
    
    func showVideoView() {
        
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { _ in
            DispatchQueue.main.sync {
                self.initVideoView()
            }
        }
    }
    
    private func initVideoView() {
        
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                                      mediaType: nil,
                                                                      position: .back)
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            self.captureSession.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            self.captureSession.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
        } catch {
            print(error)
            return
        }
        
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        self.videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.videoPreviewLayer?.frame = self.videoPreview.layer.bounds
        self.videoPreview.layer.addSublayer(self.videoPreviewLayer!)
        
    }
    
    private func mapQrs(_ metadataObjects: [AVMetadataObject]) -> [String] {
        let qrsReaded = metadataObjects.map { (metadataObject) -> String in
            guard metadataObject.type == AVMetadataObject.ObjectType.qr,
                let qrObject = metadataObject as? AVMetadataMachineReadableCodeObject else {
                    return ""
            }
            return qrObject.stringValue ?? ""
            }.filter({ !$0.isEmpty})
        return qrsReaded
    }
}

// MARK: - QRCodeScannerViewControllerProtocol
extension QRCodeScannerViewController: QRCodeScannerViewControllerProtocol {
 
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        
        guard !metadataObjects.isEmpty else { return }
        
        let qrsReaded = mapQrs(metadataObjects)
        self.presenter.readedQrs(qrsReaded)
    }
    
    func signatureValid() {
        
        self.view.backgroundColor = .appGreen
    }
    
    func signatureInvalid() {
        
        self.view.backgroundColor = .appRed
    }
}

extension QRCodeScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func stopScanning() {
        captureSession.stopRunning()
    }
    
    func startScanning() {
        self.view.backgroundColor = .appWhite
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized {
            captureSession.startRunning()
        }
    }
}

// MARK: - TopBar Delegate
extension QRCodeScannerViewController: TopBarViewDelegate {
    
    func topBarView(_ topBarView: TopBarView, didPressItem item: Button) {
        presenter.backPressed()
    }
}
