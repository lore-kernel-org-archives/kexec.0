Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQLFZ-0003vc-Vx
 for kexec@lists.infradead.org; Wed, 19 Mar 2014 18:30:03 +0000
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 19 Mar 2014 18:29:38 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 72E082190041
 for <kexec@lists.infradead.org>; Wed, 19 Mar 2014 18:29:31 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2JITOPC61866106
 for <kexec@lists.infradead.org>; Wed, 19 Mar 2014 18:29:24 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2JITZVu028354
 for <kexec@lists.infradead.org>; Wed, 19 Mar 2014 12:29:36 -0600
Date: Wed, 19 Mar 2014 19:29:32 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: makedumpfile: get_max_mapnr() from ELF header problem
Message-ID: <20140319192932.40310fac@holzheu>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971F7B95@BPXM01GP.gisp.nec.co.jp>
References: <20140228134148.15b60ceb@holzheu> <531FDF6D.5080901@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971F512A@BPXM01GP.gisp.nec.co.jp>
 <20140312171812.02f0bfe1@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971F672F@BPXM01GP.gisp.nec.co.jp>
 <20140314151928.5c49f17f@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971F7B95@BPXM01GP.gisp.nec.co.jp>
Mime-Version: 1.0
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Wed, 19 Mar 2014 07:14:25 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> >Hello Atsushi,
> >
> >I debugged my problem a bit further and tried to implement
> >a function that gets the maximum page frame number from the
> >Linux kernel memory management structures.
> >
> >I am no memory management expert, so the following patch probably
> >is not complete, but at least for my setup it worked.
> 
> The patch looks good for your case, but I don't think it's a proper
> approach for this problem.
> 
> Now, I think this is a problem of get_mm_sparsemem() in makedumpfile.
> To say in more detail, the problem is "wrong calculating the address
> of unused mem_map".
> 
> Looking at the log you sent, some addresses of mem_map corresponding
> to unused pages look invalid like below:
> 
> mem_map (256)
>   mem_map    : 80000c0002018
>   pfn_start  : 1000000
>   pfn_end    : 1010000
> mem_map (257)
>   mem_map    : 800001840400000
>   pfn_start  : 1010000
>   pfn_end    : 1020000
> ...
> mem_map (544)
>   mem_map    : a82400012f14fffc
>   pfn_start  : 2200000
>   pfn_end    : 2210000
> 
> ...(and more)
> 
> However, makedumpfile should calculate such unused mem_map addresses
> as 0(NOT_MEMMAP_ADDR). Actually it works as expected at least in my
> environment(x86_64):
> 
> ...
> mem_map (16)
>   mem_map    : 0
>   pfn_start  : 80000
>   pfn_end    : 88000
> mem_map (17)
>   mem_map    : 0
>   pfn_start  : 88000
>   pfn_end    : 90000
> ...
> 
> makedumpfile get the address from mem_section.section_mem_map,
> it will be initialized with zero: 
> 
> [CONFIG_SPARSEMEM_EXTREAM]
>   paging_init()
>     sparse_memory_present_with_active_regions()
>       memory_present()
>         sparse_index_init()
>           sparse_index_alloc()   // allocate mem_section with kzalloc()
> 
> makedumpfile assumes the value of unused mem_section will remain as 0,
> but I suspect this assumption may be broken in your environment.
> 

Hello Atshushi,

I noticed that my last patch was not complete. It only checked the
mem_section[] array for zero entries. But as you noticed, we also
have to check the section array that we get from the mem_section
entries.

So I updated the patch.

Michael
---
 makedumpfile.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2690,11 +2690,14 @@ nr_to_section(unsigned long nr, unsigned
 {
 	unsigned long addr;
 
-	if (is_sparsemem_extreme())
+	if (is_sparsemem_extreme()) {
+		if (mem_sec[SECTION_NR_TO_ROOT(nr)] == 0)
+			return NOT_KV_ADDR;
 		addr = mem_sec[SECTION_NR_TO_ROOT(nr)] +
 		    (nr & SECTION_ROOT_MASK()) * SIZE(mem_section);
-	else
+	} else {
 		addr = SYMBOL(mem_section) + (nr * SIZE(mem_section));
+	}
 
 	if (!is_kvaddr(addr))
 		return NOT_KV_ADDR;
@@ -2778,10 +2781,19 @@ get_mm_sparsemem(void)
 	}
 	for (section_nr = 0; section_nr < num_section; section_nr++) {
 		section = nr_to_section(section_nr, mem_sec);
-		mem_map = section_mem_map_addr(section);
-		mem_map = sparse_decode_mem_map(mem_map, section_nr);
-		if (!is_kvaddr(mem_map))
+		if (section == NOT_KV_ADDR) {
 			mem_map = NOT_MEMMAP_ADDR;
+		} else {
+			mem_map = section_mem_map_addr(section);
+			if (mem_map == 0) {
+				mem_map = NOT_MEMMAP_ADDR;
+			} else {
+				mem_map = sparse_decode_mem_map(mem_map,
+								section_nr);
+				if (!is_kvaddr(mem_map))
+					mem_map = NOT_MEMMAP_ADDR;
+			}
+		}
 		pfn_start = section_nr * PAGES_PER_SECTION();
 		pfn_end   = pfn_start + PAGES_PER_SECTION();
 		if (info->max_mapnr < pfn_end)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
