# [Git][git]

Git is a free and open source distributed [version control system][vcs] designed to handle everything from small to very large projects with speed and efficiency.

## Terminology

**Repository**: collection of files (blobs) and directories (trees) managed by git
**Commit**: snapshot of the entire repository and its metadata
**Head**: pointer to the current commit  
**Branch**: timeline or collection of consecutive commits  
**Remote**: remote shared repository in which changes as synced
**Working Tree**: current version of the repository on disk  
**Index (Staging Area)**: collection of changes not yet committed
**Stash**: collection of pseudo-commits not belonging to a specific branch

## Commands

### Managing Configs

There are three git config sources/scopes:

1. **system**: defined in git's installation folder and managed with `--system`
2. **global**: defined in `$HOME/.gitconfig` or `$XDG_CONFIG_HOME/git/config` and managed with `--global`
3. **local**: defined in `.git/config` and managed with `--local`

The applied config in each repository is the combination of all three scopes in order.

`git config [--<scope>] <key> <value>`: set git config key-value pair  
`git config [--<scope>] --unset <key>`: unset git config key-value pair  
`git config [--<scope>] --list`: list git config key-value pairs  

### Tracking Files & Making Changes

`git status`: shows the status of changes as untracked, modified, or staged  

`git add <files>`: add files contents to the staging area  
`git add -u|--update <files>`: stage changes but ignore untracked files  
`git add -p|--patch <files>`: interactively stage chunks of files  

`git restore .`: discard uncommitted changes  
`git restore <file>`: discard uncommitted changes to file  
`git restore --staged`: discard changes made to a file  
`git restore --staged --worktree`: unstage and discard changes made to a file  
`git restore -p|--patch`: interactively unstage chunks of files  

`git commit`: save the snapshot to the project history  
`git commit -m|--message "message"`: commit and provide a message  
`git commit -a|--all`: automatically notice any modified (but not new) files and commit  
`git commit -v|--verbose`: show unified diff between the HEAD commit and what would be committed  
`git commit --amend`: modify latest commit with the new changes  
`git commit --no-verify`: commit without executing hooks  
`git commit --fixup <commit>`: mark commit as correction to another  
`git commit -s|--signoff`: Add a `Signed-off-by` trailer by the committer at the end of the commit log message  

### Managing Stashes

`git stash [push] [-m|--message]`: add all changes to the stash (and provide message)  
`git stash [push] -k|--keep-index`: create a stash but leave files as they are  
`git stash list` list all stashes  
`git stash show [<stash>]`: show changes in the stash  
`git stash pop`: restore last stash  
`git stash drop [<stash>]`: remove a stash from the list  
`git stash clear`: remove all stashes  

### Managing Remotes

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
`git pull`: incorporate remote changes by merging, same as `git fetch; git merge`  
`git pull --rebase`: incorporate remote changes by rebasing  
`git pull --ff`: fast-forward (only update branch tip) remote changes, merge if not possible  
`git pull --ff-only`: fast-forward (only update branch tip) remote changes, error if not possible  

`git fetch|pull -p|--prune`: remove any remote-tracking references that no longer exist on the remote  
`git fetch|pull -t|--tags`: retrieve all tags from the remote

`git clone <url> [<folder_name>]`: download repository and repo history from remote  
`git clone --shallow`: clone only repo files, not history of commits  
`git clone --depth <depth>`: clone only last `<depth>` commits  

> **Note**: for a in depth explanation of `--force-if-includes` see [this][force-if-includes]

### Viewing Project History

`git log`: show history of changes  
`git log -p|--patch`: show history of changes and complete differences  
`git log --stat --summary`: show overview of the change  
`git log --follow <file>`: list version history fo file, including renames  
`git log --all --graph --decorate`: visualizes history as a DAG  
`git log --oneline`: compact log  

`git log -S<string>`: Look for diffs that change the number of occurrences of the specified `<string>`  
`git log -G<regex>`: Look for diffs whose patch text contains added/removed lines that match `<regex>`  

`git log -L <start>,<end>:<file>`: Trace the evolution of the line range given by `<start>,<end>`, within the `<file>`  
`git log -L /<regex>/:<file>`: Trace the evolution of the line range given by the function name regex `<regex>`, within the `<file>`  

`git log -<n>`: Include last `<n>` commits  
`git log <rev>`: Include commits that are reachable from `<rev>`  
`git log ^<rev>`: Exclude commits that are reachable from `<rev>`  
`git log <rev1>..<rev2>`: Include commits that are reachable from `<rev2>` but exclude those that are reachable from `<rev1>`  
`git log <rev1>...<rev2>`: Include commits that are reachable from either `<rev1>` or `<rev2>` but exclude those that are reachable from both  
`git log <rev>^@`: Include anything reachable from `<rev>` parents but not the commit itself

