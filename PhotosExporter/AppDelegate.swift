//
//  AppDelegate.swift
//  PhotosExporter
//
//  Created by Andreas Bentele on 21.10.18.
//  Copyright © 2018 Andreas Bentele. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSApp.windows.last!.close()
        export()
        NSApp.terminate(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }


}

