# Git

## Glossary

**GIT**: an open source, distributed version-control system  
**GITHUB**: a platform for hosting and collaborating on Git repositories

**TREE**: directory that maps names to blobs or trees  
**BLOB**: any file  
**COMMIT**: snapshot of the entire repository + metadata, identified it's SHA-1 hash

**HEAD**: represents the current working directory, the HEAD pointer can be moved to different branches, tags, or commits when using git checkout  
**BRANCH**: a lightweight movable pointer to a commit  
**CLONE**: a local version of a repository, including all commits and branches  
**REMOTE**: a common repository on GitHub that all team member use to exchange their changes

**FORK**: a copy of a repository on GitHub owned by a different user  
**PULL REQUEST**: a place to compare and discuss the differences introduced on a branch with reviews, comments, integrated tests, and more  

**REPOSITORY**: collection of files and folder of a project aka repo  
**STAGING AREA/STASH**: area of temporary snapshots (not yet commits)

## Data Model

Data Model Structure:

```txt linenums="1"
<root> (tree)
|
|_ foo (tree)
|  |_ bar.txt (blob, contents = "hello world")
|
|_ baz.txt (blob, contents = "git is wonderful")
```

Data Model as pseudocode:

```py linenums="1"
# a file is a bunch of bytes
blob = array<byte>

# a directory contains named files and directories
tree = map<string, tree | file>

# a commit has parents, metadata, and the top-level tree
commit = struct {
    parent: array<commit>
    author: string
    message: string
    snapshot: tree
}

# an object is either a blob, tree or commit
object = map<string, blob | tree | commit>

# commit identified by it's hash (unmutable)
def store(object):
    id = sha1(object)  # hash repo
    objects<id> = object  # store repo w/ index hash

# load the commit
def load(id):
    return objects<id>

# human-readable names for SHA-1 hashes (mutable)
references = map<string, string>

# bind a reference to a hash
def update_reference(name, id):
    references<name> = id

def read_reference(name):
    return references<name>

def load_reference(name_or_id):
    if name_or_id in references:
        return load(references<name_or_id>)
    else:
        return load(name_or_id)
```

## Commands

`git <command> -h|--help`: get help for a git command  
`git -C <path> <command>`: execute a git commend in the specified path  
`git <command> <commit>^`: operate on commit *before* the provided commit hash  

### Create Repository

`git init [<project_name>]`: initialize a brand new Git repository and begins tracking  
`.gitignore`: specify intentionally untracked files to ignore  

### Config

`git config --global user.name "<name>"`: set name attached to commits  
`git config --global user.email "<email address>"`: set email attached to commits

### Making Changes

`git status`: shows the status of changes as untracked, modified, or staged  
`git add <files>`: add files contents to the staging area  
`git add -u|--update <files>`: stage changes but ignore untracked files  
`git add -p|--patch <files>`: interactively stage chunks of files  

`git blame <file>`: show who last edited which line  
`git blame -L <start>,<end> -- <file>`: Annotate only the line range given by `<start>,<end>`, within the `<file>`  
`git blame -L /<regex>/ -- <file>`: Annotate only the range given by the function name regex `<regex>`, within the `<file>`  
`git blame -w`: Ignore whitespace when comparing the parent’s version and the child’s to find where the lines came from  
`git blame -M`: Detect moved or copied lines within a file.  
`git blame -M -C [-C -C]`: Detect moved or copied lines within a file (`-M`), from all modified files in the same commit (`-C`), in the commit that created the file (`-C -C`), in all commits (`-C -C -C`)  

`git commit`: save the snapshot to the project history  
`git commit -m|--message "message"`: commit and provide a message  
`git commit -a|--all`: automatically notice any modified (but not new) files and commit  
`git commit -v|--verbose`: show unified diff between the HEAD commit and what would be committed  
`git commit --amend`: modify latest commit with the new changes  
`git commit --no-verify`: commit without executing hooks  
`git commit --fixup <commit>`: mark commit as correction to another  
`git commit -s|--signoff`: Add a `Signed-off-by` trailer by the committer at the end of the commit log message  

`git diff <filename>`: show difference since the last commit  
`git diff <commit> <filename>`: show differences in a file since a particular snapshot  
`git diff <reference_1> <reference_2> <filename>`: show differences in a file between two snapshots  
`git diff  --cached`: show what is about to be committed  
`git diff <first-branch>...<second-branch>`: show content diff between two branches  
`git diff -w|--ignore-all-space`: show diff ignoring whitespace differences  
`git diff --word-diff`: show diff word-by-word instead of line-wise  

