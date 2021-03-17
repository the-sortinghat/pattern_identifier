CREATE (Pingr:System {title:'Pingr', description:'A Twitter clone for teaching purposes'})

CREATE (Auth:Service {name:'Autenticação'})
CREATE (User:Service {name:'Usuário'})
CREATE (Pings:Service {name:'Pings'})
CREATE (Likes:Service {name:'Curtir + Pongar'})
CREATE (Follow:Service {name:'Seguir + Amigos'})
CREATE (Chat:Service {name:'Bate Papo'})
CREATE (Tables:Service {name:'Conteúdo'})
CREATE (Notif:Service {name:'Notificação'})
CREATE (Search:Service {name:'Busca'})

CREATE (AuthDB:Database {name:'AuthDB', model:'document', make:'MongoDB'})
CREATE (UserDB:Database {name:'UserDB', model:'document', make:'MongoDB'})
CREATE (PingsDB:Database {name:'PingsDB', model:'document', make:'MongoDB'})
CREATE (LikesDB:Database {name:'LikesDB', model:'document', make:'MongoDB'})
CREATE (FollowDB:Database {name:'FollowDB', model:'document', make:'MongoDB'})
CREATE (ChatDB:Database {name:'ChatDB', model:'document', make:'MongoDB'})
CREATE (TablesDB:Database {name:'TablesDB', model:'document', make:'MongoDB'})
CREATE (NotifDB:Database {name:'NotifDB', model:'document', make:'MongoDB'})
CREATE (SearchDB:Database {name:'SearchDB', model:'document', make:'MongoDB'})

CREATE
(Auth)-[:SVC_BLONGS_TO_SYS]->(Pingr),
(User)-[:SVC_BLONGS_TO_SYS]->(Pingr),
(Pings)-[:SVC_BLONGS_TO_SYS]->(Pingr),
(Likes)-[:SVC_BLONGS_TO_SYS]->(Pingr),
(Follow)-[:SVC_BLONGS_TO_SYS]->(Pingr),
(Chat)-[:SVC_BLONGS_TO_SYS]->(Pingr),
(Tables)-[:SVC_BLONGS_TO_SYS]->(Pingr),
(Notif)-[:SVC_BLONGS_TO_SYS]->(Pingr),
(Search)-[:SVC_BLONGS_TO_SYS]->(Pingr),

(Auth)<-[:SYS_CONTAINS_SVC]-(Pingr),
(User)<-[:SYS_CONTAINS_SVC]-(Pingr),
(Pings)<-[:SYS_CONTAINS_SVC]-(Pingr),
(Likes)<-[:SYS_CONTAINS_SVC]-(Pingr),
(Follow)<-[:SYS_CONTAINS_SVC]-(Pingr),
(Chat)<-[:SYS_CONTAINS_SVC]-(Pingr),
(Tables)<-[:SYS_CONTAINS_SVC]-(Pingr),
(Notif)<-[:SYS_CONTAINS_SVC]-(Pingr),
(Search)<-[:SYS_CONTAINS_SVC]-(Pingr),

(Auth)-[:REQUESTS_FROM {verb:'POST', uri:'/users'}]->(User),
(Auth)-[:REQUESTS_FROM {verb:'GET', uri:'/users/:id'}]->(User),
(Auth)-[:REQUESTS_FROM {verb:'PUT', uri:'/users/:id'}]->(User),
(Auth)-[:REQUESTS_FROM {verb:'DELETE', uri:'/users/:id'}]->(User),
(Auth)-[:REQUESTS_FROM {verb:'PUT', uri:'/users/:id/visibility'}]->(User),

(Auth)-[:REQUESTS_FROM {verb:'GET', uri:'/users/:id'}]->(User),
(Auth)-[:REQUESTS_FROM {verb:'PUT', uri:'/users/:id'}]->(User),
(Auth)-[:REQUESTS_FROM {verb:'DELETE', uri:'/users/:id'}]->(User),
(Auth)-[:REQUESTS_FROM {verb:'PUT', uri:'/users/:id/visibility'}]->(User),

