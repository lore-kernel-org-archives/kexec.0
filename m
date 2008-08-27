Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KYHEO-0003GC-Q4
	for kexec@lists.infradead.org; Wed, 27 Aug 2008 09:22:25 +0000
Message-ID: <48B517A2.5010508@mxs.nes.nec.co.jp>
Date: Wed, 27 Aug 2008 18:00:18 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: makedumpfile fails on SGI machine
References: <20080730161416.47605c30@halley.suse.de>	<4891197D.10400@mxs.nes.nec.co.jp>	<20080731104726.035850be@halley.suse.de>	<48919306.80103@mxs.nes.nec.co.jp>	<20080731131823.3c7c97b2@halley.suse.de>	<4891A3CB.9040805@mxs.nes.nec.co.jp>	<48984275.5070409@mxs.nes.nec.co.jp>	<20080805171143.773c2465@halley.suse.de>	<48A9228A.3070005@mxs.nes.nec.co.jp>
	<20080818130025.0282e471@halley.suse.de>
In-Reply-To: <20080818130025.0282e471@halley.suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0405648673=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: Jay Lan <jlan@sgi.com>, kexec@lists.infradead.org

--===============0405648673==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Bernhard Walle wrote:
>>> * Ken'ichi Ohmichi [2008-08-05 21:07]:
>>>> BTW, I'd like to know some conditions of this problem.
>>>> So please let me know the makedumpfile commandline which you run.
>>>>  Ex. # makedumpfile -d 31 -x vmlinux /proc/vmcore dumpfile
>>>   # makedumpfile -d 3 -D vmcore.sles11 vmcore.sles11.filtered
>>>
>>>> I doubt that makedumpfile cannot distinguish the pgtable correctly.
>>>> I created the debugging patch. Please run makedumpfile-1.2.7 applied
>>>> with it by '-D' option, and report the output.
>>>> According to your kernel .config file, the output should contain
>>>> "PAGETABLE_4L : ON".
>>> See the attachment.
>> Thanks for the log.
>> makedumpfile can distinguish the pgtable correctly.
>>
>> Can the crash utility translate the virtual address 0xa0007fff8f900000
>> to physical address ? Please run the following subcommand on the crash
>> utility.
>>
>> crash> vtop 0xa0007fff8f900000
> 
> crash> vtop 0xa0007fff8f900000  
> VIRTUAL           PHYSICAL        
> a0007fff8f900000  (not mapped)
> 
> PAGE DIRECTORY: a000000100914000
>    PGD: a000000100914000 => 30030bc000
>    PUD: e0000030030bfff8 => 30030c0000
>    PMD: e0000030030c3e38 => 30030c4000
>    PTE: e0000030030c7200 => 0
> 
> 
> But I guess that's normal with virtual memory maps:
> 
> $ zgrep VIRTUAL_M /proc/config.gz 
> CONFIG_VIRTUAL_MEM_MAP=y

Thank you for your help.

I found an ia64 discontigmem kernel problem that the 'pgdat_list.node_mem_map'
has an unexpected value, and I created the attached patch for avoiding the
problem. If applying this patch, makedumpfile takes mem_map's information
from a symbol 'vmem_map' instead of 'pgdat_list.node_mem_map'.
It is for makedumpfile-1.2.8.  Could you please test it ?

Note:
 This solution needs a symbol 'vmem_map', but vmcoreinfo data in /proc/vmcore
 does not contain it. So "-x" option is necessary for running makedumpfile
 like the following.

 # makedumpfile -c -d31 -x vmlinux /proc/vmcore dumpfile


Thanks
Ken'ichi Ohmichi

diff -puN backup/v1.2.8/makedumpfile.c makedumpfile/makedumpfile.c
--- backup/v1.2.8/makedumpfile.c	2008-08-12 12:17:24.000000000 +0900
+++ makedumpfile/makedumpfile.c	2008-08-28 02:07:47.000000000 +0900
@@ -1819,6 +1819,7 @@ get_symbol_info()
 	 * Get symbol info.
 	 */
 	SYMBOL_INIT(mem_map, "mem_map");
