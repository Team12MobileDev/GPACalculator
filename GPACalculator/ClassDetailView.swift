//
//  ClassDetailView.swift
//  GPACalculator
//
//  Created by user235226 on 4/12/23.
//

import SwiftUI

struct ClassDetailView: View {
    @Binding var classModel: ClassModel
    @State private var showingAddAssignmentView = false
    @State private var selectedGradeScale: GradeScale = .hundredPoint
    @State private var showingCalculateTargetGradeView = false


    var body: some View {
        VStack {
            Picker("Grade Scale", selection: $selectedGradeScale) {
                ForEach(GradeScale.allCases, id: \.self) { scale in
                    Text(scale.rawValue).tag(scale)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            List {
                ForEach(classModel.assignments) { assignment in
                    Text("\(assignment.name) - \(selectedGradeScale == .hundredPoint ? assignment.grade : assignment.convertedGrade, specifier: "%.1f") (\(assignment.weight, specifier: "%.1f")%)")
                }
            }
            .listStyle(InsetGroupedListStyle())
            Button(action: {
                showingCalculateTargetGradeView = true
            }) {
                Text("Calculate Target Grade")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.bottom)
            .sheet(isPresented: $showingCalculateTargetGradeView) {
                CalculateTargetGradeView(assignments: $classModel.assignments)
            }

            Button(action: {
                showingAddAssignmentView = true
            }) {
                Text("Add Assignment")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            }
            .padding(.bottom)
            .sheet(isPresented: $showingAddAssignmentView) {
                AddAssignmentView(assignments: $classModel.assignments)
            }
        }
        .navigationTitle(classModel.name)
    }
}
