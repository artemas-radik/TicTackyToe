//
//  TicTackyToeWidget.swift
//  TicTackyToeWidget
//
//  Created by Artemas on 3/4/24.
//

import WidgetKit
import SwiftUI
import AppIntents

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct SuperCharge: AppIntent {
    
    static var title: LocalizedStringResource = "Emoji Ranger SuperCharger"
    static var description = IntentDescription("All heroes get instant 100% health.")
    
    func perform() async throws -> some IntentResult {
        print("hiiiiii")
        return .result()
    }
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct TicTackyToeWidgetEntryView : View {
    var entry: Provider.Entry
    
    @State var text = "hello"

    var body: some View {
        VStack {
            HStack {
                Text(text)
                Text(entry.date, style: .time)
            }
            
            if #available(macOS 14.0, iOS 17.0, *) {
                HStack(alignment: .top) {
                    Button(intent: SuperCharge()) {
                        Image(systemName: "bolt.fill")
                    }
                }
                .tint(.white)
                .padding()
            }

            Text("Emoji:")
            Text(entry.emoji)
        }
    }
}

struct TicTackyToeWidget: Widget {
    let kind: String = "TicTackyToeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(macOS 14.0, iOS 17.0, *) {
                TicTackyToeWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                TicTackyToeWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    TicTackyToeWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}