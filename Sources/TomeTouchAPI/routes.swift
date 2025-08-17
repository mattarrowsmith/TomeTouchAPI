import Fluent
import Vapor

func routes(_ app: Application) throws {
    // Base path for  API routes.
    // /api/v1/
    let api = app.grouped("api", "v1")

    // MARK: Systems Routes
    let systems = api.grouped("systems")

    // GET /api/v1/systems
    systems.get { req in
        let BSDataService = BSDataService()
        let systems = try BSDataService.getGameSystems()
        return systems
    }

    // GET /api/v1/systems/:system
    systems.get(":system") { req async -> String in
        let system = req.parameters.get("system")!
        return "Getting details for system: \(system)"
    }

    // MARK: Factions Routes
    let factions = systems.grouped(":system", "factions")

    // GET /api/v1/systems/:system/factions
    factions.get { req in
        let system = req.parameters.get("system")!
        return "get all factions for system \(system)"
    }

    // GET /api/v1/systems/:system/factions/:faction
    factions.get(":faction") { req in
        let system = req.parameters.get("system")!
        let faction = req.parameters.get("faction")!
        return "Getting details for faction: \(faction) in system: \(system)"
    }

    // MARK: Units Routes
    let units = factions.grouped(":faction", "units")

    // GET /api/v1/systems/:system/factions/:faction/units
    units.get { req in
        let system = req.parameters.get("system")!
        let faction = req.parameters.get("faction")!
        return "get all units for system \(system), faction \(faction) "
    }

    // GET /api/v1/systems/:system/factions/:faction/units/:unit
    units.get(":unit") { req in
        let system = req.parameters.get("system")!
        let faction = req.parameters.get("faction")!
        let unit = req.parameters.get("unit")!
        return "get unit info for system \(system), faction \(faction), unit \(unit)"
    }

    try api.register(collection: TodoController())
}
