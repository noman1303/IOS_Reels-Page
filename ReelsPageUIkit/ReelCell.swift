//
//  ReelCell.swift
//  ReelsPageUIkit
//
//  Created by Noman belim on 09/02/26.
//

import UIKit

import Foundation

struct Reel {
    let id: String
    let videoURL: String
    let username: String
    let userProfileImage: String
    let caption: String
    let likes: Int
    let comments: Int
    
    // For testing with sample data
    static func getSampleReels() -> [Reel] {
        return [
            Reel(id: "1",
                 videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                 username: "john_doe",
                 userProfileImage: "person.circle.fill",
                 caption: "Beautiful sunset at the beach 🌅",
                 likes: 12500,
                 comments: 234),
            
            Reel(id: "2",
                 videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
                 username: "jane_smith",
                 userProfileImage: "person.circle.fill",
                 caption: "Amazing adventure in the mountains! ⛰️",
                 likes: 8900,
                 comments: 156),
            
            Reel(id: "3",
                 videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
                 username: "travel_explorer",
                 userProfileImage: "person.circle.fill",
                 caption: "Exploring the city lights ✨",
                 likes: 15200,
                 comments: 421)
        ]
    }
}
