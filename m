Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WkUks-0008Hm-CL
 for kexec@lists.infradead.org; Wed, 14 May 2014 08:41:39 +0000
Date: Wed, 14 May 2014 10:41:11 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v3 1/2] Generic handling of multi-page exclusions
Message-ID: <20140514104111.4062e86c@hananiah.suse.cz>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9721099E@BPXM01GP.gisp.nec.co.jp>
References: <1399482403-3656-1-git-send-email-ptesarik@suse.cz>
 <1399482403-3656-2-git-send-email-ptesarik@suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE9721099E@BPXM01GP.gisp.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Wed, 14 May 2014 07:54:17 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> Hello Petr,
> 
> >When multiple pages are excluded from the dump, store the extents in
> >struct cycle and check if anything is still pending on the next invocation
> >of __exclude_unnecessary_pages. This assumes that:
> >
> >  1. after __exclude_unnecessary_pages is called for a struct mem_map_data
> >     that extends beyond the current cycle, it is not called again during
> >     that cycle,
> >  2. in the next cycle, __exclude_unnecessary_pages is not called before
> >     this final struct mem_map_data.
> >
> >Both assumptions are met if struct mem_map_data segments:
> >
> >  1. do not overlap,
> >  2. are sorted by physical address in ascending order.
> 
> In ELF case, write_elf_pages_cyclic() processes PT_LOAD entries from
> PT_LOAD(0), this can break both assumptions unluckily.
> Actually this patch doesn't work on my machine:
> 
> LOAD (0)
>   phys_start : 1000000
>   phys_end   : 182f000
>   virt_start : ffffffff81000000
>   virt_end   : ffffffff8182f000
> LOAD (1)
>   phys_start : 1000
>   phys_end   : 9b400
>   virt_start : ffff810000001000
>   virt_end   : ffff81000009b400
> LOAD (2)
>   phys_start : 100000
>   phys_end   : 27000000
>   virt_start : ffff810000100000
>   virt_end   : ffff810027000000
> LOAD (3)
>   phys_start : 37000000
>   phys_end   : cff70000
>   virt_start : ffff810037000000
>   virt_end   : ffff8100cff70000
> LOAD (4)
>   phys_start : 100000000
>   phys_end   : 170000000
>   virt_start : ffff810100000000
>   virt_end   : ffff810170000000
> 
> 
> PT_LOAD(2) includes PT_LOAD(0) and there physical addresses aren't sorted.
> 
> If there is the only "sort issue", it may easy to fix it with a new iterator
> like "for_each_pt_load()", it iterates PT_LOAD entries in ascending order
> by physical address.
> However, I don't have a good idea to solve the overlap issue now...

I have. I can go back to my previous version and add those fields to
struct mem_map_data. I only changed it because of this feedback from
HATAYAMA Daisuke:

http://lists.infradead.org/pipermail/kexec/2014-April/011477.html

If I add the fields to struct mem_map_data, the code does not depend on
any specific call order.

OK, time for version 4.

Petr T

