//
//  PlistArgumentsReader.swift
//  PhotosExporter
//
//  Created by Jeonkwan Chan on 2020/7/16.
//  Copyright © 2020 Andreas Bentele. All rights reserved.
//

import Foundation

func getPlist(withPath path: String) -> [String]?
{
//    default path:
//    let path = Bundle.main.path(forResource: name, ofType: "plist")
    let isPlistPathExist = FileManager.default.fileExists(atPath: path)
    if isPlistPathExist,
       let xml = FileManager.default.contents(atPath: path)
    {
        return (try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil)) as? [String]
    }
    print("User Preference Plist does NOT exist! Or format NOT as expected!")
    return nil
}



