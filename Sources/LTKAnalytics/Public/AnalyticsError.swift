//
//  AnalyticsError.swift
//
//
//  Created by David Okun on 5/3/24.
//

import Foundation

public enum AnalyticsError: Error {
    case duplicateEvent(
        id: UUID
    )
    case potentialRapidFire(
        type: EventType
    )
}
