//
//  EventBus.swift
//
//
//  Created by David Okun on 5/3/24.
//

import Foundation
import os

internal actor EventBus {
    private let logger = os.Logger(
        subsystem: "LTKAnalytics",
        category: "EventBus"
    )
    private var queue = [AnalyticsEvent]()

    init() {
        logger.trace(
            #function
        )
    }

    internal func addEventToQueue(
        _ event: AnalyticsEvent
    ) async throws {
        // TODO: do this in a better way
        let existingEvents = queue.filter { $0.id == event.id}
        if existingEvents.count > 0 {
            throw AnalyticsError.duplicateEvent(id: event.id)
        }
        if await checkForPotentialRapidFire(event) {
            await dispatchEvent(event)
            logger.critical("potential duplicate event fired: \(event.loggingDescription)")
            // throw error of potential duplicate, but this is more of a warning
            throw AnalyticsError.potentialRapidFire(type: event.type)
        }
        await dispatchEvent(event)
    }

    private func dispatchEvent(_ event: AnalyticsEvent) async {
        queue.append(event)
        // TODO: actually send events to a stream where they are processed and sent off
    }

    private func checkForPotentialRapidFire(_ event: AnalyticsEvent) async -> Bool {
        let existingEvents = queue.filter { existingEvent in
            existingEvent.type == event.type &&
            abs(existingEvent.timestamp.timeIntervalSince(event.timestamp)) <= 0.25
        }
        return existingEvents.count > 0
    }

    deinit {
        logger.trace(
            #function
        )
    }
}
