//
//  Int+Utilities.swift
//  Storm Counter
//
//  Created by Godohaldo Perez on 6/8/18.
//  Copyright © 2018 Godohaldo Perez. All rights reserved.
//

import Foundation

extension Int {
    private var romanDigits: [String] { return ["I", "V", "X", "L", "C", "D", "M"] }
    
    var romanNumeral: String {
        let stringNumber = String(self % 1000)
        let digitCount = stringNumber.count
        return stringNumber
            .enumerated()
            .map { self.getDigit(for: $0.element, powerOfTen: digitCount - $0.offset - 1) }
            .joined()
    }
    
    private func getDigit(for arabicDigit: Character, powerOfTen: Int) -> String {
        switch arabicDigit {
        case "1":
            return self.romanDigits[powerOfTen * 2]
        case "2":
            return self.romanDigits[powerOfTen * 2] + self.romanDigits[powerOfTen * 2]
        case "3":
            return self.romanDigits[powerOfTen * 2] + self.romanDigits[powerOfTen * 2] + self.romanDigits[powerOfTen * 2]
        case "4":
            return self.romanDigits[powerOfTen * 2] + self.romanDigits[powerOfTen * 2 + 1]
        case "5":
            return self.romanDigits[powerOfTen * 2 + 1]
        case "6":
            return self.romanDigits[powerOfTen * 2 + 1] + self.romanDigits[powerOfTen * 2]
        case "7":
            return self.romanDigits[powerOfTen * 2 + 1] + self.romanDigits[powerOfTen * 2] + self.romanDigits[powerOfTen * 2]
        case "8":
            return self.romanDigits[powerOfTen * 2 + 1] + self.romanDigits[powerOfTen * 2] + self.romanDigits[powerOfTen * 2] + self.romanDigits[powerOfTen * 2]
        case "9":
            return self.romanDigits[powerOfTen * 2] + self.romanDigits[powerOfTen * 2 + 2]
        default:
            return ""
        }
    }
}