> Thanks
> Atsushi Kumagai
> 
> >These two conditions are true for all supported memory models.
> >
> >Note that the start PFN of the excluded extent is set to the end of the
> >current cycle (which is equal to the start of the next cycle, see
> >update_cycle), so only the part of the excluded region which falls beyond
> >current cycle buffer is valid. If the excluded region is completely
> >processed in the current cycle, the start PFN is bigger than the end PFN
> >and no work is done at the beginning of the next cycle.
> >
> >After processing the leftover from last cycle, pfn_start and mem_map are
> >adjusted to skip the excluded pages. There is no check whether the
> >adjusted pfn_start is within the current cycle. Nothing bad happens if
> >it isn't, because pages outside the current cyclic region are ignored by
> >the subsequent loop, and the remainder is postponed to the next cycle by
> >exclude_range().
> >
> >Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
> >---
> > makedumpfile.c | 49 +++++++++++++++++++++++++++++++++++--------------
> > makedumpfile.h |  5 +++++
> > 2 files changed, 40 insertions(+), 14 deletions(-)
> >
> >diff --git a/makedumpfile.c b/makedumpfile.c
> >index 16081a5..a3498e4 100644
> >--- a/makedumpfile.c
> >+++ b/makedumpfile.c
> >@@ -4667,6 +4667,26 @@ initialize_2nd_bitmap_cyclic(struct cycle *cycle)
> > 	return TRUE;
> > }
> >
> >+static void
> >+exclude_range(mdf_pfn_t *counter, mdf_pfn_t pfn, mdf_pfn_t endpfn,
> >+    struct cycle *cycle)
> >+{
> >+	if (cycle) {
> >+		cycle->exclude_pfn_start = cycle->end_pfn;
> >+		cycle->exclude_pfn_end = endpfn;
> >+		cycle->exclude_pfn_counter = counter;
> >+
> >+		if (cycle->end_pfn < endpfn)
> >+			endpfn = cycle->end_pfn;
> >+	}
> >+
> >+	while (pfn < endpfn) {
> >+		if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
> >+			(*counter)++;
> >+		++pfn;
> >+	}
> >+}
> >+
> > int
> > __exclude_unnecessary_pages(unsigned long mem_map,
> >     mdf_pfn_t pfn_start, mdf_pfn_t pfn_end, struct cycle *cycle)
> >@@ -4681,6 +4701,18 @@ __exclude_unnecessary_pages(unsigned long mem_map,
> > 	unsigned long flags, mapping, private = 0;
> >
> > 	/*
> >+	 * If a multi-page exclusion is pending, do it first
> >+	 */
> >+	if (cycle && cycle->exclude_pfn_start < cycle->exclude_pfn_end) {
> >+		exclude_range(cycle->exclude_pfn_counter,
> >+			cycle->exclude_pfn_start, cycle->exclude_pfn_end,
> >+			cycle);
> >+
> >+		mem_map += (cycle->exclude_pfn_end - pfn_start) * SIZE(page);
> >+		pfn_start = cycle->exclude_pfn_end;
> >+	}
> >+
> >+	/*
> > 	 * Refresh the buffer of struct page, when changing mem_map.
> > 	 */
> > 	pfn_read_start = ULONGLONG_MAX;
> >@@ -4744,21 +4776,10 @@ __exclude_unnecessary_pages(unsigned long mem_map,
> > 		if ((info->dump_level & DL_EXCLUDE_FREE)
> > 		    && info->page_is_buddy
> > 		    && info->page_is_buddy(flags, _mapcount, private, _count)) {
> >-			int i, nr_pages = 1 << private;
> >+			int nr_pages = 1 << private;
> >+
> >+			exclude_range(&pfn_free, pfn, pfn + nr_pages, cycle);
> >
> >-			for (i = 0; i < nr_pages; ++i) {
> >-				/*
> >-				 * According to combination of
> >-				 * MAX_ORDER and size of cyclic
> >-				 * buffer, this clearing bit operation
> >-				 * can overrun the cyclic buffer.
> >-				 *
> >-				 * See check_cyclic_buffer_overrun()
> >-				 * for the detail.
> >-				 */
> >-				if (clear_bit_on_2nd_bitmap_for_kernel((pfn + i), cycle))
> >-					pfn_free++;
> >-			}
> > 			pfn += nr_pages - 1;
> > 			mem_map += (nr_pages - 1) * SIZE(page);
> > 		}
> >diff --git a/makedumpfile.h b/makedumpfile.h
> >index eb03688..43cf91d 100644
> >--- a/makedumpfile.h
> >+++ b/makedumpfile.h
> >@@ -1593,6 +1593,11 @@ int get_xen_info_ia64(void);
> > struct cycle {
> > 	mdf_pfn_t start_pfn;
> > 	mdf_pfn_t end_pfn;
> >+
> >+	/* for excluding multi-page regions */
> >+	mdf_pfn_t exclude_pfn_start;
> >+	mdf_pfn_t exclude_pfn_end;
> >+	mdf_pfn_t *exclude_pfn_counter;
> > };
> >
> > static inline int
> >--
> >1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