(Auth)-[:REQUESTS_FROM {verb:'POST', uri:'/users/:uid/pings'}]->(Pings),
(Auth)-[:REQUESTS_FROM {verb:'DELETE', uri:'/users/:uid/pings/:pid'}]->(Pings),
(Auth)-[:REQUESTS_FROM {verb:'PUT', uri:'/users/:uid/pings/:pid/visibility'}]->(Pings),

(Auth)-[:REQUESTS_FROM {verb:'POST', uri:'/users/:uid/follow_requests'}]->(Follow),
(Auth)-[:REQUESTS_FROM {verb:'PUT', uri:'/follow_requests/:frid'}]->(Follow),
(Auth)-[:REQUESTS_FROM {verb:'PUT', uri:'/users/:uid/special_friends'}]->(Follow),

(Auth)-[:REQUESTS_FROM {verb:'POST', uri:'/pings/:pid/likes'}]->(Likes),
(Auth)-[:REQUESTS_FROM {verb:'DELETE', uri:'/pings/:pid/likes/:lid'}]->(Likes),
(Auth)-[:REQUESTS_FROM {verb:'POST', uri:'/pings/:pid/pongs'}]->(Likes),
(Auth)-[:REQUESTS_FROM {verb:'DELETE', uri:'/pings/:pid/pongs/:poid'}]->(Likes),

(Auth)-[:REQUESTS_FROM {verb:'GET', uri:'/users/:uid/primary_table'}]->(Tables),
(Auth)-[:REQUESTS_FROM {verb:'POST', uri:'/users/:uid/secondary_tables'}]->(Tables),
(Auth)-[:REQUESTS_FROM {verb:'GET', uri:'/users/:uid/secondary_tables/:tid'}]->(Tables),
(Auth)-[:REQUESTS_FROM {verb:'PUT', uri:'/users/:uid/secondary_tables/:tid'}]->(Tables),

(Auth)-[:REQUESTS_FROM {verb:'GET', uri:'/tgn/here'}]->(Search),
(Auth)-[:REQUESTS_FROM {verb:'GET', uri:'/tgn/world'}]->(Search),
(Auth)-[:REQUESTS_FROM {verb:'GET', uri:'/search'}]->(Search),

(Auth)-[:REQUESTS_FROM {verb:'GET', uri:'/users/:uid/chats'}]->(Chat),
(Auth)-[:REQUESTS_FROM {verb:'POST', uri:'/users/:uid/chats'}]->(Chat),
(Auth)-[:REQUESTS_FROM {verb:'GET', uri:'/users/:uid/chats/:cid'}]->(Chat),
(Auth)-[:REQUESTS_FROM {verb:'POST', uri:'/users/:uid/chats/:cid'}]->(Chat),

(Auth)-[:REQUESTS_FROM {verb:'GET', uri:'/users/:uid/notifications'}]->(Notif),
(Auth)-[:REQUESTS_FROM {verb:'PUT', uri:'/users/:uid/notifications/:nid'}]->(Notif),

(User)-[:SENDS_TO {channel:'user.new', event:'USER_CREATED'}]->(Tables),
(User)-[:SENDS_TO {channel:'user.<id>', event:'USER_UPDATED'}]->(Tables),
(User)-[:SENDS_TO {channel:'user.<id>', event:'USER_DELETED'}]->(Tables),
(User)-[:SENDS_TO {channel:'user.new', event:'USER_CREATED'}]->(Auth),
(User)-[:SENDS_TO {channel:'user.<id>', event:'USER_UPDATED'}]->(Auth),
(User)-[:SENDS_TO {channel:'user.<id>', event:'USER_DELETED'}]->(Auth),
(User)-[:SENDS_TO {channel:'user.new', event:'USER_CREATED'}]->(Likes),
(User)-[:SENDS_TO {channel:'user.<id>', event:'USER_UPDATED'}]->(Likes),
(User)-[:SENDS_TO {channel:'user.<id>', event:'USER_DELETED'}]->(Likes),
(User)-[:SENDS_TO {channel:'user.new', event:'USER_CREATED'}]->(Pings),
(User)-[:SENDS_TO {channel:'user.<id>', event:'USER_UPDATED'}]->(Pings),
(User)-[:SENDS_TO {channel:'user.<id>', event:'USER_DELETED'}]->(Pings),
(User)-[:SENDS_TO {channel:'user.new', event:'USER_CREATED'}]->(Notif),
(User)-[:SENDS_TO {channel:'user.<id>', event:'USER_UPDATED'}]->(Notif),
(User)-[:SENDS_TO {channel:'user.<id>', event:'USER_DELETED'}]->(Notif),
(User)-[:SENDS_TO {channel:'user.new', event:'USER_CREATED'}]->(Chat),
(User)-[:SENDS_TO {channel:'user.<id>', event:'USER_UPDATED'}]->(Chat),
(User)-[:SENDS_TO {channel:'user.<id>', event:'USER_DELETED'}]->(Chat),
(User)-[:SENDS_TO {channel:'user.new', event:'USER_CREATED'}]->(Follow),
(User)-[:SENDS_TO {channel:'user.<id>', event:'USER_UPDATED'}]->(Follow),
(User)-[:SENDS_TO {channel:'user.<id>', event:'USER_DELETED'}]->(Follow),

