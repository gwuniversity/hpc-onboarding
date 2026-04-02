# Submitting Jobs on Clusters using SLURM

This article provides a tutorial for submitting jobs with SLURM, the scheduler used on George Washington University’s high-performance computing (HPC) clusters. It will go over the difference between batch jobs and interactive jobs, the relative strengths and weaknesses of each, and the process involved for submitting each type on the cluster.

## Background Information on Jobs and Job Types

In the context of clusters, a “job” is simply a task that is sent to a compute node to complete. The job can contain anywhere from a single piece of code to be run independent of user input, or comprise a period of time for more complex tasks requiring a GUI or user interaction.

Jobs are typically divided into two types: batch jobs and interactive jobs. Our HPC infrastructure is optimized for the former compared to the latter, as is usually the case with shared-system clusters. Thus, where possible, **try to submit your code as a batch job if you can**. Only use interactive jobs if your research absolutely requires you to, and the solutions for interactive software provided on Open OnDemand are insufficient. Please do not submit an interactive job simply to run code directly in the terminal that could be done via batch submission—it will not only be less efficient for your own research, but will cause backups in the queuing system that can impact access to resources for other users\! Be cognizant of others and use the clusters wisely.

**NOTE:** If your code has dependencies or input datasets, make sure that you load or install the former at the start of your script and upload the latter to a location in the cluster (and adjust the filepaths in your code to refer to said location—your code on these clusters can only see files on that cluster, not on your local device\!).

---

## Submitting Batch Jobs with sbatch

We begin with the preferred method of submitting jobs on our HPC systems, that being using a job submission script to submit a batch job with the **`sbatch`** command. Code submitted via this manner should require no user input in the middle of the process, and ensure that results are saved to a location on Pegasus. Failure to accommodate these factors will mean your job will either not complete properly, or results will be calculated but not saved.

Every batch job has a script you must submit with it. Within this page, you should see “cpu\_job\_submission\_template.sh” and "gpu\_job\_submission\_template.sh" files that you can download and read through all the comments; they explain each of the options and how to set/use them. As of February 7th, 2026, all clusters have shifted from a node-based allocations system to a resource-based allocation system. While this requires a bit more information to be specified on the researcher's end, the advantages that come with this approach strongly outweigh this slightly more complex submission script. Notably, compared to the previous system, you should be able to obtain resources much quicker and be waiting for a lot less than before. Old submission scripts will still work through roughly the end of the Spring 2026 semester, but we encourage users to take advantage of the new format and adjust their scripts as soon as possible to make the most of the benefits resource-based allocation provides, as well as to avoid any troubles that may occur once this transition period ends 90 days after February 7th, 2026.

Once your script has been adjusted for your needs, save your edits, type `sbatch \[filepath\]` and press enter to send your job to the queue via SLURM, where the filepath is the submission script. You will get a job ID if it’s been successfully submitted; keep note of it, in case you need to file a ticket for a problem you can’t diagnose. From there, you can check your job as it’s pending or running using *`squeue`* or after it's done with *`sacct`*.

A good analogy for this style of job submission is that of traditional snail mail. Your sbatch options within the script are the address and housing details, ensuring that it gets to the correct type of node you need your code to run on. The code after the options is the content you wish to be run on the node once it has been assigned to you; much like with traditional mail, what you send is what they get. You can’t edit it or interact with it once it’s there, so make sure the code works with small test jobs prior to submitting your larger, full job\!

Batch jobs will finish when your code has ended (either successfully by running fully or upon encountering an error) or when your time limit has been reached, whichever comes first. If your job is still running at the end of your set time limit, it will terminate at that very moment, regardless of if there is still more to finish. Thus, make sure your time limit is long enough for your code to finish within while still being under the maximum time allowed for your desired queue\!

---

## Submitting Interactive Jobs with salloc

We now move onto the command for reserving a node for interactive work, known as an interactive job, using the **`salloc`** command. As a reminder, this method of interacting with compute nodes should only be used as a last resort once all other options have been exhausted. Interactive jobs, both those obtained using salloc and those present on Open OnDemand, are still jobs submitted via SLURM, thus they have an associated impact on your overall priority. In general, interactive jobs tend to have worse priority than batch jobs—this means that in a queue with several pending jobs, batch jobs tend to get resources sooner than interactive jobs do. As of February 28th, 2026, the new resource-based allocation system only works with salloc interactive jobs; Open OnDemand still uses the old style of job submission, but will be updated soon.

Unlike batch jobs, interactive jobs do not need a script to be submitted alongside the command. In essence, you are requesting an allocation of resources from a node to be reserved for your personal use for a certain period of time by using this command. Our current policy is that the maximum amount of time permitted in an interactive job of any sort is 24 hours, or one day. Though some system changes have made implementing it difficult in recent months, please ensure you do not submit interactive jobs longer than a day. We may terminate jobs that go for longer than that manually. Additionally, the requested resource allocation must be available at the moment of using this command. If your requested resources aren't available on any node, it will hang and wait on the terminal.

