//
//  ClassModel.swift
//  GPACalculator
//
//  Created by user235226 on 4/12/23.
//

import Foundation

struct ClassModel: Identifiable {
    let id = UUID()
    var name: String
    var assignments: [Assignment]
    var credit: Double

    func calculateGPA() -> Double {
        let totalWeight = assignments.reduce(0.0) { $0 + $1.weight }
        let weightedSum = assignments.reduce(0.0) { $0 + $1.grade * $1.weight }
        return totalWeight > 0 ? weightedSum / totalWeight : 0
    }
}
