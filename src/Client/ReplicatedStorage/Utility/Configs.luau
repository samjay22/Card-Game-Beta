--!strict

return {
    STATS = {
        GLOBAL_STAT_LIMIT = 10e10,

        PLAYER_STAT_STORE = `Stats_%s`,
        PLAYER_CARD_STORE = `Cards_%s`,
        GLOBAL_STORE_NAME = "DATA_V4",
    },

    MESSAGES = {
        PLAYER_CARDS_LOADED = "Loaded player cards for player: %s",
        PLAYER_STATS_LOADED = "Loaded player stats for player: %s",
        LOADED_PLAYER_DATA = "Loaded player data for %s",

        SERVICE_NOT_FOUND = "Service not found: %s",
        SERVICE_NOT_LOADED = "Service not loaded: %s",
        SERVICE_NOT_REGISTERED = "Service not registered: %s",

        PLAYER_DATA_NOT_LOADED = "Player data not loaded for player: %s",
        PLAYER_STATS_NOT_LOADED = "Player stats not loaded for player: %s",
        PLAYER_CARDS_NOT_LOADED = "Player cards not loaded for player: %s",

        FAILED_TO_LOAD_DATASERVICE = "Failed to load data service: %s",

        PROCESS_TIMEOUT = "Process timed out: %s",
        PROCESS_FAILED = "Process failed: %s",
        PROCESS_SUCCESS = "Process succeeded: %s",
        
        SERVICES_LOADED = "Services loaded: %s",
        SERVICE_LOADED = "Service loaded: %s",
        SERVICE_REGISTERED = "Service registered: %s",

        ENTITY_NOT_FOUND = "Entity not found: %s",
        
    }
}