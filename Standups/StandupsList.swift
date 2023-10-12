//
//  StandupsList.swift
//  Standups
//
//  Created by Paloma St.Clair on 10/10/23.
//

import SwiftUI
import ComposableArchitecture

struct StandupsListFeature: Reducer {
    struct State{
        // identify arrays by stable id and not position index
        var standups: IdentifiedArrayOf<Standup> = []
    }
    enum Action{
        case addButtonTapped
            
    }
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action{
            case .addButtonTapped:
                state.standups.append(
                    Standup(
                        id:UUID(),
                        theme: .allCases.randomElement()!
                    )
                )
                return .none
            }
        }
    }
}
struct StandupsList: View {
    let store: StoreOf<StandupsListFeature>
    var body: some View {
        WithViewStore(self.store, observe: \.standups){ viewStore in
            List{
                ForEach(viewStore.state) { standup in
                    CardView(standup: standup)
                        .listRowBackground(standup.theme.mainColor)
                }
            }
            .navigationTitle("Daily Standups")
            .toolbar{
                ToolbarItem{
                    Button("Add") {
                        viewStore.send(.addButtonTapped)
                    }
                }
            }
        }
    }
}

struct CardView: View {
    let standup: Standup
    
    var body: some View {
        VStack(alignment: .leading) {
          Text(self.standup.title)
            .font(.headline)
          Spacer()
          HStack {
            Label("\(self.standup.attendees.count)", systemImage: "person.3")
            Spacer()
            Label(self.standup.duration.formatted(.units()), systemImage: "clock")
                  .labelStyle(.titleAndIcon)
          }
          .font(.caption)
        }
        .padding()
        .foregroundColor(self.standup.theme.accentColor)
      }
}

#Preview {
    NavigationStack{
        StandupsList(store: Store(initialState: StandupsListFeature.State(
            standups: [.mock]
        )){
            StandupsListFeature()
        })
    }
    
}
//16:59
