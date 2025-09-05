//
//  ContentView.swift
//  SwiftUIRenameDisk
//
//  Created by Angelos Staboulis on 5/9/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDisk: Disk?
    @EnvironmentObject var viewModel:ViewModel
    @State var newName:String
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Available Volumes")
                .font(.headline)
            
            List(viewModel.disks) { disk in
                HStack {
                    Text(disk.volumeName)
                    Spacer()
                    Text(disk.identifier)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedDisk = disk
                    viewModel.outputMessage = ""
                }
                .background(selectedDisk?.id == disk.id ? Color.blue.opacity(0.2) : Color.clear)
            }
            .frame(height: 200)
            
            if let selected = selectedDisk {
                Text("Selected: \(selected.volumeName) (\(selected.identifier))")
                TextField("New Name", text:$newName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Rename Disk") {
                    viewModel.renameDisk(disk: selectedDisk!, newName: newName)
                }
                .disabled(newName.isEmpty)
            }
            
            Text(viewModel.outputMessage)
                .foregroundColor(.gray)
                .padding(.top)
            
            Spacer()
        }
        .padding()
        .onAppear(perform: viewModel.loadDisks)

    }

}

#Preview {
    ContentView(newName: "")
}
