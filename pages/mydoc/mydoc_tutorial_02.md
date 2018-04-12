---
title: Introduction to HPCC Cluster and Linux
sidebar: mydoc_sidebar
permalink: mydoc_tutorial_02.html 
---


## HPCC Cluster Overview

The HPCC Cluster (formerly called biocluster) is a shared research computing system available at UCR. The HPCC website is available [here](http://hpcc.ucr.edu/index.html).

### What Is a Computer Cluster?

* A computer cluster is an assembly of CPU units, so called computer nodes that work together to perform many computations in parallel. To achieve this, an internal network (e.g. Infiniband interconnect) connects the nodes to a larger unit, while a head node controls the load and traffic across the entire system.

* Usually, users log into the head node to submit their computer requests via `srun` to a queuing system provided by resource management and scheduling software, such as SGE, Slurm or TORQUE/MAUI. The queuing system distributes the processes to the computer nodes in a controlled fashion.

* Because the head node controls the entire system, users should never run computing jobs on the head node directly!

* For code testing purposes, one can log into one of the nodes with `srun --pty bash -l` and run jobs interactively. Alternatively, one can log into the test node owl via ssh.

### Hardware Infrastructure

### Computer nodes

- Over 4,500 CPU cores
- 48 AMD computer nodes, each with 64 CPU cores and 512GB RAM
- 40 Intel computer nodes, each with 32 CPU cores and 512GB RAM
- 6 high-memory nodes, each 32 CPU cores and 1024GB RAM
- 12 GPU nodes, each with 5,000 cuda cores
    
### Interconnect 
- FDR IB @56Gbs 

### Storage

- Parallel GPFS storage system with 2.1 PB usable space
- Backup of same architecture and similar amount

### User traffic

- Computing tasks need to be submitted via `srun`
- HPCC Cluster headnode only for login, not for computing tasks!
- Monitor cluster activity: `squeue` or `jobMonitor` (`qstatMonitor`)

### Manuals

- [HPCC Cluster Manual](http://hpcc.ucr.edu/manuals_linux-cluster_intro.html)
- [Linux Manual](http://hpcc.ucr.edu/manuals_linux-basics.html)


## Linux Basics

### Log into HPCC Cluster

+ Login command on OS X or Linux 

```sh
ssh -XY user@biocluster.ucr.edu
```
  
Type password

+ Windows: provide same information in a terminal application like [Putty](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html) or [MobaXterm](http://mobaxterm.mobatek.net/).
    
    + Host name: `biocluster.ucr.edu`
    + User name: ...
    + Password: ...


### Important Linux Commands

Finding help
```sh
man <program_name>
```
        
List content of current directory
```sh
ls
```

Print current working directory
```sh
pwd
```

Search in files and directories
```sh
grep
```

Word count
```sh
wc
```

Create directory
```sh
mkdir
```

Delete files and directories
```sh
rm
```

Move and rename files
```sh
mv
```

Copy files from internet to `pwd`
```sh
wget
```

Viewing files
```sh
less
```


### File Exchange

__GUI applications__

+ Windows: [WinSCP](http://winscp.net/eng/index.php)
+ Mac OS X: [CyberDuck](http://cyberduck.en.softonic.com/mac)
+ Win/OS X/Linux: [FileZilla](https://filezilla-project.org/)
        
__SCP command-line tool__

```sh
scp file user@remotehost:/home/user/ # From local to remote 
scp user@remotehost:/home/user/file . # From remote to local 
```

	
### STD IN/OUT/ERR, Redirect & Wildcards

Wildcard `*` to specify many files
```sh
file.*                        
```
Redirect `ls` output to file
```sh
ls > file                     
```
Specify file as input to command
```sh
command < myfile              
```
Append output of command to file
```sh
command >> myfile             
```
Pipe `STDOUT` of one command to another command
```sh
command1 | command2     
```
Turn off progress info 
```sh
command > /dev/null 
```
Pipe output of `grep` to `wc`
```sh
grep pattern file | wc        
```
Print `STDERR` to file
```sh
grep pattern nonexistingfile 2 > mystderr 
```

### Homework Assignment (HW2)

See HW2 page [here](http://girke.bioinformatics.ucr.edu/GEN242/mydoc_homework_02.html).

### Permissions and ownership

List directories and files

```sh
ls -al 
```

The previous command shows something like this for each file/dir: `drwxrwxrwx`. The 
meaning of this syntax is as follows:
         
* `d`: directory
* `rwx`: read, write and execute permissions, respectively
    * first triplet: user permissions (u)
    * second triplet: group permissions (g)
    * third triplet: world permissions (o)

Example for assigning write and execute permissions to user, group and world
```sh
chmod ugo+rx my_file
```

* `+` causes the permissions selected to be added
* `-` causes them to be removed
* `=` causes them to be the only permissions that the file has.

Syntax for changing user & group ownership
```sh
chown <user>:<group> <file or dir> 
```

### Symbolic Links
Symbolic links are short nicknames to files and directories that save typing of their full paths. 
```sh
ln -s original_filename new_nickname
```


## Software and module system

* Over 750 software tools are currently installed on HPCC Cluster
* Most common research databases used in bioinformatics are available
* Support of most common programming languages used in research computing
* A module system is used to facilitate the management of software tools. This includes any number of versions of each software.
* New software install requests can be sent to support@biocluster.ucr.edu.
* To use software manged under the module system, users need to learn using some basic commands. The most common commands are listed below.

Print available modules
```sh
module avail
```

Print available modules starting with R
```sh
module avail R
```

Load default module R
```sh
module load R
```

Load specific module R version
```sh
module load R/3.2.2
```

List loaded modules
```sh
module list
```

Unload module R
```sh
module unload R
```

Unload specific module R
```sh
module unload R/3.2.3-dev
```


## Big data storage

Each user account on HPCC Cluster comes only with 20GB of disk space. Much more disk space is 
available in a dedicated `bigdata` directory. How much space depends on the subscription 
of each user group. The path of `bigdata` and `bigdata-shared` is as follows:

* `/bigdata/labname/username`
* `/bigdata/labname/shared`

All lab members share the same bigdata pool. The course number `gen242` is used as `labname`
for user accounts adminstered under GEN242.

The disk usage of `home` and `bigdata` can be monitored on the [HPCC Cluster Dashboard](https://dashboard.bioinfo.ucr.edu/).


## Queuing system: `Slurm` 

HPCC Cluster uses `Slurm` as queuing and load balancing system. To control user traffic, any 
type of compute intensive jobs need to be submitted via the `sbatch` or `srun` (see below) to the computer
nodes. Much more detailed information on this topic can be found on these sites: 

+ [UCR HPCC Manual](http://hpcc.ucr.edu/manuals_linux-cluster_jobs.html)
+ [Slurm Documentation](https://slurm.schedmd.com/documentation.html)
+ [Torque/Slurm Comparison](http://www.nersc.gov/users/computational-systems/cori/running-jobs/for-edison-users/torque-moab-vs-slurm-comparisons/)
+ [Switching from Torque to Slurm](https://sites.google.com/a/case.edu/hpc-upgraded-cluster/slurm-cluster-commands)
+ [Slurm Quick Start Tutorial](http://www.ceci-hpc.be/slurm_tutorial.html)

### Job submission with `sbatch`

Print information about queues/partitions available on a cluster.
```sh
sinfo
```

Compute jobs are submitted `sbatch` via a submission script (here `script_name.sh`).

```sh
sbatch script_name.sh
```

The following sample submission script (`script_name.sh`) executes an R script named `my_script.R`.

```sh
#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=1-00:15:00 # 1 day and 15 minutes
#SBATCH --mail-user=useremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --job-name="some_test"
#SBATCH -p batch # Choose queue/parition from: intel, batch, highmem, gpu, short

Rscript my_script.R
```

Interactive session: logs user into node
```sh
srun --pty bash -l
```

Interactive session with specific resource requests
```sh
srun --x11 --partition=short --mem=2gb --cpus-per-task 4 --ntasks 1 --time 1:00:00 --pty bash -l
```

`STDOUT` and `STDERROR` of jobs will be written to files named `slurm-<jobid>.out` or to custom a file specified under `#SBATCH --output` in the submission script. 

### Monitoring jobs with `squeue`

List all jobs in queue
```sh
squeue
```

List jobs of a specific user
```sh
squeue -u <user>
```

Print more detailed information about a job
```sh
scontrol show job <JOBID>
```

Custom command to summarize and visualize cluster activity
```sh
jobMonitor
```

### Deleting and altering jobs 

Delete a single job
```sh
scancel -i <JOBID>
```

Delete all jobs of a user
```sh
scancel -u <username> 
```

Delete all jobs of a certain name
```sh
scancel --name <myJobName>
```

Altering jobs with `scontrol update`. The below example changes the walltime (`<NEW_TIME>`) of a specific job (`<JOBID>`). 
```sh
scontrol update jobid=<JOBID> TimeLimit=<NEW_TIME>
```

### Resource limits

Resourse limits for users can be viewed as follows. 
```sh
sacctmgr show account $GROUP format=Account,User,Partition,GrpCPUs,GrpMem,GrpNodes --ass | grep $USER
```

Similarly, one can view the limits of the group a user belongs to. 
```sh
sacctmgr show account $GROUP format=Account,User,Partition,GrpCPUs,GrpMem,GrpNodes,GrpTRES%30 --ass | head -3
```


## Text/code editors

The following list includes examples of several widely used code editors.

* __Vi/Vim/Neovim__: Non-graphical (terminal-based) editor. Vi is guaranteed to be available on any system. Vim is the improved version of vi.
* __Emacs__: Non-graphical or window-based editor. You still need to know keystroke commands to use it. Installed on all Linux distributions and on most other Unix systems.
* __Pico__: Simple terminal-based editor available on most versions of Unix. Uses keystroke commands, but they are listed in logical fashion at bottom of screen. 
* __Nano__: A simple terminal-based editor which is default on modern Debian systems. 
* __Atom__: Modern text editor developed by GitHub project.

### Why does it matter?

To work efficiently on remote systems like a computer cluster, it is essential
to learn how to work in a pure command-line interface. GUI environments like
RStudio and similar coding environments are not suitable for this. In addition,
there is a lot of value of knowing how to work in an environment that is not
restricted to a specific programming language. Therefore, this class embraces
RStudio where it is useful, but for working on remote systems like HPCC Cluster, it 
uses Vim and Tmux. Both are useful for many programming languages.
Combinded with the `vim-r` plugin they also provide a powerful command-line working
environment for R. The following provides a brief introduction to this environment.

### Vim overview

The following opens a file (here `myfile`) with vim
```sh
vim myfile.txt
```

Once you are in Vim the most important commands are:

* `i`: The `i` key brings you into the insert mode for typing. 
* `Esc`: The `Esc` key brings you out of the insert mode.
* `:`: The `:` key starts the command mode at the bottom of the screen.

Use the arrow keys to move your cursor in the text. Using `Fn Up/Down key` allows to page through
the text quicker. In the following command overview, all commands starting with `:` need to be typed in the command mode. 
All other commands are typed in the normal mode after pushing the `Esc` key. 

Important modifier keys to control vim

* `:w`: save changes to file. If you are in editing mode you have to hit `Esc` first.
* `:q`: quit file that has not been changed
* `:wq`: save and quit file
* `:!q`: quit file without saving any changes

### Useful resources for learning vim

* [Interactive Vim Tutorial](http://www.openvim.com)
* [Official Vim Documentation](http://vimdoc.sourceforge.net/)
* [UCR Linux Manual](http://manuals.bioinformatics.ucr.edu/home/linux-basics#TOC-Vim-Manual)

## Vim-R-Tmux essentials 

Terminal-based Working Environment for R: [Vim-R-Tmux](http://manuals.bioinformatics.ucr.edu/home/programming-in-r/vim-r). <font color="red">Note: the new version of of vim-R is <a href="http://127.0.0.1:4000/mydoc_tutorial_02.html#nvim-r-tmux">nvim-R</a>. New users should use the new nvim-R instead of the old vim-R.</font>

<center><img title="Vim-R-Tmux" src="pages/mydoc/Rbasics_files/screenshot.png" ></center>
<center>Vim-R-Tmux IDE for R</center>


### Basics

Tmux is a terminal multiplexer that allows to split terminal windows and to detach/reattach to
existing terminal sessions. Combinded with the `vim-r` plugin it provides a powerful command-line working 
environment for R where users can send code from a script to the R console or command-line.
Both tmux and the `vim-r` plugin need to be installed on a system. On HPCC Cluster both are configured
in each user account. A detailed user manual is available [here](http://manuals.bioinformatics.ucr.edu/home/programming-in-r/vim-r).
The following gives a short introduction into the basic usage:

__1. Start tmux session__
```sh
tmux # starts a new tmux session 
tmux a #  attaches to an existing session 
```

__2. Open R script in vim__ 

This can be any of these file types: `*.R`, `*.Rnw` or `*.Rmd`.

```sh
vim myscript.R
```

__3. Open vim-connected R session by pressing the `F2` key__ 

This will open an R session in a separate tmux pane. Note, in the provided `.tmux.conf` file 
the command key binding has been reassigned from the tmux default `Ctrl-b` to `Ctrl-a`, 
and the shortcut for starting R from vim has been reassigned from `\rf` to `F2` in the `.vimrc` 
file. The command key binding `Ctrl-a` is the most important key sequence in order to move 
around in tmux. For instance, the key sequence `Ctrl-a o` will switch between the vim and R 
panes, and `Ctrl-a Ctrl-o` will swap the two panes. 

__4. Send R code vim to the R pane__

Single lines of code can be sent from vim to the R console by pressing the space bar. To send 
several lines at once, one can select them in vim's visual mode and then hit the space bar. 
Please note, the default command for sending code lines in the vim-r-plugin is `\l`. This key 
binding has been remapped in the provided `.vimrc` file to the space bar. Most other key 
bindings (shortcuts) still start with the `\` as LocalLeader, _e.g._ `\rh` opens the help for 
a function/object where the curser is located in vim. More details on this are given below.

### Important keybindings for vim

* `<F2>`: opens vim-connected R session; remapped in `.vimrc` from default `\rf` 
* `<spacebar>`: sends code from vim to R; here remapped in `.vimrc` from default `\l` 
* `:split` or `:vsplit`: splits viewport (similar to pane split in tmux)  
* `Ctrl-w-w`: jumps cursor to next viewport
* `Ctrl-w-r`: swaps viewports
* `Ctrl-s` and `Ctrl-x`: freezes/unfreezes vim (some systems)

### Important keybindings for tmux

__Pane-level commands__

* `Ctrl-a %`: splits pane vertically
* `Ctrl-a "`: splits pane horizontally
* `Ctrl-a o`: jumps cursor to next pane
* `Ctrl-a Ctrl-o`: swaps panes
* `Ctrl-a <space bar>`: rotates pane arrangement

__Window-level comands__

* `Ctrl-a n`: switches to next tmux window 
* `Ctrl-a Ctrl-a`: switches to previous tmux window
* `Ctrl-a c`: creates a new tmux window 
* `Ctrl-a 1`: switches to specific tmux window selected by number

__Session-level comands__

* `Ctrl-a d`: detaches from current session
* `Ctrl-a s`: switch between available tmux sesssions
* `$ tmux new -s <name>`: starts new session with a specific name
* `$ tmux ls`: lists available tmux session(s)
* `$ tmux attach -t <id>`: attaches to specific tmux session  
* `$ tmux attach`: reattaches to session 
* `$ tmux kill-session -t <id>`: kills a specific tmux session
* `Ctrl-a : kill-session`: kills a session from tmux command mode that can be initiated with `Ctrl-a :`

## Nvim-R-Tmux

<div id='overview'/>

### 1. Overview

This page gives an overview of the installation and usage of the new [Nvim-R](https://github.com/jalvesaq/Nvim-R) plugin from Jakson Alves de Aquino, the developer of the original vim-R plugin ([also available here](https://gist.github.com/tgirke/7a7c197b443243937f68c422e5471899)). The new plugin now also supports the new extension of Vim called [Neovim](https://neovim.io/). The main advantages of Neovim compared to Vim are its better performance and its built-in terminal emulator facilitating the communication among Neovim and interactive programming environments such as R. Since the Vim and Neovim environments are managed independently, one can run them in parallel on the same system without interfering with each other. The Nvim-R project page can be found [here](https://vim.sourceforge.io/scripts/script.php?script_id=2628) and its main manual is [here](https://raw.githubusercontent.com/jalvesaq/Nvim-R/master/doc/Nvim-R.txt). The usage section below introduces how to use the plugin with or without Tmux. 

<center><img title="Nvim-R-Tmux" src="https://raw.githubusercontent.com/jalvesaq/Nvim-R/master/Nvim-R.gif" ></center>
<center>Nvim-R-Tmux IDE for R</center>

<div id='intallation'/>

### 2 Installation

<div id='neovim'/>

#### 2.1 Install Neovim for your OS 
Neovim Version >= 0.1.7 is required for Nvim-R. For the installation, follow the instructions [here](https://github.com/neovim/neovim/wiki/Installing-Neovim). A sample config file for controlling Neovim, called `init.vim`, is given [here](https://gist.githubusercontent.com/tgirke/7a7c197b443243937f68c422e5471899/raw/init.vim). This or a similar `init.vim` file should be downloaded and saved to a user's home under `~/.config/nvim/init.vim`.

<div id='tmux'/>

#### 2.2 Install Tmux 
The usage of Tmux with Nvim-R is highly recommended on Linux or OS X systems but not absolutely necessary. Supported Tmux versions are >=2.0. To upgrade Tmux to a more recent version, one can follow the instructions [here](https://goo.gl/FssKpb). To install it from source, consult this [page](https://gist.github.com/P7h/91e14096374075f5316e#file-tmux_build_from_source_ubuntu-sh). If you get on Ubuntu 16.04 a `locale-gen en_US.UTF-8` error, then the last step [here](https://github.com/openwrt/packages/issues/2900) fixes it.  A sample config file for controlling Tmux, called `.tmux.conf`, is given [here](https://gist.githubusercontent.com/tgirke/7a7c197b443243937f68c422e5471899/raw/tmux.conf). This or a similar `.tmux.conf` file should be downloaded and saved to a user's home under `~/.tmux.conf`.

<div id='colorout'/>

#### 2.3 Install R package `colorout` 
The R package `colorout` is available on GitHub [here](https://github.com/jalvesaq/colorout). If it is not yet installed in an R environment, one can install it from within R via the `devtools` package as follows: 

```sh
devtools::install_github("jalvesaq/colorout")
```

<div id='nvimr'/>

#### 2.4 Install Nvim-R plugin for Neovim
Download the latest `*.vmb` from [here](https://vim.sourceforge.io/scripts/script.php?script_id=2628). Then open the downloaded file with nvim (neovim), and then run from nvim's command mode the following commands:

```sh
:packadd vimball
:so %
# press space bar a few times until install is complete!
```

<div id='nerdtree'/>

#### 2.5 Install Nerdtree (optional)
Download the Nerdtree vim plugin from [here](http://www.vim.org/scripts/script.php?script_id=1658). Then extract to `~/.config/nvim` with:

```sh
unzip NERD_tree.zip -d ~/.config/nvim
```

<div id='colorscheme'/>

#### 2.6 Color Scheme (optional)
Jakson Alves de Aquino has developed the `southernlights` color scheme that works well with Nvim-R. To enable it, users want to save the file `southernlights.vim` from this [repos](https://github.com/jalvesaq/southernlights) to `~/.config/nvim/colors/` and add the recommended bash configurations to your `.bashrc` as described [here](https://github.com/jalvesaq/southernlights). 

<div id='ucrhpcc'/>

#### 2.7 Step-by-step setup in user accounts of UCR's HPCC
Neovim and Tmux are already installed systemwide on the [HPCC](http://hpcc.ucr.edu/), but need to be loaded from the module system (step 1). What remains to be installed in each user's account are the plugins and configuration files (steps 2-5).

1. Add to your `.bashrc` the following lines

    ```sh
    if [ -n "$MODULESHOME" ]; then
        module load neovim
        module load tmux/2.2
    fi
    ```

2. Install Nvim-R plugin for Neovim as instructed [here](#nvimr)
3. Save this [`init.vim`](https://gist.githubusercontent.com/tgirke/7a7c197b443243937f68c422e5471899/raw/init.vim) sample file to `~/.config/nvim/init.vim`
4. Install Nerdtree plugin as instructed [here](#nerdtree)
5. Install `southernlights` color scheme as instructed [here](#colorscheme)
6. Now log out of the system and in again. After this start tmux and then open a `.R` or `.Rmd` file with `nvim` command. Next open a connected R session with the key combination `\rf` and then follow the usage instructions given [here](#usage).

<div id='ucrhpcc_quick'/>

#### 2.8 Quick setup in user accounts of UCR's HPCC

1. Log into your user account on HPCC and copy and paste these [install commands](http://biocluster.ucr.edu/~tgirke/Documents/R_BioCond/My_R_Scripts/vim-r-plugin/README_nvimRtmux).
2. To enable the nvim-R-tmux environment, log out and in again.
3. Follow usage instructions of next section.

<div id='usage'/>

### 3. Usage and configuration

The usage of Neovim is almost identical to Vim. Two important differences are:

1. The command for opening Neovim is `nvim` instead of `vim`.
2. Plugins are usually stored under `~/.config/nvim/` and the counter part of the `.vimrc` config file is `init.vim` located at `~/.config/nvim/init.vim`.

#### 3.1 Run R in built-in terminal emulator

Open a `*.R` or `*.Rmd` file with `nvim` and intialize a connected R session with `\rf`. This command can be remapped to other key combinations, e.g. uncommenting lines 10-12 in `init.vim` will remap it to the `F2` key. Note, the resulting split window among Nvim and R behaves like a split viewport in `nvim` or `vim` meaning the usage of `Ctrl-w w` followed by `i` and `Esc` is important for navigation.

Important keybindings for nvim (vim):

- `\rf`: opens vim-connected R session. If you do this the first time in your user account, you might be asked to create an `R` directory under `~/`. If so approve this action by pressing `y`. 
- `spacebar`: sends code from vim to R; here remapped in `init.vim` from default `\l`
- `:split` or `:vsplit`: splits viewport (similar to pane split in tmux)
- `gz`: maximizes size of viewport in normal mode (similar to Tmux's `Ctrl-a z` zoom utility) 
- `Ctrl-w w`: jumps cursor to R viewport and back; toggle between insert (`i`) and command (`Esc`) mode is required for navigation and controlling the environment.
- `Ctrl-w r`: swaps viewports
- `Ctrl-w =`: resizes splits to equal size
- `Ctrl-w 5< or 5>`: resizes splits to left or right by 5 steps; change number as needed
- `Ctrl-w H` or `Ctrl-w K`: toggles between horizontal/vertical splits
- `Ctrl-spacebar`: omni completion for R objects/functions when nvim is in insert mode. Note, this has been remapped in `init.vim` from difficult to type default `Ctrl-x Ctrl-o`. 
- `:h nvim-R`: opens nvim-R's user manual; navigation works the same as for any Vim/Nvim help document
- `:Rhelp fct_name`: opens help for a function from nvim's command mode with text completion support
- `Ctrl-s and Ctrl-x`: freezes/unfreezes vim (some systems)


#### 3.2 Run R in Tmux Pane

To run R in a separate Tmux pane, include the following two lines in your `init.vim`: 

    - `let R_in_buffer=0`
    - `let R_tmux_split=1`

Open a `*.R` or `*.Rmd` file with `nvim` and start R with `\rf`. Similarly as above, the `\rf` command can be remapped to other key combinations, e.g. uncommenting the three lines containing `F2` in `init.vim` will remap it to the `F2` key. To navigate among the Nvim and R panes, the key combination `Ctrl-w-o` is important. 

Important keybindings for Tmux panes:

- `Ctrl-a o`: jumps cursor to next pane e.g. from Nvim to R console pane
- `Ctrl-a Ctrl-o`: swaps panes
- `Ctrl-z z`: maximizes (zooms into) active pane

Note, closing R in this setup will also close the corresponding Tmux pane. This is different from the behavior of the older vim-R plugin where the R pane stayed open and returned a shell after quitting R. This behavior can be useful to open a different R version or ssh into remote systems while maintaining the connected Nvim pane from where code can still be sent to the original pane. To achieve a similar behavior with the new Nvim-R plugin, one can use the following workaround: 

1. Switch cursor scope to R esssion (with `Ctrl-a o`) and then execute from R pane `system("tmux set remain-on-exit on")`
2. Quit R with `q()`. This gives a dead pane that can be reactivated by starting a shell in it with the commands `Ctrl-a` and `:respawn-pane bash`

<div id='configfiles'/>

### 4. Config files
The following config files (or similar custom versions) should be saved to the following locations in a user's home directory:

- File [init.vim](https://gist.githubusercontent.com/tgirke/7a7c197b443243937f68c422e5471899/raw/init.vim) for Neovim: `~/.config/nvim/init.vim`
- File [tmux.conf](https://gist.githubusercontent.com/tgirke/7a7c197b443243937f68c422e5471899/raw/tmux.conf) for Tmux: `~/.tmux.conf`

