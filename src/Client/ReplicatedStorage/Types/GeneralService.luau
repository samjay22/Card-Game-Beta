--!strict
export type ServiceContainer = {
    RegisterService : (serviceName : string, modulePath : string) -> (),
    Inject : (serviceName : string) -> any,
}
