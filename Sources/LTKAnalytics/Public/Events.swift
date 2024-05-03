//
//  AnalyticsEvent.swift
//
//
//  Created by David Okun on 5/3/24.
//

import Foundation

public struct AnalyticsEvent: Identifiable {
    internal let type: EventType
    internal let attributes: [String: String]?
    internal let timestamp: Date
    public let id: UUID

    init(
        type: EventType,
        attributes: [String : String]? = nil
    ) {
        self.id = UUID()
        self.timestamp = Date()
        self.type = type
        self.attributes = attributes
    }

    public var loggingDescription: String {
        """
        
        ID: \(id.uuidString)
        type: \(type.description)
        timestamp: \(timestamp.ISO8601Format())
        attributes: \(String(
        describing: attributes
        ))
        """
    }
}
