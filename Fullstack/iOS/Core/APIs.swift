import PapyrusAlamofire
import Shared

extension AuthAPI: API {
    public var baseURL: String { "http://localhost:3000" }
}

extension TodoAPI: API {
    public var baseURL: String { "http://localhost:3000" }
    
    public func adapt<Req: EndpointRequest, Res: EndpointResponse>(endpoint: inout Endpoint<Req, Res>) {
        if let token = Storage.shared.authToken {
            endpoint.baseRequest.headers["Authorization"] = " Bearer \(token)"
        }
    }
}
