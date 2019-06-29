//
//  Today.swift
//  Novus
//
//  Created by Reuben Catchpole on 28/06/19.
//  Copyright © 2019 PolarTeam. All rights reserved.
//

import SwiftUI

dynamic var isRunning = false
var outputPipe:Pipe!
var buildTask:Process!

//  Converted to Swift 5 by Swiftify v5.0.31639 - https://objectivec2swift.com/
func runProcess(asAdministrator scriptPath: String?, withArguments arguments: [String]?, output: String?, errorDescription: String?) -> Bool {
    var output = output
    var errorDescription = errorDescription
    
    let allArgs = arguments?.joined(separator: " ")
    let fullScript = "\(scriptPath ?? "") \(allArgs ?? "")"
    
    var errorInfo: NSDictionary?
    let script = "do shell script \"\(fullScript)\" with administrator privileges"
    
    let appleScript = NSAppleScript(source: script)
    let eventResult = appleScript?.executeAndReturnError(&errorInfo)
    
    // Check errorInfo
    if eventResult == nil {
        // Describe common errors
        errorDescription = nil
        if errorInfo?[NSAppleScript.errorNumber] != nil {
            let errorNumber = errorInfo?[NSAppleScript.errorNumber] as? NSNumber
            if errorNumber?.intValue ?? 0 == -128 {
                errorDescription = "The administrator password is required to do this."
            }
        }
        
        // Set error message from provided message
        if errorDescription == nil {
            if errorInfo?[NSAppleScript.errorMessage] != nil {
                errorDescription = errorInfo?[NSAppleScript.errorMessage] as? String
            }
        }
        
        print(errorDescription)
        
        return false
    } else {
        // Set output to the AppleScript's output
        output = eventResult?.stringValue
        
        print(output)
        
        return true
    }
}



func runScript(_ arguments:[String]) {
    
    //1.
    isRunning = true
    
    let taskQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
    
    //2.
    taskQueue.async {
        
        //1.
        guard let path = Bundle.main.path(forResource: "BuildScript",ofType:"command") else {
            print("Unable to locate BuildScript.command")
            return
        }
        
        //2.
        buildTask = Process()
        buildTask.launchPath = path
        buildTask.arguments = ["pass"]
        buildTask.environment = ["path": "/usr/bin"]
        
        //3.
        buildTask.terminationHandler = {
            
            task in
            DispatchQueue.main.async(execute: {
                isRunning = false
            })
            
        }
        
        captureStandardOutputAndRouteToTextView(buildTask)
        
        //4.
        buildTask.launch()
        
        //5.
        buildTask.waitUntilExit()
        
    }
    
}


func captureStandardOutputAndRouteToTextView(_ task:Process) {
    
    //1.
    outputPipe = Pipe()
    task.standardOutput = outputPipe
    
    //2.
    outputPipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
    
    //3.
    NotificationCenter.default.addObserver(forName: NSNotification.Name.NSFileHandleDataAvailable, object: outputPipe.fileHandleForReading , queue: nil) {
        notification in
        
        //4.
        let output = outputPipe.fileHandleForReading.availableData
        let outputString = String(data: output, encoding: String.Encoding.utf8) ?? ""
            
        print(outputString)

        
        //6.
        outputPipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
        
        
    }
    
}


struct Today : View {
    
    var body: some View {
        
        VStack{
            HStack(alignment: .top){
                VStack(alignment: .leading) {
                    Text("Monday, 22 June").font(.caption).color(.secondary)
                    Text("Today").font(.title).bold()
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    HStack{
                        Image("OlympusProfilePicture").resizable().clipShape(Circle()).frame(width: 30, height: 30)
                    }
                }
                
            }
            
            
            Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color("GradientColorSetNumberOne"), Color("GradientColorSetNumberTwo")]), startPoint: .leading, endPoint: .trailing)).overlay(
                HStack{
                    VStack {
                        Image("NovusLogo").resizable().aspectRatio(1, contentMode: .fit)
                        
                    }
                    
                    
                    VStack(alignment: .leading){
                        
                        Text("Welcome to Novus").font(.title).color(.white).bold()
                        Text("A reimagined way of getting everything!").color(.white).font(.subheadline).opacity(0.42)
                        
                    }
                    
                    
                    
                    }.padding(40)).cornerRadius(8)
            
            HStack{
                Text("Test")
                RoundedRectangle(cornerRadius: 8).tapAction {
                    runProcess(asAdministrator: Bundle.main.path(forResource: "BuildScript", ofType: "command"), withArguments: [""], output: "", errorDescription: "")
                    
                    }
                RoundedRectangle(cornerRadius: 8)
                }.foregroundColor(Color("BlankCardColors"))
            
            
            }.padding(.all)
    }
}

#if DEBUG
struct Today_Previews : PreviewProvider {
    static var previews: some View {
        Today()
    }
}
#endif
