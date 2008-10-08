Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KnO2v-0004T0-Oo
	for kexec@lists.infradead.org; Wed, 08 Oct 2008 01:41:02 +0000
Date: Wed, 8 Oct 2008 12:40:57 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/3] kexec/kdump: read crash memory ranges from drconf
	memory
Message-ID: <20081008014055.GA22396@verge.net.au>
References: <200809241719.07464.chandru@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200809241719.07464.chandru@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Chandru <chandru@in.ibm.com>
Cc: kexec@lists.infradead.org

On Wed, Sep 24, 2008 at 05:19:07PM +0530, Chandru wrote:
> Get the memory ranges of the 1st kernel excluding the memory reserved for 
> kexec/kdump kernel in case of ibm,dynamic-reconfiguration-memory node of 
> device tree 
> 
> Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com>
> ---
> 
>  kexec/arch/ppc64/crashdump-ppc64.c |  121 +++++++++++++++++++--------
>  kexec/arch/ppc64/crashdump-ppc64.h |    3
>  2 files changed, 90 insertions(+), 34 deletions(-)
> 
> --- kexec-tools-orig/kexec/arch/ppc64/crashdump-ppc64.c	2008-09-24 
> 14:46:55.000000000 +0530
> +++ kexec-tools/kexec/arch/ppc64/crashdump-ppc64.c	2008-09-24 
> 14:34:38.000000000 +0530
> @@ -84,6 +84,82 @@ mem_rgns_t usablemem_rgns = {0, NULL};
>   */
>  uint64_t saved_max_mem = 0;
>  
> +static unsigned long long cstart, cend;
> +static int memory_ranges;

I'm not entirely happy with the scope of these variables
being changed to static. But I guess it is ok.

