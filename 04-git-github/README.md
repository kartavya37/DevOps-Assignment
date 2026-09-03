# Git / GitHub

**Name:** Kartavya Panchal
**Roll No.:** 24BCS10343

I did both tasks in a throwaway practice repo so the output stays readable.

---

## Task 1: `git commit -m` vs `git commit -a -m`

`-a` stages the files git already knows about. It does nothing for files git has never seen.

So it covers modified and deleted *tracked* files, and skips untracked ones entirely. It is
not a shortcut for `git add .`, which is what I assumed before actually testing it.

```console
$ git init -q . && git branch -M main && echo "init done"
init done

$ git config user.name "Kartavya Panchal"

$ git config user.email "kartavya.panchal@scalerailabs.com"

$ echo "# Notes app" > README.md

$ git add README.md

$ git commit -m "Add README" -q && git log --oneline
20a87bd Add README

### change a tracked file, and add an untracked one
$ echo "line added later" >> README.md

$ echo "print(1)" > script.py

$ git status --short
 M README.md
?? script.py

### plain -m with nothing staged
$ git commit -m "try to commit without staging"
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   README.md

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	script.py

no changes added to commit (use "git add" and/or "git commit -a")

### -a picks up the modified tracked file
$ git commit -a -m "Update README using -a flag" && git log --oneline
[main a51f4ea] Update README using -a flag
 1 file changed, 1 insertion(+)
a51f4ea Update README using -a flag
20a87bd Add README

$ git status --short
?? script.py

### script.py needs an explicit add
$ git add script.py && git commit -m "Add script.py after git add" -q && git log --oneline
1f91fda Add script.py after git add
a51f4ea Update README using -a flag
20a87bd Add README

$ git status --short
```

`M` in `git status --short` means a modified tracked file, `??` means untracked. Plain
`git commit -m` refused because nothing was staged. `git commit -a -m` then committed 1 file
changed, only `README.md`, and `script.py` was still sitting there as `??` afterwards.

This is the part that would actually bite me. Running `git commit -a -m`, assuming everything
is in, and finding out later that a whole new file never got committed and the build is broken
for everyone else.

---

## Task 2: cherry-pick

`git cherry-pick <commit>` copies the changes from one commit onto the branch you're on, as a
new commit with a new hash. Merge and rebase move whole branches; cherry-pick takes one commit.
The case for it is "I need that one fix from the feature branch on main, and none of the rest".

Four commits on main, then a branch with three more, then pull across only the hotfix:

```console
$ git log --oneline
1f91fda Add script.py after git add
a51f4ea Update README using -a flag
20a87bd Add README

$ echo "notes.txt is for daily notes" > notes.txt && git add notes.txt && git commit -q -m "Add notes.txt on main" && git log --oneline
a02b0a3 Add notes.txt on main
1f91fda Add script.py after git add
a51f4ea Update README using -a flag
20a87bd Add README

$ git switch -c feature-login
Switched to a new branch 'feature-login'

$ echo "def login(): pass" > login.py && git add login.py && git commit -q -m "Add login function" && echo done
done

$ echo "def logout(): pass" > logout.py && git add logout.py && git commit -q -m "Add logout function" && echo done
done

$ echo "HOTFIX: validate password length" > validate.py && git add validate.py && git commit -q -m "HOTFIX: add password validation" && echo done
done

$ git log --oneline
7cbaaa1 HOTFIX: add password validation
47f8e1a Add logout function
c0f9c5b Add login function
a02b0a3 Add notes.txt on main
1f91fda Add script.py after git add
a51f4ea Update README using -a flag
20a87bd Add README

### only what the branch adds
$ git log --oneline main..feature-login
7cbaaa1 HOTFIX: add password validation
47f8e1a Add logout function
c0f9c5b Add login function

### back to main. validate.py is not here yet
$ git switch main
Switched to branch 'main'

$ ls
README.md
notes.txt
script.py

$ git cherry-pick 7cbaaa1
[main 505a245] HOTFIX: add password validation
 Date: Thu Sep 3 21:25:32 2026 +0530
 1 file changed, 1 insertion(+)
 create mode 100644 validate.py

$ git log --oneline
505a245 HOTFIX: add password validation
a02b0a3 Add notes.txt on main
1f91fda Add script.py after git add
a51f4ea Update README using -a flag
20a87bd Add README

$ ls
README.md
notes.txt
script.py
validate.py

$ cat validate.py
HOTFIX: validate password length

$ git log --oneline --graph --all
* 7cbaaa1 HOTFIX: add password validation
* 47f8e1a Add logout function
* c0f9c5b Add login function
| * 505a245 HOTFIX: add password validation
|/  
* a02b0a3 Add notes.txt on main
* 1f91fda Add script.py after git add
* a51f4ea Update README using -a flag
* 20a87bd Add README
```

The graph is the clearest bit of evidence. Both branches share history up to
`a02b0a3 Add notes.txt on main`, where they split. `feature-login` carries all three of its
commits. Main got `505a245`, which is the hotfix and nothing else, and login/logout aren't
there.

The hash changing from `7cbaaa1` to `505a245` is the thing worth understanding: the original
commit stays where it is, and cherry-pick makes a copy of its diff. Same change, different
commit.

A few things I looked up while doing this. A cherry-pick can conflict just like a merge if the
surrounding code has moved on, and you resolve it the same way, `git add` the files then
`git cherry-pick --continue`, or `--abort` to back out. `git cherry-pick A^..B` takes a range
instead of one commit. And because the copy has a different hash, cherry-picking a commit and
then merging the same branch later can make the change show up twice in the log, so it's for
hotfixes rather than a general replacement for merging.
