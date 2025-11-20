CFP.ChatClient = new function () {

    let selectedUserId = null;
    let connection = null;
    let currentUserId = parseInt($("#currentUserId").val());
    currentChatType = null;   // IMPORTANT
    currentRoomId = null;          // Reset room

    //---------------------------------------------------------
    // Start SignalR Connection
    //---------------------------------------------------------
    this.StartConnection = function () {

        connection = new signalR.HubConnectionBuilder()
            .withUrl("/chathub", {
                withCredentials: true
            })
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

        connection.on("ReceiveRoomMessage", function (message) {

            let isOwn = (message.fromUserId === currentUserId);

            // Only show if user is inside this room right now
            if (currentChatType === "room" && message.chatRoomId === currentRoomId) {
                $("#users-conversation").append(
                    CFP.ChatClient.BuildMessageHtml(message.message, message.sentAt, isOwn)
                );
                CFP.ChatClient.ScrollBottom();
            }

            // Optional: If user is NOT in room, increase unread badge
            else {
                CFP.ChatClient.IncreaseRoomBadge(message.chatRoomId);
            }
        });

        connection.on("ForceLogout", () => {
            console.log("Your session has expired. Logging out...");
            window.location.href = "/Account/Logout";
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
							<li class="chat-user-item" id="private${u.userId}" onclick="CFP.ChatClient.OpenChat(${u.userId}, '${u.userName}', ${u.isOnline})"		>
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
                        $(".member-count").text("Online");   // Show Online in member-count                        
                    } else {
                        $(".user-own-img").removeClass("online");
                        $(".member-count").text("Offline");  // Show Offline
                    }
                }
            });

            $("#chatUserList").html(html);
            $("#private" + selectedUserId).addClass("active");
            // If there is at least one user, load their messages
            if (users.length > 0) {
                CFP.ChatClient.LoadMessages();
            }
        });
    }

    this.OpenChat = function (userId, name, isOnline) {
        currentChatType = "private";   // IMPORTANT
        currentRoomId = null;          // Reset room
        selectedUserId = userId;
        $(".username").text(name);
        CFP.ChatClient.LoadMessages();
        CFP.ChatClient.RemoveUnreadBadge(userId);
        $(".chat-user-item").removeClass("active");
        $(".channel-item").removeClass("active");
        $("#private" + userId).addClass("active");
        $(".user-own-img img").attr("src", "/assets/images/users/user-dummy-img.jpg");
        if (isOnline) {
            $(".user-own-img").addClass("online");
            $(".member-count").text("Online");   // Show Online in member-count
        } else {
            $(".user-own-img").removeClass("online");
            $(".member-count").text("Offline");  // Show Offline
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

        const msgDate = new Date(msg.sentAt);
        const now = new Date(new Date().toLocaleString("en-US", CFP.Common.TimeZoneOptions));

        // Format time
        let time = msgDate.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', hour12: true });

        // Check if message is today or yesterday
        let dateLabel = "";
        const isToday = msgDate.toDateString() === now.toDateString();
        const yesterday = now;
        yesterday.setDate(now.getDate() - 1);
        const isYesterday = msgDate.toDateString() === yesterday.toDateString();

        if (isToday) {
            dateLabel = "Today";
        } else if (isYesterday) {
            dateLabel = "Yesterday";
        } else {
            dateLabel = msgDate.toLocaleDateString(); // fallback to full date
        }

        let html = "";

        if (msg.isOwnMessage) {
            html = `
			<li class="right">
				<div class="conversation-list">
					<div class="user-chat-content">
						<div class="ctext-wrap">
							<div class="ctext-wrap-content">${msg.message}</div>
						</div>
						<small class="text-muted">${dateLabel}, ${time}</small>
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
						<small class="text-muted ms-1">${dateLabel}, ${time}</small>
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
        if (currentChatType === "room") {
            CFP.ChatClient.SendRoomMessage();
        } else {

            let text = $("#chatInput").val().trim();
            if (!text || !selectedUserId) return;

            CFP.ChatClient.AppendMessageToChat({
                fromUserId: currentUserId,
                toUserId: selectedUserId,
                message: text,
                sentAt: new Date(new Date().toLocaleString("en-US", CFP.Common.TimeZoneOptions)),
                isOwnMessage: true
            });

            CFP.ChatClient.ScrollBottom();
            connection.invoke("SendMessage", selectedUserId, text);
            $("#chatInput").val("");
        }
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
                <li id="channel-${r.chatRoomId}" data-name="channel" data-roomid="${r.chatRoomId}"  class="channel-item">
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
    //$("#btnCreateRoom").click(function () {
    //    $("#roomNameInput").val("");
    //    $('.select2').select2({
    //        dropdownParent: $('#createRoomModal')
    //    });
    //    $("#createRoomModal").modal("show");
    //});

    this.AddRoom = function (id = '') {
        debugger;
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Chat/_RoomDetails"),
            data: {
                id: id
            },
            success: function (data) {
                $("#common-dialogContent").html(data);
                $.validator.unobtrusive.parse($("#roomForm"));
                $("#common-dialog").modal('show');
                $(".preloader").hide();
                $('.select2').select2({
                    dropdownParent: $('#common-dialog')
                });

            }
        })
    }

    this.SaveRoom = function () {

        if ($("#roomForm").valid()) {
            $(".preloader").show();
            var formdata = $("#roomForm").serialize();
            $.ajax({
                type: "Post",
                url: UrlContent("Chat/SaveRoom/"),
                data: formdata,
                success: function (result) {
                    $(".preloader").hide();
                    if (result.isSuccess) {
                        CFP.Common.ToastrSuccess(result.message);
                        $("#common-dialog").modal("hide");
                        debugger;
                        CFP.ChatClient.LoadRooms();
                        CFP.ChatClient.OpenRoom(result.chatRoomId);

                    } else {
                        CFP.Common.ToastrError(result.message);
                    }
                },
            })
        }
    }

    this.DeleteRoom = function (id) {
        Swal.fire({
            title: '<h4>Are you sure want to delete this channel?</h4>',
            html: '',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#f33c02',
            cancelButtonColor: '#a1aab2',
            confirmButtonText: '<i class="mdi mdi-trash-can"></i> Delete',
            cancelButtonText: '<i class="mdi mdi-cancel"></i> Cancel'
        }).then((result) => {
            if (result.value) {
                $('.preloader').show();
                $.ajax({
                    type: "POST",
                    url: UrlContent("Chat/Delete"),
                    data: {
                        id: id,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
                            CFP.Common.ToastrSuccess(result.message);
                            window.location.reload();
                        }
                        else {
                            CFP.Common.ToastrError(result.message);
                        }
                    }
                })
            }
        });
    }


    //// CREATE ROOM
    //$("#btnSaveRoom").click(function () {
    //    const roomName = $("#roomName").val();
    //    const users = $("#roomUsers").val(); // array of userIds

    //    $.ajax({
    //        url: "/chat/createroom",
    //        type: "POST",
    //        data: { roomName, users },
    //        success: function (res) {
    //            $("#createRoomModal").modal("hide");
    //            $("#roomName").val("");                // clear room name
    //            $("#roomUsers").val(null).trigger('change'); // clear select2 values
    //            CFP.ChatClient.LoadRooms(); // refresh list
    //        }
    //    });
    //});


    $(document).on("click", ".channel-item", function () {
        let roomId = $(this).data("roomid");
        CFP.ChatClient.OpenRoom(roomId);
    });

    this.SendRoomMessage = function () {

        let msg = $("#chatInput").val().trim();
        if (!msg || !currentRoomId) return;

        let payload = {
            chatRoomId: currentRoomId,
            message: msg,
            fromUserId: currentUserId
        };

        // Send to Hub
        connection.invoke("SendRoomMessage", payload);

        // Clear input
        $("#chatInput").val("");

        // Show own message instantly
        CFP.ChatClient.AppendMessageToChat({
            fromUserId: currentUserId,
            message: msg,
            sentAt: new Date(new Date().toLocaleString("en-US", CFP.Common.TimeZoneOptions)),
            isOwnMessage: true
        });

        CFP.ChatClient.ScrollBottom();
    };
    this.OpenRoom = function (roomId) {
        debugger;
        currentChatType = "room";     // NEW FLAG
        currentRoomId = roomId;       // SET SELECTED ROOM
        selectedUserId = null;
        // Highlight selected room
        $(".chat-user-item").removeClass("active");
        $(".channel-item").removeClass("active");
        $(`.channel-item[data-roomid='${roomId}']`).addClass("active");
        $(".user-own-img img").attr("src", "/assets/images/users/multi-user.jpg");

        // Load room messages
        $.get("/chat/getroommessages?roomId=" + roomId, function (messages) {

            let html = "";

            messages.forEach(m => {
                let isOwn = (m.fromUserId === currentUserId);

                html += CFP.ChatClient.BuildMessageHtml(
                    m.message,
                    m.sentAt,
                    isOwn,
                    m.senderName
                );
            });

            $("#users-conversation").html(html);
            CFP.ChatClient.ScrollBottom();
        });
        debugger;
        // Load room name in header
        $.get("/chat/getroom?roomId=" + roomId, function (room) {
            debugger;
            $(".username").text(room.roomName);
            $(".member-count").text("Members: " + room.memberCount);
            if (room.isShowActionBtn) {
                CFP.ChatClient.RenderRoomDropdown(room);
            }
        });

    };


    this.BuildMessageHtml = function (message, sentAt, isOwn, senderName) {

        const msgMoment = moment(sentAt);
        const now = moment();

        // Format time
        let time = msgMoment.format("hh:mm A");

        // Determine date label
        let dateLabel = "";
        if (msgMoment.isSame(now, 'day')) {
            dateLabel = "Today";
        } else if (msgMoment.isSame(moment().subtract(1, 'days'), 'day')) {
            dateLabel = "Yesterday";
        } else {
            dateLabel = msgMoment.format("MMM D, YYYY"); // e.g., Nov 18, 2025
        }

        if (isOwn) {
            return `
     <li class="right">
         <div class="conversation-list">
             <div class="user-chat-content">                 
                 <div class="ctext-wrap">
                     <div class="ctext-wrap-content">
                         ${message}
                     </div>
                 </div>

                 <div><small class="text-muted">${dateLabel}, ${time}</small></div>

             </div>
         </div>
     </li>`;
        } else {
            return `
     <li>
         <div class="conversation-list">

             <div class="chat-avatar">
                 <img src="/assets/images/users/user-dummy-img.jpg" class="rounded-circle avatar-xs" />
             </div>

             <div class="user-chat-content">
                 <div class="text-muted d-block pb-1">${senderName} </div>
                 <div class="ctext-wrap">
                     <div class="ctext-wrap-content">
                         ${message}
                     </div>
                 </div>
                 <small class="text-muted ms-1">${dateLabel}, ${time}</small>
             </div>

         </div>
     </li>`;
        }
    };


    this.RenderRoomDropdown = function (room) {
        debugger;
        let html = `
        <div class="dropdown">
           <button class="btn btn-ghost-secondary btn-icon" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-more-vertical icon-sm"><circle cx="12" cy="12" r="1"></circle><circle cx="12" cy="5" r="1"></circle><circle cx="12" cy="19" r="1"></circle></svg>
                                                                    </button>

            <div class="dropdown-menu dropdown-menu-end">
                <a class="dropdown-item" href="#"
                   onclick="CFP.ChatClient.AddRoom('${room.encChatRoomId}')">
                    <i class="ri-edit-2-line align-bottom text-muted me-2"></i> Edit Room
                </a>

                <a class="dropdown-item text-danger" href="#"
                  onclick="CFP.ChatClient.DeleteRoom('${room.encChatRoomId}')"
>
                    <i class="ri-delete-bin-5-line align-bottom me-2"></i> Delete
                </a>
            </div>
        </div>    `;

        $(".chat-header-actions").html(html);
    };




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
