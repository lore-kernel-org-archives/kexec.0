Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dDYf0-0001pR-DF
 for kexec@lists.infradead.org; Wed, 24 May 2017 15:57:19 +0000
Date: Wed, 24 May 2017 11:56:28 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <2121155069.18928570.1495641388085.JavaMail.zimbra@redhat.com>
In-Reply-To: <1495609985-5328-1-git-send-email-honglei.wang@oracle.com>
References: <1495609985-5328-1-git-send-email-honglei.wang@oracle.com>
Subject: Re: [Crash-utility] [PATCH] xen: Add support for domU with Linux
 kernel 3.19 and newer
MIME-Version: 1.0
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
To: Honglei Wang <honglei.wang@oracle.com>
Cc: jgross@suse.com, konrad wilk <konrad.wilk@oracle.com>, ptesarik@suse.cz, daniel kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, xen-devel@lists.xenproject.org, eric devolder <eric.devolder@oracle.com>, crash-utility@redhat.com



----- Original Message -----
> crash patch c3413456599161cabc4e910a0ae91dfe5eec3c21 (xen: Add support for
> dom0 with Linux kernel 3.19 and newer) from Daniel made crash utility
> support xen dom0 vmcores after linux kernel commit
> 054954eb051f35e74b75a566a96fe756015352c8 (xen: switch to linear virtual
> mapped sparse p2m list).
> 
> This patch can be deemed as a subsequent and make this utility support Xen
> PV domU dumpfiles again.
> 
> Basically speaking, readmem() can't be used to read xen_p2m_addr associate
> memory directly during m2p translation. It introduces infinite recursion.
> Following call sequence shows the scenario, it comes from a section of
> backtrace with only kvaddr, machine addr and mfn left as parameter:
> 
> module_init()
> 
> /* The first readmem() from module_init(). */
> readmem(addr=0xffffffffa02fe4a0)
> 
> /* readmem() needs physical address, so calls kvtop(). */
> kvtop(kvaddr=0xffffffffa02fe4a0)
> x86_64_kvtop(kvaddr=ffffffffa02fe4a0)
> 
> /* Calculate physical address by traversing page tables. */
> x86_64_kvtop_xen_wpt(kvaddr=0xffffffffa02fe4a0)
> 
> /*
>  * x86_64_kvtop_xen_wpt() is going to traverse the page table to
>  * get the physical address for 0xffffffffa02fe4a0. So, at first it
>  * is needed to translate the pgd from machine address to physical
>  * address. So invoke xen_m2p() here to do the translation. 0x58687f000
>  * is the pgd machine address in x86_64_kvtop_xen_wpt() and is needed
>  * to be translated to its physical address.
>  */
> xen_m2p(machine=0x58687f000)
> __xen_m2p(machine=0x58687f000, mfn=0x58687f)
> 
> /*
>  * __xen_m2p() is going to search mfn 0x58687f in p2m VMA which starts
>  * at VMA 0xffffc900001cf000. It compares every mfn stored in it with
>  * 0x58687f. Once it's proved 0x58687f is one mfn in the p2m, its offset
>  * will be used to calculate the pfn.
>  *
>  * readmem() is invoked by __xen_m2p() to read the page from VMA
>  * 0xffffc900001cf000 here.
>  */
> readmem(addr=0xffffc900001cf000)
> 
> /*
>  * readmem() needs physical address of 0xffffc900001cf000 to make the
>  * reading done. So it invokes kvtop() to get the physical address.
>  */
> kvtop(kvaddr=0xffffc900001cf000)
> x86_64_kvtop(kvaddr=0xffffc900001cf000)
> 
> /* It needs to calculate physical address by traversing page tables. */
> x86_64_kvtop_xen_wpt(kvaddr=0xffffc900001cf000)
> 
> /*
>  * 0x581b7e000 is the machine address of pgd need to be translated here.
>  * The mfn is calculated in this way at x86_64_kvtop_xen_wpt():
>  *
>  * pml4 = ((ulong *)machdep->machspec->pml4) + pml4_index(kvaddr);
>  * pgd_paddr = (*pml4) & PHYSICAL_PAGE_MASK;
>  *
>  * The kvaddr 0xffffc900001cf000 here is quite different from the one
>  * above, so the machine address of pgd is not the same one. And this
>  * pgd is the one we use to access the VMA of p2m table.
>  */
> xen_m2p(machine=0x581b7e000)
> __xen_m2p(machine=0x581b7e000, mfn=0x581b7e)
> 
> /*
>  * Looking for mfn 0x581b7e in the range of p2m page which starts at
>  * VMA 0xffffc900001f5000.
>  */
> readmem(addr=0xffffc900001f5000)
> 
> /* Need physical address of VMA 0xffffc900001f5000 as same reason above. */
> kvtop(kvaddr=0xffffc900001f5000)
> x86_64_kvtop(kvaddr=0xffffc900001f5000)
> 
> /* Need to traverse page tables to calculate physical address for it. */
> x86_64_kvtop_xen_wpt(kvaddr=0xffffc900001f5000)
> 
> /*
>  * Unfortunately, machine address 0x581b7e000 have to be translated again.
>  * Endless loop starts from here.
>  */
> xen_m2p(machine=0x581b7e000)
> __xen_m2p(machine=0x581b7e000, mfn=0x581b7e)
> readmem(addr=0xffffc900001f5000)
> 
> Fortunately, PV domU p2m mapping is also stored at xd->xfd + xch_index_offset
> and organized as struct xen_dumpcore_p2m. We have a chance to read the p2m
> stuff directly from there, and then we avoid the loop above.
> 
> So, this patch implements a special reading function read_xc_p2m() to extract
> the mfns from xd->xfd + xch_index_offset. This function does not need to read
> mfns from p2m VMA like readmem() does, so, we avoid the endless loop introduced
> by the address translation.
> 
> Signed-off-by: Honglei Wang <honglei.wang@oracle.com>
> Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

