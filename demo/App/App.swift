import Alchemy

@main
struct App: Application {

    /// Boot the application setting any routes, middleware, and controllers.

    func boot() {
        useAll(MaintenanceMiddleware(), FileMiddleware())
        controller(UsersController())
    }

    /// Setup any recurring tasks

    func schedule(on schedule: Scheduler) {
        schedule.job(CleanupTokensJob())
            .everyDay()

        schedule.task { Log.info("Happy Friday!") }
            .everyWeek(day: .fri, hr: 9)
    }
}
