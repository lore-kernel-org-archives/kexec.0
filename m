Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KZzRj-0007K0-Ay
	for kexec@lists.infradead.org; Mon, 01 Sep 2008 02:47:15 +0000
Message-ID: <48BB5551.8000106@mxs.nes.nec.co.jp>
Date: Mon, 01 Sep 2008 11:37:05 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH][ia64] Fix the difference between node_mem_map and
	node_start_pfn
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1405932066=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Bernhard Walle <bwalle@suse.de>, kexec-ml <kexec@lists.infradead.org>, Jay Lan <jlan@sgi.com>

--===============1405932066==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi,

makedumpfile[1] cannot run on ia64 discontigmem kernel, because the member
node_mem_map of struct pgdat_list has invalid value. This patch fixes it.

node_start_pfn shows the start pfn of each node, and node_mem_map should
point 'struct page' of each node's node_start_pfn.
On my machine, node0's node_start_pfn shows 0x400 and its node_mem_map points
0xa0007fffbf000000. This address is the same as vmem_map, so the node_mem_map
points 'struct page' of pfn 0, even if its node_start_pfn shows 0x400.

The cause is due to the round down of min_pfn in count_node_pages() and
node0's node_mem_map points 'struct page' of inactive pfn (0x0).
This patch fixes it.


makedumpfile[1]: dump filtering command
https://sourceforge.net/projects/makedumpfile/

Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
---
--- a/arch/ia64/mm/discontig.c	2008-08-29 23:05:52.000000000 +0900
+++ b/arch/ia64/mm/discontig.c	2008-08-29 23:06:59.000000000 +0900
@@ -631,7 +631,6 @@ static __init int count_node_pages(unsig
 			(min(end, __pa(MAX_DMA_ADDRESS)) - start) >>PAGE_SHIFT;
 #endif
 	start = GRANULEROUNDDOWN(start);
-	start = ORDERROUNDDOWN(start);
 	end = GRANULEROUNDUP(end);
 	mem_data[node].max_pfn = max(mem_data[node].max_pfn,
 				     end >> PAGE_SHIFT);
--- a/include/asm-ia64/meminit.h	2008-08-29 23:06:36.000000000 +0900
+++ b/include/asm-ia64/meminit.h	2008-08-29 23:06:48.000000000 +0900
@@ -47,7 +47,6 @@ extern int reserve_elfcorehdr(unsigned l
  */
 #define GRANULEROUNDDOWN(n)	((n) & ~(IA64_GRANULE_SIZE-1))
 #define GRANULEROUNDUP(n)	(((n)+IA64_GRANULE_SIZE-1) & ~(IA64_GRANULE_SIZE-1))
-#define ORDERROUNDDOWN(n)	((n) & ~((PAGE_SIZE<<MAX_ORDER)-1))
 
 #ifdef CONFIG_NUMA
   extern void call_pernode_memory (unsigned long start, unsigned long len, void *func);
_



--===============1405932066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1405932066==--
