# nfcoreWorkshopTesting

Testing and materials development for AusBioCommons customising nf-core workshop 2023

Materials developed by: 
* Cali Willet
* Georgie Samaha 

Test instances:
* 146.118.64.217
* 146.118.66.55

## Set up environment 

Instances set up using Nimbus bioimage which has Singularity, Nextflow, Docker already installed. Running:

```
nextflow -v 
```
Gives:
```
nextflow version 22.04.3.5703
```

Nextflow does not currently provide docs for previous versions. See [this GitHub issue](https://github.com/nextflow-io/nextflow/issues/3458) for explanation of why. Currently, using https://www.nextflow.io/docs/latest/index.html to guide testing and development. 

### Download rnaseq pipeline 

Download and install nf-core/rnaseq code with: 

```bash
git clone https://github.com/nf-core/rnaseq.git
```

### Download materials 

Using the same dataset as rnaseq workshop, but needed to recreate STAR indexes for most recent stable release of nf-core/rnaseq workflow and opting to rename files and directory for sake of clarity. Will send updated materials to Alex to be uploaded to cvmfs once finalised. For now materials are on Cloudstor (and subject to change) and contain:

* `mm10_reference/mm10_chr18.fa` 
* `mm10_reference/mm10_chr18.gtf`
* `mm10_reference/STAR/` (star index files)
* `samplesheet.csv` (assumes fq path `/home/ubuntu/nfcoreWorkshopTesting/materials/`)
* `fastqs/`
* `README.md`

Download subset/test data from Cloudstor
```bash
wget -O nfcore_materials.tar.gz https://cloudstor.aarnet.edu.au/plus/s/gIBdDhKEwfq2j58/download
```
Unpack the files: 
```bash
tar -zxvf nfcore_materials.tar.gz
```

### CVMFS caching 

Need to cache CVMFS before we can access containers or Nandan's training materials. This should not be required for workshop. Would like CVMFS repositories pre-mounted, as they would be going forward. Before running anything, had to re-install CVMFS:

```
git clone https://github.com/PawseySC/Pawsey-CernVM-FS.git
cd Pawsey-CernVM-FS
sudo ./install-cvmfs.sh install
```

Refreshed repositories: 
```
sudo ./install-cvmfs.sh install
```

**Prepare (unpacked) container**

Make key directory for the repository: 
```
sudo mkdir /etc/cvmfs/keys/biocommons.aarnet.edu.au/
```

Then copied [pub key](https://github.com/PawseySC/Pawsey-CernVM-FS/blob/main/pubkeys/unpacked.containers.biocommons.aarnet.edu.au.pub) over using nano:
```
sudo nano /etc/cvmfs/keys/biocommons.aarnet.edu.au/unpacked.containers.biocommons.aarnet.edu.au.pub
```

Create config file for repo:
```
sudo nano /etc/cvmfs/config.d/unpacked.containers.biocommons.aarnet.edu.au.conf
```

Save the following inside:
```
CVMFS_SERVER_URL="http://bcws.test.aarnet.edu.au/cvmfs/@fqrn@"
CVMFS_PUBLIC_KEY="/etc/cvmfs/keys/biocommons.aarnet.edu.au/unpacked.containers.biocommons.aarnet.edu.au.pub"
```

Test with: 
```
ls /cvmfs/unpacked.containers.biocommons.aarnet.edu.au
```

**RNAseq training materials**

Do not need to worry about this for now, as materials are not yet available. See Cloudstor link for now. 

To access cvmfs data repository, make key directory for the repository: 
```
sudo mkdir /etc/cvmfs/keys/data.biocommons.aarnet.edu.au/
```

Then copied [pub key](https://github.com/PawseySC/Pawsey-CernVM-FS/blob/main/pubkeys/data.biocommons.aarnet.edu.au.pub) over using nano:
```
sudo nano /etc/cvmfs/keys/data.biocommons.aarnet.edu.au/data.biocommons.aarnet.edu.au.pub
```

Create config file for repo:
```
sudo nano /etc/cvmfs/config.d/data.biocommons.aarnet.edu.au.conf
```

Save the following inside:
```
CVMFS_SERVER_URL="http://bcws.test.aarnet.edu.au/cvmfs/@fqrn@"
CVMFS_PUBLIC_KEY="/etc/cvmfs/keys/data.biocommons.aarnet.edu.au/data.biocommons.aarnet.edu.au.pub"
```

Test with: 
```
ls /cvmfs/data.biocommons.aarnet.edu.au
```

## Materials testing  

Notes for each exercise draft have been included in the following directories. Each section to include: 

* Objectives 
* Testing reflection
* Content draft 
* Troubleshooting
* Links/resources
* [Exercise 1](nfcoreWorkshopTesting/exercise1/README.md)
* [Exercise 2](nfcoreWorkshopTesting/exercise2/README.md)
* [Exercise 3](nfcoreWorkshopTesting/exercise3/README.md)
* [Exercise 4](nfcoreWorkshopTesting/exercise4/README.md)