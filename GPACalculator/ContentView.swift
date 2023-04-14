//
//  ContentView.swift
//  GPACalculator
//
//  Created by user235226 on 3/21/23.
//

import SwiftUI

struct ContentView: View {
    @State private var classes: [ClassModel] = []
    @State private var gpa: Double = 0.0
    @State private var showingAddClassView = false
    private var gpaCalculator = GPACalculator()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(classes) { item in
                        NavigationLink(destination: SelectClassView(classes: $classes)) {
                            Text(item.name)
                        }
                    }
                    .onDelete(perform: deleteClass)
                }

                .listStyle(InsetGroupedListStyle())

                Button(action: {
                    self.gpa = gpaCalculator.calculateCumulativeGPA(classes: classes)
                }) {
                    Text("Calculate Cumulative GPA")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }

                Text("Your Cumulative GPA is: \(gpa, specifier: "%.2f")")
                    .font(.title)
                    .padding(.top)
            }
            .navigationBarTitle("GPA Calculator")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                showingAddClassView = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddClassView) {
                AddClassView(classes: $classes)
            }
        }
    }

    private func deleteClass(at offsets: IndexSet) {
        classes.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
