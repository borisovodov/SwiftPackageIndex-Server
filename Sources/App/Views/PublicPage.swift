import Foundation
import Vapor
import Plot

class PublicPage {

    /// The page's full HTML document.
    /// - Returns: A fully formed page inside a <html> element.
    final func document() -> HTML {
        HTML(
            head(),
            body()
        )
    }

    /// The page head.
    /// - Returns: A <head> element.
    final func head() -> Node<HTML.DocumentContext> {
        .head(
            .viewport(.accordingToDevice, initialScale: 1),
            .title(title()),
            .link(
                .rel(.stylesheet),
                .href("https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css")
            ),
            .link(
                .rel(.stylesheet),
                .href("https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,400;0,600;0,700;1,400;1,600;1,700&display=swap")
            ),
            .link(
                .rel(.stylesheet),
                .href("/stylesheets/main.css?\(resourceReloadQueryString())")
            ),
            .script(
                .src("https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.15/lodash.min.js")
            ),
            .script(
                .src("https://cdnjs.cloudflare.com/ajax/libs/axios/0.19.2/axios.min.js")
            ),
            .script(
                .src("/javascripts/main.js?\(resourceReloadQueryString())")
            )
        )
    }

    /// A query string that will force resources to reload after they change. In development this is the
    /// current date, to force a reload every time. In production this is the date of the last deploy.
    /// - Returns: A string containing the query string.
    final func resourceReloadQueryString() -> String {
        let secondsSince1970String = String(Int(Current.date().timeIntervalSince1970))
        do {
            return (try Environment.detect() == .development) ? secondsSince1970String : appVersion
        } catch {
            return secondsSince1970String
        }
    }

    /// The full page title, including the site name.
    /// - Returns: A string with the fully formed page title, ready for use in a <title> element.
    final func title() -> String {
        guard let pageTitle = pageTitle()
            else { return "Swift Package Index" }

        return "\(pageTitle) &ndash; Swift Package Index"
    }

    /// The title for the current page.
    /// - Returns: A string with a custom page title, if one is desired.
    func pageTitle() -> String? {
        nil
    }

    /// The page body.
    /// - Returns: A <body> element.
    final func body() -> Node<HTML.DocumentContext> {
        .body(
            header(),
            preMain(),
            main(),
            postMain(),
            footer()
        )
    }

    /// The site header, including the site navigation.
    /// - Returns: A <header> element.
    final func header() -> Node<HTML.BodyContext> {
        .header(
            .div(
                .class("inner"),
                .a(
                    .href("/"),
                    .h1(
                        .img(.src("/images/logo.svg")),
                        "Swift Package Index"
                    )
                ),
                .nav(
                    .ul(
                        .group(navItems())
                    )
                )
            )
        )
    }

    /// List items to be rendered in the site navigation menu.
    /// - Returns: An array of <li> elements.
    func navItems() -> [Node<HTML.ListContext>] {
        [
            .li(
                .a(
                    .href("#"),
                    "Add a Package"
                )
            ),
            .li(
                .a(
                    .href("#"),
                    "About"
                )
            ),
            .li(
                .a(
                    .href("#"),
                    "Search"
                )
            )
        ]
    }


    /// Optional content that will be inserted in between the page header and the main content for the page.
    /// - Returns: An optional element, or group of elements.
    func preMain() -> Node<HTML.BodyContext> {
        .text("")
    }

    /// The <main> element that will contain the primary content for the page.
    /// - Returns: A <main> element.
    final func main() -> Node<HTML.BodyContext> {
        .main(
            .div(.class("inner"),
                 content()
            )
        )
    }

    /// Optional content that will be inserted in between the main content for the page and the page footer.
    /// - Returns: An optional element, or group of elements.
    func postMain() -> Node<HTML.BodyContext> {
        .text("")
    }

    /// The page's content.
    /// - Returns: A node, or nodes (in a `.group`) with the page's content.
    func content() -> Node<HTML.BodyContext> {
        .p(
            "Override ",
            .code("content()"),
            " to change this page's content."
        )
    }

    /// The site footer, including all footer links.
    /// - Returns: A <footer> element.
    final func footer() -> Node<HTML.BodyContext> {
        .footer(
            .div(.class("inner"),
                 .nav(
                    .ul(
                        .li(
                            .a(
                                .href("https://github.com/SwiftPackageIndex/SwiftPackageIndex-Server"),
                                "GitHub"
                            )
                        ),
                        .li(
                            .a(
                                .href("/privacy"),
                                "Privacy and Cookies"
                            )
                        ),
                        .li(
                            .a(
                                .href("https://twitter.com/swiftpackages"),
                                "Twitter"
                            )
                        )
                    )
                )
            )
        )
    }

}