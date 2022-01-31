# Pipes

This page will give you recommendations on how to use pipes for your Angular project.

## When to use Pipes?

When you want to display the data in another format, but still want to keep the raw format data.

### Don't do this
```typescript{% raw %}
@Component({
  selector: 'app-foo',
  template: `<p>{{ myFormatData(myData) }}</p>`
})
export class FooComponent {
  @Input() myData

  constructor() { }

  myFormatData(data) {
    // do something
    return newData;
  }
}{% endraw %}
```
If you do like above, the function `myFormatData` will be executed every time Angular detects a change (every keystroke or mouse movement), so **it affect to the performance** if that function has a lot process inside.

The way we do is using **built-in** or **custom pipe**.

### Do this
```typescript{% raw %}
@Component({
  selector: 'app-foo',
  template: `<p>{{ myData | myFormatData }}</p>`
})
export class FooComponent {
  @Input() myData

  constructor() { }
}

@Pipe({name: 'myFormatData'})
export class MyFormatDataPipe implements PipeTransform {
  transform(value) {
    // do something
    return newValue;
  }
}{% endraw %}
```
If you use pipe the function `transform` in `MyFormatDataPipe` will be executed only when Angular detects a change for the input value.


## Pipes with object references
Be careful when pipe's input variable is object references such as `Date`, `Array`, or `Object`. 

If you change data inside object references (such as added element of an existing array) but the references address still the same, Angular change detector will ignore that changes, so **the pipe doesn't run**.

The way to resolve this problem is change the object reference itself such as replace array with a new array containing the newly changed elements.
```typescript{% raw %}
@Component({
  selector: 'app-foo',
  template: `
  <input type="text" #inputPerson (click)="addPerson(inputPerson.value)">
  <div *ngFor="let woman of (people | womanPeople)">
    <p>{{ woman.name }}</p>
  </div>
  `
})
export class FooComponent {
  people: {name: string; sex: 'male'|'female'}[] = [];
  sex = ['male', 'female'];

  constructor() { }

  addPerson(name: string) {
    const newPerson = {
      name: name,
      sex: sex[Math.floor(Math.random() * this.sex.length)]
    }

    this.people.push(newPerson);  // NO, the reference didn't change
    this.people = [...this.people, newPerson];  // YES
    this.people = this.people.concat(newPerson)  // YES
  }

}

@Pipe({ name: 'womanPeople' })
export class WomanPeoplePipe implements PipeTransform {
  transform(people: {name: string; sex: 'male'|'female'}[]) {
    return people.filter(person => person.sex === 'female');
  }
}{% endraw %}
```


##  AsyncPipe
`AsyncPipe` is the built-in pipe for getting data from Observables or Promises. 

The useful is it automatically subscribes to the observable, renders the output and then also unsubscribes when the component is destroyed so we don’t need to handle the clean up logic ourselves.

###  Without AsyncPipe
```typescript{% raw %}
@Component({
  selector: 'app-foo',
  template: `
  <div *ngFor="let person of people">
    <p>{{ person.firstName }} {{ person.lastName }}</p>
  </div>
  `
})
export class FooComponent implements OnInit, OnDestroy {
  people: People[];
  sub: Subscription;

  constructor(private peopleService: PeopleService) { }

  ngOnInit() {
    this.sub = this.peopleService.getPeople().subscribe(people => {
      this.people = people;
      // do something after subscribe
    });
  }

  ngOnDestroy() {
    this.sub.unsubscribe();
  }
}{% endraw %}
```

###  With AsyncPipe
We don't need to worry about memory leaks problem because it unsubscribes automatically.
```typescript{% raw %}
@Component({
  selector: 'app-foo',
  template: `
  <ng-container *ngIf="people$ | async as people">
    <div *ngFor="let person of people">
      <p>{{ person.firstName }} {{ person.lastName }}</p>
    </div>
  </ng-container>
  `
})
export class FooComponent implements OnInit {
  people$: Observable<People[]>;

  constructor(private peopleService: PeopleService) { }

  ngOnInit() {
    this.people$ = this.peopleService.getPeople().pipe(
      tap(people => {
        // do something after subscribe
      })
    );
  }
}{% endraw %}
```