`git bisect`: binary search history (e.g. for regressions)  

### Stashes

`git stash [push] [-m|--message]`: add all changes to the stash (and provide message)  
`git stash list` list all stashes  
`git stash show [<stash>]`: show changes in the stash  
`git stash pop`: restore last stash  
`git stash drop [<stash>]`: remove a stash from the list  
`git stash clear`: remove all stashes  

### Remotes

`git remote`: list remotes  
`git remote -v|--verbose`: list remotes names and URLs  
`git remote show <remote>`: inspect the remote  

`git remote add <remote> <url | path>`: add a remote  
`git remote remove <remote>`: remove the specified remote  
`git remote rename <old_name> <new_name>`: rename a remote  
`git branch -u|--set-upstream-to=<remote>/<remote branch>`: set up correspondence between local and remote branch  

`git push`: send objects to default remote on current branch  
`git push <remote> <branch>`: send objects to remote  
`git push <remote> <local branch>:<remote branch>`: send objects to remote, and update remote reference  

`git push -f|--force`: overwrite remote with local version  
`git push --force-with-lease`: overwrite remote with local version if remote has not been modified  
`git push --force-with-lease --force-if--includes`: will verify if updates from the remote that may have been implicitly updated in the background are integrated locally before allowing a forced update  

`git fetch [<remote>]`: retrieve objects/references from a remote  
`git pull`: update the local branch with updates from its remote counterpart, same as `git fetch; git merge`  
`git pull --ff`: when possible resolve the merge as a fast-forward (only update branch pointer, don't create merge commit). Otherwise create a merge commit.  

`git fetch|pull -p|--prune`: remove any remote-tracking references that no longer exist on the remote  
`git fetch|pull -t|--tags`: fetch all tags from the remote

`git clone <url> [<folder_name>]`: download repository and repo history from remote  
`git clone --shallow`: clone only repo files, not history of commits  

> **Note**: for a in depth explanation of `--force-if-includes` see [this][force-if-includes]

### Viewing Project History

`git log`: show history of changes  
`git log -p|--patch`: show history of changes and complete differences  
`git log --stat --summary`: show overview of the change  
`git log --follow <file>`: list version history fo file, including renames  
`git log --all --graph --decorate`: visualizes history as a DAG  
`git log  --oneline`: compact log  

`git log -S<string>`: Look for diffs that change the number of occurrences of the specified `<string>`  
`git log -G<regex>`: Look for diffs whose patch text contains added/removed lines that match `<regex>`  

`git log -L <start>,<end>:<file>`: Trace the evolution of the line range given by `<start>,<end>`, within the `<file>`  
`git log -L /<regex>/:<file>`: Trace the evolution of the line range given by the function name regex `<regex>`, within the `<file>`  

`git log <rev>`: Include commits that are reachable from `<rev>`  
`git log ^<rev>`: Exclude commits that are reachable from `<rev>`  
`git log <rev1>..<rev2>`: Include commits that are reachable from `<rev2>` but exclude those that are reachable from `<rev1>`. When either `<rev1>` or `<rev2>` is omitted, it defaults to HEAD.  
`git log <rev1>...<rev2>`: Include commits that are reachable from either `<rev1>` or `<rev2>` but exclude those that are reachable from both. When either `<rev1>` or `<rev2>` is omitted, it defaults to HEAD.  
`git log <rev>^@`: Include anything reachable from `<rev>` parents but not the commit itself

`git shortlog`: list commits by author  
`git reflog`: show record of when the tips of branches and other references were updated in the local repository  

`git show <commit>`: output metadata and content changes of commit  
`git cat-file -p <commit>`: output commit metadata  

### Tag

Git supports two types of tags: *lightweight* and *annotated*.  

A lightweight tag is very much like a branch that doesn't change: it's just a pointer to a specific commit.  

Annotated tags, however, are stored as full objects in the Git database.  
They're checksummed; contain the tagger name, email, and date; have a tagging message; and can be signed and verified with GNU Privacy Guard (GPG).  
It's generally recommended creating annotated tags so it's possible to have all this information.  

`git tag`: list existing tags  
`git tag -l|--list <pattern>`: list existing tags matching a wildcard or pattern  

`git tag <tag> [<commit_hash>]`: create a *lightweight* tag on the commit  
`git tag -a|--annotate <tag> [<commit_hash> -m <message>]`: create am *annotated* tag on the commit  
`git tag -f|--force <tag> [<commit_hash>]`: update a tag if it exists  
`git tag -s|--sign <tag> [<commit_hash>]`: sign a tag  

`git push <remote> <tagname>`: push a tag to the remote  
`git push <remote> --tags`: push commits and their tags (both types) to the remote  

`git tag -d|--delete <tagname>`: delete a tag  
`git push <remote> :refs/tags<tagname>:`: remove a tag from the remote  
`git push <remote> --delete <tagname>`: remove a tag from the remote  

`git checkout <tag>`: checkout a tag - **WARNING**: will go into *detached HEAD*  

### Branching And Merging

![branch](../img/git_branches.png "how branches work")

`git branch`: shows branches  
`git branch -vv`: show branch + last commit + remote status  
`git branch --merged [--remote]`: show branches (remote) that have been merged into current one (needs same history, merge squash/rebase break history)
`git branch`: show list of all existing branches  (* indicates current)  
`git branch <branch-name>`: create new branch  
`git branch -d|--delete <branch-name>`: delete specified branch  
`git branch -m|--move <old_name> <new_name>`: rename a branch without affecting the branch's history  
`git switch -c <branch-name>`: create a branch and switches to  
`git switch <branch-name>`: change current branch (update HEAD) and update working directory  

`git merge <branch-name>`: merges into current branch  
`git merge --continue`: continue previous merge after solving a merge conflict  
`git mergetool`: use a fancy tool to help resolve merge conflicts  
`git rebase <branch>`: rebase current branch commits onto another branch  

`git cherry-pick <commit>`: bring in a commit from another branch  
`git cherry-pick <commit>^..<commit>`: bring in a  range of commits from another branch (first included)  
`git cherry-pick <commit>..<commit>`: bring in a  range of commits from another branch (first excluded)  


### Worktrees

A git repository can support multiple working trees, allowing to check out more than one branch at a time.

Additional worktrees are called "linked worktrees" as opposed to the "main worktree" prepared by `git init` or `git clone`.  
A repository has one main worktree (if it’s not a bare repository) and zero or more linked worktrees.

`git worktree list`: show worktrees  
`git worktree add <path> <commit>`: create worktree at `<path>` and checkout `<commit>`  
`git worktree add -b <branch> <path> <commit>`: create worktree and branch at `<path>`  
`git worktree remove <worktree>`: remove a worktree  

### Undo & Rewriting History

`git rm -r --cached <file>`: remove a file from being tracked  
`git commit --amend`: replace last commit by creating a new one (can add files or rewrite commit message)  
`git commit --amend -m "amended message"`: replace last commit by creating a new one (can add files or rewrite commit message)  
`git commit --amend  --no-edit`: replace last commit by creating a new one (can add files or rewrite commit message)  

`git reset HEAD <file>`: unstage a file  
`git reset <commit>`: undo all commits after specified commit, preserving changes locally  
`git reset --soft <commit>`: revert to specific commit but keep changes and staged files  
`git reset --hard <commit>`: discard all history and changes back to specified commit  

`git clean`: remove untracked files form the working tree  
`git clean -d`: recurse into untracked directories while cleaning  
`git clean --interactive`: clean files interactively  

`git restore .`: discard uncommitted changes  
`git restore <file>`: discard uncommitted changes to file  
`git restore --source <commit> <file>`: revert file to commit version  
`git restore --staged`: unstage changes made to a file  
`git restore --staged --worktree`: unstage and discard changes made to a file  
`git restore <deleted-file>`: recover deleted file if previously committed  

`git rebase -i|--interactive`: modify (reword, edit, drop, squash, merge, ...) current branch commits  
`git rebase -i|--interactive HEAD~<n>`: modify (reword, edit, drop, squash, merge, ...) *n* commits  
`git rebase -i|--interactive <commit>`: modify (reword, edit, drop, squash, merge, ...) *from* commit to latest  
`git rebase --autostash`: automatically create a temporary stash entry before rebasing  
`git rebase --autosquash`: automatically apply "squash!" or "fixup!" or "amend!" commits  

> **WARN**: Changing history can have nasty side effects

<!-- links -->
[force-if-includes]: https://stackoverflow.com/a/65839129 "git --force-if-includes explanation"
