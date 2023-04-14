//
//  Assignment.swift
//  GPACalculator
//
//  Created by user235226 on 4/12/23.
//

import Foundation

struct Assignment: Identifiable, Codable {
    var id = UUID()
    let name: String
    let grade: Double
    let weight: Double

    var convertedGrade: Double {
        return grade >= 90 ? 4.0 : grade >= 80 ? 3.0 : grade >= 70 ? 2.0 : grade >= 60 ? 1.0 : 0.0
    }
}
enum GradeScale: String, CaseIterable {
    case fourPoint = "4-point scale"
    case hundredPoint = "100-point scale"
}
