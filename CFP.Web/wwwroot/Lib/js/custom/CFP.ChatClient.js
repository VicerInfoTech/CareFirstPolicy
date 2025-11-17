CFP.ChatClient = new function () {

    let selectedUserId = null;
    let connection = null;
    let currentUserId = parseInt($("#currentUserId").val());


    //---------------------------------------------------------
    // Start SignalR Connection
    //---------------------------------------------------------
    this.StartConnection = function () {

        connection = new signalR.HubConnectionBuilder()
            .withUrl("/chathub")
            .withAutomaticReconnect()
            .build();

        // Receive message
        connection.on("ReceiveMessage", function (msg) {

            if (selectedUserId && selectedUserId === msg.fromUserId) {
                CFP.ChatClient.AppendMessageToChat(msg);
                setTimeout(CFP.ChatClient.ScrollBottom, 50);

                $.get("/Chat/MarkMessagesRead", { targetUserId: msg.fromUserId });

                CFP.ChatClient.RemoveUnreadBadge(msg.fromUserId);
            }
            else {
                CFP.ChatClient.IncreaseUnreadCount(msg.fromUserId);
            }

            CFP.ChatClient.UpdateLastMessageInSidebar(msg);
        });

        connection.start()
            .then(() => console.log("SignalR Connected"))
            .catch(err => console.error(err));
    }

    this.IncreaseUnreadCount = function (userId) {
        debugger;
        const row = $(`#chatUserList .chat-user-item`).filter(function () {
            return $(this).attr("onclick") && $(this).attr("onclick").indexOf(`CFP.ChatClient.OpenChat(${userId},`) !== -1;
        });

        if (!row || row.length === 0) return;

        let badge = row.find(".unread-badge");
        if (badge.length === 0) {
            row.find("a").append(`<div class="ms-auto"><span class="badge bg-dark-subtle text-body rounded p-1 unread-badge">1</span></div>`);
        } else {
            let count = parseInt(badge.text() || "0");
            badge.text(count + 1);
        }
    }

    this.UpdateLastMessageInSidebar = function (msg) {
        const row = $(`#chatUserList .chat-user-item`).filter(function () {
            return $(this).attr("onclick") && $(this).attr("onclick").indexOf(`CFP.ChatClient.OpenChat(${msg.fromUserId},`) !== -1;
        });

        if (!row || row.length === 0) return;
        row.find("p.small.text-muted").text(msg.message ?? "");
        row.find("small.text-muted").first().text(new Date(msg.sentAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', hour12: true }));
    }

    this.LoadUserList = function () {

        $.get("/Chat/GetChatUsers", function (users) {

            let html = "";

            users.forEach((u, index) => {
                html += `
							<li class="chat-user-item" onclick="CFP.ChatClient.OpenChat(${u.userId}, '${u.userName}', ${u.isOnline})"		>
						<a class="d-flex align-items-center" href="javascript:void(0)">

							 <!-- Theme Avatar + Status -->
					<div class="chat-user-img me-2 ${u.isOnline ? "online" : ""}">
							<img src="/assets/images/users/user-dummy-img.jpg"
								 class="rounded-circle avatar-xs" />
							<span class="user-status"></span>
						</div>

						<div class="flex-grow-1">
							<h6 class="mb-0">${u.userName}</h6>

						</div>



						<div class="ms-auto">
							${u.unreadCount > 0
                        ? `<span class="badge bg-dark-subtle text-body rounded p-1 unread-badge">${u.unreadCount}</span>`
                        : ``
                    }
						</div>

						</a>
					</li>`;
                if (index === 0) {
                    selectedUserId = u.userId;
                    $(".username").text(u.userName);
                    if (u.isOnline) {
                        $(".user-own-img").addClass("online");
                    } else {
                        $(".user-own-img").removeClass("online");
                    }
                }
            });

            $("#chatUserList").html(html);
            // If there is at least one user, load their messages
            if (users.length > 0) {
                CFP.ChatClient.LoadMessages();
            }
        });
    }

    this.OpenChat = function (userId, name, isOnline) {
        selectedUserId = userId;
        $(".username").text(name);
        CFP.ChatClient.LoadMessages();
        CFP.ChatClient.RemoveUnreadBadge(userId);
        if (isOnline) {
            $(".user-own-img").addClass("online");
        } else {
            $(".user-own-img").removeClass("online");
        }
    }


    this.LoadMessages = function () {
        if (!selectedUserId) return;

        $.get(`/Chat/GetMessages?targetUserId=${selectedUserId}`, function (msgs) {

            $("#users-conversation").html("");

            msgs.forEach(m => CFP.ChatClient.AppendMessageToChat(m));

            setTimeout(CFP.ChatClient.ScrollBottom, 100);
            CFP.ChatClient.RemoveUnreadBadge(selectedUserId);
        });
    }

    this.RemoveUnreadBadge = function (userId) {
        const row = $(`#chatUserList .chat-user-item`).filter(function () {
            return $(this).attr("onclick")?.includes(`CFP.ChatClient.OpenChat(${userId},`);
        });

        row.find(".unread-badge").remove();

    }

    this.AppendMessageToChat = function (msg) {

        let time = new Date(msg.sentAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', hour12: true });


        let html = "";

        if (msg.isOwnMessage) {
            html = `
				<li class="right">
					<div class="conversation-list">
						<div class="user-chat-content">
							<div class="ctext-wrap">
								<div class="ctext-wrap-content">${msg.message}</div>
							</div>
							<div><small class="text-muted">${time}</small></div>
						</div>
					</div>
				</li>`;
        } else {
            html = `
				<li>
					<div class="conversation-list">
						<div class="chat-avatar">
							<img src="/assets/images/users/user-dummy-img.jpg" class="rounded-circle avatar-xs" />
						</div>
						<div class="user-chat-content">
							<div class="ctext-wrap">
								<div class="ctext-wrap-content">${msg.message}</div>
							</div>
							<div><small class="text-muted">${time}</small></div>
						</div>
					</div>
				</li>`;
        }

        $("#users-conversation").append(html);
    }


    //this.ScrollBottom = function () {
    //    let div = document.getElementById("chat-conversation");
    //    div.scrollTop = div.scrollHeight;
    //}
    this.SendPrivateMessage = function () {
        let text = $("#chatInput").val().trim();
        if (!text || !selectedUserId) return;

        CFP.ChatClient.AppendMessageToChat({
            fromUserId: currentUserId,
            toUserId: selectedUserId,
            message: text,
            sentAt: new Date(),
            isOwnMessage: true
        });

        CFP.ChatClient.ScrollBottom();
        connection.invoke("SendMessage", selectedUserId, text);
        $("#chatInput").val("");
    }

    this.ScrollBottom = function () {
        const wrapper = document.querySelector("#chat-conversation .simplebar-content-wrapper");
        if (wrapper) {
            wrapper.scrollTop = wrapper.scrollHeight;
        }
    }

    this.LoadContacts = function () {
        $.get("/chat/getcontacts", function (contacts) {
            let html = "";
            const grouped = {};
            
            contacts.forEach(c => {
                const letter = c.name[0].toUpperCase();
                if (!grouped[letter]) grouped[letter] = [];
                grouped[letter].push(c);
            });

            Object.keys(grouped).sort().forEach(letter => {
                html += `
						<li class="mt-3 mb-1">
							<div class="text-muted text-uppercase fs-12">${letter}</div>
						</li>
					`;

                grouped[letter].forEach(c => {
                    const initials = c.name
                        .split(" ").map(x => x[0]).join("").substring(0, 2).toUpperCase();

                    const img =
                        `<div class="chat-user-img me-2 ${c.isOnline ? "online" : ""}">
							<img src="/assets/images/users/user-dummy-img.jpg"
								 class="rounded-circle avatar-xs" />
							<span class="user-status"></span>
						</div>`
                        //   `<img src="assets/images/users/user-dummy-img.jpg" class="avatar-xs rounded-circle">`;

                    html += `
							<li onclick="CFP.ChatClient.OpenChat(${c.contactUserId}, '${c.name}', ${c.isOnline})">
								<div class="d-flex align-items-center">
									<div class="flex-shrink-0 me-2">${img}</div>
									<div class="flex-grow-1">
										<p class="text-truncate mb-0 fs-14">${c.name}</p>
									</div>
								</div>
							</li>`;
                });
            });

            $("#contactList").html(html);
        });
    }


  
    this.LoadRooms = function () {
        $.get("/chat/getrooms", function (rooms) {

            let html = "";

            rooms.forEach(r => {

                html += `
                <li id="channel-${r.chatRoomId}" data-name="channel" class="channel-item">
                    <a href="javascript:void(0);">
                        <div class="d-flex align-items-center">
                            
                            <!-- Icon -->
                            <div class="flex-shrink-0 chat-user-img align-self-center me-2 ms-0">
                                <div class="avatar-xxs">
                                    <div class="avatar-title bg-light rounded-circle text-body">#</div>
                                </div>
                            </div>

                            <!-- Room Name -->
                            <div class="flex-grow-1 overflow-hidden">
                                <p class="text-truncate mb-0">${r.roomName}</p>
                            </div>

                            <!-- Unread Count Placeholder -->
                            <div>
                                <div class="flex-shrink-0 ms-2">
                                    <span class="badge bg-dark-subtle text-body rounded p-1 d-none" id="room-unread-${r.chatRoomId}">
                                        0
                                    </span>
                                </div>
                            </div>

                        </div>
                    </a>
                </li>
            `;
            });

            $("#channelList").html(html);
        });
    }


    // OPEN MODAL
    $("#btnCreateRoom").click(function () {
        $("#roomNameInput").val("");
        $("#createRoomModal").modal("show");
    });

    // CREATE ROOM
    $("#btnSaveRoom").click(function () {
        const roomName = $("#roomName").val();
        const users = $("#roomUsers").val(); // array of userIds

        $.ajax({
            url: "/chat/createroom",
            type: "POST",
            data: { roomName, users },
            success: function (res) {
                $("#createRoomModal").modal("hide");
                CFP.ChatClient.LoadRooms(); // refresh list
            }
        });
    });


    $(document).on("click", ".channel-item", function () {
        let roomId = $(this).data("roomid");
        CFP.ChatClient.OpenRoom(roomId);
    });

    window.addEventListener("beforeunload", function () {
        if (connection && connection.connectionId) {

            const payload = JSON.stringify({ connectionId: connection.connectionId });

            navigator.sendBeacon(
                "/Chat/RemoveConnection",
                new Blob([payload], { type: "application/json" })
            );
        }
    });


};
