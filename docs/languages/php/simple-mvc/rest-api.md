# REST API with Simple-MVC

## Routing (Example)

```php
// config/route.php
return [   
   [ 'GET', '/api/user[/{id}]', Controller\User::class ],
   [ 'POST', '/api/user', Controller\User::class ],
   [ 'PATCH', '/api/user/{id}', Controller\User::class ],
   [ 'DELETE', '/api/user/{id}', Controller\User::class ]
];
```

## Controller (Example)

```php
public class UserController implements ControllerInterface
{
    public function __construct(UserModel $user)
    {
        $this->userModel = $user;

        // Set the Content-type for all the HTTP methods
        header('Content-type: application/json');
    }

    // method dispatcher
    public function execute(ServerRequestInterface $request)
    {
        $method = strtolower($request->getMethod());
        if (!method_exists($this, $method)) {
            http_response_code(405); // method not exists
            return;
        }
        $this->$method($request);
    }

    public function get(ServerRequestInterface $request)
    {
        $id = $request->getAttribute('id');
        try {
            $result = empty($id)
                ? $this->userModel->getAllUsers()
                : $this->userModel->getUser($id);
        } catch (UserNotFoundException $e) {
            http_response_code(404); // user not found
            $result = ['error' => $e->getMessage()];
        }
        echo json_encode($result);
    }

    public function post(ServerRequestInterface $request)
    {
        $data = json_decode($request->getBody()->getContents(), true);
        try {
            $result = $this->userModel->addUser($data);
        } catch (InvalidAttributeException $e) {
            http_response_code(400); // bad request
            $result = ['error' => $e->getMessage()];
        } catch (UserAlreadyExistsException $e) {
            http_response_code(409); // conflict, the user is not present
            $result = ['error' => $e->getMessage()];
        }
        echo json_encode($result);
    }

    public function patch(ServerRequestInterface $request)
    {
        $id = $request->getAttribute('id');
        $data = json_decode($request->getBody()->getContents(), true);
        try {
            $result = $this->userModel->updateUser($data, $id);
        } catch (InvalidAttributeException $e) {
            http_response_code(400); // bad request
            $result = ['error' => $e->getMessage()];
        } catch (UserNotFoundException $e) {
            http_response_code(404); // user not found
            $result = ['error' => $e->getMessage()];
        }
        echo json_encode($result);
    }

    public function delete(ServerRequestInterface $request)
    {
        $id = $request->getAttribute('id');
        try {
            $this->userModel->deleteUser($id);
            $result = ['result' => 'success'];
        } catch (UserNotFoundException $e) {
            http_response_code(404); // user not found
            $result = ['error' => $e->getMessage()];
        }
        echo json_encode($result);
    }
}
```
