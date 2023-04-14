//
//  GPACalculator.swift
//  GPACalculator
//
//  Created by user235226 on 4/12/23.
//
import Foundation

class GPACalculator {
    func calculateCumulativeGPA(classes: [ClassModel]) -> Double {
        let totalCredits = classes.reduce(0.0) { $0 + $1.credit }
        let weightedGPA = classes.reduce(0.0) { $0 + $1.calculateGPA() * $1.credit }
        return totalCredits > 0 ? weightedGPA / totalCredits : 0
    }
}