(Follow)-[:SENDS_TO {channel:'follow_request.new', event:'A_REQUESTED_FOLLOWING_B'}]->(Notif),
(Follow)-[:SENDS_TO {channel:'following.new', event:'S_BEGAN_FOLLOWING_B'}]->(Notif),
(Follow)-[:SENDS_TO {channel:'following.new', event:'S_BEGAN_FOLLOWING_B'}]->(Chat),
(Follow)-[:SENDS_TO {channel:'following.new', event:'S_BEGAN_FOLLOWING_B'}]->(Tables),
(Follow)-[:SENDS_TO {channel:'user.<id>.special_friends', event:'UPDATED_SPECIAL_FRIENDS'}]->(Tables),

(Chat)-[:SENDS_TO {channel:'user.<id>', event:'DP_RECEIVED'}]->(Notif),

(Pings)-[:SENDS_TO {channel:'user.<id>.pings', event:'PING_CREATED'}]->(Tables),
(Pings)-[:SENDS_TO {channel:'user.<id>.pings', event:'PING_CREATED'}]->(Search),
(Pings)-[:SENDS_TO {channel:'user.<id>.pings', event:'PING_CREATED'}]->(Likes),
(Pings)-[:SENDS_TO {channel:'user.<id>.pings', event:'PING_CREATED'}]->(Notif),

(Pings)-[:SENDS_TO {channel:'ping.<id>', event:'PING_DELETED'}]->(Tables),
(Pings)-[:SENDS_TO {channel:'ping.<id>', event:'PING_DELETED'}]->(Search),
(Pings)-[:SENDS_TO {channel:'ping.<id>', event:'PING_DELETED'}]->(Likes),

(Likes)-[:SENDS_TO {channel:'ping.<id>', event:'PING_LIKED'}]->(Tables),
(Likes)-[:SENDS_TO {channel:'ping.<id>', event:'PING_LIKE_REMOVED'}]->(Tables),
(Likes)-[:SENDS_TO {channel:'ping.<id>', event:'PING_LIKED'}]->(Notif),
(Likes)-[:SENDS_TO {channel:'ping.<id>', event:'PING_PONGED'}]->(Tables),
(Likes)-[:SENDS_TO {channel:'ping.<id>', event:'PING_PONG_REMOVED'}]->(Tables),
(Likes)-[:SENDS_TO {channel:'ping.<id>', event:'PING_PONGED'}]->(Notif),

(Auth)-[:USES {role:'main storage', namespace:'default'}]->(AuthDB),
(User)-[:USES {role:'main storage', namespace:'default'}]->(UserDB),
(Follow)-[:USES {role:'main storage', namespace:'default'}]->(FollowDB),
(Chat)-[:USES {role:'main storage', namespace:'default'}]->(ChatDB),
(Likes)-[:USES {role:'main storage', namespace:'default'}]->(LikesDB),
(Tables)-[:USES {role:'main storage', namespace:'default'}]->(TablesDB),
(Notif)-[:USES {role:'main storage', namespace:'default'}]->(NotifDB),
(Search)-[:USES {role:'main storage', namespace:'default'}]->(SearchDB),
(Pings)-[:USES {role:'main storage', namespace:'default'}]->(PingsDB);

