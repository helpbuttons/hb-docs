# Store

Held in the /store directory, this script is written by @hirunatan to avoid the need of using another software like Redux that would make the app heavier and more complex. 

```
// === Definición del Store ===

export class Store<T> {
  public state$: Observable<T>;
  public events$: Observable<Event>;

  public constructor(initialState: T) {
    this.state$ = new BehaviorSubject<T>(initialState);
    this.events$ = new Subject<Event>().pipe(share());
    this._subscribe();
  }

  public emit(event: Event): void {
    this.events$.next(event);
  }

  private _subscribe(): void {
    this.events$.pipe(
      filter((event) => {
        console.log(event);
        return isUpdateEvent(event);
      }),
      withLatestFrom(this.state$),
    ).subscribe(([event, state]) => this._processUpdateEvent(event, state));

    this.events$.pipe(
      filter((event) => {
        console.log(event);
        return isWatchEvent(event);
      }),
      withLatestFrom(this.state$),
    ).subscribe(([event, state]) => this._processWatchEvent(event, state));

    this.events$.pipe(
      filter((event) => {
        console.log(event);
        return isEffectEvent(event);
      }),
      withLatestFrom(this.state$),
    ).subscribe(([event, state]) => this._processEffectEvent(event, state));
  }

  private _processUpdateEvent(event: Event, state: T) {
    const newState = event.update(state);
    this.state$.next(newState);
  }

  private _processWatchEvent(event: Event, state: T) {
    const newEvents$ = event.watch(state);
    newEvents$.subscribe(event => this.events$.next(event));
  }

  private _processEffectEvent(event: Event, state: T) {
    event.effect(state);
  }
}

```
