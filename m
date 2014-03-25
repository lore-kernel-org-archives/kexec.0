Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WSFyc-0000T6-1M
 for kexec@lists.infradead.org; Tue, 25 Mar 2014 01:16:28 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: makedumpfile: get_max_mapnr() from ELF header problem
Date: Tue, 25 Mar 2014 01:14:21 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971F909B@BPXM01GP.gisp.nec.co.jp>
References: <20140228134148.15b60ceb@holzheu> <531FDF6D.5080901@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971F512A@BPXM01GP.gisp.nec.co.jp>
 <20140312171812.02f0bfe1@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971F672F@BPXM01GP.gisp.nec.co.jp>
 <20140314151928.5c49f17f@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971F7B95@BPXM01GP.gisp.nec.co.jp>
 <20140319180903.2c6e2b72@holzheu>
In-Reply-To: <20140319180903.2c6e2b72@holzheu>
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
To: "holzheu@linux.vnet.ibm.com" <holzheu@linux.vnet.ibm.com>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>> Now, I think this is a problem of get_mm_sparsemem() in makedumpfile.
>> To say in more detail, the problem is "wrong calculating the address
>> of unused mem_map".
>>
>> Looking at the log you sent, some addresses of mem_map corresponding
>> to unused pages look invalid like below:
>>
>> mem_map (256)
>>   mem_map    : 80000c0002018
>>   pfn_start  : 1000000
>>   pfn_end    : 1010000
>> mem_map (257)
>>   mem_map    : 800001840400000
>>   pfn_start  : 1010000
>>   pfn_end    : 1020000
>> ...
>> mem_map (544)
>>   mem_map    : a82400012f14fffc
>>   pfn_start  : 2200000
>>   pfn_end    : 2210000
>>
>> ...(and more)
>>
>> However, makedumpfile should calculate such unused mem_map addresses
>> as 0(NOT_MEMMAP_ADDR). Actually it works as expected at least in my
>> environment(x86_64):
>>
>> ...
>> mem_map (16)
>>   mem_map    : 0
>>   pfn_start  : 80000
>>   pfn_end    : 88000
>> mem_map (17)
>>   mem_map    : 0
>>   pfn_start  : 88000
>>   pfn_end    : 90000
>> ...
>>
>> makedumpfile get the address from mem_section.section_mem_map,
>> it will be initialized with zero:
>>
>> [CONFIG_SPARSEMEM_EXTREAM]
>>   paging_init()
>>     sparse_memory_present_with_active_regions()
>>       memory_present()
>>         sparse_index_init()
>>           sparse_index_alloc()   // allocate mem_section with kzalloc()
>>
>> makedumpfile assumes the value of unused mem_section will remain as 0,
>> but I suspect this assumption may be broken in your environment.
>
>No, I think your assumption is true also for my environment. For my
>dump the "mem_section" array is zero except for the first entry.
>
>crash> print/x mem_section
>$1 = {0x2fe6f800, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, ...}
>
>But it looks like get_mm_sparsemem() does not check for zero.
>The nr_to_section() function just returns an invalid address
>(something between 0 and 4096) for section in case we get zero
>from the "mem_section" entry. This is address is then used for
>calculating "mem_map":

In other architectures, the check by is_kaddr() avoids to
read invalid address, but it doesn't do anything in the case
of s390 due to the its memory management mechanism:

s390x: Fix KVBASE to correct value for	s390x architecture.
http://lists.infradead.org/pipermail/kexec/2011-March/004930.html

Finally I've understood the cause of this issue completely,
thanks for your report.

>mem_map = section_mem_map_addr(section);
>mem_map = sparse_decode_mem_map(mem_map, section_nr);
>
>With the patch below I could use makedumpfile (1.5.3) successfully
>on the 1TB dump with mem=1G. I attached the -D output that is
>created by makedumpfile with the patch.
>
>But compared to my first patch it takes much longer and the resulting
>dump is bigger (version 1.5.3):
>
>             | Dump time   | Dump size
>-------------+-------------+-----------
>First patch  |  10 sec     |  124 MB
>Second patch |  87 minutes | 6348 MB
>
>No idea why the dump is bigger with the second patch. I think the time
>is consumed in write_kdump_pages_cyclic() by checking for zero pages
>for the whole range:

I suppose this difference was resolved with the v2 of the second patch,
right?

>
>5970            for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>(gdb) n
>5972                    if ((num_dumped % per) == 0)
>(gdb) n
>5978                    if (!is_dumpable_cyclic(info->partial_bitmap2, pfn))
>(gdb) n
>5981                    num_dumped++;
>(gdb) n
>5983                    if (!read_pfn(pfn, buf))
>(gdb) n
>5989                    if ((info->dump_level & DL_EXCLUDE_ZERO)
>(gdb) n
>5990                        && is_zero_page(buf, info->page_size)) {
>(gdb) n
>5991                            if (!write_cache(cd_header, pd_zero, sizeof(page_desc_t)))
>(gdb) n
>5993                            pfn_zero++;
>(gdb) n
>5994                            continue;
>
>(gdb) print end_pfn
>$3 = 268435456
>
>So the first patch would be better for my scenario. What in particular are your
>concerns with that patch?

I think the v2 second patch is a reasonable patch to fix the
bug of get_mm_sparsemem().
Additionally, the latest patch you posted to adjust max_mapnr
(which using mem_map_data[]) is acceptable instead of the first
patch.
So could you re-post the two as a formal patch set?
I mean patch descriptions and your signature are needed.


Thanks
Atsushi Kumagai

>Michael
>
>The following patch adds the zero check for "mem_section" entries
>---
> makedumpfile.c |   17 ++++++++++++-----
> 1 file changed, 12 insertions(+), 5 deletions(-)
>
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -2402,11 +2402,14 @@ nr_to_section(unsigned long nr, unsigned
> {
> 	unsigned long addr;
>
>-	if (is_sparsemem_extreme())
>+	if (is_sparsemem_extreme()) {
>+		if (mem_sec[SECTION_NR_TO_ROOT(nr)] == 0)
>+			return NOT_KV_ADDR;
> 		addr = mem_sec[SECTION_NR_TO_ROOT(nr)] +
> 		    (nr & SECTION_ROOT_MASK()) * SIZE(mem_section);
>-	else
>+	} else {
> 		addr = SYMBOL(mem_section) + (nr * SIZE(mem_section));
>+	}
>
> 	if (!is_kvaddr(addr))
> 		return NOT_KV_ADDR;
>@@ -2490,10 +2493,14 @@ get_mm_sparsemem(void)
> 	}
> 	for (section_nr = 0; section_nr < num_section; section_nr++) {
> 		section = nr_to_section(section_nr, mem_sec);
>-		mem_map = section_mem_map_addr(section);
>-		mem_map = sparse_decode_mem_map(mem_map, section_nr);
>-		if (!is_kvaddr(mem_map))
>+		if (section == NOT_KV_ADDR) {
> 			mem_map = NOT_MEMMAP_ADDR;
>+		} else {
>+			mem_map = section_mem_map_addr(section);
>+			mem_map = sparse_decode_mem_map(mem_map, section_nr);
>+			if (!is_kvaddr(mem_map))
>+				mem_map = NOT_MEMMAP_ADDR;
>+		}
> 		pfn_start = section_nr * PAGES_PER_SECTION();
> 		pfn_end   = pfn_start + PAGES_PER_SECTION();
> 		if (info->max_mapnr < pfn_end)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
