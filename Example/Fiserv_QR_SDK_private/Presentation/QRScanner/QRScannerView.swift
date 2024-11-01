//
//  RequiresCameraPermission.swift
//  Fiserv_QR_SDK_private
//
//  Created by Ariel Scarafia on 19/09/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI
import AVKit

struct QRScannerView: View {
    @StateObject var qrScannerViewModel: QRScannerViewModel = .init()
    
    @State private var cameraPermission: CameraPermission = .idle
    @State private var session: AVCaptureSession = .init()
    @State private var qrValueOutput: AVCaptureMetadataOutput = .init()
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    
    @SwiftUI.Environment(\.openURL) private var openURL

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {

                CameraView(session: $session)
                
                VStack (spacing: 0) {
                    Text("Código escaneado: " + qrScannerViewModel.scannedText)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                }
            }
            .alert(errorMessage, isPresented: $showError) {
                if cameraPermission == .denied {
                    Button("Settigns") {
                        let settingsString = UIApplication.openSettingsURLString
                        if let settingsURL = URL(string: settingsString) {
                            openURL(settingsURL)
                        }
                    }
                
                    Button("Cancel", role: .cancel) {
                        
                    }
                }
            }
            .navigationDestination(isPresented: $qrScannerViewModel.goToPaymentMethod) {
                PaymentMethodScreen()
            }
            .onAppear {
                checkCameraPermission()
            }
            .onDisappear {
                session.stopRunning()
            }
        }
        
    }
    
    func checkCameraPermission() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                cameraPermission = .approved
                
                if session.inputs.isEmpty {
                    setupCamera()
                } else {
                    reactivateCamera()
                }
            case .notDetermined:
                if await AVCaptureDevice.requestAccess(for: .video) {
                    cameraPermission = .approved
                    
                    if session.inputs.isEmpty {
                        setupCamera()
                    } else {
                        reactivateCamera()
                    }
                    
                } else {
                    cameraPermission = .denied
                    presentError("Se necesitan permisos de cámara para poder utilizar la función de pagos con QR")
                }
            case .denied, .restricted:
                if await AVCaptureDevice.requestAccess(for: .video) {
                    cameraPermission = .approved
                    
                    if session.inputs.isEmpty {
                        setupCamera()
                    } else {
                        reactivateCamera()
                    }
                    
                }
                cameraPermission = .denied
                presentError("Se necesitan permisos de cámara para poder utilizar la función de pagos con QR")
            default: break
            }
        }
    }
        
    func presentError(_ errorMessage: String) {
        self.errorMessage = errorMessage
        showError = true
    }
    
    func setupCamera() {
        do {
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInUltraWideCamera], mediaType: .video, position: .back).devices.first else {
                presentError("UNKWON DEVICE ERROR")
                return
            }
            
            let input = try AVCaptureDeviceInput(device: device)
            
            guard session.canAddInput(input), session.canAddOutput(qrValueOutput) else {
                presentError("UNKWON I/O ERROR")
                return
            }
            
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrValueOutput)

            qrValueOutput.metadataObjectTypes = [.qr]
            
            qrValueOutput.setMetadataObjectsDelegate(qrScannerViewModel, queue: .main)
            session.commitConfiguration()
            
            DispatchQueue.global(qos: .background).async {
                session.startRunning()
            }
        } catch {
            presentError(error.localizedDescription)
        }
        
    }
    
    func reactivateCamera() {
        DispatchQueue.global(qos: .background).async {
            session.startRunning()
        }
    }
}

#Preview {
    QRScannerView()
        .environmentObject(QRScannerViewModel())
}
