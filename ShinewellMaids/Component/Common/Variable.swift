//
//  Variable.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 10/06/23.
//

import Foundation
import UIKit

var globalUserName          =       k.userDefault.value(forKey: "user_name")
var globalUserImage         =       k.userDefault.value(forKey: "user_image")

var localTimeZoneIdentifier: String { return
    TimeZone.current.identifier }