Queued for crash-7.2.0:

  https://github.com/crash-utility/crash/commit/5c52842a58a2602dba81de71831af98b2b53c6e0

Thanks,
  Dave

  
> ---
>  kernel.c  |  151
>  +++++++++++++++++++++++++++++++++++++++++++++++++++++++------
>  xendump.c |    2 +-
>  xendump.h |    2 +
>  3 files changed, 140 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel.c b/kernel.c
> index 395736c..7a5ce64 100644
> --- a/kernel.c
> +++ b/kernel.c
> @@ -22,6 +22,7 @@
>  #include <libgen.h>
>  #include <ctype.h>
>  #include <stdbool.h>
> +#include "xendump.h"
>  
>  static void do_module_cmd(ulong, char *, ulong, char *, char *);
>  static void show_module_taint(void);
> @@ -67,6 +68,9 @@ static ulong __xen_m2p(ulonglong, ulong);
>  static ulong __xen_pvops_m2p_l2(ulonglong, ulong);
>  static ulong __xen_pvops_m2p_l3(ulonglong, ulong);
>  static ulong __xen_pvops_m2p_hyper(ulonglong, ulong);
> +static ulong __xen_pvops_m2p_domU(ulonglong, ulong);
> +static int read_xc_p2m(ulonglong addr, void *buffer, long size);
> +static void read_p2m(ulong cache_index, int memtype, void *buffer);
>  static int search_mapping_page(ulong, ulong *, ulong *, ulong *);
>  static void read_in_kernel_config_err(int, char *);
>  static void BUG_bytes_init(void);
> @@ -181,10 +185,7 @@ kernel_init()
>  						&kt->pvops_xen.p2m_mid_missing);
>  			get_symbol_data("p2m_missing", sizeof(ulong),
>  						&kt->pvops_xen.p2m_missing);
> -		} else if (symbol_exists("xen_p2m_addr")) {
> -			if (!XEN_CORE_DUMPFILE())
> -				error(FATAL, "p2m array in new format is unreadable.");
> -		} else {
> +		} else if (!symbol_exists("xen_p2m_addr")) {
>  			kt->pvops_xen.p2m_top_entries = get_array_length("p2m_top", NULL, 0);
>  			kt->pvops_xen.p2m_top = symbol_value("p2m_top");
>  			kt->pvops_xen.p2m_missing = symbol_value("p2m_missing");
> @@ -9305,13 +9306,7 @@ __xen_m2p(ulonglong machine, ulong mfn)
>  				if (memtype == PHYSADDR)
>  					pc->curcmd_flags |= XEN_MACHINE_ADDR;
>  
> -				if (!readmem(kt->p2m_mapping_cache[c].mapping, memtype,
> -			       	    mp, PAGESIZE(), "phys_to_machine_mapping page (cached)",
> -			    	    RETURN_ON_ERROR))
> -                                	error(FATAL, "cannot access "
> -                                    	    "phys_to_machine_mapping page\n");
> -				else
> -					kt->last_mapping_read = kt->p2m_mapping_cache[c].mapping;
> +				read_p2m(c, memtype, mp);
>  
>  				if (memtype == PHYSADDR)
>  					pc->curcmd_flags &= ~XEN_MACHINE_ADDR;
> @@ -9349,9 +9344,12 @@ __xen_m2p(ulonglong machine, ulong mfn)
>  		 */
>  		if (symbol_exists("p2m_mid_missing"))
>  			pfn = __xen_pvops_m2p_l3(machine, mfn);
> -		else if (symbol_exists("xen_p2m_addr"))
> -			pfn = __xen_pvops_m2p_hyper(machine, mfn);
> -		else
> +		else if (symbol_exists("xen_p2m_addr")) {
> +			if (XEN_CORE_DUMPFILE())
> +				pfn = __xen_pvops_m2p_hyper(machine, mfn);
> +			else
> +				pfn = __xen_pvops_m2p_domU(machine, mfn);
> +		} else
>  			pfn = __xen_pvops_m2p_l2(machine, mfn);
>  
>  		if (pfn != XEN_MFN_NOT_FOUND)
> @@ -9559,6 +9557,131 @@ __xen_pvops_m2p_hyper(ulonglong machine, ulong mfn)
>  	return XEN_MFN_NOT_FOUND;
>  }
>  
> +static void read_p2m(ulong cache_index, int memtype, void *buffer)
> +{
> +	/*
> +	 *  Use special read function for PV domain p2m reading.
> +	 *  See the comments of read_xc_p2m().
> +	 */
> +	if (symbol_exists("xen_p2m_addr") && !XEN_CORE_DUMPFILE()) {
> +		if (!read_xc_p2m(kt->p2m_mapping_cache[cache_index].mapping,
> +			buffer, PAGESIZE()))
> +			error(FATAL, "cannot access phys_to_machine_mapping page\n");
> +	} else if (!readmem(kt->p2m_mapping_cache[cache_index].mapping, memtype,
> +			buffer, PAGESIZE(), "phys_to_machine_mapping page (cached)",
> +			RETURN_ON_ERROR))
> +		error(FATAL, "cannot access phys_to_machine_mapping page\n");
> +
> +	kt->last_mapping_read = kt->p2m_mapping_cache[cache_index].mapping;
> +}
> +
> +/*
> + *  PV domain p2m mapping info is stored in xd->xfd at xch_index_offset. It
> + *  is organized as struct xen_dumpcore_p2m and the pfns are progressively
> + *  increased by 1 from 0.
> + *
> + *  This is a special p2m reading function for xen PV domain vmcores after
> + *  kernel commit 054954eb051f35e74b75a566a96fe756015352c8 (xen: switch
> + *  to linear virtual mapped sparse p2m list). It is invoked for reading
> + *  p2m associate stuff by read_p2m().
> + */
> +static int read_xc_p2m(ulonglong addr, void *buffer, long size)
> +{
> +	ulong i, new_p2m_buf_size;
> +	off_t offset;
> +	struct xen_dumpcore_p2m *new_p2m_buf;
> +	static struct xen_dumpcore_p2m *p2m_buf;
> +	static ulong p2m_buf_size = 0;
> +
> +	if (size <= 0) {
> +		if ((CRASHDEBUG(1) && !STREQ(pc->curcmd, "search")) ||
> +			CRASHDEBUG(2))
> +			error(INFO, "invalid size request: %ld\n", size);
> +		return FALSE;
> +	}
> +
> +	/*
> +	 * We extract xen_dumpcore_p2m.gmfn and copy them into the
> +	 * buffer. So, we need temporary p2m_buf whose size is
> +	 * (size * (sizeof(struct xen_dumpcore_p2m) / sizeof(ulong)))
> +	 * to put xen_dumpcore_p2m structures read from xd->xfd.
> +	 */
> +	new_p2m_buf_size = size * (sizeof(struct xen_dumpcore_p2m) /
> sizeof(ulong));
> +
> +	if (p2m_buf_size != new_p2m_buf_size) {
> +		p2m_buf_size = new_p2m_buf_size;
> +
> +		new_p2m_buf = realloc(p2m_buf, p2m_buf_size);
> +		if (new_p2m_buf == NULL) {
> +			free(p2m_buf);
> +			error(FATAL, "cannot realloc p2m buffer\n");
> +		}
> +		p2m_buf = new_p2m_buf;
> +	}
> +
> +	offset = addr * (sizeof(struct xen_dumpcore_p2m) / sizeof(ulong));
> +	offset += xd->xc_core.header.xch_index_offset;
> +
> +	if (lseek(xd->xfd, offset, SEEK_SET) == -1)
> +		error(FATAL,
> +		    "cannot lseek to xch_index_offset offset 0x%lx\n", offset);
> +	if (read(xd->xfd, (void*)p2m_buf, p2m_buf_size) != p2m_buf_size)
> +		error(FATAL,
> +		    "cannot read from xch_index_offset offset 0x%lx\n", offset);
> +
> +	for (i = 0; i < size / sizeof(ulong); i++)
> +		*((ulong *)buffer + i) = p2m_buf[i].gmfn;
> +
> +	return TRUE;
> +}
> +
> +static ulong
> +__xen_pvops_m2p_domU(ulonglong machine, ulong mfn)
> +{
> +	ulong c, end, i, mapping, p, pfn, start;
> +
> +	/*
> +	 * xch_nr_pages is the number of pages of p2m mapping. It is composed
> +	 * of struct xen_dumpcore_p2m. The stuff we want to copy into the mapping
> +	 * page is mfn whose type is unsigned long.
> +	 * So actual number of p2m pages should be:
> +	 *
> +	 * xch_nr_pages / (sizeof(struct xen_dumpcore_p2m) / sizeof(ulong))
> +	 */
> +	for (p = 0;
> +	     p < xd->xc_core.header.xch_nr_pages /
> +		(sizeof(struct xen_dumpcore_p2m) / sizeof(ulong));
> +	     ++p) {
> +
> +		mapping = p * PAGESIZE();
> +
> +		if (mapping != kt->last_mapping_read) {
> +			if (!read_xc_p2m(mapping, (void *)kt->m2p_page, PAGESIZE()))
> +				error(FATAL, "cannot read the last mapping page\n");
> +			kt->last_mapping_read = mapping;
> +		}
> +		kt->p2m_pages_searched++;
> +
> +		if (search_mapping_page(mfn, &i, &start, &end)) {
> +			pfn = p * XEN_PFNS_PER_PAGE + i;
> +			c = kt->p2m_cache_index;
> +			if (CRASHDEBUG (1))
> +				console("mfn: %lx (%llx) i: %ld pfn: %lx (%llx)\n",
> +					mfn, machine, i, pfn, XEN_PFN_TO_PSEUDO(pfn));
> +
> +			kt->p2m_mapping_cache[c].start = start;
> +			kt->p2m_mapping_cache[c].end = end;
> +			kt->p2m_mapping_cache[c].mapping = mapping;
> +			kt->p2m_mapping_cache[c].pfn = p * XEN_PFNS_PER_PAGE;
> +			kt->p2m_cache_index = (c+1) % P2M_MAPPING_CACHE;
> +
> +			return pfn;
> +		}
> +	}
> +
> +	return XEN_MFN_NOT_FOUND;
> +}
> +
>  /*
>   *  Search for an mfn in the current mapping page, and if found,
>   *  determine the range of contiguous mfns that it's contained
> diff --git a/xendump.c b/xendump.c
> index 8170b22..4bd59b5 100644
> --- a/xendump.c
> +++ b/xendump.c
> @@ -19,7 +19,7 @@
>  #include "xendump.h"
>  
>  static struct xendump_data xendump_data = { 0 };
> -static struct xendump_data *xd = &xendump_data;
> +struct xendump_data *xd = &xendump_data;
>  
>  static int xc_save_verify(char *);
>  static int xc_core_verify(char *, char *);
> diff --git a/xendump.h b/xendump.h
> index 08d41b4..b7bae65 100644
> --- a/xendump.h
> +++ b/xendump.h
> @@ -192,3 +192,5 @@ struct xen_dumpcore_p2m {
>  	uint64_t pfn;
>  	uint64_t gmfn;
>  };
> +
> +extern struct xendump_data *xd;
> --
> 1.7.1
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