To use this command with the new resource-based allocation system, you'll need to give some different options based on whether or not your job is a CPU or GPU job. Below we provide some examples for Pegasus; these options are the exact same as the batch job options in the templates with similar requirements (-t and -p are both absolutely required, the other options need to be specified to go beyond the limited defaults or obtain a GPU outright, etc.), so please review that document to understand what each portion means for your own adjustments.

### CPU Interactive Job Examples

`salloc -p cpu -t 2\:00\:00 --cpus-per-task=8 --mem=16G`  
`salloc -p cpu -t 30:00 --cpus-per-task=4 --mem-per-cpu=2G`

### GPU Interactive Job Examples

`salloc -p gpu -t 30:00 --gres=gpu\:v100\:1 --cpus-per-gpu=4 --mem=16G`  
`salloc -p gpu -t 2\:00\:00 --gres=gpu\:a100\:1 --cpus-per-task=8 --mem-per-cpu=4G`

Entering these commands will display a jobID associated with your interactive job, which you'll need to keep in mind for later. Once your allocation has been confirmed, you can gain access to your interactive resources using the command **`srun --pty bash`**. If you have multiple interactive allocations, to get the exact one you desire, please use the command **`srun --jobid \[jobID\] --pty bash`** instead, where \[jobID\] is the job ID for the particular allocation you're interested in accessing. From there, you can run code directly through the command line as you’d like until your time limit has hit. Make sure that you aren’t doing so on the login node, as running code on the login nodes is strictly prohibited\! If you’re done doing what you want with time still remaining on your reservation, exit the node by typing “exit” and hitting enter, followed by **`scancel \[jobID\]`** \+ enter, with the job ID you saw earlier in this process. That will free the resources, allowing them to be used by another researcher, so make sure you cancel your interactive jobs once you’ve done everything you want to on them\!

**NOTE:** The interactive jobs that go through Open OnDemand (this will be the next tutorial, still being written at the moment\!) also have this same process, where you will need to make sure to cancel the job once you are done with it. Please be sure to cancel, as leaving nodes unused for hours on end slows down the queue system for everybody, not just yourself.

---

## Controlling Job Placement and Performance

In addition to requesting resources, you can control how your job is placed and runs on a node. This can have a significant impact on performance, particularly for multi-core and parallel workloads. When a job is assigned to a node, SLURM determines where each task (or rank) will run and how it utilizes CPU cores and memory. Workloads that

- use many CPU cores  
- rely on frequent communication between tasks  
- are sensitive to memory bandwidth or latency  

may benefit from this type of granular control. 

### Controlling Task Placement

SLURM provides several options to control how tasks are distributed across a node:

- `--ntasks-per-node`  
  Controls how many tasks are placed on each node  

- `--ntasks-per-socket`  
  Helps align tasks with CPU sockets  

- `-m, --distribution={*|block|cyclic|arbitrary|plane=<size>}[:{*|block|cyclic|fcyclic}[:{*|block|cyclic|fcyclic}]][,{Pack|NoPack}]`  
  Controls how tasks are spread across available hardware

- `-B, --extra-node-info=<sockets>[:cores[:threads]]`  
  Restrict node selection to nodes with at least the specified number of sockets, cores per socket and/or threads per core.

These options allow you to organize how your job is laid out without changing the total resources requested.

### Binding Tasks to Hardware / Task Affinity

In addition to placement, researchers can control how tasks are bound to CPU cores and memory, which may be 
useful for jobs that show variability in runtime between runs:

- `--cpu-bind` (srun only)  
  Pins tasks to specific CPU cores to improve consistency  

- `--mem-bind` (if needed)  
  Helps keep memory access local to the CPU running each task 

**NOTE:** Pegasus is configured to support task affinity. This means that CPU and memory resources are tracked 
at a fine-grained level, and options such as `--cpu-bind` and `--mem-bind` will behave as expected when used. 
Most users do not need to worry about these details, but they are available for workloads that require more precise 
control.

### Example: Refining Task Placement  

```
#!/bin/bash
#SBATCH -p cpu
#SBATCH -t 1:00:00
#SBATCH --ntasks=40
#SBATCH --ntasks-per-node=20
#SBATCH --ntasks-per-socket=10
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G

srun --cpu-bind=cores your_program
```  

### General Guidance

For most workloads:

- Start with simple resource requests and add placement options as necessary.   
- Use small test jobs to evaluate performance before scaling up. RTS staff will be happy to assist you if needed.  
- Add binding options if your workload shows inconsistent performance. 

---

## Further Assistance

Should you have any issues using any of these commands, such as difficulties with loading certain modules or running your code non-interactively, please email [hpchelp@gwu.edu](mailto:hpchelp@gwu.edu) and detail the problems you encountered. Someone at Research Technology Services (RTS) will assist you as available\!
