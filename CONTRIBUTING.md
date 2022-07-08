# How to contribute

## Project management
Tasks are tracked via the github `Project`, this direct link should work: https://github.com/lijcam/Instruqt/projects/1
![A test image](.markdown_svg/project_flow.svg)

From here, you can self-contribute in the following ways:

* dump your rough lab ideas in the "incubating" column. Make sure you create a github issue, or convert it to an issue. Add the `lab` label. 
* refine existing incubating idea into a well defined lab.
* Add fixes / improvements in the backlog
* Pick up existing tasks from the Todo column, and work on them.
* Add comments on existing tasks.

We plan to run regular meetings (fortnightly) with a focus on transitioning Academy sessions (Labs) ideas from Incubating to the backlog, and to prioretize tasks to transition from the backlog to the todo.
We plan to have a dedicated google chat channel once online discussions start to pick up.

## The Instruqt platform

You will need an instruqt account. Contact Natale V. to gain access to the redhat account

The instruqt **documentation** is reasonably good and short. It's worth spending 1h going through it. The Instruqt **slack** channel is active / monitored by Instruqt time. It's a good way to get some tips, ask for help etc... Instruqt staff normally work in european timezone.

## Guideline
### Admonition
Instruqt doesn't (yet) comes with admonition. Until then, let's use the same style, i.e. leveraging html rendering in markdown.
If you feel like you can find a better way, nicer looking style, please contribute and update this file. Otherwise, just use the following:
#### Information
> &#8505;&#65039; **INFO**: Some Infos

which use the code below
```
> &#8505;&#65039; **INFO**: Some Infos
```

#### Warning
> &#9888;&#65039; **WARNING**: Be careful, or else!

which uses the code bellow
```
> &#9888;&#65039; **WARNING**: Be careful, or else!
```

### Tips
When you need to visualize quickly your changes on the markdown documents, you have several options with pros and cons:
- rendering locally. The markdown rendering might slightly differ, as the one from Instruqt might have some bugs.
- pushing the track via the CLI. The track will be rebuild, and you will need to fully restart the track which takes time (VM start, script to start OC)
- adding a flag in some of your setup script, i.e. to NOT start oc, saving some times.
- pushing the markdown via Instruqt GUI. This will give you immediate results.
