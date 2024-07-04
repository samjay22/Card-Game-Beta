--!strict
export type TopicItem<T> = {
    RequestID : string,
    EventType : string,
    Metadata : T?,
    Timestamp : number?,
    Device : string?,
    Country : string?,
    Language : string?,
    UserId : number,

    OnTopicCompleted : BindableEvent,
}

return 0