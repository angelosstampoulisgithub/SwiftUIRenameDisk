//
//  ViewModel.swift
//  SwiftUIRenameDisk
//
//  Created by Angelos Staboulis on 5/9/25.
//

import Foundation
class ViewModel:ObservableObject{
    @Published var disks:[Disk] = []
    @Published var outputMessage:String = " "
    func loadDisks() {
            let volumesURL = URL(fileURLWithPath: "/Volumes")
            guard let volumeNames = try? FileManager.default.contentsOfDirectory(atPath: volumesURL.path) else {
                return
            }

            let systemVolume = "/"
            disks = volumeNames.compactMap { name in
                let fullPath = "/Volumes/\(name)"
                if fullPath != systemVolume {
                    return Disk(identifier: name, volumeName: fullPath)
                }
                return nil
            }
        }

    func renameDisk(disk:Disk,newName:String) {
            let task = Process()
            task.launchPath = "/usr/sbin/diskutil"
            task.arguments = ["rename", disk.volumeName, newName]

            let pipe = Pipe()
            task.standardOutput = pipe
            task.standardError = pipe

            task.launch()
            task.waitUntilExit()

            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            outputMessage = String(data: data, encoding: .utf8) ?? "Unknown error"

            // Refresh disk list
            loadDisks()
        }
}


