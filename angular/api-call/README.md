# API Call

## Environment

- Define `baseUrl` in file `environment.ts` 

Example

```typescript
// environment.ts

const url = window.location.href;
const matches = /^http(s?)?:\/\/([^\/?#]+)/.exec(url);

export const environment = {
  ...
  baseUrl: matches[0].replace('4200', '8000'),
  ...
};
```

## API Constant

- Create file `api.constant.ts` for keep all Api endpoints
- Set `BaseUrl` constant in `api.constant.ts`

Example

```typescript
// api.constant.ts

import { environment } from '../../../environments/environment';

const BaseUrl = environment.baseUrl + '/api';
```

## API Function

- You should define returned type for your Api function and set function name start with Http method
    - In general, Http methods will return type as observable that you can use by subscribe
    
- If you want to send api by using id then send as parameter of Api function before connecting id to Api Url

Example

```typescript
// example.service.ts

postData(id: number, data): Observable<ResponseType> {
  return this.http.post<ResponseType>(ApiUrl.endpoint + id + '/', data);
}
```

