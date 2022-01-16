import Alchemy

@main
struct App: Application {
    
    /// Boot the application.
    
    func boot() {
        useAll(LoggingMiddleware())
        useAll(FileMiddleware())

        get("/") { _ in
            HomeView(greetings: ["Hola", "Bonjour", "Hello", "Hallo", "Ola"], name: "Josh")
        }
        
        controller(AuthController())
        
        // Authenticate subsequent requests by token.
        use(UserToken.tokenAuthMiddleware())

        get("/email") {
            try $0.get(User.self).email
        }
    }
    
    func schedule(schedule: Scheduler) {
        schedule.job(CleanupTokens())
            .daily()
        
        schedule.run { Log.info("Happy Friday!") }
            .weekly(day: .fri, hr: 9)
    }
}
