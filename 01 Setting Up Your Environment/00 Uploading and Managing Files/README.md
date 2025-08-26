# Uploading and Managing Files on HPC Clusters

This article outlines the process to upload, download and manage files within HPC clusters at GW, as well as the structure of the filesystems on the platform. Reading this article will give you an understanding of where particular files should go, how to organize and ensure data doesn’t get removed, as well as general policies regarding storage on the system. For the purposes of streamlining explanation, this article will use Pegasus as a central example, but other clusters maintained by GW have very similar structures.

**Note:** This article is exclusively for uploading files stored locally on a personal computer or device, not files stored in cloud systems (i.e. Google Drive, Box, etc.). For information on that, please refer to [this article](https://hpc.gwu.edu/pegasus/globus-setup/) present on the HPC website.

## Background Information on Pegasus’ Filesystems

Before outlining the steps to follow for uploading and maintaining files on Pegasus, it is important to understand some fundamentals regarding the storage space itself.

### Pegasus Directory Use Etiquette 

The majority of users within Pegasus will have a total of three main directories (or folders) which they will have access to: your home directory, your group directory, and a Scratch directory. While these are by no means completely binding, we recommend that you follow the following practices to most efficiently use your available storage, as well as avoid any potential data loss.

**Home Directory:** This is where you should store files that you want to keep for a longer period of time, or where files such as final results for individual projects should be transferred in order to be downloaded onto your personal device. For the most part, these should be files which will undergo minimal editing, things which are largely complete or just needed to start your actual program (i.e. initialization files for particular software, final results from code ran on Pegasus, etc.) While longer term than the Scratch filesystem, this is not intended to be a permanent storage space either; once you are no longer affiliated with the university, these files will become inaccessible to you unless you go through the process of obtaining an affiliate account. Thus, we recommend that you regularly download files from here onto your own device/storage unit so that you can keep them for future use\!

**Group Directory:** Much like the home directory, except for things you want everyone in your research group to be able to download. Follows the same rules as the home directory for the most part, so these should mostly be files that are self-contained and not being regularly edited or revised by numerous members of the research group. The same removal of access due to lack of affiliation applies, but this time also at the college level (i.e. if you transfer between CCAS and another college within GW, your access to this directory may also be adjusted and will need to be requested for again if your research group changes).

**Scratch Space:** Used for collaborative works or files to run any jobs on Pegasus, such that multiple group members can adjust the same code or use the same input files to run different scripts. Thus, if you have code you wish to run on Pegasus, it and any important files that you need to get the script operational on HPC should be put into the Scratch space. This is meant as a temporary storage space to place anything you need to complete the research that doesn’t need to be kept for more than a month. Examples of suitable files are code (especially code you have multiple revisions of, and are saved locally on your device), input datasets for analysis, batch files for submitting your jobs to SLURM, and so on. Files that have existed for longer than 30 days will be automatically deleted, so make sure to move important files which you need to retain for longer than that to either of the aforementioned directories, particularly any results outputted from jobs\!

Please make sure that wherever possible, you follow the suggestions laid above. Doing so will allow for more efficient use of the cluster, improving performance for all users\!

### Storage Space Limitations

Another common question many have is the amount of storage available to them within Pegasus. Some fields are more data-intensive than others, and thus we partition available storage on a school-by-school basis, not individual users. Generally speaking, CCAS, SEAS and GWSPH have the largest partitions in terms of space, as these three schools account for a majority of Pegasus users. However, for the most up-to-date, accurate numbers for your particular situation, we recommend reaching out to RTS and scheduling a research intake session. You can do so by emailing [hpchelp@gwu.edu](mailto:hpchelp@gwu.edu) and describing your particular workflow and relevant details such as research group and school within the university in the body of your message.

---

## Methods for Uploading Files

### Using Open OnDemand (OOD)

Open OnDemand, often shortened to OOD, is a web service provided by Research Technology Services (RTS) for Pegasus users that offer a browser-based interface for the completion of certain tasks. Alongside being able to run a Jupyter Notebook server and check the progress of submitted jobs, OOD is most noteworthy for being able to manage all your files present on the cluster. We recommend trying this method first, as it is the most user-friendly of the two and allows for multiple files to be uploaded simultaneously.

1. Make sure you are either connected directly to a GW network, or using the VPN if you aren’t on-campus. If you aren’t sure how to set up the latter, [Access the GW VPN Using GlobalProtect](https://ithelp.gwu.edu/en-us/article/1665784).  
2. Access [ood.arc.gwu.edu](http://ood.arc.gwu.edu), then sign in with SSO. You may get a series of prompts regarding release of data; accept the terms and select your preferred options to reach the main menu.  
3. Once on the main menu, click “Files” and select the location you want to upload to from the dropdown menu. From here, make sure you are within the folder you want to upload to by navigating in much the same way you would with your local files on your device.  
4. On the top right of the screen, you should see a button stating **Upload**. Click it, and then either drag the files you want to upload into the box, or click on either of the two links to select your files from your device’s file navigation window.  
   1. If you want to upload more than one file, either drag multiple files/select multiple files when doing the above process OR click on the **\+ Add more** link at the top right of the pop-up window to add more files.  
5. When you have selected everything you want to upload, click **Upload \# file(s)** on the bottom left of the pop-up window, where \# will be the number of files you have selected.  
   1. **Note:** Files that are too large will tend to result in an error message on OOD, due to a timeout occurring. Thus, for large datasets, video recordings and other sizable files, we suggest using the Secure Copy method detailed down below instead.  
6. Once uploaded successfully, you should be able to see the files present in the folder you are viewing. These files are now within Pegasus, and can be accessed when logged in via SSH, as well as used in running jobs on the cluster\!

### Using the Secure Copy (scp) Command

This method works across all major platforms, as it uses the same framework that allows Secure Shell (SSH) access to Pegasus. However, it is difficult to send multiple files at once with Secure Copy, but it will allow for larger files to be uploaded without concern over timeout errors. If you are interested in sending multiple files via this method, we recommend compressing all the files into a single compressed folder, such as ZIP or RAR. Once on Pegasus, simply extract the files from the file to obtain all the individual files once again.

1. Open the Terminal if on Mac OS or Linux, and the Command Prompt if on Windows. Programs which create a Unix-like Environment on Windows like Git Bash or CygWin also work. We will refer to all of these programs with the term **command line** for the rest of this guide to avoid confusion.  
2. Find the location of the file you wish to upload onto Pegasus. Either make a note of the location OR go to that location within your command line.  
   1. For those doing the former, you will need to use an **absolute path** when it comes time to actually use scp. This is a way of stating a file’s location from the root folder of your device all the way to the exact location of the file. While the paths tend to be long, stating it in this manner will always result in the same file every time, regardless of where in your computer you are requesting the file.  
      1. As an example, for a Windows user named username with a single C: drive wanting to get the absolute path of a file, test.txt, within their downloads folder, the absolute path of that file would be */c/Users/username/downloads/test.txt* (Mac OS / Linux) or *C:\\Users\\username\\Downloads\\test.txt* (Windows).  
   2. For those doing the latter, you will be using a **relative path** when using the scp command. This is a way of stating a file’s location by expressing it relative to the current directory you are in. While typically simpler, the downside is that you must make sure the path you give makes sense given where you currently are in your computer. Failing to do so will result in invalid files or incorrect selections.  
      1. In the previous example, if the command line opens up to the user’s home directory (/c/Users/username/), then the relative path from there to test.txt would be *downloads/test.txt* OR *./downloads/test.txt*. The latter is just being extra specific by specifying that it starts from the current directory by using the *./* shorthand. If the command line is in the downloads folder itself, then the relative path becomes simply *text.txt* or *./text.txt*.  
3. Find the location where you wish to upload the file in Pegasus, in the form of an absolute path.  
   1. If you want to upload it to your home directory, the path within Pegasus will be in the format of \[SCHOOL NAME\]/home/\[USERNAME\], with the former being the acronym for your college within GW and the latter being the username you used to log into Pegasus with SSH.  
      1. These are the acronyms used on Pegasus for each of the schools within the university:  
         1. Columbian College of Arts and Sciences: CCAS  
         2. School of Engineering and Applied Sciences: SEAS  
         3. Graduate School of Education and Human Development: GSEHD  
         4. Milken Institute School of Public Health: GWSPH  
         5. School of Medicine and Health Sciences: SMHS  
         6. GW School of Business: GWSB  
   2. If you want to upload it to your group directory, the path within Pegasus will be in the format of \[SCHOOL NAME\]/groups/\[GROUP NAME\], with the former being the acronym for your college within GW and the latter being the full name of your research group within Pegasus.  
      1. For the most part, research groups are just the name of the Principal Investigator of that group followed by the shorthand *grp*. If you are unsure of what your research group should be, check OOD by looking at the path just underneath your home directory on the Files page.  
   3. If you want to upload it to your Scratch space, the path within Pegasus will be in the format of /scratch/\[GROUP NAME\], with that being the research group name mentioned above.  
4. Once you have both the file on your device and the location within Pegasus you’d like to upload to, type “scp \[LOCAL FILE\] \[USERNAME\]@pegasus.arc.gwu.edu:\[PEGASUS LOCATION\]”, where \[LOCAL FILE\] is the file path from Step 2, \[USERNAME\] is your username on Pegasus, and \[PEGASUS LOCATION\] is the file path from Step 3\. When everything is typed in correctly, hit **Enter** to proceed.  
   1. **Note:** Make sure before doing this that you either are on a GW network, or connected to the GW VPN.  
5. You will now log in to Pegasus much the same way you would when signing in via SSH. Input your SSH passphrase, followed by your 2FA code on the next prompt.  
6. If successful, you will see your file name on the left of the command line, a progress bar on the right and a few number values beside it. Below are explanations of these values in order from left to right:  
   1. The percentage value is the upload progress.  
   2. The unchanging value is the filesize of your upload.  
   3. The changing value with the per second unit is your current upload speed.  
   4. The time value is the estimated time remaining until the upload is complete.  
7. Remain connected to the network and do not close your command line until the upload is fully complete. When fully complete, you should be automatically disconnected from the Pegasus cluster. Your file should be accessible within Pegasus now, and the easiest way to check is by going to the OOD service and looking through the folder you uploaded it to.

---

## Managing and Downloading Files in Pegasus

Once you have your files on Pegasus itself, the best way to manage, download and delete files is by using the features present in the OOD service. While you can also do all these things within the command line itself, familiarity with the Unix shell is essential to avoid damaging shared files or folders, accidental overwriting of results and other potential losses of data. Thus, RTS recommends using the OOD service to complete these sorts of tasks.

The majority of these processes should be self-explanatory for those familiar with a typical file manager program such as File Explorer in Windows or Finder in Mac OS. For instance, to download a file to your computer, you check off the boxes on the left of any files you wish to download, then hit the **Download** button at the top right of the screen to get them onto your local device. Files can be viewed from within your browser without needing to download them by double-clicking the name of the file; do note that some files may be too large to reasonably open in this manner, so always check the filesize on the right of the row prior to doing this\!

Some processes are a little more involved, such as the **Copy/Move** function. For that, you select with the checkboxes once again for any files you wish to copy or move, then hit the **Copy/Move** button on the top right. A pop-up box should appear on the top left of the web interface; select a directory to move to by clicking on the selections below the pop-up as if you were just navigating through files normally. Once you have reached the intended destination to copy or move the file(s) to, hit the respective button and the process should complete as normal.

If you have any difficulties with file access through OOD or otherwise, please contact [hpchelp@gwu.edu](mailto:hpchelp@gwu.edu) in order to file a ticket with us. An employee will be available to assist you at the earliest convenience.
