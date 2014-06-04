# Extracts a file based on its extension
# Usage: extract <archive>
function auto_extract
{
	path=$1
	name=`echo $path|sed -e "s/.*\///"`
	ext=`echo $name|sed -e "s/.*\.//"`
	
	case $ext in
		"tar") tar -xf $name && return 0 ;;
		"gz"|"tgz") tar -xzf $name && return 0 ;;
		"bz2"|"tbz2") tar -xjf $name && return 0 ;;
		"zip") unzip $name && return 0 ;;
		*) echo "download_and_extract doesn't know how to extract $ext archives!" ;;
	esac
	
	return 1
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
	[ -d $outdir ] && echo "Deleting old version of $outdir" && rm -Rf outdir
	
	# First, if the archive already exists, attempt to extract it. Failing
	# that, attempt to continue an interrupted download. If that also fails,
	# remove the presumably corrupted file.
	[ -f $name ] && auto_extract $name || wget --continue --no-check-certificate $1 -O $name || rm -f $name
	
	# If the file does not exist at this point, it means it was either never
	# downloaded, or it was deleted for being corrupted. Just go ahead and
	# download it.
	# Using wget --continue here would make buggy servers flip out for nothing.
	[ -f $name ] || wget --no-check-certificate $1 -O $name && auto_extract $name
	
	# Update the modification time of the file even if it exists, for patch_once
	[ -f $name ] && touch $name
}

# Clones or updates a Git repository.
# Usage: clone_git_repo <hostname> <user> <repo>
function clone_git_repo
{
	host=$1
	user=$2
	repo=$3
	
	# If the target directory exists, assume it's a repository and updating it.
	# If it's not, or if it's corrupted and fails to pull, just nuke it.
	[ -d $repo ] && cd $repo && git pull || cd .. && rm -rf $repo
	
	# If it does not exist at this point, it was never there in the first place
	# or it was nuked due to being corrupted. Clone and track master, please.
	# Attempt to clone over SSH if possible, use anonymous HTTP as fallback.
	# SSH_ASKPASS=false prevents the script from stopping to ask for auth.
	[ -d $repo ] || SSH_ASKPASS=false git clone --recursive -b master git@$host:$repo.git || SSH_ASKPASS=false git clone --recursive -b master https://$host/$user/$repo.git || return 1
}
