# Training materials at CernVM-FS

We intend to make subset data (currently on CloudStor) available on cvfms repository. Once materials and exercises have been finalised, materials will be uploaded to AARNet's CernVM-FS repository. In the meantime, follow instructions on downloading testing materials from [Cloudstor link in README.md](https://github.com/Sydney-Informatics-Hub/nfcoreWorkshopTesting/blob/main/README.md).

## Preparing CVMFS cache 

Need to cache CVMFS before we can access containers or training materials. This will not be a required exercise for workshop attendees. CVMFS repositories will be pre-mounted on all attendee VMs for the workshop. For testing of CVMFS, may have to re-install CVMFS:

```
git clone https://github.com/PawseySC/Pawsey-CernVM-FS.git
cd Pawsey-CernVM-FS
sudo ./install-cvmfs.sh install
```

Refreshed repositories: 
```
sudo ./install-cvmfs.sh install
```

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