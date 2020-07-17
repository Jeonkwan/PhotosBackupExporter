//
//  SelectableModeExporter.swift
//  PhotosExporter
//
//  Created by Jeonkwan Chan on 2020/7/15.
//  Copyright © 2020 Andreas Bentele. All rights reserved.
//

// This function wraps up two Exporter giving user flexibility to select different exporter

import Foundation
import MediaLibrary

// Supported Export Mode
enum ExportMode {
    case snapshot
    case timemachine
}

func exportPhotosWith(mode: ExportMode, toDestDir: String) {
    // define which media groups should be exported
    let exportMediaGroupFilter = { (mediaGroup: MLMediaGroup) -> Bool in
        // export all media groups
        return true
    }
    
    // define for which media groups the photos should be exported
    let exportPhotosOfMediaGroupFilter = { (mediaGroup: MLMediaGroup) -> Bool in
        return ["com.apple.Photos.Album", "com.apple.Photos.SmartAlbum", "com.apple.Photos.CollectionGroup", "com.apple.Photos.MomentGroup", "com.apple.Photos.YearGroup", "com.apple.Photos.PlacesCountryAlbum", "com.apple.Photos.PlacesProvinceAlbum", "com.apple.Photos.PlacesCityAlbum", "com.apple.Photos.PlacesPointOfInterestAlbum", "com.apple.Photos.FacesAlbum", "com.apple.Photos.VideosGroup", "com.apple.Photos.FrontCameraGroup", "com.apple.Photos.PanoramasGroup", "com.apple.Photos.BurstGroup", "com.apple.Photos.ScreenshotGroup"].contains(mediaGroup.typeIdentifier) &&
            !("com.apple.Photos.FacesAlbum" == mediaGroup.typeIdentifier && mediaGroup.parent?.typeIdentifier == "com.apple.Photos.AlbumsGroup") &&
            !("com.apple.Photos.PlacesAlbum" == mediaGroup.typeIdentifier && mediaGroup.parent?.typeIdentifier == "com.apple.Photos.RootGroup")
    }
    
    // Initiate an Export with the selected mode
    switch mode {
    case .snapshot:
        //////////////////////////////////////////////////////////////////////////////////////
        // Export to local disk in simple export mode (snapshot folder, with hard links
        // to the original files to save disk space)
        //////////////////////////////////////////////////////////////////////////////////////
        
        // define the target path (this is the root path for your backups)
        let localPhotosExporter = SnapshotPhotosExporter.init(targetPath: toDestDir)
        localPhotosExporter.exportMediaGroupFilter = exportMediaGroupFilter
        localPhotosExporter.exportPhotosOfMediaGroupFilter = exportPhotosOfMediaGroupFilter
        localPhotosExporter.exportPhotos()
    case .timemachine:
        //////////////////////////////////////////////////////////////////////////////////////
        // Export to external disk in "time machine" mode (one folder for each export date)
        //////////////////////////////////////////////////////////////////////////////////////
        
        // define the target path (this is the root path for your backups)
        let externalDiskPhotosExporter = IncrementalPhotosExporter.init(targetPath: toDestDir)
        externalDiskPhotosExporter.exportMediaGroupFilter = exportMediaGroupFilter
        externalDiskPhotosExporter.exportPhotosOfMediaGroupFilter = exportPhotosOfMediaGroupFilter
        externalDiskPhotosExporter.exportPhotos()
    }
}
