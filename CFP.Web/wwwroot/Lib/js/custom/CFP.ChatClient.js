CFP.ChatClient = new function () {
    let connection = null;
    let userId = null;

    this.StartConnection = function (user) {
        userId = user;

        connection = new signalR.HubConnectionBuilder()
            .withUrl(`/chathub}`)
            .withAutomaticReconnect()
            .build();

        // Listen for private message
        connection.on("ReceivePrivateMessage", (from, message, time) => {
            this.ShowNotification(`New message from ${from}`, message);
        });

        // Listen for room message
        connection.on("ReceiveRoomMessage", (room, from, message, time) => {
            this.ShowNotification(`[${room}] ${from}`, message);
        });

        connection.start().catch(err => console.error(err));
    }

    this.ShowNotification = function (title, msg) {
        if (!("Notification" in window)) return;

        if (Notification.permission === "granted") {
            new Notification(title, { body: msg, icon: "/images/chat.png" });
        } else if (Notification.permission !== "denied") {
            Notification.requestPermission();
        }
    }

    this.SendPrivateMessage = async function (receiverId,msg) {
        await connection.invoke("SendPrivateMessage", receiverId, msg);
    }
    this.SendRoomMessage = async function (roomId, msg) {
        await connection.invoke("SendRoomMessage", roomId, msg);
    }

    return { StartConnection };
}