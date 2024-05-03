import XCTest
@testable import LTKAnalytics

final class PublicAPITests: XCTestCase {
    private var publicAPI: LTKAnalytics?

    override func setUp() async throws {
        publicAPI = LTKAnalytics()
    }

    func testExample() async throws {
        do {
            let eventID = try await publicAPI?.recordEvent(.loadedHomeFeed)
            XCTAssertNotNil(eventID)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testThatTwoSeparateEventsHaveSeparateIDs() async throws {
        do {
            let first = try await publicAPI?.recordEvent(.loadedHomeFeed)
            let second = try await publicAPI?.recordEvent(.postImpression(id: "8675309"))
            XCTAssertNotEqual(first, second, "two events of different types fired should have different IDs")
        } catch {
            XCTFail(error.localizedDescription)
        }
    } 

    func testThatTwoIdenticalEventsHaveSeparateIDs() async throws {
        do {
            let first = try await publicAPI?.recordEvent(.loadedHomeFeed)
            let second = try await publicAPI?.recordEvent(.loadedHomeFeed)
            XCTAssertNotEqual(first, second, "two events of the same type fired should have different IDs")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
