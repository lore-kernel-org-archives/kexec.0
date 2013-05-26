Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uganv-00058c-Ah
 for kexec@lists.infradead.org; Sun, 26 May 2013 13:16:08 +0000
Date: Sun, 26 May 2013 22:16:26 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/4] kexec-tools: Fix possible overflows and make use of
 dbg_memrange() macro
Message-ID: <20130526131626.GC11134@verge.net.au>
References: <1369213056-77661-1-git-send-email-trenn@suse.de>
 <1369213056-77661-4-git-send-email-trenn@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1369213056-77661-4-git-send-email-trenn@suse.de>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Thomas Renninger <trenn@suse.de>
Cc: yinghai@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com, vgoyal@redhat.com

On Wed, May 22, 2013 at 10:57:35AM +0200, Thomas Renninger wrote:
> add_memmap() will add another memrange, therefore we need an additional
> array entry and need to check for
> if (nr_entries >= CRASH_MAX_MEMMAP_NR - 1)
> 
> Same for delete_memmap: If a region has to be split an additional region is
> added first, so we again have to check for:
> if (nr_entries >= CRASH_MAX_MEMMAP_NR - 1)
> 
> In add_memmap we know the amount of range entries. No need to check for the
> ugly:
> -               if (mstart == 0 && mend == 0)
> -                       break;
> condition, just let the loop go until nr_entries.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> Signed-off-by: Thomas Renninger <Thomas Renninger" trenn@suse.de>

This patch seems fine, however, the second Signed-off-by line seems to be a
malformed duplicate of the first.

> ---
>  kexec/arch/i386/crashdump-x86.c |   35 ++++++++---------------------------
>  1 files changed, 8 insertions(+), 27 deletions(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 9b5a7cd..7fd1c5b 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -545,14 +545,12 @@ static int add_memmap(struct memory_range *memmap_p, unsigned long long addr,
>  		else
>  			nr_entries++;
>  	}
> -	if (nr_entries == CRASH_MAX_MEMMAP_NR)
> +	if (nr_entries >= CRASH_MAX_MEMMAP_NR - 1)
>  		return -1;
>  
> -	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
> +	for (i = 0; i < nr_entries;  i++) {
>  		mstart = memmap_p[i].start;
>  		mend = memmap_p[i].end;
> -		if (mstart == 0 && mend == 0)
> -			break;
>  		if (mstart <= (addr+size-1) && mend >=addr)
>  			/* Overlapping region. */
>  			return -1;
> @@ -565,16 +563,8 @@ static int add_memmap(struct memory_range *memmap_p, unsigned long long addr,
>  	memmap_p[tidx].start = addr;
>  	memmap_p[tidx].end = addr + size - 1;
>  
> -	dbgprintf("Memmap after adding segment\n");
> -	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
> -		mstart = memmap_p[i].start;
> -		mend = memmap_p[i].end;
> -		if (mstart == 0 && mend == 0)
> -			break;
> -		dbgprintf("%016llx - %016llx\n",
> -			mstart, mend);
> -	}
> -
> +	nr_entries++;
> +	dbg_memrange("Memmap after adding segment", &memmap_p, nr_entries);
>  	return 0;
>  }
>  
> @@ -600,8 +590,7 @@ static int delete_memmap(struct memory_range *memmap_p, unsigned long long addr,
>  		else
>  			nr_entries++;
>  	}
> -	if (nr_entries == CRASH_MAX_MEMMAP_NR)
> -		/* List if full */
> +	if (nr_entries >= CRASH_MAX_MEMMAP_NR - 1)
>  		return -1;
>  
>  	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
> @@ -643,25 +632,17 @@ static int delete_memmap(struct memory_range *memmap_p, unsigned long long addr,
>  		for (j = nr_entries-1; j > tidx; j--)
>  			memmap_p[j+1] = memmap_p[j];
>  		memmap_p[tidx+1] = temp_region;
> +		nr_entries++;
>  	}
>  	if ((operation == -1) && tidx >=0) {
>  		/* Delete the exact match memory region. */
>  		for (j = i+1; j < CRASH_MAX_MEMMAP_NR; j++)
>  			memmap_p[j-1] = memmap_p[j];
>  		memmap_p[j-1].start = memmap_p[j-1].end = 0;
> +		nr_entries--;
>  	}
>  
> -	dbgprintf("Memmap after deleting segment\n");
> -	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
> -		mstart = memmap_p[i].start;
> -		mend = memmap_p[i].end;
> -		if (mstart == 0 && mend == 0) {
> -			break;
> -		}
> -		dbgprintf("%016llx - %016llx\n",
> -			mstart, mend);
> -	}
> -
> +	dbg_memrange("Memmap after deleting segment", &memmap_p, nr_entries);
>  	return 0;
>  }
>  
> -- 
> 1.7.6.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
