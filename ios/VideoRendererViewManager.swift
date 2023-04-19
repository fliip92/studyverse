//
//  VideoRendererViewManager.swift
//  studyverse
//
//  Created by Felipe Loyola on 4/18/23.
//

import React

@objc(VideoRendererViewManager)
class VideoRendererViewManager: RCTViewManager {
    override func view() -> UIView! {
        return VideoRendererView()
    }
    
    @objc override static func moduleName() -> String {
        return "VideoRendererView"
    }
}
