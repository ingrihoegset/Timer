//
//  BreakObserver.swift
//  Timer
//
//  Created by Ingrid on 21/09/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//
//  This class analyzes whether a break has occured - i.e. whether or not someone has run passed the device.

import Foundation
import AVFoundation
import UIKit

class BreakObserver {
    
    var colorData = [CGFloat]()
    private let numberOfFramesForAnalysis = 12
    private let sensitivity: CGFloat = 0.2
    var currentTime: String

    init() {
        currentTime = ""
    }
    
    func detectBreak(cvPixelBuffer: CVImageBuffer) -> Bool{
        let currentFrame = CIImage(cvPixelBuffer: cvPixelBuffer)
        
        addCurrentToData(currentFrame: currentFrame)
        
        // When the analysis array is full
        if colorData.count >= numberOfFramesForAnalysis {
            let averageColorOfArray = findAverageOfAnalysisArray(realTimeArray: colorData)
            let hasBroken = checkForBreak(average: averageColorOfArray, currentObservation: currentFrame.averageColor)
            if (hasBroken == true) {
                return true
            }
        }
        return false
    }
    
    private func addCurrentToData(currentFrame: CIImage) {
        //Removes the oldest input from the matrix when the matrix reaches a certain size
        if(colorData.count >= numberOfFramesForAnalysis) {
            colorData.removeFirst(1)
        }
        
        //appends current frame to back of data array
        colorData.append(currentFrame.averageColor)
    }
          
    //Returns average color of the last frames that are being analyzed
    private func findAverageOfAnalysisArray(realTimeArray: [CGFloat]) -> CGFloat {
        var sum = CGFloat(0)
        var count = CGFloat(0)
        
        for i in 0...realTimeArray.count - 1 {
            sum = sum + realTimeArray[i]
            count = count + 1
        }

        let averageColor = sum / count
        return averageColor
    }
        
    private func checkForBreak(average: CGFloat, currentObservation: CGFloat) -> Bool {
        if (abs((currentObservation - average) / average) > sensitivity) {
            return true
        }
        else {
            return false
        }
    }
}

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

//This extension reads in the source image and creates an extent for the full image.
//It then uses the “CIAreaAverage” filter to do the actual work, then renders the average color to a 1x1 image.
//Finally, it reads each of the color values into a UIColor, and sends it back.
extension CIImage {
    var averageColor: CGFloat {
        let extentVector = CIVector(x: self.extent.origin.x, y: self.extent.origin.y, z: self.extent.size.width, w: self.extent.size.height)

        let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: self, kCIInputExtentKey: extentVector])
        let outputImage = filter?.outputImage

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage!, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return CGFloat(bitmap[0]) / 255 + CGFloat(bitmap[1]) / 255 + CGFloat(bitmap[2]) / 255
    }
}



