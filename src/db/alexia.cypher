CREATE (Alexia:System {title:'Hacknizer', description:'A platform to host and organize hackathons'})

CREATE (Auth:Service {name:'Autenticação'})
CREATE (User:Service {name:'Usuários'})
CREATE (Create:Service {name:'Criação de Hackathon'})
CREATE (Search:Service {name:'Busca de Hackathons'})
CREATE (Disc:Service {name:'Gerador de Servidor no Discord'})
CREATE (PWA:Service {name:'Gerador de PWA'})

CREATE (AuthDB:Database {name:'Autenticação DB', model:'document', make:'MongoDB'})
CREATE (UserDB:Database {name:'Usuários DB', model:'document', make:'MongoDB'})
CREATE (CreateDB:Database {name:'Criação de Hackathon DB', model:'document', make:'MongoDB'})
CREATE (SearchDB:Database {name:'Busca de Hackathons DB', model:'document', make:'MongoDB'})
CREATE (DiscDB:Database {name:'Gerador de Servidor no Discord DB', model:'document', make:'MongoDB'})
CREATE (PWADB:Database {name:'Gerador de PWA DB', model:'document', make:'MongoDB'})

CREATE
(User)-[:USES {role:'main storage', namespace:'default'}]->(UserDB),
(Auth)-[:USES {role:'main storage', namespace:'default'}]->(AuthDB),
(Create)-[:USES {role:'main storage', namespace:'default'}]->(CreateDB),
(Search)-[:USES {role:'main storage', namespace:'default'}]->(SearchDB),
(Disc)-[:USES {role:'main storage', namespace:'default'}]->(DiscDB),
(PWA)-[:USES {role:'main storage', namespace:'default'}]->(PWADB);

CREATE
(Auth)-[:SVC_BLONGS_TO_SYS]->(Alexia),
(User)-[:SVC_BLONGS_TO_SYS]->(Alexia),
(Create)-[:SVC_BLONGS_TO_SYS]->(Alexia),
(Search)-[:SVC_BLONGS_TO_SYS]->(Alexia),
(Disc)-[:SVC_BLONGS_TO_SYS]->(Alexia),
(PWA)-[:SVC_BLONGS_TO_SYS]->(Alexia),

(Auth)<-[:SYS_CONTAINS_SVC]-(Alexia),
(User)<-[:SYS_CONTAINS_SVC]-(Alexia),
(Create)<-[:SYS_CONTAINS_SVC]-(Alexia),
(Search)<-[:SYS_CONTAINS_SVC]-(Alexia),
(Disc)<-[:SYS_CONTAINS_SVC]-(Alexia),
(PWA)<-[:SYS_CONTAINS_SVC]-(Alexia),

(User)-[:SENDS_TO {channel:'user.new', event:'USER_CREATED'}]->(Auth),
(User)-[:SENDS_TO {channel:'user.new', event:'USER_CREATED'}]->(Create),
(User)-[:SENDS_TO {channel:'user.<id>', event:'USER_UPDATED'}]->(Auth),
(User)-[:SENDS_TO {channel:'user.<id>', event:'USER_UPDATED'}]->(Create),
(User)-[:SENDS_TO {channel:'user.<id>', event:'USER_DELETED'}]->(Auth),
(User)-[:SENDS_TO {channel:'user.<id>', event:'USER_DELETED'}]->(Create),

(Create)-[:SENDS_TO {channel:'hackathon.new', event:'HACKATHON_CREATED'}]->(Search),
(Create)-[:SENDS_TO {channel:'hackathon.new', event:'HACKATHON_CREATED'}]->(Disc),
(Create)-[:SENDS_TO {channel:'hackathon.new', event:'HACKATHON_CREATED'}]->(PWA),
(Create)-[:SENDS_TO {channel:'hackathon.<id>', event:'HACKATHON_UPDATED'}]->(Search),
(Create)-[:SENDS_TO {channel:'hackathon.<id>', event:'HACKATHON_UPDATED'}]->(Disc),
(Create)-[:SENDS_TO {channel:'hackathon.<id>', event:'HACKATHON_UPDATED'}]->(PWA),
(Create)-[:SENDS_TO {channel:'hackathon.<id>', event:'HACKAHTON_DELETED'}]->(Search),
(Create)-[:SENDS_TO {channel:'hackathon.<id>', event:'HACKAHTON_DELETED'}]->(Disc),
(Create)-[:SENDS_TO {channel:'hackathon.<id>', event:'HACKAHTON_DELETED'}]->(PWA),

(Auth)-[:REQUESTS_FROM {verb:'POST', uri:'/users'}]->(User),
(Auth)-[:REQUESTS_FROM {verb:'PUT', uri:'/users/:id'}]->(User),
(Auth)-[:REQUESTS_FROM {verb:'GET', uri:'/users/:id'}]->(User),
(Auth)-[:REQUESTS_FROM {verb:'DELETE', uri:'/users/:id'}]->(User),
(Auth)-[:REQUESTS_FROM {verb:'POST', uri:'/hackathons'}]->(Create),
(Auth)-[:REQUESTS_FROM {verb:'PUT', uri:'/hackathons/:id'}]->(Create),
(Auth)-[:REQUESTS_FROM {verb:'GET', uri:'/hackathons/:id'}]->(Create),
(Auth)-[:REQUESTS_FROM {verb:'DELETE', uri:'/hackathons/:id'}]->(Create),
(Auth)-[:REQUESTS_FROM {verb:'GET', uri:'/search'}]->(Search),
(Auth)-[:REQUESTS_FROM {verb:'POST', uri:'/hackathons/:id/discord-server'}]->(Disc),
(Auth)-[:REQUESTS_FROM {verb:'POST', uri:'/hackathons/:id/pwa-project'}]->(PWA);
