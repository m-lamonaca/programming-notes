# Child Process Module

## Spawning

```js
child_process.spawn(command, args, options);  // spawn a child process

// On Windows, setting options.detached to true makes it possible for the child process to continue running after the parent exits
child_process.spawn(command, args, {
    detached: true
});
```

## Using The System Shell

```js
exec("command args", {'shell':'powershell.exe'},  (err, stdout, stderr) => {

});

execSync("command args", {'shell':'powershell.exe'});
```
