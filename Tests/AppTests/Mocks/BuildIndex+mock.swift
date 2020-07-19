@testable import App
import Foundation


extension BuildIndex.Model {

    static let id: App.Build.Id = UUID(uuidString: "2f16f873-1ebf-4987-b4ce-a9f22269d13a")!

    static var mock: Self {
        .init(
            packageName: "foobar",
            stable: .init(
                name: "1.2.3",
                kind: .stable,
                builds: [
                    Build(id: Self.id, swiftVersion: .init(5, 2, 4), platform: .macos("x86_64"), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 2, 4), platform: .ios(""), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 2, 4), platform: .tvos(""), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 1, 5), platform: .macos("x86_64"), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 1, 5), platform: .ios(""), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 1, 5), platform: .tvos(""), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 0, 3), platform: .macos("x86_64"), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 0, 3), platform: .ios(""), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 0, 3), platform: .tvos(""), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(4, 2, 3), platform: .macos("x86_64"), status: .failed),
                    Build(id: Self.id, swiftVersion: .init(4, 2, 3), platform: .ios(""), status: .failed),
                    Build(id: Self.id, swiftVersion: .init(4, 2, 3), platform: .tvos(""), status: .failed),
                ]),
            latest: .init(
                name: "main",
                kind: .latest,
                builds: [
                    Build(id: Self.id, swiftVersion: .init(5, 2, 4), platform: .macos("x86_64"), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 2, 4), platform: .ios(""), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 2, 4), platform: .tvos(""), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 1, 5), platform: .macos("x86_64"), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 1, 5), platform: .ios(""), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 1, 5), platform: .tvos(""), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 0, 3), platform: .macos("x86_64"), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 0, 3), platform: .ios(""), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 0, 3), platform: .tvos(""), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(4, 2, 3), platform: .macos("x86_64"), status: .failed),
                    Build(id: Self.id, swiftVersion: .init(4, 2, 3), platform: .ios(""), status: .failed),
                    Build(id: Self.id, swiftVersion: .init(4, 2, 3), platform: .tvos(""), status: .failed),
                ]
            ),
            beta: .init(
                name: "2.0.0-b1",
                kind: .beta,
                builds: [
                    Build(id: Self.id, swiftVersion: .init(5, 2, 4), platform: .macos("x86_64"), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 2, 4), platform: .ios(""), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 2, 4), platform: .tvos(""), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 1, 5), platform: .macos("x86_64"), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 1, 5), platform: .ios(""), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 1, 5), platform: .tvos(""), status: .ok),
                    Build(id: Self.id, swiftVersion: .init(5, 0, 3), platform: .macos("x86_64"), status: .failed),
                    Build(id: Self.id, swiftVersion: .init(5, 0, 3), platform: .ios(""), status: .failed),
                    Build(id: Self.id, swiftVersion: .init(5, 0, 3), platform: .tvos(""), status: .failed),
                    Build(id: Self.id, swiftVersion: .init(4, 2, 3), platform: .macos("x86_64"), status: .failed),
                    Build(id: Self.id, swiftVersion: .init(4, 2, 3), platform: .ios(""), status: .failed),
                    Build(id: Self.id, swiftVersion: .init(4, 2, 3), platform: .tvos(""), status: .failed),
                ]
            )
        )
    }
}