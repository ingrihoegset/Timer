//
//  CameraCapture.swift
//  HeadLight2020
//
//  Created by Ingrid on 21/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//


import Foundation
import AVFoundation
import UIKit

class CameraCapture: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate{
    
    let captureSession = AVCaptureSession()
    var colorData = [CGFloat]()
    let breakObserver = BreakObserver()
    var counter = 0
    var record = false

    override init() {
        super.init()
        getVideoOutput()
        
        NotificationCenter.default.addObserver(self, selector: #selector(startRecording), name: NSNotification.Name.init(rawValue: "startRecording"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(stopRecording), name: NSNotification.Name.init(rawValue: "stopRecording"), object: nil)
    }
    
    func getVideoOutput() {
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable as! String: Int(kCVPixelFormatType_32BGRA)]
        videoOutput.alwaysDiscardsLateVideoFrames = true
        
        let videoOutputQueue = DispatchQueue(label: "VideoQueue")
        videoOutput.setSampleBufferDelegate(self, queue: videoOutputQueue)
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        }
        else {
            print("Could not add video data as output.")
        }
    }
    
    // This function is called automatically each time a new frame is recieved, i.e. 24 times per second
    // as long as the configuration was successfull.
    func captureOutput(_ captureOutput: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        counter = counter + 1
        
        let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!

        //Dont know what this does, but dont move
        CVPixelBufferUnlockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: CVOptionFlags(0)))

        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        
        //Will only record breaks after the start button has been selected
        if (record == true) {
            let broken = breakObserver.detectBreak(cvPixelBuffer: pixelBuffer!)
            if (broken == true) {
                NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "broken"), object: nil)
                breakObserver.colorData = []
            }
        }
    }
    
    @objc func startRecording() {
        record = true
    }
    
    @objc func stopRecording() {
        record = false
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "raceEnded"), object: nil)
    }
}





