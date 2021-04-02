# API Call

## Environment

- Define `baseUrl` in `environment.ts` file in order to use in `api.constant.ts` file

Example *( In case of using same base URL )*

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

Example *( In case of using different base URL )*

```typescript
// environment.ts

const url = window.location.href;

export const environment = {
  ...
  baseUrl: < base URL of your API >,
  ...
};
```

## API Constant

- Collect all API endpoints in file follow to `src/app/core/http/api.constant.ts` if there is no this file in repository, so you need to create this file first
- Set `BaseApiUrl` constant in `api.constant.ts` and define your endpoints in `ApiUrl` constant

Example

```typescript
// api.constant.ts

import { environment } from '../environments/environment';

const BaseApiUrl = environment.baseUrl + '/api';

export const ApiUrl = {
  example: BaseApiUrl + '/masterdata/company-groups/',
}
```

## API Function

- You should define returned type for your API function and set function name start with HTTP method
  - In general, HTTP methods will return type as observable that you can use by subscribe
- If you want to send API by using id then send as parameter of API function before connecting id to API URL

Example

```typescript
// example.service.ts

postData(id: number, data): Observable<ResponseType> {
  return this.http.post<ResponseType>(ApiUrl.endpoint + id + '/', data);
}
```
