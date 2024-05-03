// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import os

public actor LTKAnalytics {
    private let logger = os.Logger(subsystem: "LTKAnalytics", category: "PublicAPI")
    private let eventBus = EventBus()

    public init() {
        logger.trace(#function)
    }

    @discardableResult
    public func recordEvent(_ type: EventType, attributes: [String: String]? = nil) async throws -> UUID {
        let recordedEvent = AnalyticsEvent(type: type, attributes: attributes)
        do {
            try await eventBus.addEventToQueue(recordedEvent)
            return recordedEvent.id
        } catch AnalyticsError.duplicateEvent(let id) {
            logger.warning("received duplicate event: \(id, privacy: .public)")
            throw AnalyticsError.duplicateEvent(id: id)
        } catch AnalyticsError.potentialRapidFire(let type) {
            logger.critical("potential duplicate event fired: \(type.description)")
            return recordedEvent.id
        }
    }

    deinit {
        logger.trace(#function)
    }
}
