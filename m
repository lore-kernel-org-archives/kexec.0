Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SFxj5-00031N-3J
 for kexec@lists.infradead.org; Fri, 06 Apr 2012 01:12:33 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 3E60D3EE0B6
 for <kexec@lists.infradead.org>; Fri,  6 Apr 2012 10:12:25 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 262D445DEA6
 for <kexec@lists.infradead.org>; Fri,  6 Apr 2012 10:12:25 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 108FE45DE9E
 for <kexec@lists.infradead.org>; Fri,  6 Apr 2012 10:12:25 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 03C541DB8038
 for <kexec@lists.infradead.org>; Fri,  6 Apr 2012 10:12:25 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.240.81.146])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id A86721DB803F
 for <kexec@lists.infradead.org>; Fri,  6 Apr 2012 10:12:24 +0900 (JST)
Date: Fri, 06 Apr 2012 10:12:12 +0900 (   )
Message-Id: <20120406.101212.193682065.d.hatayama@jp.fujitsu.com>
Subject: Re: makedumpfile memory usage grows with system memory size
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120405143439.GA23999@redhat.com>
References: <20120402164651.6c2b1ae7.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120405.155211.347142878.d.hatayama@jp.fujitsu.com>
 <20120405143439.GA23999@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@redhat.com
Cc: dzickus@redhat.com, oomichi@mxs.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: makedumpfile memory usage grows with system memory size
Date: Thu, 5 Apr 2012 10:34:39 -0400

> On Thu, Apr 05, 2012 at 03:52:11PM +0900, HATAYAMA Daisuke wrote:
> 
> [..]
>>   * Bad performance is free pages only. Cache, cache private, user and
>>     zero pages are processed per range of memory in good performance.
> 
> Hi Daisuke-san,
> 

Hello Vivek,

> I am wondering why can't we walk through the memmap array and look into
> struct page for figuring out if page is free or not. Looks like that
> in the past we used to have PG_buddy flag and same information possibly
> could be retrieved by looking at page->_count field. 
> 
> So I am just curious that why do we walk through free pages list to figure
> out free pages instead of looking at "struct page".

Thanks. To be honest, I have just beginning with reading around here
and known PG_buddy just now. I have small checked this fact on 2.6.18
with the patch in the bottom of this mail and free pages found from
free_list and by PG_buddy check are coincide.

As Vivek says, more recent kernel has change around PG_buddy and the
patch says we should check _mapcount; I have yet to check this.

Author: Andrea Arcangeli <aarcange@redhat.com>
Date:   Thu Jan 13 15:47:00 2011 -0800

     thp: remove PG_buddy

    PG_buddy can be converted to _mapcount == -2.  So the PG_compound_lock can
    be added to page->flags without overflowing (because of the sparse section
    bits increasing) with CONFIG_X86_PAE=y and CONFIG_X86_PAT=y.  This also
    has to move the memory hotplug code from _mapcount to lru.next to avoid
    any risk of clashes.  We can't use lru.next for PG_buddy removal, but
    memory hotplug can use lru.next even more easily than the mapcount
    instead.

    Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

$ git describe 5f24ce5fd34c3ca1b3d10d30da754732da64d5c0
v2.6.37-7012-g5f24ce5

So now we can walk on the memmap array also for free pages like other
kinds of memory. The question I have now is why the current
implementation was chosen. Is there any difference between two ways?

Subject: [PATCH] Add free pages message

---
 makedumpfile.c |    9 +++++++++
 makedumpfile.h |    1 +
 print_info.h   |    2 +-
 3 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index c843567..bd770b1 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3198,6 +3198,9 @@ reset_bitmap_of_free_pages(unsigned long node_zones)
                                        retcd = ANALYSIS_FAILED;
                                        return FALSE;
                                }
+
+                               FREEPAGE_MSG("order: %d migrate_type: %d pfn: %llu\n", order, migrate_type, start_pfn);
+
                                for (i = 0; i < (1<<order); i++) {
                                        pfn = start_pfn + i;
                                        clear_bit_on_2nd_bitmap_for_kernel(pfn);
@@ -3399,6 +3402,7 @@ _exclude_free_page(void)
                        }
                        if (!spanned_pages)
                                continue;
+                       FREEPAGE_MSG("NR_ZONE: %d\n", i);
                        if (!reset_bitmap_of_free_pages(zone))
                                return FALSE;
                }
@@ -3688,6 +3692,11 @@ __exclude_unnecessary_pages(unsigned long mem_map,
                _count  = UINT(pcache + OFFSET(page._count));
                mapping = ULONG(pcache + OFFSET(page.mapping));

+               if ((info->dump_level & DL_EXCLUDE_FREE)
+                   && (flags & (1UL << PG_flag))) {
+                       FREEPAGE_MSG("PG_flag: flags: %#016lx pfn %llu\n", flags, pfn);
+               }
+
                /*
                 * Exclude the cache page without the private page.
                 */
diff --git a/makedumpfile.h b/makedumpfile.h
index ed1e9de..1faef47 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -67,6 +67,7 @@ int get_mem_type(void);
 #define PG_lru_ORIGINAL                (5)
 #define PG_private_ORIGINAL    (11)    /* Has something at ->private */
 #define PG_swapcache_ORIGINAL  (15)    /* Swap page: swp_entry_t in private */
+#define PG_buddy               (19)

 #define PAGE_MAPPING_ANON      (1)

diff --git a/print_info.h b/print_info.h
index 94968ca..44415d3 100644
--- a/print_info.h
+++ b/print_info.h
@@ -42,7 +42,7 @@ void print_execution_time(char *step_name, struct timeval *tv_start);
  * Message Level
  */
 #define MIN_MSG_LEVEL          (0)
-#define MAX_MSG_LEVEL          (31)
+#define MAX_MSG_LEVEL          (31+0x20)
 #define DEFAULT_MSG_LEVEL      (7)     /* Print the progress indicator, the
                                           common message, the error message */
 #define ML_PRINT_PROGRESS      (0x001) /* Print the progress indicator */
--
1.7.4.4

Thanks,
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
