//
//  RCTVideoViewManager.swift
//  studyverse
//
//  Created by Felipe Loyola on 4/17/23.
//

import Foundation
import TwilioVideo
import React

@objc(RCTVideoViewManager)
class RCTVideoViewManager: RCTViewManager {
  override func view() -> UIView! {
    return VideoView()
  }
}

