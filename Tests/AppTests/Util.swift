import Fluent
import Vapor

@testable import App


func setup(_ environment: Environment, resetDb: Bool = true) throws -> Application {
    // Always start with a baseline mock environment to avoid hitting live resources
    Current = .mock
    
    let app = Application(.testing)
    try configure(app)
    if resetDb {
        try app.autoRevert().wait()
        try app.autoMigrate().wait()
    }
    return app
}


// MARK: - Package creation helpers


@discardableResult
func savePackage(on db: Database, _ url: URL) throws -> Package {
    let p = Package(id: UUID(), url: url)
    try p.save(on: db).wait()
    return p
}


@discardableResult
func savePackages(on db: Database, _ urls: [URL]) throws -> [Package] {
    try urls.map { try savePackage(on: db, $0) }
}


// MARK: - Client mocking


class MockClient: Client {
    var response: ClientResponse

    func send(_ request: ClientRequest) -> EventLoopFuture<ClientResponse> {
        eventLoop.makeSucceededFuture(response)
    }

    var eventLoop: EventLoop {
        return EmbeddedEventLoop()
    }

    func delegating(to eventLoop: EventLoop) -> Client {
        self
    }

    init(_ updateResponse: (inout ClientResponse) -> Void) {
        self.response = ClientResponse()
        updateResponse(&self.response)
    }
}


func makeBody(_ string: String) -> ByteBuffer {
    var buffer: ByteBuffer = ByteBuffer.init(.init())
    buffer.writeString(string)
    return buffer
}


// MARK: - Useful extensions


extension String {
    var url: URL {
        URL(string: self)!
    }
}


extension Result {
    var isSuccess: Bool {
        if case .success = self { return true }
        return false
    }

    var isFailure: Bool {
        if case .failure = self { return true }
        return false
    }
}
