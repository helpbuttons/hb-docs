#Architecture

## Introduction

The project has one main repository: 

[Repository](https://github.com/helpbuttons/helpbuttons)

The doc repository, this one, can be edited here :

[Docs Repository](https://github.com/helpbuttons/hb_docs)


## Technologies

We tried to choose technologies following three concepts: open software, mobile devices and GIS positioning. Trying to keep an eye on the popularity and documentation available for each one.

#### HTML
[LINK](https://developer.mozilla.org/en-US/docs/Learn/HTML/Introduction_to_HTML)

#### CSS
[LINK](https://developer.mozilla.org/en-US/docs/Learn/CSS/First_steps/What_is_CSS)

#### Typescript
TypeScript is a programming language developed and maintained by Microsoft. It is a strict syntactical superset of JavaScript and adds optional static typing to the language. TypeScript is designed for the development of large applications and transcompiles to JavaScript.

### Front:

#### Nextjs
[LINK](https://nextjs.org/)

#### React
[LINK](https://reactjs.org/)

#### RxJS
[LINK](https://rxjs.dev/)

RxJS is a library for reactive programming using Observables, to make it easier to compose asynchronous or callback-based code. This project is a rewrite of Reactive-Extensions/RxJS with better performance, better modularity, better debuggable call stacks, while staying mostly backwards compatible, with some breaking changes that reduce the API surface

### Backend :

* #### Nodejs
[LINK](https://nodejs.org/en/)

#### Nestjs
[LINK](https://nestjs.com/)
NestJS is a framework for building efficient, scalable Node.js web applications. It uses modern JavaScript, is built with TypeScript and combines elements of OOP (Object Oriented Programming), FP (Functional Programming), and FRP (Functional Reactive Programming).

#### PostgreSQL
[LINK](https://www.postgresql.org/)
PostgreSQL, also known as Postgres, is a free and open-source relational database management system emphasizing extensibility and SQL compliance. It was originally named POSTGRES, referring to its origins as a successor to the Ingres database developed at the University of California,

#### PostGIS
[LINK](https://postgis.net/)
PostGIS is a spatial database extender for PostgreSQL object-relational database. It adds support for geographic objects allowing location queries to be run in SQL.


##Basic concepts

In order to understand the project you need to know how three concepts interact: Helpbuttons, Users and Networks.   

A Network is an enviroment where the users can create Helpbuttons. Comparing with other collaborative apps: Airbnb would be a network, a house would be a Helpbutton, and a landlord would be an user.

One server could hold more than one separated Network, and then federate them. Users could create Helpbuttons that could be published in several of those Networks. So, the Helpbuttons is the post, that can be posted in any enviroment (Network) depending on the purpose and owned by an user.

##Conventions / Naming

- Btn is traditional HTML button, Button is the actual post in the app HelpButtons.

- Css naming is lowercase, including file names.

- Folder and archive naming follows the logic ElementClass or ElementModel (i.e. CardNotification) except for main Classes/Models that start having many elements related to the same class (i.e ButtonNew, NetworkNew, ButtonCard, NetworkCard). As a general rule, we want elements to be grouped by type so it's easier to find all together (Cards, Forms, ...). Main Classes, on the contrary, have a lot of elements associated so it's better to have them together by naming the class first.

- For any question you can publish an issue in the repository follow the issue guide (link to issue guide ):
[Issue Guide](/docs/English/issues&PR)

##MODELS

###BUTTON / HELPBUTTON

A Button or Helpbutton is the app post. Basically when you create a button you make a publication that has some basic fields: A title, a type, a place, a date, a description, images and tags. On top of these records you have fields that change depending on the network type. Depending on those fields your app can be better for transport sharing (duration fields, destination list,...), food sharing (food types selectable, amounts fields,...) or any other purpose that your app can have. All these extra fields come specified in one JSON element that is dependant on a template called ButtonTemplate.

Helpbuttons can be activated and desactivated without the need of deleting them. And everybutton has an interactions record list called the Feed, where users and app changes related to the Button are displayed.

All Helpbuttons by default can be published at the same time in any Network that share the buttonTemplate.

```
export interface IButton {
  id?: any | null,
  owner: any,
  name: string,
  templateButtonId: any | null,
  type: enum,
  tags: [Itag],
  description: string,
  //required data
  date: [],
  //GIS DATA
  geoPlace: [],
  // optional values
  networks: [],
  feedType: enum, //enum {single,group} feed structure
  templateExtraData: {}, //JSON template contains info about the image and the description (standard) and also about booleans, radius, checklist and every other field related to the network module
}

```


###NETWORK

If the Helpbutton is the post, the network is the group of posts. These posts share structure of ButtonTemplate defined in the network. One Network has a location, a radius,a description, an icon, a name and a list of options that change the visulization of the Helpbuttons (on map, on map by zones, on list only, on list + map) among others. The ButtonTemplate selected in the Network properties define the properties of the Helpbuttons and also the filters displayed in the Explore page and the fields in the creation menu of the Helpbuttons New page. Networks can be also friends of other networks and show their data in common, so users couldd navigate in between them.

All Helpbuttons created in a network can be shared in another network too if they share the same ButtonTemplate.

A network can be public (all can see what the Helpbuttons inside) or private (you need to enter to see and interact with the Helpbuttons).

The creator of the network is the owner and moderator. This person can assign moderation roles to other users of the network.  

```
export interface INetwork {
  //required data
  id: string;
  name: string,
  url: string,
  avatar: string,
  privacy: string, //enum {publico, privado} default publico
  roles: string, //enum {admin, user, blocked} default admin, user
  //not required data
  tags: [],
  description: string,
  buttonsTemplate: {}, //array of objects, each type has an int, a name and a color associated. Default are offer (green), need (red).
  //data for GIS
  showButtons : string, //enum {area, point} show Helpbuttons by area not showing exact position on map
  place: string,
  geoPlace: {},
  radius: string,
  friendNetworks: [],
  //only for admins:
  networkRoles: [], //array of roles specific for the net, default are net admins. Each of these net roles have their user list
  blockedUsers: [], //user ids, the blocked users cannot rejoin a network. only admin users
  // extra option friendNets:[12,234],}
}

```

###USER

The users are the person profile that is over the networks. User can jump in and out of networks, and move their Helpbuttons to other networks and to other Users. This way an user can keep their reputation and profile independent.

User cannot be rated but their reputation is stablished by supports. Other users can support an user for increasing his reputation. Blocks and low support rates can be used to measure the negative impact of the actions of users that can be moderation objectives by the community.

```
//User interface
export interface IUser {

  username: string,
  email: string,
  realm: string,
  roles: [],
  token: string,

}

export interface ICurrentUser {

  token: string,

}

```

###BUTTON / HELPBUTTON TEMPLATE

ButtonTemplate is the model that adds the modularity. It's a mix of some boolean elements and a JSON objetc that can include custom information inside. It's used by the app to configure posts and forms and adapt them to the networks' purpose. i.e. A network for selling food would have a ButtonTemplate that includes references to prices, quantities, origins, etc.

```
export interface ITemplateButton {
//JSON template contains info about the image and the description (standard) and also about booleans, radius, checklist and every other field related to the network module
  id: any || null,
  name: string,
  type: enum,
  fields: {},
  owner: int,

}

```

###FEED

A Feed, as we introduced before, is a component that shows a list of interactions related to the component that is attached to. The Feed in the Helpbuttons page shows all interactions (messages, updates, changes... ) related to that Helpbuttons. The Feed in the Profile page shows all interactions related to the user (What we can call ).

It has several filtered options. Filters change depending on the content but also depending on the user role. The owner of the Helpbuttons can see different information in a Feed than other users, etc.

###TAG
Tags in Helpbuttons are used for search purposes but also to configure notifications. Users could select Tags in the Config page to receive notifications when a Helpbuttons is creted with those tags, or with an specific button-type.
```
{
  "id": "string",
  "modelName": "string",
  "modelId": "string",
  "created": "2022-04-10T14:33:32.823Z",
  "modified": "2022-04-10T14:33:32.823Z"
}

```

##The ButtonTemplate Model

The ButtonTemplate is the model that defines the modular elements that will differenciate the Network. Fields is the JSON object that will enumerate the Button fileds and options for that Network. (Add examples)
```bash
{
  "id": 0,
  "name": "string",
  "type": "need",
  "fields": {},
  "created": "2022-04-10T14:28:32.085Z",
  "modified": "2022-04-10T14:28:32.085Z",
  "owner": "string"
}
```

##Models



##Folder architecture FRONT

The structure follows the typical arrangement of an React / Nextjs project. The naming follows the logic of FIRST FUNCTION - SECOND TYPE. i.e. BtnCirle (Btn is the function -button- and circle the type).

Every directory has a .md file that explains the purpose of the folder.

* elements : Basic atoms repeated all over the app (Accordion, Avatar, Btn, BtnCircle, Checkbox, Dropdown, Form...)  

* components : Group of elments that complete and develop a function (button, feed, map, popup, nav, network, picker, popup, search, user...)

* layouts : Group of components that are not enough to define a page. (May be erased?)

* pages : Urls of the application. In Nextjs the subfolders included in this foldder define the routes. (ButtonFile, ButtonNew, Explore, Faqs, Login, ...). You can check all of them in the Pages section:

[http://localhost:8000/English/pages/](http://localhost:8000/English/pages/)

* modules : this a folder for complex functionalities that shoulddn't be separated by the general foler structure. i.e. You want to have the services and the reacts components together in a directory for authentication functionaliity. The folder has a fake example inside.

* services: Each model has a folder in this directory to communicate with the API (Helpbuttons, ButtonTemplates, Feed, Networks, Tags, Users). Also basic API functionalities (Alerts, Errors, HttpUtils -localStorage- and Store) have a service in this folder.

* store : It's a custom script written by @hirunatan in Telegram. It's intended for storing temporal data in the session (without refreshing the page, after refresh data is lost) and avoid the need of using more complex store mngmnt software.

[http://localhost:8000/English/store/](http://localhost:8000/English/store/)

It's an rxjs event stream service that you can subscribe to. If you're not familiar with observables follow the link to [RxJS](https://rxjs.dev/) page.

```
// === Hook para suscribirse al store ===

export function useRef(store: Store, selector: func) {
  const [value, setValue] = useState(null);

  useEffect(() => {
    store.state$.subscribe((state) => {
      const newValue = selector(state);
      if (newValue !== value) {
        setValue(selector(state));
      }
    });
  });

  return value;
}

```



##Folder architecture BACK
