//
//  AddAssignmentView.swift
//  GPACalculator
//
//  Created by user235226 on 4/12/23.
//

import SwiftUI

struct AddAssignmentView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var assignments: [Assignment]
    @State private var assignmentName: String = ""
    @State private var assignmentGrade: String = ""
    @State private var assignmentWeight: String = ""
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Assignment Name", text: $assignmentName)
                    TextField("Grade", text: $assignmentGrade)
                        .keyboardType(.numberPad)
                    TextField("Weight (%)", text: $assignmentWeight)
                        .keyboardType(.numberPad)
                }

                Section {
                    Button("Add Assignment") {
                        if let grade = Int(assignmentGrade), let weight = Int(assignmentWeight), grade >= 1, grade <= 1000, weight >= 1, weight <= 100, !assignmentName.isEmpty {
                            let newAssignment = Assignment(name: assignmentName, grade: Double(grade), weight: Double(weight))
                            assignments.append(newAssignment)
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            showAlert = true
                        }
                    }
                }
            }
            .navigationBarTitle("Add Assignment", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Invalid Input"),
                    message: Text("Please enter valid integer values for Grade (1-1000) and Weight (1-100)."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}


