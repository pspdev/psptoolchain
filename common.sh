# Returns the number of processor cores available
# Usage: num_cpus
function num_cpus
{
    # This *should* be available on literally everything, including OSX
    getconf _NPROCESSORS_ONLN
}

# Extracts a file based on its extension
# Usage: extract <archive>
function auto_extract
{
    path=$1
    name=`echo $path|sed -e "s/.*\///"`
    ext=`echo $name|sed -e "s/.*\.//"`
    
    echo "Extracting $name..."
    
    case $ext in
        "tar") tar --no-same-owner -xf $path ;;
        "gz"|"tgz") tar --no-same-owner -xzf $path ;;
        "bz2"|"tbz2") tar --no-same-owner -xjf $path ;;
        "zip") unzip $path ;;
        *) echo "I don't know how to extract $ext archives!"; return 1 ;;
    esac
    
    return $?
}

# Downloads and extracts a file, with some extra checks.
# Usage: download_and_extract <url> <output?>
function download_and_extract
{
    url=$1
    name=`echo $url|sed -e "s/.*\///"`
    outdir=$2
    
    # If there are already an extracted directory, delete it, otherwise
    # reapplying patches gets messy. I tried.
    [ -d $outdir ] && echo "Deleting old version of $outdir" && rm -rf $outdir
    
    # Instead of wget's progress bar, just print that we're downloading the url
    echo "Downloading: $url"; 
    
    # First, if the archive already exists, attempt to extract it. Failing
    # that, attempt to continue an interrupted download. If that also fails,
    # remove the presumably corrupted file.
    [ -f $name ] && auto_extract $name || { wget --continue --no-verbose --no-check-certificate $url -O $name || rm -f $name; }
    
    # If the file does not exist at this point, it means it was either never
    # downloaded, or it was deleted for being corrupted. Just go ahead and
    # download it.
    # Using wget --continue here would make buggy servers flip out for nothing.
    [ -f $name ] || wget --no-verbose --no-check-certificate $url -O $name && auto_extract $name
}

# Clones or updates a Git repository.
# Usage: clone_git_repo <hostname> <user> <repo> <branch>
function clone_git_repo
{
    host=$1
    user=$2
    repo=$3
    branch=${4:-master}
    
    OLDPWD=$PWD
    
    # Try to update an existing repository at the target path.
    # Nuke it if it's corrupted and the pull fails.
    [ -d $repo/.git ] && { cd $repo && git pull; } || rm -rf $OLDPWD/$repo
    
    # The above command may leave us standing in the existing repo.
    cd $OLDPWD
    
    # If it does not exist at this point, it was never there in the first place
    # or it was nuked due to being corrupted. Clone and track master, please.
    # Attempt to clone over SSH if possible, use anonymous HTTP as fallback.
    # Set SSH_ASKPASS and stdin(<) to prevent it from freezing to ask for auth.
    [ -d $repo ] || SSH_ASKPASS=false git clone --recursive -b $branch git@$host:$user/$repo.git $repo < /dev/null || SSH_ASKPASS=false git clone --recursive -b $branch https://$host/$user/$repo.git $repo < /dev/null || return 1
}
