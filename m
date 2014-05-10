Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WjPFq-00026V-FN
 for kexec@lists.infradead.org; Sun, 11 May 2014 08:37:07 +0000
Date: Sun, 11 May 2014 08:51:29 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/ppc64: Fix up ELF header and dt for PowerNV
 platform.
Message-ID: <20140510235129.GJ31760@verge.net.au>
References: <20140209165459.29541.26032.stgit@mars>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140209165459.29541.26032.stgit@mars>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Laurent Dufour <ldufour@linux.vnet.ibm.com>, Kexec-ml <kexec@lists.infradead.org>

On Sun, Feb 09, 2014 at 10:24:59PM +0530, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> On PowerNV platform, OPAL region is overlapped with crashkernel, need to
> create ELF Program header for the overlapped memory. The changes are
> similar to the way RTAS region was handled.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

I apologise that this seems to have slipped through the cracks.
Manesh, is this patch still needed? If so, is it possible for
someone on the power side of things to review it?

> ---
>  kexec/arch/ppc/crashdump-powerpc.h |    2 ++
>  kexec/arch/ppc64/crashdump-ppc64.c |   28 +++++++++++++++++++++++
>  kexec/arch/ppc64/crashdump-ppc64.h |    2 ++
>  kexec/arch/ppc64/kexec-ppc64.c     |   44 +++++++++++++++++++++++++++++++++++-
>  kexec/fs2dt.c                      |    4 +++
>  5 files changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/kexec/arch/ppc/crashdump-powerpc.h b/kexec/arch/ppc/crashdump-powerpc.h
> index efdc7e3..9b9b01e 100644
> --- a/kexec/arch/ppc/crashdump-powerpc.h
> +++ b/kexec/arch/ppc/crashdump-powerpc.h
> @@ -40,6 +40,8 @@ extern unsigned long long crash_base;
>  extern unsigned long long crash_size;
>  extern unsigned int rtas_base;
>  extern unsigned int rtas_size;
> +extern uint64_t opal_base;
> +extern uint64_t opal_size;
>  extern uint64_t memory_limit;
>  
>  #endif /* CRASHDUMP_POWERPC_H */
> diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
> index c0d575d..00a0e63 100644
> --- a/kexec/arch/ppc64/crashdump-ppc64.c
> +++ b/kexec/arch/ppc64/crashdump-ppc64.c
> @@ -294,6 +294,34 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
>  		crash_memory_range[memory_ranges++].end = cend;
>  	}
>  
> +	/*
> +	 * If OPAL region is overlapped with crashkernel, need to create ELF
> +	 * Program header for the overlapped memory.
> +	 */
> +	if (crash_base < opal_base + opal_size &&
> +		opal_base < crash_base + crash_size) {
> +		page_size = getpagesize();
> +		cstart = opal_base;
> +		cend = opal_base + opal_size;
> +		if (cstart < crash_base)
> +			cstart = crash_base;
> +		if (cend > crash_base + crash_size)
> +			cend = crash_base + crash_size;
> +		/*
> +		 * The opal section created here is formed by reading opal-base
> +		 * and opal-size from /proc/device-tree/ibm,opal.  Unfortunately
> +		 * opal-size is not required to be a multiple of PAGE_SIZE
> +		 * The remainder of the page it ends on is just garbage, and is
> +		 * safe to read, its just not accounted in opal-size.  Since
> +		 * we're creating an elf section here though, lets round it up
> +		 * to the next page size boundary though, so makedumpfile can
> +		 * read it safely without going south on us.
> +		 */
> +		cend = _ALIGN(cend, page_size);
> +
> +		crash_memory_range[memory_ranges].start = cstart;
> +		crash_memory_range[memory_ranges++].end = cend;
> +	}
>  	*range = crash_memory_range;
>  	*ranges = memory_ranges;
>  
> diff --git a/kexec/arch/ppc64/crashdump-ppc64.h b/kexec/arch/ppc64/crashdump-ppc64.h
> index 001be3a..d654c6b 100644
> --- a/kexec/arch/ppc64/crashdump-ppc64.h
> +++ b/kexec/arch/ppc64/crashdump-ppc64.h
> @@ -31,6 +31,8 @@ extern uint64_t crash_size;
>  extern uint64_t memory_limit;
>  extern unsigned int rtas_base;
>  extern unsigned int rtas_size;
> +extern uint64_t opal_base;
> +extern uint64_t opal_size;
>  
>  uint64_t lmb_size;
>  unsigned int num_of_lmbs;
> diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
> index 49b291d..5956836 100644
> --- a/kexec/arch/ppc64/kexec-ppc64.c
> +++ b/kexec/arch/ppc64/kexec-ppc64.c
> @@ -43,6 +43,7 @@ uint64_t memory_limit;
>  static int nr_memory_ranges, nr_exclude_ranges;
>  uint64_t crash_base, crash_size;
>  unsigned int rtas_base, rtas_size;
> +uint64_t opal_base, opal_size;
>  int max_memory_ranges;
>  
>  static void cleanup_memory_ranges(void)
> @@ -343,7 +344,8 @@ static int get_devtree_details(unsigned long kexec_flags)
>  			strncmp(dentry->d_name, "memory@", 7) &&
>  			strcmp(dentry->d_name, "memory") &&
>  			strncmp(dentry->d_name, "pci@", 4) &&
> -			strncmp(dentry->d_name, "rtas", 4)) 
> +			strncmp(dentry->d_name, "rtas", 4) &&
> +			strncmp(dentry->d_name, "ibm,opal", 8))
>  			continue;
>  		strcpy(fname, device_tree);
>  		strcat(fname, dentry->d_name);
> @@ -575,6 +577,46 @@ static int get_devtree_details(unsigned long kexec_flags)
>  				add_usable_mem_rgns(rtas_base, rtas_size);
>  		} /* rtas */
>  
> +		if (strncmp(dentry->d_name, "ibm,opal", 8) == 0) {
> +			strcat(fname, "/opal-base-address");
> +			file = fopen(fname, "r");
> +			if (file == NULL) {
> +				perror(fname);
> +				goto error_opencdir;
> +			}
> +			if (fread(&opal_base, sizeof(uint64_t), 1, file) != 1) {
> +				perror(fname);
> +				goto error_openfile;
> +			}
> +			opal_base = be64_to_cpu(opal_base);
> +			fclose(file);
> +
> +			memset(fname, 0, sizeof(fname));
> +			strcpy(fname, device_tree);
> +			strcat(fname, dentry->d_name);
> +			strcat(fname, "/opal-runtime-size");
> +			file = fopen(fname, "r");
> +			if (file == NULL) {
> +				perror(fname);
> +				goto error_opencdir;
> +			}
> +			if (fread(&opal_size, sizeof(uint64_t), 1, file) != 1) {
> +				perror(fname);
> +				goto error_openfile;
> +			}
> +			fclose(file);
> +			closedir(cdir);
> +			opal_size = be64_to_cpu(opal_size);
> +			/* Add OPAL to exclude_range */
> +			exclude_range[i].start = opal_base;
> +			exclude_range[i].end = opal_base + opal_size;
> +			i++;
> +			if (i >= max_memory_ranges)
> +				realloc_memory_ranges();
> +			if (kexec_flags & KEXEC_ON_CRASH)
> +				add_usable_mem_rgns(opal_base, opal_size);
> +		} /* ibm,opal */
> +
>  		if (!strncmp(dentry->d_name, "memory@", 7) ||
>  			!strcmp(dentry->d_name, "memory")) {
>  			strcat(fname, "/reg");
> diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
> index 5e6b98d..44510cb 100644
> --- a/kexec/fs2dt.c
> +++ b/kexec/fs2dt.c
> @@ -113,6 +113,10 @@ static void checkprop(char *name, unsigned *data, int len)
>  		die("unrecoverable error: no property data");
>  	else if (!strcmp(name, "linux,rtas-base"))
>  		base = be32_to_cpu(*data);
> +	else if (!strcmp(name, "opal-base-address"))
> +		base = be64_to_cpu(*(unsigned long long *)data);
> +	else if (!strcmp(name, "opal-runtime-size"))
> +		size = be64_to_cpu(*(unsigned long long *)data);
>  	else if (!strcmp(name, "linux,tce-base"))
>  		base = be64_to_cpu(*(unsigned long long *) data);
>  	else if (!strcmp(name, "rtas-size") ||
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
