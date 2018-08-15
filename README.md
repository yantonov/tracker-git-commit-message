### tool to simplify git development with [yandex.tracker](https://yandex.com/tracker/)

#### Purpose
Automatically add ticket number (id) (or number and summary) to commit messages.

#### Installation
##### prerequisites

1. [get oauth token](https://tech.yandex.com/connect/tracker/api/concepts/access-docpage/)
2. save OAuth token at /path-to-this-repo/oauth_token file (ignored by git for security reasons)  
3. add this repository to $PATH  
4. install commit hook by  

`
install-tracker-commit-hook.sh
`

##### usage  

##### scenatio 1 - create new branch
1. go to your git repository
2. branch.sh ISSUEID  
branch 'ISSUEID' will be created with meta info obtained from st
3. commit 
    1. with descriptive message  
    git commit -m "descriptive message"  
    Your actual commit message will be: ISSUEID - descriptive message  
    2. with empty message  
    git commit  
    Your actual commit message will be: ISSUEID - summary from st  


##### scenario 2 - save issue description for existing branch
1. go to your git repository
2. checkout existing branch
2. ticket.sh ISSUEID  
meta info from st is saved into git config
3. commit 
    1. with descriptive message  
    git commit -m "descriptive message"  
    Your actual commit message will be: ISSUEID - descriptive message  
    2. with empty message  
    git commit  
    Your actual commit message will be: ISSUEID - summary from st  

##### custom branch name prefixes
Sometimes fixed prefix must be added to branch name (due to team convention, for example).  
You can achieve this:

`
/path-to-this-repo/bin/set-branch-name-prefix.sh feature/
`

After that, if you create branch by

`
branch.sh ISSUEID
`

name of newly create branch will be equal to 'feature/ISSUEID'  
Custom prefix name is defined at repository level.
