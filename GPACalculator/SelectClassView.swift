//
//  SelectClassView.swift
//  GPACalculator
//
//  Created by user235226 on 4/12/23.
//

import SwiftUI

struct SelectClassView: View {
    @Binding var classes: [ClassModel]

    var body: some View {
        NavigationView {
            List {
                ForEach(classes) { item in
                    NavigationLink(destination: ClassDetailView(classModel: $classes[classes.firstIndex(where: { $0.id == item.id })!])) {
                        Text(item.name)
                    }
                }
            }
            .navigationBarTitle("Select Class")
        }
    }
}
