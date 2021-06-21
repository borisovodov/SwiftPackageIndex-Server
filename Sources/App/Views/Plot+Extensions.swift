import Foundation
import Plot

extension Node where Context: HTML.BodyContext {
    static func turboFrame(id: String, source: String? = nil, _ nodes: Node<HTML.BodyContext>...) -> Self {
        let attributes: [Node<HTML.BodyContext>] = [
            .attribute(named: "id", value: id),
            .attribute(named: "src", value: source)
        ]
        return .element(named: "turbo-frame", nodes: attributes + nodes)
    }

    static func structuredData<T>(_ model: T) -> Node<HTML.BodyContext> where T: Encodable {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = [ .sortedKeys, .withoutEscapingSlashes ]

        do {
            let data = try encoder.encode(model)
            let rawScript = String(decoding: data, as: UTF8.self)

            return .script(
                .attribute(named: "type", value: "application/ld+json"),
                .raw(rawScript)
            )
        } catch {
            AppEnvironment.logger?.error("Failed to encode structured data model: \(error)")
            return .empty
        }
    }

    static func spiReadme(_ nodes: Node<HTML.BodyContext>...) -> Self {
        .element(named: "spi-readme", nodes: nodes)
    }

    static func spinner() -> Self {
        .div(
            .class("spinner"),
            .div(.class("rect1")),
            .div(.class("rect2")),
            .div(.class("rect3")),
            .div(.class("rect4")),
            .div(.class("rect5"))
        )
    }

    static func searchForm(query: String = "", autofocus: Bool = true) -> Self {
        .form(
            .action(SiteURL.search.relativeURL()),
            .searchField(query: query, autofocus: autofocus),
            .button(
                .type(.submit),
                .div(
                    .title("Search")
                )
            )
        )
    }
}

extension Node where Context == HTML.FormContext {
    static func searchField(query: String = "", autofocus: Bool = true) -> Self {
        .input(
            .id("query"),
            .name("query"),
            .type(.search),
            .placeholder("Search"),
            .spellcheck(false),
            .autocomplete(false),
            .enableGrammarly(false),
            .data(named: "focus", value: String(autofocus)),
            .value(query)
        )
    }
}

// Custom attributes specific to the Swift Package Index

extension Attribute where Context == HTML.InputContext {
    static func enableGrammarly(_ isEnabled: Bool) -> Attribute {
        .data(named: "gramm", value: String(isEnabled))
    }
}
