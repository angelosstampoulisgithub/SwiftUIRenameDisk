//
//  SwiftUIRenameDiskApp.swift
//  SwiftUIRenameDisk
//
//  Created by Angelos Staboulis on 5/9/25.
//

import SwiftUI

@main
struct SwiftUIRenameDiskApp: App {
    @StateObject var viewmodel = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(newName: "")
                .frame(width:650,height:400,alignment: .center)
                .environmentObject(viewmodel)
        }.windowResizability(.contentSize)
    }
}
