# Git Cheatsheet

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

```txt
<root> (tree)
|
|_ foo (tree)
|  |_ bar.txt (blob, contents = "hello world")
|
|_ baz.txt (blob, contents = "git is wonderful")
```

Data Model as pseudocode:

```py
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

# bind a regerence to a hash
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

`git help <command>`: get help for a git command

### Create Repository

`git init [<project_name>]`: initialize a brand new Git repository and begins tracking
`.gitignore`: specify intentionally untracked files to ignore

### Config

`git config --global user.name "<name>"`: set name attached to commits  
`git config --global user.email "<email address>"`: set email attached to commits  
`git config --global color.ui auto`: enable colorization of command line output  

### Making Changes

`git status`: shows the status of changes as untracked, modified, or staged
`git add <filename1 filename2 ...>`: add files to the staging area
`git add -p <files>`: interacively stage chuncks of a file

`git stash`: temporarily remove modifications to working directory (must be staged to be stashed)
`git stash pop`: recuperate stashed changes

`git blame <file>`: show who last edited which line

`git commit`: save the snapshot to the project history  
`git commit -m "message"`: commit and provide a message  
`git commit -a`: automatically notice any modified (but not new) files and commit  

`git diff <filename>`: show difference since the last commit
`git diff <commit> <filename>`: show differences in a file since a particular snapshot
`git diff <reference_1> <reference_2> <filename>`: show differences in a file between two snapshots
`git diff  --cached`: show what is about to be committed  
`git diff <firts-branch>...<second-branch>`: show content diff between two branches

`git bisect`: binary search history (e.g. for regressions)

### Remotes

`git remote`: list remotes
`git remote -v`: list remotes names and URLs
`git remote show <remote>`: inspect the remote

`git remote add <remote> <url | path>`: add a remote
`git branch --set-upstream-to=<remote>/<remote branch>`: set up correspondence between local and remote branch

`git push <remote> <branch>`: send objects to remote
`git push <remote> <local branch>:<remote branch>`: send objects to remote, and update remote reference

`git fetch [<remote>]`: retrieve objects/references from a remote
`git pull`: update the local branch with updates from its remote counterpart, same as `git fetch; git merge`

`git fetch && git show <remote>/<branch>`: show incoming changes

`git clone <url> [<folder_name>]`: download repository and repo history from remote  
`git clone --shallow`: clone only repo files, not history of commits

`git remote remove <remote>`: remove the specified remote
`git remote rename <old_name> <new_name>`: rename a remote

### Viewing Project History

`git log`: show history of changes  
`git log -p`: show history of changes and complete differences  
`git log --stat --summary`: show overview of the change  
`git log --follow <file>`: list version history fo file, including renames  
`git log --all --graph --decorate`: visualizes history as a DAG  
`git log  --oneline`: compact log  

`git show <commit>`: output metadata and content changes of commit  
`git cat-file -p <commit>`: output commit metadata

### Tag

Git supports two types of tags: *lightweight* and *annotated*.

A lightweight tag is very much like a branch that doesn’t change—it’s just a pointer to a specific commit.

Annotated tags, however, are stored as full objects in the Git database.
They’re checksummed;contain the tagger name, email, and date; have a tagging message; and can be signed and verifiedwith GNU Privacy Guard (GPG).
It’s generally recommended creating annotated tags so it's possible to have all this information.

`git tag`: list existing tags
`git tag -l|--list <pattern>`: list existing tags mathcing a wildard or pattern

`git tag <tag> [<commit_hash>]`: create a *lightweight* tag on the commit
`git tag -a <tag> [<commit_hash> -m <message>]`: create am *annotated* tag on the commit

`git push <remote> <tagname>`: push a tag to the remote
`git push <remote> --tags`: push commits and their tags (both types) to the remote

`git tag -d <tagname>`: delete a tag
`git push <remote> :refs/tags<tagname>:`: remove a tag from the remote
`git push <remote> --delete <tagname>`: remove a tag from the remote

`git checkout <tag>`: checkout a tag - **WARNING**: will go into *detached HEAD*

### Branching And Merging

`git branch`: shows branches
`git branch -v`: show branch + last commit

`git branch <branch-name>`: create new branch  
`git checkout -b <branch-name>`: create a branch and switches to it, same as `git branch <name>; git checkout <name>`  
`git branch`: show list of all existing branches  (* indicates current)  
`git checkout <branch-name>`: change current branch (update HEAD) and update working directory  
`git branch -d <branch-name>`: delete specified branch

`git merge <branch-name>`: merges into current branch  
`git merge --continue`: continue previous merge after solving a merge conflinct  
`git mergetool`: use a fancy tool to help resolve merge conflicts  
`git rebase`: rebase set of patches onto a new base
`git rebase -i`: interactive rebasing

`gitk`: show graph of history (git for windows only)

### Undo & [Rewriting History](https://www.themoderncoder.com/rewriting-git-history/)

`git commit --amend`: replace last commit by creating a new one (can add files or rewrite commit message)
`git commit --amend  --no-edit`: replace last commit by creating a new one (can add files or rewrite commit message)
`git reset HEAD <file>`: unstage a file  
`git reset <commit>`: undo all commits after specified commit, preserving changes locally  
`git checkout <file>`: discard changes  
`git checkout -- <file>`: discard changes, no output to screen  
`git reset --hard`: discard all changes since last commit
`git reset --hard <commit>`: discard all history and changes back to specified commit  
`git rebase -i HEAD~<n>`: modify (reword, edit, drop, squash, merge, ...) *n* commits

**WARNING**: Changing history can have nasty side effects

---

## How To

### Rebase Branches

```ps1
git checkout <primary_branch>
git pull  # get up to date

git checkout <feature_branch>
git rebase <primary_branch>  # rebase commits on master (moves branch start point on last master commit)

git chechout <primary_branch>
git rebase <feature_branch>  # moves commits from the branch on top of master
```

![branch](https://hackernoon.com/hn-images/1*iHPPa72N11sBI_JSDEGxEA.png "how branches work")

### Clone Branches

```ps1
git clone <repo>  # clone the repo

git branch -r  # show remote branches
git checkout <branch>  # checkout remote branch (omit <remote>/)

git pull  # clone branch
```

### [Sync Forks][github sync frok guide]

[github sync frok guide](https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/syncing-a-fork)

```ps1
git fetch upstream  # Fetch the branches and their respective commits from the upstream repository
git checkout main  # chechout fork's main primary branch

git merge upstream/main  # Merge the changes from the upstream default branch into the local default branch

git push  #  update fork on GitHub
```
