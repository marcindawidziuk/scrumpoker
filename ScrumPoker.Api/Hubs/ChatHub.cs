using Microsoft.AspNetCore.SignalR;

namespace ScrumPoker.Api.Hubs;

public class ChatHub : Hub
{
    private static readonly IStore Store = new Store();
    
    public override async Task OnConnectedAsync()
    {
        var userName = Context.GetHttpContext()!.Request.Query["username"];
        var room = Context.GetHttpContext()!.Request.Query["room"];
        // this.Clients.U
        Store.AddUser(Context.ConnectionId, userName, room);
        await SendMessage("test", $"{userName} joined");
        
        await Groups.AddToGroupAsync(Context.ConnectionId, room);
        var store = Store.GetRoomStore(room);
        await Clients.Group(room).SendAsync("joined", store);

        var roomObj = Store.GetRoom(room);
        await Clients.Client(Context.ConnectionId).SendAsync("description_updated", roomObj.CaseDescription);
        
        await base.OnConnectedAsync();
    }

    public async Task SendMessage(string user, string message)
    {
        await Clients.All.SendAsync("ReceiveMessage", user, message);
    }
    
    public async Task Vote(string vote)
    {
        Store.Vote(Context.ConnectionId, vote);
        
        var room = Store.GetRoomForUser(Context.ConnectionId);
        var users = Store.GetUsers(room);
        if (users.All(x => x.Vote != null))
        {
            Store.ShowVotes(room);
        }
        var store = Store.GetRoomStore(room);
        await Clients.Group(room).SendAsync("joined", store);
    }
    
    public async Task UpdateDescription(string description)
    {
        var room = Store.GetRoomForUser(Context.ConnectionId);
        Store.UpdateDescription(room, description);
        await Clients.All.SendAsync("description_updated", description);
    }

    public override async Task OnDisconnectedAsync(Exception? exception)
    {
        var room = Store.GetRoomForUser(Context.ConnectionId);
        
        Store.DisconnectUser(Context.ConnectionId);
        var store = Store.GetRoomStore(room);
        await Clients.Group(room).SendAsync("joined", store);
        await base.OnDisconnectedAsync(exception);
    }

    public async Task Join(string channelName)
    {
        // await Groups.AddToGroupAsync(Context.ConnectionId, channelName);
        //
        // _store.AddToRoom(Context.ConnectionId, channelName);
        // var store = _store.GetRoomStore(channelName);
        // await Clients.Group(channelName).SendAsync("joined", store);
    }
    
    public async Task NextStory()
    {
        var room = Store.GetRoomForUser(Context.ConnectionId);
        Store.NextStory(Context.ConnectionId, room);
        var store = Store.GetRoomStore(room);
        await Clients.Group(room).SendAsync("next_story", store);
        // await Groups.AddToGroupAsync(Context.ConnectionId, channelName);
        //
        // _store.AddToRoom(Context.ConnectionId, channelName);
        // var store = _store.GetRoomStore(channelName);
        // await Clients.Group(channelName).SendAsync("joined", store);
    }
}