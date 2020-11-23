
import Foundation
import UIKit

struct Constants {
    
    // Colors
    static let main = "main"
    static let accentDark = "accentDark"
    static let accentLight = "accentLight"
    static let white = "white"
    static let contrast = "contrast"
    static let contrastLight = "contrastLight"
    static let contratDark = "contrastDark"
    
    // Text Colors
    static let lightText = "lightText"
    static let darkText = "darkText"
    
    // Fonts
    static let countDownFont = UIFont(name: "BarlowSemiCondensed-SemiBold", size: 200)
    static let mainFontLarge = UIFont(name: "BarlowSemiCondensed-Light", size: 22)
    static let mainFont = UIFont(name: "BarlowSemiCondensed-Light", size: 18)
    static let mainFontMedium = UIFont(name: "BarlowSemiCondensed-Light", size: 14)
    static let mainFontSmall = UIFont(name: "BarlowSemiCondensed-Light", size: 12)
    static let mainFontLargeSB = UIFont(name: "BarlowSemiCondensed-SemiBold", size: 22)
    static let mainFontXLargeSB = UIFont(name: "BarlowSemiCondensed-SemiBold", size: 35)
    static let mainFontXXLargeSB = UIFont(name: "BarlowSemiCondensed-SemiBold", size: 55)
    static let mainFontSB = UIFont(name: "BarlowSemiCondensed-SemiBold", size: 18)
    static let mainFontMediumSB = UIFont(name: "BarlowSemiCondensed-SemiBold", size: 14)
    static let mainFontSmallSB = UIFont(name: "BarlowSemiCondensed-SemiBold", size: 10)
    static let resultFont = UIFont(name: "BarlowSemiCondensed-SemiBold", size: 70)
    static let resultFontSmall = UIFont(name: "BarlowSemiCondensed-SemiBold", size: 40)
    
    // Set race VC texts
    static let noOfLaps = "Number of laps"
    static let lengthOfLap = "Lap length"
    static let delayTime = "Seconds delay before start"
    static let reactionPeriod = "Reaction period"
    
    // Dimension
    static let widthOfDisplay = UIScreen.main.bounds.size.width
    static let heightOfDisplay = UIScreen.main.bounds.size.height
    static let sideMargin = widthOfDisplay * 0.05
    static let cornerRadius = CGFloat(4)
    static let cornerRadiusSmall = CGFloat(4)
    static let smallButtons = widthOfDisplay * 0.2
    
    // Picker dimensions
    static let widthOfPickerLabel = Constants.widthOfDisplay * 0.2
    static let widthOfLengthPicker = widthOfPickerLabel * 3
    static let widthOfDelayPicker = widthOfPickerLabel * 2
    
    //European Units
    static let meters = "m"
    static let seconds = "s"
    
    // Types
    static let speedRace = "Speed"
    static let laps = "Laps"
    static let reaction = "Reaction"
    
    // Names
    static let speedRun = "Speed Run"
    static let Intervals = "Intervals"
    static let reactionRun = "Reaction Run"

}
