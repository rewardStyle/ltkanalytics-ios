//
//  EventType.swift
//  
//
//  Created by David Okun on 5/3/24.
//

import Foundation

public enum EventType: Equatable {
    case applicationBecameActive
    case applicationFinishedLoading
    case loadedHomeFeed
    case postImpression(
        id: String
    )
    case profileImpression(
        id: String
    )
}

extension EventType: CustomStringConvertible {
    public var description: String {
        switch self {
            case .applicationBecameActive:
                return "Application Became Active"
            case .applicationFinishedLoading:
                return "Application Finished Loading"
            case .loadedHomeFeed:
                return "Loaded Home Feed"
            case .postImpression(
                let id
            ):
                return "Post Impression (ID: \(id))"
            case .profileImpression(
                let id
            ):
            return "Profile Impression (ID: \(id))"
        }
    }
}
