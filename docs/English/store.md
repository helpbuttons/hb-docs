# Store

A typical problem in web applications is how to share data between unrelated web components in one page. When a component is a child of another one, the parent may pass info with the properties. But if components that want to share data are scattered around the page, the question is more difficult.

In addition, when the interacions become more complex, a change of one piece of data, often triggers further changes elsewhere. Without care, this may lead to infinite loops or race conditions.

There are a number of solutions for these problems. Here we use the Store module, inspired in [Redux](https://redux.js.org/) but much simpler to use, although quite powerful. It's based in two main contents:

* The `Store` holds a global state of the application. A tree of objects that may be changed by any component, and subscribed by any one to be notified of the changes.
* The `Event` stream. When any component wants to modify the state, it does not directly write to the Store. Instead, emits an `Event`, that is queued and executed only when all other processes are finished. The event is an object with a function that receives the global state, and returns a new state with the desired changes.

This way, loops and race conditions are avoided, the state being stable while any javascript event or component redraw is being executed.

## Declaring the global state

Define an interface with all the variables you need inside the global state. Then, declare ain instance of `Store`, generated from the given interface and with the initial data, and exported to be accessible from anywhere in the app:

```typescript
// index.tsx

import { Store } from "store/Store";

export interface GlobalState {
  loading: boolean,
  currentUser?: {
    username: string,
    name: string;
    email: string;
  }
}

export const store = new Store<GlobalState>({
  loading: false,
  currentUser: null,
});
```

## Using immer to efficiently modify data

The architecture explained here implies a lot of object cloning (to compliy with the immutable objects paradigm). To achieve this in an efficient way, we use the [immerjs](https://immerjs.github.io/immer/) library. The main resource is the `produce` function, that takes an object and perform a shallow copy, but preserving all parts that have not changed. Example of usage:

```typescript
import produce from "immer";

const someObject = {
  one: 1,
  two: 2,
  letters: ["a", "b", "c"]
}

const newObject = produce(someObject, draft => {
  draft.one = 11;
  draft.letters.push("d");
});

// newObject is {one: 11, two: 2, letters: ["a", "b", "c", "d"]}
// The structure of newObject shares any attribute that has not changed (in this case, `two`),
// to save memory and processing time.
```

## Using events to change the state

Define a class that implements `UpdateEvent`, with an `update` method that does the work. Then (inside a dom event handler, for example), use the `emit` method of the store to queue it to be executed later, when all other processing have stopped.

```typescript
// SomeComponent/data.tsx

import { UpdateEvent } from "store/Event";
import { GlobalState } from "index";

export class SetLoadingEvent implements UpdateEvent {
  public constructor(private loading: boolean) {}

  public update(state: GlobalState) {
    return produce(state, newState => {
      newState.loading = this.loading;
    });
  }
}

// SomeComponent/index.tsx

import { store } from "index";
import { SetLoadingEvent } from "SomeComponent/data";

window.onload(() => store.emit(new SetLoadingEvent(true)));
```

In this example, after the `onload` event completely finishes, the global state is modified to set the `loading` variable to true. Then, the subscribers of this variable will be notified of the change (see below).


## Subscribing to state changes

The global state may be read synchronously, and it will give the current value at the moment it's read. But the usual way of reading it is not so, but subscribing to the state or to one part of it, and being notified whenever it changes.

The `Store` class has a public member named `state$`, that is a RX observable that you can subscribe to, and that emits the new state each time it's modified.

```typescript
import { store, GlobalState } from "index";

store.state$.subscribe((state: GlobalState) => {
  console.log(state.currentUser?.name);
}
```

If the state is read from a React component, we provide a React hook that is useful to subscribe to a subset of the state. You give it a function that selects the portion of the state you need, and the hook ensures that whenever this fragment changes, a componet repaint is triggered, with the value attached to a local variable.

```typescript
// SomeComponent/index.tsx

import { useRef } from "store/Store";
import { store } from "index";

export default function SomeComponent() {
  const user = useRef(store, (state) => state.currentUser);

  return (
    (user &&
      <div class="user-block">
        <p>{ user.name }</p>
        <p>{ user.email }</p>
      </div>)
  );
}
```

## Using asynchronous events

Often, you will need to trigger some action that is not immediate, but have to wait for something (for example, ask the backend for some data, or set a timer).

For this, you can use the `WatchEvent`. These kind of events also may be emitted, and have a function `watch` that receives the current global state value. But these ones return a RX observable, that emits one or more events before completting. The new events are then queued, to be executed when it's their turn. If the new events are UpdateEvents, the state will finally be modified. If they are also WatchEvents, more events will be queued in turn, extending the chain.

```typescript
import { UpdateEvent } from "store/Event";
import { GlobalState } from "index";
import { ajax } from "rxjs/ajax";

export class LoadUserEvent implements WatchEvent {
  public watch(state: GlobalState) {
    return ajax.getJSON("https://my.backend/api/current-user").pipe(
      map((user) => new UserLoadedEvent(user))
    );
  }
}

class UserLoadedEvent implements UpdateEvent {
  public constructor(private user: object) {}

  public update(state: GlobalState) {
    return produce(state, newState => {
      newState.currentUser = this.user;
    });
  }
}
```

An event may implement both `UpdateEvent` and `WatchEvent`. In this case, when the event is executed, the `update` function will be called first, and then `watch` will be called with the updated state.

```typescript
import { UpdateEvent } from "store/Event";
import { GlobalState } from "index";
import { ajax } from "rxjs/ajax";

export class LoadUserEvent implements UpdateEvent, WatchEvent {
  public update(state: GlobalState) {
    return produce(state, newState => {
      newState.loading = true;
    });
  }

  public watch(state: GlobalState) {
    return ajax.getJSON("https://my.backend/api/current-user").pipe(
      map((user) => new UserLoadedEvent(user))
    );
  }
}

class UserLoadedEvent implements UpdateEvent {
  public constructor(private user: object) {}

  public update(state: GlobalState) {
    return produce(state, newState => {
      newState.loading = false;
      newState.currentUser = this.user;
    });
  }
}

// LoadingComponent/index.tsx

import { useRef } from "store/Store";
import { store } from "index";

export default function LoadingComponent() {
  const loading = useRef(store, (state) => state.loading);

  return (
    (loading &&
      <div class="loading">
        <img src="spinner.gif" />
      </div>)
  );
}
```

A third type of event is the `EffectEvent`. It's intended for when you need to trigger an external action (a 'side effect') but you don't need a return value.

```typescript
import { EffectEvent } from "store/Event";
import { GlobalState } from "index";
import { ajax } from "rxjs/ajax";

export class LogEntryEvent implements EffectEvent {
  public effect(state: GlobalState) {
    ajax.post("https://my.backend/api/log-entry", JSON.stringify({
      date: date.now(),
      user: state.user.username,
    }));
  }
}
```


## Modularizing the global state

When the applicatoin grows, it's not a good idea to have all state in a big global object with all variables in the same level. Te suggestion is to have each submodule its own definition of the local state, the initial values and the selecte function, and to aggregate all modules in the global state.

```typescript

// index.ts

import { Store } from "store/Store";
import { UserState, userInitial } from "user/data";
import { OtherState, otherInitial } from "other/data";
...

export interface GlobalState {
  user: UserState,
  other: OtherState,
  ...
}

export const store = newStore<GlobalState>({
  user: userInitial,
  other: otherInitial,
  ...
});


// User/data.tsx

export interface UserState {
  loading: boolean,
  currentUser?: {
    username: string,
    name: string;
    email: string;
  }
}

export const userInitial = {
  loading: false,
  currentUser: null,
};

export getUser = (state) => state.user;


// User/index.tsx

import { useRef } from "store/Store";
import { store } from "index";
import { getUser } from "./data";

export default function SomeComponent() {
  const user = useRef(store, (state) => state.getUser().currentUser);

  return (
    (user &&
      <div class="user-block">
        <p>{ user.name }</p>
        <p>{ user.email }</p>
      </div>)
  );
}
```

