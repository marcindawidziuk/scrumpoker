interface RoomStore{
    isShowingVotes: boolean;
    users: RoomUser[]
}

interface RoomUser {
    userName: string;
    vote: string;
}