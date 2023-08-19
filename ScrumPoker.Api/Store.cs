using System.Collections.Concurrent;
using Microsoft.Extensions.Primitives;

namespace ScrumPoker.Api;

public class RoomStore
{
    public required List<RoomUser> Users { get; set; }
    public bool IsShowingVotes { get; set; }
    public List<PastStory> History { get; set; }

    public class RoomUser
    {
        public required string UserName { get; set; }
        public bool HasVoted { get; set; }
        public string? Vote { get; set; }
    }
}

public interface IStore
{
    public void AddUser(string contextConnectionId, string connectionId, string userName);
    public void AddToRoom(string connectionId, string group);
    public void Vote(string connectionId, string vote);
    public void NextStory(string connectionId, string roomName);
    public string GetUserName(string connectionId);
    public string GetRoomForUser(string connectionId);
    public RoomStore GetRoomStore(string name);
    public void SetDescription(string room, string description);
    void DisconnectUser(string contextConnectionId);
    void UpdateDescription(string room, string description);
    Room GetRoom(string room);
    List<PokerUser> GetUsers(string room);
    void ShowVotes(string room);
    void NextCase(string room);
}

public class Store : IStore
{
    private readonly ConcurrentDictionary<string, PokerUser> _connections = new();
    private readonly ConcurrentDictionary<string, Room> _rooms = new();

    public void AddUser(string connectionId, string userName, string room)
    {
        _connections[connectionId] = new PokerUser { UserName = userName, Room = room};
        AddToRoom(connectionId, room);
    }

    public void AddToRoom(string connectionId, string group)
    {
        _rooms.TryAdd(group, new Room {Name = group});

        _rooms[group].Connections.Add(connectionId);
    }

    public void Vote(string connectionId, string vote)
    {
        _connections[connectionId].Vote = vote;
    }
    
    public void NextStory(string connectionId, string roomName)
    {
        var room = _rooms[roomName];
        var history = new PastStory
        {
            CompletedAt = DateTimeOffset.UtcNow,
            Description = room.CaseDescription,
            Votes = room.Connections.Select(conn =>
            {
                var hasValue = _connections.TryGetValue(conn, out var user);
                return hasValue && user != null ? user : null;
            })
            .Where(x => x is not null && x?.Vote is not null)
            .Select(x => (x.UserName, x.Vote))
            .ToList()
        };
        room.PastStories.Add(history);
        room.IsShowingVotes = false;
        room.CaseDescription = string.Empty;
        foreach (var roomConnectionId in room.Connections)
        {
            var hasValue = _connections.TryGetValue(roomConnectionId, out var user);
            if (hasValue)
            {
                user!.Vote = null;
            }
        }
    }

    public string GetUserName(string connectionId)
    {
        return _connections[connectionId].UserName;
    }

    public string GetRoomForUser(string connectionId)
    {
        return _connections[connectionId].Room;
    }

    public RoomStore GetRoomStore(string name)
    {
        var room = _rooms[name];
        return new RoomStore
        {
            IsShowingVotes = room.IsShowingVotes,
            History = room.PastStories,
            Users = _rooms[name].Connections
                .Select(x =>
                {
                    var hasValue =  _connections.TryGetValue(x, out var a);
                    if (hasValue)
                        return a;
                    return null;
                })
                .Where(x => x != null)
                .Select(x => new RoomStore.RoomUser
                {
                    UserName = x!.UserName,
                    HasVoted = x!.Vote != null,
                    Vote = x!.Vote
                }).ToList()
        };
    }

    public void SetDescription(string room, string description)
    {
        _rooms[room].Name = description;
    }

    public void DisconnectUser(string contextConnectionId)
    {
        _connections.TryRemove(contextConnectionId, out _);
    }

    public void UpdateDescription(string room, string description)
    {
        _rooms[room].CaseDescription = description;
    }

    public Room GetRoom(string room)
    {
        return _rooms[room];
    }

    public List<PokerUser> GetUsers(string room)
    {
        return _connections.Values.Where(x => x.Room == room).ToList();
    }

    public void ShowVotes(string room)
    {
        _rooms[room].IsShowingVotes = true;
    }

    public void NextCase(string roomName)
    {
        var room = _rooms[roomName];
        room.IsShowingVotes = false;
        room.CaseDescription = string.Empty;
    }
}

public class PokerUser
{
    public required string UserName { get; set; }
    public required string Room { get; set; }
    
    public string? Vote { get; set; }
}
public class Room
{
    public string Name { get; set; }
    public string CaseDescription { get; set; }
    public bool IsShowingVotes { get; set; }

    public HashSet<string> Connections { get; set; } = new();
    public List<PastStory> PastStories { get; set; } = new();
}

public class PastStory
{
    public DateTimeOffset CompletedAt { get; set; }
    public required string Description { get; set; }
    public required List<(string user, string vote)> Votes { get; set; }
}

