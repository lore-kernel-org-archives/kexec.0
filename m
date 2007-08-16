Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1ILWq3-0001N4-Ak
	for kexec@lists.infradead.org; Thu, 16 Aug 2007 00:20:05 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7G4K0wI016429
	for <kexec@lists.infradead.org>; Thu, 16 Aug 2007 00:20:00 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l7G4K0il261828
	for <kexec@lists.infradead.org>; Wed, 15 Aug 2007 22:20:00 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7G4K0aM006880
	for <kexec@lists.infradead.org>; Wed, 15 Aug 2007 22:20:00 -0600
Date: Thu, 16 Aug 2007 09:50:08 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [RFC][PATCH 1/3] Embed vmcoreinfo into kernel file
Message-ID: <20070816042008.GB20860@in.ibm.com>
References: <20070813163212oomichi@mail.jp.nec.com>
	<20070813163653oomichi@mail.jp.nec.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070813163653oomichi@mail.jp.nec.com>
Reply-To: vgoyal@in.ibm.com
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Don Zickus <dzickus@redhat.com>, Bernhard Walle <bwalle@suse.de>, kexec-ml <kexec@lists.infradead.org>, Neil Horman <nhorman@redhat.com>, Dan Aloni <da-x@monatomic.org>

On Mon, Aug 13, 2007 at 04:36:53PM +0900, Ken'ichi Ohmichi wrote:
> 
> Patches:
> - [1/3] patch for linux-2.6.22.
>   Changelog:
>   * Rename "mkdfinfo" to "vmcoreinfo".
>   * Multi memory models (FLATMEM, DISCONTIGMEM, and SPASEMEM) are
>     supported.
>   * The elf note typedef for vmcoreinfo is added because the original
>     elf note size is limited to 1024.
>   * The generation of the elf note is moved to boot time instead of
>     crash time.
> 

Hi Keni'chi,

Overall it looks good. Few thougts inline.

> +#define SIZE(name) \
> +	vmcoreinfo_append_str("SIZE(%s)=%d\n", #name, sizeof(struct name))
> +#define OFFSET(name, field) \
> +	vmcoreinfo_append_str("OFFSET(%s.%s)=%d\n", #name, #field, &(((struct name *)0)->field))
> +#define LENGTH(name, value) \
> +	vmcoreinfo_append_str("LENGTH(%s)=%d\n", #name, value)
> +
> +static int __init crash_save_vmcoreinfo_init(void)
> +{
> +#ifndef CONFIG_X86_32
> +	extern char _stext;
> +#endif

In general, there are too many #ifdef in a single function. Code looks too
cluttered. Some suggestions are inlined.

Can't we put the definition of extern _stext in a header file and then
include it here?

> +#ifdef CONFIG_ARCH_DISCONTIGMEM_ENABLE
> +#ifdef CONFIG_IA64
> +	extern pg_data_t *pgdat_list[MAX_NUMNODES];
> +#endif

This extern declaration also should be part of some header file and that
file should be included.

> +#endif
> +	vmcoreinfo_append_str("OSRELEASE=%s\n", UTS_RELEASE);
> +	vmcoreinfo_append_str("PAGESIZE=%d\n", PAGE_SIZE);
> +
> +	SYMBOL(init_uts_ns);
> +	SYMBOL(node_online_map);
> +	SYMBOL(swapper_pg_dir);
> +	SYMBOL(_stext);
> +
> +#ifndef CONFIG_NEED_MULTIPLE_NODES
> +	SYMBOL(mem_map);
> +	SYMBOL(contig_page_data);
> +#endif
> +#ifdef CONFIG_SPARSEMEM
> +	SYMBOL(mem_section);
> +	LENGTH(mem_section, NR_SECTION_ROOTS);
> +	SIZE(mem_section);
> +	OFFSET(mem_section, section_mem_map);
> +#endif
> +
> +#ifdef CONFIG_ARCH_DISCONTIGMEM_ENABLE
> +#ifdef CONFIG_IA64
> +	SYMBOL(pgdat_list);
> +	LENGTH(pgdat_list, MAX_NUMNODES);
> +	SYMBOL(node_memblk);
> +	LENGTH(node_memblk, NR_NODE_MEMBLKS);
> +	SIZE(node_memblk_s);
> +	OFFSET(node_memblk_s, start_paddr);
> +	OFFSET(node_memblk_s, size);
> +	OFFSET(node_memblk_s, nid);
> +#else
> +	SYMBOL(node_data);
> +	LENGTH(node_data, MAX_NUMNODES);
> +#endif

There is too much IA64 specific stuff in arch independent function. I think
we can create an arch specific function also which is called from here.
Something like arch_save_vmcoreinfo(). IA64 can fill all the IA64 specific
details in that function. Rest of the kdump supporting arch will define
this function as do{}while().

> +#endif
> +
> +	SIZE(page);
> +	SIZE(pglist_data);
> +	SIZE(zone);
> +	SIZE(free_area);
> +	SIZE(list_head);
> +
> +	OFFSET(page, flags);
> +	OFFSET(page, _count);
> +	OFFSET(page, mapping);
> +	OFFSET(page, lru);
> +	OFFSET(pglist_data, node_zones);
> +	OFFSET(pglist_data, nr_zones);
> +#ifdef CONFIG_FLAT_NODE_MEM_MAP
> +	OFFSET(pglist_data, node_mem_map);
> +#endif
> +	OFFSET(pglist_data, node_start_pfn);
> +	OFFSET(pglist_data, node_spanned_pages);
> +	OFFSET(pglist_data, node_id);
> +	OFFSET(zone, free_area);
> +	OFFSET(zone, vm_stat);
> +	OFFSET(zone, spanned_pages);
> +	OFFSET(free_area, free_list);
> +	OFFSET(list_head, next);
> +	OFFSET(list_head, prev);
> +	LENGTH(zone.free_area, MAX_ORDER);
> +#ifdef CONFIG_X86_PAE
> +	vmcoreinfo_append_str("CONFIG_X86_PAE=y\n");
> +#endif
> +
> +#ifdef CONFIG_IA64
> +#ifdef CONFIG_PGTABLE_3
> +	vmcoreinfo_append_str("CONFIG_PGTABLE_3=y\n");
> +#elif CONFIG_PGTABLE_4
> +	vmcoreinfo_append_str("CONFIG_PGTABLE_4=y\n");

For config variables we can possibly define another preprocessor macro.
Something like
#define CONFIG(name)
 vmcoreinfo_append_str("CONFIG_#name = %c\n", if(CONFIG_#name =='y'?'y':n)

This should get rid of config option specific #ifdef.

- There is another important field which I would like to see in vmcoreinfo
  and that is time of crash (lets say CRASH_TIME). This will indicate the
  timestamp when did system actually crash. One can read the time in
  crash_kexec(), fill in the field and then save vmcore info note.

  For this, either you need to scan the vmcoreinfo note again and fill in
  the time stamp. Or you need to do vmcoreinfo note saving after crash
  instead of boot time.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
