--!strict

export type FilterRule<T> = (item : T) -> boolean
export type Packagerule<T, E> = (item : T) -> E
export type DataHandler<T> = (data : T) -> ()
export type ErrorHandler = (error : string) -> ()

return 0