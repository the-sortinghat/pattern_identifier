CREATE
(Pingr:System {title:'Pingr', description:'A Twitter clone for teaching purposes'}),

(Auth:Service {name:'Autenticação'}),
(User:Service {name:'Usuário'}),
(Pings:Service {name:'Pings'}),
(Likes:Service {name:'Curtir + Pongar'}),
(Follow:Service {name:'Seguir + Amigos'}),
(Chat:Service {name:'Bate Papo'}),
(Tables:Service {name:'Conteúdo'}),
(Notif:Service {name:'Notificação'}),
(Search:Service {name:'Busca'}),


(Auth)-[:BELONGS_TO]->(Pingr),
(User)-[:BELONGS_TO]->(Pingr),
(Pings)-[:BELONGS_TO]->(Pingr),
(Likes)-[:BELONGS_TO]->(Pingr),
(Follow)-[:BELONGS_TO]->(Pingr),
(Chat)-[:BELONGS_TO]->(Pingr),
(Tables)-[:BELONGS_TO]->(Pingr),
(Notif)-[:BELONGS_TO]->(Pingr),
(Search)-[:BELONGS_TO]->(Pingr),

(AuthDB:Database {name:'AuthDB', model:'document', make:'MongoDB'}),
(UserDB:Database {name:'UserDB', model:'document', make:'MongoDB'}),
(PingsDB:Database {name:'PingsDB', model:'document', make:'MongoDB'}),
(LikesDB:Database {name:'LikesDB', model:'document', make:'MongoDB'}),
(FollowDB:Database {name:'FollowDB', model:'document', make:'MongoDB'}),
(ChatDB:Database {name:'ChatDB', model:'document', make:'MongoDB'}),
(TablesDB:Database {name:'TablesDB', model:'document', make:'MongoDB'}),
(NotifDB:Database {name:'NotifDB', model:'document', make:'MongoDB'}),
(SearchDB:Database {name:'SearchDB', model:'document', make:'MongoDB'}),


(Auth)-[:USES {role:'main storage', namespace:'default'}]->(AuthDB),
(User)-[:USES {role:'main storage', namespace:'default'}]->(UserDB),
(Follow)-[:USES {role:'main storage', namespace:'default'}]->(FollowDB),
(Chat)-[:USES {role:'main storage', namespace:'default'}]->(ChatDB),
(Likes)-[:USES {role:'main storage', namespace:'default'}]->(LikesDB),
(Tables)-[:USES {role:'main storage', namespace:'default'}]->(TablesDB),
(Notif)-[:USES {role:'main storage', namespace:'default'}]->(NotifDB),
(Search)-[:USES {role:'main storage', namespace:'default'}]->(SearchDB),
(Pings)-[:USES {role:'main storage', namespace:'default'}]->(PingsDB),

(GetAllUsers:Operation {verb:'POST', uri:'/users'}),
(GetOneUser:Operation {verb:'GET', uri:'/users/:id'}),
(UpdateOneUser:Operation {verb:'PUT', uri:'/users/:id'}),
(DeleteOneUser:Operation {verb:'DELETE', uri:'/users/:id'}),
(UpdateOneUserVisibility:Operation {verb:'PUT', uri:'/users/:id/visibility'}),


(User)-[:EXPOSES]->(GetAllUsers)<-[:PROXIES_TO]-(Auth),
(User)-[:EXPOSES]->(GetOneUser)<-[:PROXIES_TO]-(Auth),
(User)-[:EXPOSES]->(UpdateOneUser)<-[:PROXIES_TO]-(Auth),
(User)-[:EXPOSES]->(DeleteOneUser)<-[:PROXIES_TO]-(Auth),
(User)-[:EXPOSES]->(UpdateOneUserVisibility)<-[:PROXIES_TO]-(Auth),

(CreatePing:Operation {verb:'POST', uri:'/users/:uid/pings'}),
(DeletePing:Operation {verb:'DELETE', uri:'/users/:uid/pings/:pid'}),
(UpdatePingVisibility:Operation {verb:'PUT', uri:'/users/:uid/pings/:pid/visibility'}),


