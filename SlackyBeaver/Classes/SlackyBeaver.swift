//
//  SlackyBeaver.swift
//  Pods
//
//  Created by Andrew Garcia on 4/28/17.
//
//

import Foundation
import SwiftyBeaver

let log = SwiftyBeaver.self

open class SlackyBeaver: NSObject {
    
    public let console = ConsoleDestination()
    public let file = FileDestination()
    let slackClient = SlackClient.sharedInstance
    
    var slackTokenString: String
    var slackChannelString: String
    
    public init(slackToken: String, slackChannel: String) {
        slackTokenString = slackToken
        slackChannelString = slackChannel
        
        slackClient.setup(slackToken: slackToken)
        
        file.format = "$DHH:mm:ss.SSS$d $L $N.$F:$l - $M"
        console.format = "$DHH:mm:ss$d $L $M"
        
        log.addDestination(console)
        log.addDestination(file)
    }
    
    public func deviceInformation() -> Dictionary<String, String> {
        let systemVersion = UIDevice.current.systemVersion
        let model = UIDevice.current.model
        
        return ["deviceModel": model, "systemVersion": systemVersion]
    }
    
    public func debug(message: String) {
        log.debug(message)
    }
    
    public func verbose(message: String) {
        log.verbose(message)
    }
    
    public func info(message: String) {
        log.info(message)
    }
    
    public func warning(message: String) {
        log.warning(message)
    }
    
    public func error(message: String, otherInformation: Any?) {
        log.info("******************************************")
        if otherInformation != nil {
            log.info(otherInformation)
        }
        log.info(deviceInformation)
        log.info("******************************************")
        log.error(message)
        uploadLogsToSlack()
    }
    
    func uploadLogsToSlack() {
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            
            sleep(5)
            if let swiftyBeaverFile = self.file.logFileURL {
                let deviceName = UIDevice.current.name + ".log"
                SlackClient.sharedInstance.uploadFile(filePath: swiftyBeaverFile.path, fileName: deviceName, channels: "#\(self.slackChannelString)") { (res, error) in
                    
                    if error != nil {
                        log.verbose("Unable to send logs over Slack.")
                    } else {
                        log.verbose("Sent logs over Slack.")
                    }
                }
            }
        }
    }
}
