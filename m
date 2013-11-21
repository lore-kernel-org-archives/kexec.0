Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjPzd-00046U-1Q
 for kexec@lists.infradead.org; Thu, 21 Nov 2013 08:52:11 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v2] makedumpfile: Support to filter dump for kernels
 that use CONFIG_SPARSEMEM_VMEMMAP
Date: Thu, 21 Nov 2013 08:49:14 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971C47C6@BPXM01GP.gisp.nec.co.jp>
References: <20131119071808.19442.14464.stgit@localhost.localdomain>
 <528B2710.8020408@linux.vnet.ibm.com>
In-Reply-To: <528B2710.8020408@linux.vnet.ibm.com>
Content-Language: ja-JP
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Kenichi Oomichi <oomichi@mxs.nes.nec.co.jp>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Onkar N Mahajan <onmahaja@in.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Haren Myneni <hbabu@us.ibm.com>, Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Hello Hari,

On 2013/11/19 17:54:59, kexec <kexec-bounces@lists.infradead.org> wrote:
> On 11/19/2013 12:48 PM, Hari Bathini wrote:
> > Makedumpfile fails to filter dump for kernels build with CONFIG_SPARSEMEM_VMEMMAP
> > enabled as it fails to do vmemmap translations. So far, makedumpfile on ppc64 never
> > had to deal with vmemmap addresses (vmemmap regions) seperately to filter ppc64
> > crash dumps as vmemmap regions where mapped in zone normal. But with the inclusion
> > of CONFIG_SPARSEMEM_VMEMMAP config option in recent kernels, vmemmap memory regions
> > are mapped outside zone normal. There is a need to handle vmemmap to physical address
> > translation seperately in this scenario. This patch provides support in makedumpfile
> > tool to do vmemmap to physical address translation when vmemmap regions are mapped
> > outside zone normal. Some kernel symbols are needed in vmcoreinfo for this changes to
> > be effective. The kernel patch that adds the necessary symbols to vmcoreinfo has been
> > posted to linuxppc devel mailing list. This patch is influenced by vmemmap to physical
> > address translation support code in crash utility. It is has been tested successfully
> > at all dump filtering levels on kernel dumps that have CONFIG_SPARSEMEM_VMEMMAP enabled
> > and kernel dumps with CONFIG_SPARSEMEM_VMEMMAP disabled as well. Also, successfully
> > tested dump filtering on already filtered vmcores (re-filtering). The patch applies
> > cleanly on version 1.5.4 of makedumpfile.
> > 
> > Changes in v2:
> > 1. Fixed return value when vmemmap list initialization fails
> > 2. Fixed coding style issue
> > 
> > Signed-off-by: Onkar N Mahajan <onmahaja@in.ibm.com>
> > Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> > ---
> 
> This patch looks good to me.
> 
> Acked-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Basically it seems good, but I have two trivial comments.

> >  0 files changed
> > 
> > diff --git a/arch/ppc64.c b/arch/ppc64.c
> > index c229ede..390fe05 100644
> > --- a/arch/ppc64.c
> > +++ b/arch/ppc64.c
> > @@ -24,6 +24,153 @@
> >  #include "../elf_info.h"
> >  #include "../makedumpfile.h"
> > 
> > +/*
> > + * This function traverses vmemmap list to get the count of vmemmap regions
> > + * and populates the regions' info in info->vmemmap_list[]
> > + */
> > +static int
> > +get_vmemmap_list_info(ulong head)
> > +{
> > +	int   i, cnt;
> > +	long  backing_size, virt_addr_offset, phys_offset, list_offset;
> > +	ulong curr, next;
> > +	char  *vmemmap_buf = NULL;
> > +
> > +	backing_size		= SIZE(vmemmap_backing);
> > +	virt_addr_offset	= OFFSET(vmemmap_backing.virt_addr);
> > +	phys_offset		= OFFSET(vmemmap_backing.phys);
> > +	list_offset		= OFFSET(vmemmap_backing.list);
> > +	info->vmemmap_list = NULL;
> > +
> > +	/*
> > +	 * Get list count by traversing the vmemmap list
> > +	 */
> > +	cnt = 0;
> > +	curr = head;
> > +	next = 0;
> > +	do {
> > +		if (!readmem(VADDR, (curr + list_offset), &next,
> > +			     sizeof(next))) {
> > +			ERRMSG("Can't get vmemmap region addresses\n");
> > +			goto err;
> > +		}
> > +		curr = next;
> > +		cnt++;
> > +	} while ((next != 0) && (next != head));
> > +
> > +	/*
> > +	 * Using temporary buffer to save vmemmap region information
> > +	 */
> > +	vmemmap_buf = calloc(1, backing_size);

You should free this temporary buffer even when succeed.

[...]
> > +
> > +	return cnt;
> > +err:
> > +	free(vmemmap_buf);
> > +	free(info->vmemmap_list);
> > +	return 0;
> > +}

[...]
> >  struct DumpInfo {
> >  	int32_t		kernel_version;      /* version of first kernel*/
> >  	struct timeval	timestamp;
> > @@ -908,6 +916,14 @@ struct DumpInfo {
> >  	unsigned long   vmalloc_end;
> >  	unsigned long	vmemmap_start;
> >  	unsigned long	vmemmap_end;
> > +	int		vmemmap_psize;
> > +	int		vmemmap_cnt;
> > +	struct ppc64_vmemmap	*vmemmap_list;
> > +	unsigned long	flags;

DumpInfo is a wide namespace, so I think it's better to rename "flags"
to more specific name. Actually, we use specific names (e.g. flag_split,
flag_cyclic, flag_usemmap...) for each purpose.


Thanks
Atsushi Kumagai

> > +
> > +	/*
> > +	 * for vmemmap
> > +	 */
> > 
> >  	/*
> >  	 * Filter config file containing filter commands to filter out kernel
> > @@ -1093,7 +1109,6 @@ struct module_info {
> >  	struct symbol_info	*sym_info;
> >  };
> > 
> > -
> >  struct symbol_table {
> >  	unsigned long long	mem_map;
> >  	unsigned long long	vmem_map;
> > @@ -1165,6 +1180,13 @@ struct symbol_table {
> >  	unsigned long long	__per_cpu_load;
> >  	unsigned long long	cpu_online_mask;
> >  	unsigned long long	kexec_crash_image;
> > +
> > +	/*
> > +	 * vmemmap symbols on ppc64 arch
> > +	 */
> > +	unsigned long long		vmemmap_list;
> > +	unsigned long long		mmu_vmemmap_psize;
> > +	unsigned long long		mmu_psize_defs;
> >  };
> > 
> >  struct size_table {
> > @@ -1200,6 +1222,12 @@ struct size_table {
> >  	long	elf64_hdr;
> >  	long	log;
> > 
> > +	/*
> > +	 * vmemmap symbols on ppc64 arch
> > +	 */
> > +	long	vmemmap_backing;
> > +	long	mmu_psize_def;
> > +
> >  	long	pageflags;
> >  };
> > 
> > @@ -1343,6 +1371,18 @@ struct offset_table {
> >  		long text_len;
> >  	} log;
> > 
> > +	/*
> > +	 * vmemmap symbols on ppc64 arch
> > +	 */
> > +	struct mmu_psize_def {
> > +		long	shift;
> > +	} mmu_psize_def;
> > +
> > +	struct vmemmap_backing {
> > +		long	phys;
> > +		long	virt_addr;
> > +		long	list;
> > +	} vmemmap_backing;
> >  };
> > 
> >  /*
> > 
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
