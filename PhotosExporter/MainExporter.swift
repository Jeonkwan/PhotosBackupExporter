//
//  Main.swift
//  PhotosExporter
//
//  Created by Andreas Bentele on 10.02.18.
//  Copyright © 2018 Andreas Bentele. All rights reserved.
//

import Foundation
import MediaLibrary

func export() {
    let userPlistPath = "/Users/\(NSUserName())/Pictures/PhotosBackupExporterPreference.plist"
    guard let userPreferences = getPlist(withPath: userPlistPath) else {
        return
    }
    exportPhotosBy(preferences: userPreferences)
}

func exportPhotosBy(preferences: [String]) {
    // Retrive Arguments
    let userInputMode = preferences[0]
    let userInputExportDestinationDirectory = preferences[1]

    // Check User Input Mode String
    let selectedMode: ExportMode
    switch userInputMode {
    case "snapshot":
        selectedMode = .snapshot
    case "timemachine":
        selectedMode = .timemachine
    default:
        print("Unexpected Mode \(userInputMode) is NOT supported!\nPossible Mode: snapshot or timemachine")
        return
    }
    
    // Check User Input Export Destination Directory
    let selectedExportDestinationDirectory: String
    let fileManager = FileManager.default
    var isDir: ObjCBool = false
    if fileManager.fileExists(atPath: userInputExportDestinationDirectory, isDirectory:&isDir) {
        if isDir.boolValue {
            // file exists and is a directory
            selectedExportDestinationDirectory = userInputExportDestinationDirectory
        } else {
            // file exists and is not a directory
            print("Export Destination MUST be a Directory NOT a File!")
            return
        }
    } else {
        print("Invalid Path! The given directory does NOT exist!")
        return
    }
    
    // Result Output
    print("Provided Arguments are valid.")
    print("Selected Mode:\n==> \(selectedMode)")
    print("Photos will be exported to:\n==> \(selectedExportDestinationDirectory)")
    
    // Starting to Export
    print("Starting to export, please be patient...")
    exportPhotosWith(mode: selectedMode, toDestDir: selectedExportDestinationDirectory)
}
