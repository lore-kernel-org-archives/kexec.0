Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]
	helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KZ8V6-0000nF-Ks
	for kexec@lists.infradead.org; Fri, 29 Aug 2008 18:15:13 +0000
Message-ID: <48B83C82.3060100@sgi.com>
Date: Fri, 29 Aug 2008 11:14:26 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: Re: [PATCH][ia64] Fix the difference between node_mem_map
	and	node_start_pfn. (Re: makedumpfile fails on SGI machine)
References: <20080730161416.47605c30@halley.suse.de>	<4891197D.10400@mxs.nes.nec.co.jp>	<20080731104726.035850be@halley.suse.de>	<48919306.80103@mxs.nes.nec.co.jp>	<20080731131823.3c7c97b2@halley.suse.de>	<4891A3CB.9040805@mxs.nes.nec.co.jp>	<48984275.5070409@mxs.nes.nec.co.jp>	<20080805171143.773c2465@halley.suse.de>	<48A9228A.3070005@mxs.nes.nec.co.jp>	<20080818130025.0282e471@halley.suse.de>	<48B517A2.5010508@mxs.nes.nec.co.jp>	<48B602CF.5040809@sgi.com>	<20080828092519.5d2d8838@halley.suse.de>
	<48B79B17.8050307@mxs.nes.nec.co.jp>
In-Reply-To: <48B79B17.8050307@mxs.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1475385456=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org

--===============1475385456==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Ken'ichi Ohmichi wrote:
> Hi Bernhard, Jay,
> 
> Bernhard Walle wrote:
>> Hi Ken'ichi Ohmichi,
>>
>> * Jay Lan [2008-08-27 18:43]:
>>> Thanks for your patch!
>>>
>>> I am wondering if the discontigmem kernel has a legitimate bug,
>>> we probably should report it?
>>>
>>> I tested your patch on a machine that used to fail in executing
>>> 'makedumpfile'. It now generated a dump file fine.
>> thanks for the patch, I can also report that with the patch and with
>> vmlinux it works now.
> 
> Thank you for the report. It's a good news :-)
> 
> 
>> However, shouldn't we add that vmem_map to VMCOREINFO of the kernel?

Hmm, it failed on a shub2 machine. (The previous on that worked was a
shub1 machine, an A3700. An A4700 is a shub2.) I assumed the warning
about kernel version 2.6.27 not supported was harmless?

a4700rac:~ # /bin/makedumpfile-1.2.7-0.2 -c -d31 -x
/boot/vmlinux-2.6.27-rc4-vanilla /proc/vmcore /diskdump/dumpfile
Can't distinguish the pgtable.
The kernel version is not supported.
The created dumpfile may be incomplete.
Excluding unnecessary pages        : [  0 %] readmem: Can't convert a
virtual address(a07ffff9df8f5800) to offset.
create_2nd_bitmap: Can't exclude unnecessary pages.

makedumpfile Failed.
a4700rac:~ #

I will try your kernel patch next.

Regards,
 - jay

> 
> I think that we would rather fix the kernel bug than add vmem_map to
> VMCOREINFO of the kernel. If fixing it, makedumpfile does not need
> vmem_map.
> 
> The attached patch fixes the kernel bug, and makedumpfile can work without
> '-x' option. I tested it on my ia64 none-NUMA machine, and it works fine.
> Could you test the attached patch on your machine again ?
> 
> 
> Thanks
> Ken'ichi Ohmichi
> 
> ---
> [PATCH][ia64] Fix the difference between node_mem_map and node_start_pfn.
> 
> makedumpfile[1] cannot run on ia64 discontigmem kernel, because the member
> node_mem_map of struct pgdat_list has invalid value. This patch fixes it.
> 
> node_start_pfn shows the start pfn of each node, and node_mem_map should
> point 'struct page' of each node's node_start_pfn.
> On my machine, node0's node_start_pfn shows 0x400 and its node_mem_map points
> 0xa0007fffbf000000. This address is the same as vmem_map, so the node_mem_map
> points 'struct page' of pfn 0, even if its node_start_pfn shows 0x400.
> 
> The cause is due to the round down of min_pfn in count_node_pages().
> This patch fixes it.
> 
> 
> makedumpfile[1]: dump filtering command
> https://sourceforge.net/projects/makedumpfile/
> 
> Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
> ---
> --- a/arch/ia64/mm/discontig.c	2008-08-29 23:05:52.000000000 +0900
> +++ b/arch/ia64/mm/discontig.c	2008-08-29 23:06:59.000000000 +0900
> @@ -631,7 +631,6 @@ static __init int count_node_pages(unsig
>  			(min(end, __pa(MAX_DMA_ADDRESS)) - start) >>PAGE_SHIFT;
>  #endif
>  	start = GRANULEROUNDDOWN(start);
> -	start = ORDERROUNDDOWN(start);
>  	end = GRANULEROUNDUP(end);
>  	mem_data[node].max_pfn = max(mem_data[node].max_pfn,
>  				     end >> PAGE_SHIFT);
> --- a/include/asm-ia64/meminit.h	2008-08-29 23:06:36.000000000 +0900
> +++ b/include/asm-ia64/meminit.h	2008-08-29 23:06:48.000000000 +0900
> @@ -47,7 +47,6 @@ extern int reserve_elfcorehdr(unsigned l
>   */
>  #define GRANULEROUNDDOWN(n)	((n) & ~(IA64_GRANULE_SIZE-1))
>  #define GRANULEROUNDUP(n)	(((n)+IA64_GRANULE_SIZE-1) & ~(IA64_GRANULE_SIZE-1))
> -#define ORDERROUNDDOWN(n)	((n) & ~((PAGE_SIZE<<MAX_ORDER)-1))
>  
>  #ifdef CONFIG_NUMA
>    extern void call_pernode_memory (unsigned long start, unsigned long len, void *func);
> _
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



--===============1475385456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1475385456==--