(Pings)-[:EXPOSES]->(CreatePing)<-[:PROXIES_TO]-(Auth),
(Pings)-[:EXPOSES]->(DeletePing)<-[:PROXIES_TO]-(Auth),
(Pings)-[:EXPOSES]->(UpdatePingVisibility)<-[:PROXIES_TO]-(Auth),

(RequestFollow:Operation {verb:'POST', uri:'/users/:uid/follow_requests'}),
(ResolveFollowRequest:Operation {verb:'PUT', uri:'/follow_requests/:frid'}),
(UpdateSpecialFriends:Operation {verb:'PUT', uri:'/users/:uid/special_friends'}),


(Follow)-[:EXPOSES]->(RequestFollow)<-[:PROXIES_TO]-(Auth),
(Follow)-[:EXPOSES]->(ResolveFollowRequest)<-[:PROXIES_TO]-(Auth),
(Follow)-[:EXPOSES]->(UpdateSpecialFriends)<-[:PROXIES_TO]-(Auth),

(LikePing:Operation {verb:'POST', uri:'/pings/:pid/likes'}),
(RemoveLike:Operation {verb:'DELETE', uri:'/pings/:pid/likes/:lid'}),
(PongPing:Operation {verb:'POST', uri:'/pings/:pid/pongs'}),
(RemovePong:Operation {verb:'DELETE', uri:'/pings/:pid/pongs/:poid'}),


(Likes)-[:EXPOSES]->(LikePing)<-[:PROXIES_TO]-(Auth),
(Likes)-[:EXPOSES]->(RemoveLike)<-[:PROXIES_TO]-(Auth),
(Likes)-[:EXPOSES]->(PongPing)<-[:PROXIES_TO]-(Auth),
(Likes)-[:EXPOSES]->(RemovePong)<-[:PROXIES_TO]-(Auth),

(GetPrimaryTable:Operation {verb:'GET', uri:'/users/:uid/primary_table'}),
(CreateSecondaryTable:Operation {verb:'POST', uri:'/users/:uid/secondary_tables'}),
(GetSecondaryTable:Operation {verb:'GET', uri:'/users/:uid/secondary_tables/:tid'}),
(UpdateSecondaryTable:Operation {verb:'PUT', uri:'/users/:uid/secondary_tables/:tid'}),


(Tables)-[:EXPOSES]->(GetPrimaryTable)<-[:PROXIES_TO]-(Auth),
(Tables)-[:EXPOSES]->(CreateSecondaryTable)<-[:PROXIES_TO]-(Auth),
(Tables)-[:EXPOSES]->(GetSecondaryTable)<-[:PROXIES_TO]-(Auth),
(Tables)-[:EXPOSES]->(UpdateSecondaryTable)<-[:PROXIES_TO]-(Auth),

(GetTgH:Operation {verb:'GET', uri:'/tgn/here'}),
(GetTgW:Operation {verb:'GET', uri:'/tgn/world'}),
(DeploySearch:Operation {verb:'GET', uri:'/search'}),


(Search)-[:EXPOSES]->(GetTgH)<-[:PROXIES_TO]-(Auth),
(Search)-[:EXPOSES]->(GetTgW)<-[:PROXIES_TO]-(Auth),
(Search)-[:EXPOSES]->(DeploySearch)<-[:PROXIES_TO]-(Auth),

(GetAllChats:Operation {verb:'GET', uri:'/users/:uid/chats'}),
(CreateChat:Operation {verb:'POST', uri:'/users/:uid/chats'}),
(GetDPsFromChat:Operation {verb:'GET', uri:'/users/:uid/chats/:cid'}),
(SendDP:Operation {verb:'POST', uri:'/users/:uid/chats/:cid'}),


(Chat)-[:EXPOSES]->(GetAllChats)<-[:PROXIES_TO]-(Auth),
(Chat)-[:EXPOSES]->(CreateChat)<-[:PROXIES_TO]-(Auth),
(Chat)-[:EXPOSES]->(GetDPsFromChat)<-[:PROXIES_TO]-(Auth),
(Chat)-[:EXPOSES]->(SendDP)<-[:PROXIES_TO]-(Auth),

