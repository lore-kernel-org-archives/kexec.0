Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UHnEv-0002QI-Cn
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 03:29:30 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 69BAA3EE0AE
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 12:29:27 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5223845DE54
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 12:29:27 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 3081545DE56
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 12:29:27 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 231CCE08003
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 12:29:27 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id B95761DB804E
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 12:29:26 +0900 (JST)
Date: Tue, 19 Mar 2013 12:29:21 +0900 (JST)
Message-Id: <20130319.122921.370560287.d.hatayama@jp.fujitsu.com>
Subject: [PATCH] kexec: ppc, ppc64: increment saved_max_mem in case
 firmware exports inclusive maps
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
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
To: horms@verge.net.au, sharada@in.ibm.com, muvarov@gmail.com, vgoyal@redhat.com
Cc: kexec@lists.infradead.org

There are two kinds of notation to represent a map: inclusive and
exclusive. Here are the examples:

  1)  [mem 0x0000000100000000-0x000000013fffffff]
  2)  [mem 0x0000000100000000-0x0000000140000000]

1) is inclusive and 2) is exclusive. In case of 1), the pfn calculated
from the end address belongs to the map, while in case of 2), it
doesn't.

The variable saved_max_pfn is exclusive, but the condition of sanity
check in read_oldmem() wrongly treats it as inclusive, i.e.

		if (pfn > saved_max_pfn)
			return read;

This should have been

		if (pfn >= saved_max_pfn)
			return read;

Currently, architecture mips, powerpc and s390 noticed this fact and
treat saved_max_pfn as inclusive.

$ git grep ".*saved_max_pfn.*" ./
arch/ia64/kernel/efi.c:         /* saved_max_pfn should ignore max_addr= command line arg */
arch/ia64/kernel/efi.c:         if (saved_max_pfn < (efi_md_end(md) >> PAGE_SHIFT))
arch/ia64/kernel/efi.c:                 saved_max_pfn = (efi_md_end(md) >> PAGE_SHIFT);
arch/mips/kernel/crash_dump.c:          saved_max_pfn = (memparse(p, &p) >> PAGE_SHIFT) - 1;
arch/powerpc/kernel/crash_dump.c:               saved_max_pfn = (memparse(p, &p) >> PAGE_SHIFT) - 1;
arch/s390/kernel/setup.c:               saved_max_pfn = PFN_DOWN(OLDMEM_BASE) - 1;
arch/s390/kernel/setup.c:               saved_max_pfn = PFN_DOWN(real_memory_size) - 1;
arch/x86/kernel/e820.c:         saved_max_pfn = e820_end_of_ram_pfn();
arch/x86/kernel/pci-calgary_64.c:                                       saved_max_pfn : max_pfn) * PAGE_SIZE);
drivers/char/mem.c:             if (pfn > saved_max_pfn)
include/linux/crash_dump.h:extern unsigned long saved_max_pfn;
kernel/crash_dump.c:unsigned long saved_max_pfn;

In kexec-tools, both mips and s390 increments the corresponding
saved_max_mem. From the above, the existing firmware for powerpc is
expected to being exporting memory mapping as exclusive. Hence, it's
possible to rewrite saved_max_pfn in kernel side uniformly so it's
treated as exclusive.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 kexec/arch/ppc/crashdump-powerpc.c |    2 +-
 kexec/arch/ppc64/crashdump-ppc64.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
index eee5b37..1122c18 100644
--- a/kexec/arch/ppc/crashdump-powerpc.c
+++ b/kexec/arch/ppc/crashdump-powerpc.c
@@ -230,7 +230,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 	 */
 	for (i = 0; i < memory_ranges; i++)
 		if (saved_max_mem < crash_memory_range[i].end)
-			saved_max_mem = crash_memory_range[i].end;
+			saved_max_mem = crash_memory_range[i].end + 1;
 
 	*range = crash_memory_range;
 	*ranges = memory_ranges;
diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index 49cab12..743fc15 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -309,7 +309,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 	 */
 	for (i = 0; i < memory_ranges; i++)
 		if (saved_max_mem < crash_memory_range[i].end)
-			saved_max_mem = crash_memory_range[i].end;
+			saved_max_mem = crash_memory_range[i].end + 1;
 
 	*range = crash_memory_range;
 	*ranges = memory_ranges;
-- 
1.7.7.6



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