> +
> +/*
> + * Exclude the region that lies within crashkernel
> + */
> +static void exclude_crash_region(uint64_t start, uint64_t end)
> +{
> +	if (cstart < end && cend > start) {
> +		if (start < cstart && end > cend) {
> +			crash_memory_range[memory_ranges].start = start;
> +			crash_memory_range[memory_ranges].end = cstart;
> +			crash_memory_range[memory_ranges].type = RANGE_RAM;
> +			memory_ranges++;
> +			crash_memory_range[memory_ranges].start = cend;
> +			crash_memory_range[memory_ranges].end = end;
> +			crash_memory_range[memory_ranges].type = RANGE_RAM;
> +			memory_ranges++;
> +		} else if (start < cstart) {
> +			crash_memory_range[memory_ranges].start = start;
> +			crash_memory_range[memory_ranges].end = cstart;
> +			crash_memory_range[memory_ranges].type = RANGE_RAM;
> +			memory_ranges++;
> +		} else if (end > cend) {
> +			crash_memory_range[memory_ranges].start = cend;
> +			crash_memory_range[memory_ranges].end = end;
> +			crash_memory_range[memory_ranges].type = RANGE_RAM;
> +			memory_ranges++;
> +		}
> +	} else {
> +		crash_memory_range[memory_ranges].start = start;
> +		crash_memory_range[memory_ranges].end  = end;
> +		crash_memory_range[memory_ranges].type = RANGE_RAM;
> +		memory_ranges++;
> +	}
> +}
> +
> +static int get_dyn_reconf_crash_memory_ranges()
> +{
> +	uint64_t start, end;
> +	char fname[128], buf[32];
> +	FILE *file;
> +	int i, n;
> +
> +	strcpy(fname, "/proc/device-tree/");
> +	strcat(fname, "ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory");
> +	if ((file = fopen(fname, "r")) == NULL) {
> +		perror(fname);
> +		return -1;
> +	}
> +
> +	fseek(file, 4, SEEK_SET);
> +	for (i = 0; i < num_of_lmbs; i++) {
> +		if ((n = fread(buf, 1, 24, file)) < 0) {
> +			perror(fname);
> +			fclose(file);
> +			return -1;
> +		}
> +		if (memory_ranges >= (max_memory_ranges + 1)) {
> +			/* No space to insert another element. */
> +				fprintf(stderr,
> +				"Error: Number of crash memory ranges"
> +				" excedeed the max limit\n");
> +			return -1;
> +		}
> +
> +		start = ((uint64_t *)buf)[0];
> +		end = start + lmb_size;
> +		if (start == 0 && end >= (BACKUP_SRC_END + 1))
> +			start = BACKUP_SRC_END + 1;
> +		exclude_crash_region(start, end);
> +	}
> +	fclose(file);
> +	return 0;
> +}
> +
>  /* Reads the appropriate file and retrieves the SYSTEM RAM regions for whom to
>   * create Elf headers. Keeping it separate from get_memory_ranges() as
>   * requirements are different in the case of normal kexec and crashdumps.
> @@ -98,7 +174,6 @@ uint64_t saved_max_mem = 0;
>  static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
>  {
>  
> -	int memory_ranges = 0;
>  	char device_tree[256] = "/proc/device-tree/";
>  	char fname[256];
>  	char buf[MAXBYTES];
> @@ -106,7 +181,7 @@ static int get_crash_memory_ranges(struc
>  	FILE *file;
>  	struct dirent *dentry, *mentry;
>  	int i, n, crash_rng_len = 0;
> -	unsigned long long start, end, cstart, cend;
> +	unsigned long long start, end;
>  	int page_size;
>  
>  	crash_max_memory_ranges = max_memory_ranges + 6;
> @@ -129,7 +204,16 @@ static int get_crash_memory_ranges(struc
>  		perror(device_tree);
>  		goto err;
>  	}
> +
> +	cstart = crash_base;
> +	cend = crash_base + crash_size;
> +
>  	while ((dentry = readdir(dir)) != NULL) {
> +		if (!strncmp(dentry->d_name,
> +				"ibm,dynamic-reconfiguration-memory", 35)){
> +			get_dyn_reconf_crash_memory_ranges();
> +			continue;
> +		}
>  		if (strncmp(dentry->d_name, "memory@", 7) &&
>  			strcmp(dentry->d_name, "memory"))
>  			continue;
> @@ -170,38 +254,7 @@ static int get_crash_memory_ranges(struc
>  			if (start == 0 && end >= (BACKUP_SRC_END + 1))
>  				start = BACKUP_SRC_END + 1;
>  
> -			cstart = crash_base;
> -			cend = crash_base + crash_size;
> -			/*
> -			 * Exclude the region that lies within crashkernel
> -			 */
> -			if (cstart < end && cend > start) {
> -				if (start < cstart && end > cend) {
> -					crash_memory_range[memory_ranges].start = start;
> -					crash_memory_range[memory_ranges].end = cstart;
> -					crash_memory_range[memory_ranges].type = RANGE_RAM;
> -					memory_ranges++;
> -					crash_memory_range[memory_ranges].start = cend;
> -					crash_memory_range[memory_ranges].end = end;
> -					crash_memory_range[memory_ranges].type = RANGE_RAM;
> -					memory_ranges++;
> -				} else if (start < cstart) {
> -					crash_memory_range[memory_ranges].start = start;
> -					crash_memory_range[memory_ranges].end = cstart;
> -					crash_memory_range[memory_ranges].type = RANGE_RAM;
> -					memory_ranges++;
> -				} else if (end > cend){
> -					crash_memory_range[memory_ranges].start = cend;
> -					crash_memory_range[memory_ranges].end = end;
> -					crash_memory_range[memory_ranges].type = RANGE_RAM;
> -					memory_ranges++;
> -				}
> -			} else {
> -				crash_memory_range[memory_ranges].start = start;
> -				crash_memory_range[memory_ranges].end  = end;
> -				crash_memory_range[memory_ranges].type = RANGE_RAM;
> -				memory_ranges++;
> -			}
> +			exclude_crash_region(start, end);
>  			fclose(file);
>  		}
>  		closedir(dmem);
> --- kexec-tools-orig/kexec/arch/ppc64/crashdump-ppc64.h	2008-09-24 
> 14:46:55.000000000 +0530
> +++ kexec-tools/kexec/arch/ppc64/crashdump-ppc64.h	2008-09-16 
> 19:18:57.000000000 +0530
> @@ -28,4 +28,7 @@ extern uint64_t crash_size;
>  extern unsigned int rtas_base;
>  extern unsigned int rtas_size;
>  
> +uint64_t lmb_size;
> +unsigned int num_of_lmbs;
> +

I am a little confused about why these variables need to be global
as they only seem to be used inside get_crash_memory_ranges().
I am also a little confused about how they are initialised.

>  #endif /* CRASHDUMP_PPC64_H */

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
