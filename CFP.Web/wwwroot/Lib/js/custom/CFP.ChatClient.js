CFP.ChatClient = new function () {

    let connection = null;
    let currentUserId = null;

    //---------------------------------------------------------
    // Start SignalR Connection
    //---------------------------------------------------------
    this.StartConnection = function (userId) {
        currentUserId = userId;

        connection = new signalR.HubConnectionBuilder()
            .withUrl("/chathub")   // FIXED: removed stray '}'
            .withAutomaticReconnect()
            .build();

        //-----------------------------------------------------
        // Handle received messages
        //-----------------------------------------------------
        connection.on("ReceiveMessage", (msg) => {
            // msg = { MessageId, FromUserId, ToUserId, Message, SentAt, IsOwnMessage }

            // 1) Show desktop notification
            if (!msg.isOwnMessage) {
                this.ShowNotification(`New message from ${msg.FromUserId}`, msg.Message);
            }

            // 2) Show in chat UI
            this.AppendMessageToChat(msg);
        });

        //-----------------------------------------------------
        // Handle user online/offline (optional)
        //-----------------------------------------------------
        connection.on("UserOnline", (userId) => {
            $(`#user-${userId}`).addClass("online-dot");
        });

        //-----------------------------------------------------
        // Connect
        //-----------------------------------------------------
        connection.start()
            .then(() => console.log("ChatHub Connected"))
            .catch(err => console.error("ChatHub Error:", err));
    };


    //---------------------------------------------------------
    // Append incoming/outgoing message to chat window (UI)
    //---------------------------------------------------------
    this.AppendMessageToChat = function (msg) {

        let time = new Date(msg.SentAt).toLocaleTimeString();

        let html = "";

        if (msg.isOwnMessage) {
            html = `
                <div class="my-message">
                    <div class="msg-text">${msg.Message}</div>
                    <div class="msg-time">${time}</div>
                </div>`;
        } else {
            html = `
                <div class="their-message">
                    <div class="msg-text">${msg.Message}</div>
                    <div class="msg-time">${time}</div>
                </div>`;
        }

        $("#users-conversation").append(html);
        $("#users-conversation").scrollTop($("#users-conversation")[0].scrollHeight);
    };


    //---------------------------------------------------------
    // Desktop Notification
    //---------------------------------------------------------
    this.ShowNotification = function (title, msg) {
        if (!("Notification" in window)) return;

        if (Notification.permission === "granted") {
            new Notification(title, { body: msg, icon: "/images/chat.png" });
        }
        else if (Notification.permission !== "denied") {
            Notification.requestPermission();
        }
    };


    //---------------------------------------------------------
    // Send private message via hub
    //---------------------------------------------------------
    this.SendPrivateMessage = async function (receiverId, msg) {
        connection.invoke("SendMessage", toUserId, message)
            .then(() => {
                loadUserList();  // <— Refresh chat list dynamically
            });


    };
    function loadUserList() {
        $.get("/Chat/GetChatUsers", function (data) {
            renderChatUserList(data);
        });
    }


    //---------------------------------------------------------
    // Old function preserved for compatibility (room chat)
    //---------------------------------------------------------
    this.SendRoomMessage = async function (roomId, msg) {   
        await connection.invoke("SendRoomMessage", roomId, msg);
    };


    //---------------------------------------------------------
    // Public exports
    //---------------------------------------------------------
    return {
        StartConnection: this.StartConnection,
        SendPrivateMessage: this.SendPrivateMessage,
        SendRoomMessage: this.SendRoomMessage
    };

};
