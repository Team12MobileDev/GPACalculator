//
//  CalculateTargetGradeView.swift
//  GPACalculator
//
//  Created by user235226 on 4/12/23.
//

import SwiftUI

struct CalculateTargetGradeView: View {
    @Binding var assignments: [Assignment]
    @State private var targetGrade: String = ""
    @State private var remainingWeight: String = ""

    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Target Grade", text: $targetGrade)
                        .keyboardType(.decimalPad)
                    TextField("Remaining Weight (%)", text: $remainingWeight)
                        .keyboardType(.decimalPad)
                }
            }

            Button(action: {
                calculateRequiredGrade()
            }) {
                Text("Calculate Required Grade")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            }
            .padding(.bottom)
        }
        .navigationTitle("Target Grade")
    }

    private func calculateRequiredGrade() {
        if let targetGrade = Double(self.targetGrade),
           let remainingWeight = Double(self.remainingWeight) {
            let currentWeight = 100 - remainingWeight
            let currentGrade = assignments.reduce(0.0) { $0 + $1.grade * $1.weight } / currentWeight
            let requiredGrade = (targetGrade * 100 - currentGrade * currentWeight) / remainingWeight
            let alertTitle = requiredGrade.isNaN || requiredGrade.isInfinite ? "Error" : "Required Grade"
            let alertMessage = requiredGrade.isNaN || requiredGrade.isInfinite
                ? "Please enter valid values for target grade and remaining weight."
                : String(format: "You need a grade of %.1f%% on the remaining assignments to achieve a target grade of %.1f%%.", requiredGrade, targetGrade)
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            //UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                window.rootViewController?.present(alert, animated: true)
            }
        }
    }
}