> **Note**: when `<rev>` is omitted it defaults to HEAD

`git shortlog`: list commits by author  
`git reflog [<rev>]`: show record of when the tips of branches and other references were updated in the local repository  

`git show <commit>`: show commit metadata and content  
`git show --stat <commit>`: show number of changes in commit  

`git blame <file>`: show who last edited which line  
`git blame -L <start>,<end> -- <file>`: Annotate only the line range given by `<start>,<end>`, within the `<file>`  
`git blame -L /<regex>/ -- <file>`: Annotate only the range given by the function name regex `<regex>`, within the `<file>`  
`git blame -w`: Ignore whitespace when comparing the parent’s version and the child’s to find where the lines came from  
`git blame -M`: Detect moved or copied lines within a file.  
`git blame -M -C [-C -C]`: Detect moved or copied lines within a file (`-M`), from all modified files in the same commit (`-C`), in the commit that created the file (`-C -C`), in all commits (`-C -C -C`)  

`git diff <filename>`: show difference since the last commit  
`git diff <commit> <filename>`: show differences in a file since a particular snapshot  
`git diff <reference_1> <reference_2> <filename>`: show differences in a file between two snapshots  
`git diff  --staged`: show what is about to be committed  
`git diff <first-branch>...<second-branch>`: show content diff between two branches  
`git diff -w|--ignore-all-space`: show diff ignoring whitespace differences  
`git diff --word-diff`: show diff word-by-word instead of line-wise  

`git bisect start`: start binary search through commit history, to find the first "bad" commit  
`git bisect good`: mark current commit as "good"  
`git bisect bad`: mark current commit as "bad"  
`git bisect reset`: conclude search and restore HEAD  

### Managing Tags

Git supports two types of tags: *lightweight* and *annotated*.  

A lightweight tag is very much like a branch that doesn't change: it's just a pointer to a specific commit.  

Annotated tags, however, are stored as full objects in the Git database.  
They're checksummed; contain the tagger name, email, and date; have a tagging message; and can be signed.  
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

`git switch <tag>`: checkout a tag - **WARNING**: will go into *detached HEAD*  

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
`git rebase <branch>`: rebase current branch commits onto another branch  
`git rebase --onto <new-base> <old-base>`: rebase a slice of commits from `<old-base>` onto `<new-base>`  

`git cherry-pick <commit>`: bring in a commit from another branch  
`git cherry-pick <commit>..<commit>`: bring in a range of commits from another branch (first excluded)  
`git cherry-pick <commit>^..<commit>`: bring in a range of commits from another branch (first included)  

### Worktrees

A git repository can support multiple working trees, allowing to check out more than one branch at a time.

Additional worktrees are called "linked worktrees" as opposed to the "main worktree" prepared by `git init` or `git clone`.  
A repository has one main worktree (if it’s not a bare repository) and zero or more linked worktrees.

`git worktree list`: show worktrees  
`git worktree add <path> <commit>`: create worktree at `<path>` and checkout `<commit>`  
`git worktree add -b <branch> <path> <commit>`: create worktree and branch at `<path>`  
`git worktree remove <worktree>`: remove a worktree  

### Rewriting History

`git commit --amend`: replace last commit by creating a new one (can add files or rewrite commit message)  
`git commit --amend -m "amended message"`: replace last commit by creating a new one (can add files or rewrite commit message)  
`git commit --amend  --no-edit`: replace last commit by creating a new one (can add files or rewrite commit message)  

`git reset <commit>`: revert to specific commit but keep changes  
`git reset --soft <commit>`: revert to specific commit but keep changes and staged files  
`git reset --hard <commit>`: revert to specific commit and discard changes  
`git reset <commit> <file>`: revert `<file>` to specific commit  

`git clean`: remove untracked files form the working tree  
`git clean -d`: remove untracked files recursively  
`git clean --interactive`: remove untracked files interactively  

`git restore --source <commit> <file>`: revert file to commit version  
`git restore <deleted-file>`: recover deleted file if previously committed  

`git rebase -i|--interactive`: modify (reword, edit, drop, squash, merge, ...) current branch commits  
`git rebase -i|--interactive HEAD~<n>`: modify (reword, edit, drop, squash, merge, ...) *n* commits  
`git rebase -i|--interactive <commit>`: modify (reword, edit, drop, squash, merge, ...) *from* commit to latest  
`git rebase --autostash`: automatically create a temporary stash entry before rebasing  
`git rebase --autosquash`: automatically apply "squash!" or "fixup!" or "amend!" commits  

<!-- links -->
[git]: https://git-scm.com/ "Git Home Page"
[vcs]: https://en.wikipedia.org/wiki/Version_control "VCS on Wikipedia"
[force-if-includes]: https://stackoverflow.com/a/65839129 "git --force-if-includes explanation"
