//
//  VideoRendererView.swift
//  studyverse
//
//  Created by Felipe Loyola on 4/18/23.
//
import UIKit
import TwilioVideo
import React

class VideoRendererView: UIView {
    let videoView: VideoView
    
    override init(frame: CGRect) {
        videoView = VideoView(frame: frame)
        super.init(frame: frame)
        self.addSubview(videoView)
        videoView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addVideoViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVideoViewConstraints() {
        videoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            videoView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            videoView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            videoView.topAnchor.constraint(equalTo: self.topAnchor),
            videoView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
