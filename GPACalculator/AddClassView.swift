//
//  AddClassView.swift
//  GPACalculator
//
//  Created by user235226 on 4/12/23.
//

import SwiftUI

struct AddClassView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var classes: [ClassModel]
    @State private var className: String = ""
    @State private var classCredit: String = ""
    @State private var showCreditErrorPopup = false

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Class Name", text: $className)
                    TextField("Class Credit", text: $classCredit)
                        .keyboardType(.decimalPad)
                }

                Section {
                    Button("Add Class") {
                        if let credit = Double(classCredit), !className.isEmpty {
                            let newClass = ClassModel(name: className, assignments: [], credit: credit)
                            classes.append(newClass)
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            showCreditErrorPopup = true
                        }
                    }
                }
            }
            .navigationBarTitle("Add Class", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
            .alert(isPresented: $showCreditErrorPopup) {
                Alert(title: Text("Invalid Class Credit"),
                      message: Text("Please enter a valid number for class credit."),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
}
