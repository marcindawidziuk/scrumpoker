// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
import socket from "./socket"
const urlParams = new URLSearchParams(window.location.search);
// const channelName = urlParams.get('channel');
// const channelName = document.URL.substr(0,document.URL.lastIndexOf('/'));
const channelName = window.channelRoomId;
const userName = urlParams.get('name');

let channel = socket.channel('room:'+ channelName +':lobby', {}); // connect to chat "room"

channel.join(); // join the channel.

Vue.filter('moment-ago', function (date) {
    var b = new Date();
    var difference = (b - date) / 1000;

    if (difference > 60){
        return "offline" + difference;
    }
    return "online" + difference;
});

let app = new Vue({
    el: '#app',
    data: {
        userName: "",
        channelName: channelName,
        message: 'Hello Vue!',
        isShowingVotes: false,
        votes: {},
        users: [],
        myVote: null
    },
    created: function () {
        this.userName = userName;
        setInterval(function(){ app.ping(); }, 30000);

        channel.push('joined', { // send the message to the server on "shout" channel
            name: this.userName     // get value of "name" of person sending the message
        });

        channel.on('voted', function (payload) { // listen to the 'shout' event
            console.log(payload.name + " voted");
            app.$set(app.votes, payload.name, payload.message);
        });

        channel.on('show_votes', function (payload) { // listen to the 'shout' event
            console.log('show_votes');
            app.isShowingVotes = true
        });

        channel.on('clear_votes', function (payload) { // listen to the 'shout' event
            console.log('clear_votes');
            app.isShowingVotes = false;
            app.votes = {};
            app.myVote = null;
        });
    },
    methods: {
        markOnline: function (userName) {
            if (app.users.some(x => x.name === userName) === false){
                app.users.push({name: userName, time: new Date()})
            }
        },
        vote: function (message) {
            channel.push('voted', { // send the message to the server on "shout" channel
                name: this.userName,     // get value of "name" of person sending the message
                message: message// get message text (value) from msg input field.
            });
            this.myVote = message;
        },
        showVotes: function () {
            channel.push('show_votes', { // send the message to the server on "shout" channel
                name: this.userName,     // get value of "name" of person sending the message
            });
        },
        clearVotes: function () {
            channel.push('clear_votes', { // send the message to the server on "shout" channel
                name: this.userName,     // get value of "name" of person sending the message
            });
        },
        ping: function () {
            channel.push('ping', { // send the message to the server on "shout" channel
                name: this.userName,     // get value of "name" of person sending the message
            });
        }
    },
    computed: {
        canVote: function() {
            return (this.isShowingVotes && this.votes[this.userName] !== undefined) === false;
        }
    }
});

channel.on('ping', function (payload) { // listen to the 'shout' event
    console.log('ping from ' + payload.name);
    app.markOnline(payload.name)
});

channel.on('joined', function (payload) {
    console.log('user ' + payload.name + ' joined');
    app.ping();

    if (app.myVote != null){
        channel.push('voted', { 
            name: app.userName, 
            message: app.myVote 
        });
    }
});

    
