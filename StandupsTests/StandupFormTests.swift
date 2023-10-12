//
//  StandupFormTests.swift
//  StandupsTests
//
//  Created by Paloma St.Clair on 10/12/23.
//

import XCTest
import ComposableArchitecture
@testable import Standups

@MainActor
final class StandupFormTests: XCTestCase {

    func testAddDeleteAttendee() async {
        let store = TestStore(
            initialState: StandupsFormFeature.State(
                standup: Standup(
                    id: UUID(0),
                    attendees: [Attendee(id:UUID(0))]
                )
            )
        ){
            StandupsFormFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        await store.send(.addAttendeeButtonTapped) {
                $0.focus = .attendee(UUID(0))
                $0.standup.attendees.append(Attendee(id:UUID(0)))
        }
        await store.send(.deleteAttendees(atOffsets: [1])){
            $0.focus = .attendee($0.standup.attendees[0].id)
            $0.standup.attendees.remove(at:1)
        }
    }

}