+	SYMBOL_INIT(vmem_map, "vmem_map");
 	SYMBOL_INIT(mem_section, "mem_section");
 	SYMBOL_INIT(pkmap_count, "pkmap_count");
 	SYMBOL_INIT_NEXT(pkmap_count_next, "pkmap_count");
@@ -2110,6 +2111,7 @@ generate_vmcoreinfo()
 	 * write the symbol of 1st kernel
 	 */
 	WRITE_SYMBOL("mem_map", mem_map);
+	WRITE_SYMBOL("vmem_map", vmem_map);
 	WRITE_SYMBOL("mem_section", mem_section);
 	WRITE_SYMBOL("pkmap_count", pkmap_count);
 	WRITE_SYMBOL("pkmap_count_next", pkmap_count_next);
@@ -2350,6 +2352,7 @@ read_vmcoreinfo()
 		return FALSE;
 
 	READ_SYMBOL("mem_map", mem_map);
+	READ_SYMBOL("vmem_map", vmem_map);
 	READ_SYMBOL("mem_section", mem_section);
 	READ_SYMBOL("pkmap_count", pkmap_count);
 	READ_SYMBOL("pkmap_count_next", pkmap_count_next);
@@ -2912,6 +2915,7 @@ get_mm_discontigmem()
 {
 	int i, j, id_mm, node, num_mem_map, separate_mm = FALSE;
 	unsigned long pgdat, mem_map, pfn_start, pfn_end, node_spanned_pages;
+	unsigned long vmem_map;
 	struct mem_map_data temp_mmd;
 
 	num_mem_map = get_num_mm_discontigmem();
@@ -2924,6 +2928,13 @@ get_mm_discontigmem()
 		separate_mm = TRUE;
 	}
 
+	if (SYMBOL(vmem_map) != NOT_FOUND_SYMBOL) {
+		if (!readmem(VADDR, SYMBOL(vmem_map), &vmem_map, sizeof vmem_map)) {
+			ERRMSG("Can't get vmem_map.\n");
+			return FALSE;
+		}
+	}
+
 	/*
 	 * Get the first node_id.
 	 */
@@ -2937,11 +2948,6 @@ get_mm_discontigmem()
 	}
 	id_mm = 0;
 	for (i = 0; i < vt.numnodes; i++) {
-		if (!readmem(VADDR, pgdat + OFFSET(pglist_data.node_mem_map),
-		    &mem_map, sizeof mem_map)) {
-			ERRMSG("Can't get mem_map.\n");
-			return FALSE;
-		}
 		if (!readmem(VADDR, pgdat + OFFSET(pglist_data.node_start_pfn),
 		    &pfn_start, sizeof pfn_start)) {
 			ERRMSG("Can't get node_start_pfn.\n");
@@ -2954,6 +2960,15 @@ get_mm_discontigmem()
 		}
 		pfn_end = pfn_start + node_spanned_pages;
 
+		if (SYMBOL(vmem_map) == NOT_FOUND_SYMBOL) {
+			if (!readmem(VADDR, pgdat + OFFSET(pglist_data.node_mem_map),
+			    &mem_map, sizeof mem_map)) {
+				ERRMSG("Can't get mem_map.\n");
+				return FALSE;
+			}
+		} else
+			mem_map = vmem_map + SIZE(page) * pfn_start;
+
 		if (separate_mm) {
 			/*
 			 * For some ia64 NUMA systems.
diff -puN backup/v1.2.8/makedumpfile.h makedumpfile/makedumpfile.h
--- backup/v1.2.8/makedumpfile.h	2008-08-12 12:17:24.000000000 +0900
+++ makedumpfile/makedumpfile.h	2008-08-28 02:06:40.000000000 +0900
@@ -814,6 +814,7 @@ extern struct vm_table		vt;
 
 struct symbol_table {
 	unsigned long long	mem_map;
+	unsigned long long	vmem_map;
 	unsigned long long	mem_section;
 	unsigned long long	pkmap_count;
 	unsigned long long	pkmap_count_next;


--===============0405648673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0405648673==--