(GetNotifications:Operation {verb:'GET', uri:'/users/:uid/notifications'}),
(MarkNotificationAsRead:Operation {verb:'PUT', uri:'/users/:uid/notifications/:nid'}),


(Notif)-[:EXPOSES]->(GetNotifications)<-[:PROXIES_TO]-(Auth),
(Notif)-[:EXPOSES]->(MarkNotificationAsRead)<-[:PROXIES_TO]-(Auth),

(UserNew:Channel {label:'user.new'}),
(UserID:Channel {label:'user.<id>'}),
(FollowRequestNew:Channel {label:'follow_request.new'}),
(FollowingNew:Channel {label:'following.new'}),
(UserSpecialFriends:Channel {label:'user.<id>.special_friends'}),
(UserPings:Channel {label:'user.<id>.pings'}),
(PingID:Channel {label:'ping.<id>'}),
(ChatNew:Channel {label:'chat.new'}),
(ChatID:Channel {label:'chat.<id>'}),


(User)-[:PUBLISHES_TO {event:'USER_CREATED'}]->(UserNew),
(User)-[:PUBLISHES_TO {event:'USER_UPDATED'}]->(UserID),
(User)-[:PUBLISHES_TO {event:'USER_DELETED'}]->(UserID),
(Follow)-[:PUBLISHES_TO {event:'A_REQUESTED_FOLLOWING_B'}]->(FollowRequestNew),
(Follow)-[:PUBLISHES_TO {event:'A_BEGAN_FOLLOWING_B'}]->(FollowingNew),
(Follow)-[:PUBLISHES_TO {event:'UPDATED_SPECIAL_FRIENDS'}]->(UserSpecialFriends),
(Chat)-[:PUBLISHES_TO {event:'CHAT_CREATED'}]->(ChatNew),
(Chat)-[:PUBLISHES_TO {event:'DP_SENT'}]->(ChatID),
(Pings)-[:PUBLISHES_TO {event:'PING_CREATED'}]->(UserPings),
(Pings)-[:PUBLISHES_TO {event:'PING_DELETED'}]->(PingID),
(Likes)-[:PUBLISHES_TO {event:'PING_LIKED'}]->(PingID),
(Likes)-[:PUBLISHES_TO {event:'PING_LIKE_REMOVED'}]->(PingID),
(Likes)-[:PUBLISHES_TO {event:'PING_PONGED'}]->(PingID),
(Likes)-[:PUBLISHES_TO {event:'PING_PONG_REMOVED'}]->(PingID),


(Tables)-[:SUBSCRIBES_TO]->(UserNew),
(Tables)-[:SUBSCRIBES_TO]->(UserID),
(Tables)-[:SUBSCRIBES_TO]->(FollowingNew),
(Tables)-[:SUBSCRIBES_TO]->(UserSpecialFriends),
(Tables)-[:SUBSCRIBES_TO]->(PingID),
(Auth)-[:SUBSCRIBES_TO]->(UserNew),
(Auth)-[:SUBSCRIBES_TO]->(UserID),
(Likes)-[:SUBSCRIBES_TO]->(UserNew),
(Likes)-[:SUBSCRIBES_TO]->(UserID),
(Likes)-[:SUBSCRIBES_TO]->(UserPings),
(Likes)-[:SUBSCRIBES_TO]->(PingID),
(Pings)-[:SUBSCRIBES_TO]->(UserNew),
(Pings)-[:SUBSCRIBES_TO]->(UserID),
(Notif)-[:SUBSCRIBES_TO]->(UserNew),
(Notif)-[:SUBSCRIBES_TO]->(UserID),
(Notif)-[:SUBSCRIBES_TO]->(FollowRequestNew),
(Notif)-[:SUBSCRIBES_TO]->(FollowingNew),
(Notif)-[:SUBSCRIBES_TO]->(ChatNew),
(Notif)-[:SUBSCRIBES_TO]->(ChatID),
(Chat)-[:SUBSCRIBES_TO]->(UserNew),
(Chat)-[:SUBSCRIBES_TO]->(UserID),
(Chat)-[:SUBSCRIBES_TO]->(FollowingNew),
(Follow)-[:SUBSCRIBES_TO]->(UserNew),
(Follow)-[:SUBSCRIBES_TO]->(UserID);
