# Requests Lib

## GET REQUEST

Get or retrieve data from specified resource

```py
response = requests.get('URL')    # returns response object

# PAYLOAD -> valuable information of response
response.status_code    # http status code
```

The response message consists of:

- status line which includes the status code and reason message
- response header fields (e.g., Content-Type: text/html)
- empty line
- optional message body

```text
1xx -> INFORMATIONAL RESPONSE
2xx -> SUCCESS
    200 OK -> request succesful
3xx -> REDIRECTION
4xx -> CLIENT ERRORS
    404 NOT FOUND -> resource not found
5xx -> SERVER ERRORS
```

```py
# raise exception HTTPError for error status codes
response.raise_for_status()

response.content    # raw bytes of payload
response.encoding = 'utf-8'    # specify encoding
response.text    # string payload (serialized JSON)
response.json()    # dict of payload
response.headers    # response headers (dict)
```

### QUERY STRING PARAMETERS

```py
response = requests.get('URL', params={'q':'query'})
response = requests.get('URL', params=[('q', 'query')])
response = requests.get('URL', params=b'q=query')
```

### REQUEST HEADERS

```py
response = requests.get(
    'URL',
    params={'q': 'query'},
    headers={'header': 'header_query'}
)
```

## OTHER HTTP METHODS

### DATA INPUT

```py
# requests that entity enclosed be stored as a new subordinate of the web resource identified by the URI
requests.post('URL', data={'key':'value'})
# requests that the enclosed entity be stored under the supplied URI
requests.put('URL', data={'key':'value'})
# applies partial modification
requests.patch('URL', data={'key':'value'})
# deletes specified resource
requests.delete('URL')
# ask for a response but without the response body (only headers)
requests.head('URL')
# returns supported HTTP methods of the server
requests.options('URL')
```

### SENDING JSON DATA

```py
requests.post('URL', json={'key': 'value'})
```

### INSPECTING THE REQUEST

```py
# requests lib prepares the requests nefore sending it
response = requests.post('URL', data={'key':'value'})
response.request.something    # inspect request field
```

## AUTHENTICATION

```py
requests.get('URL', auth=('uesrname', 'password'))    # use implicit HTTP Basic Authorization

# explicit HTTP Basic Authorization and other
from requests.auth import HTTPBasicAuth, HTTPDigestAuth, HTTPProxyAuth
from getpass import getpass
requests.get('URL', auth=HTTPBasicAuth('username', getpass()))
```

### PERSOANLIZED AUTH

```py
from requests.auth import AuthBase
class TokenAuth(AuthBase):
    "custom authentication scheme"

    def __init__(self, token):
        self.token = token

    def __call__(self, r):
        """Attach API token to custom auth"""
        r.headers['X-TokenAuth'] = f'{self.token}'
        return r

requests.get('URL', auth=TokenAuth('1234abcde-token'))
```

### DISABLING SSL VERIFICATION

```py
requests.get('URL', verify=False)
```

## PERFORMANCE

### REQUEST TIMEOUT

```py
# raise Timeout exception if request times out
requests.get('URL', timeout=(connection_timeout, read_timeout))
```

### MAX RETRIES

```py
from requests.adapters import HTTPAdapter
URL_adapter = HTTPAdapter(max_retries = int)
session = requests.Session()

# use URL_adapter for all requests to URL
session.mount('URL', URL_adapter)
```
