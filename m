Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WSTzb-0000ti-64
 for kexec@lists.infradead.org; Tue, 25 Mar 2014 16:14:23 +0000
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Tue, 25 Mar 2014 16:14:01 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id D8D0617D8059
 for <kexec@lists.infradead.org>; Tue, 25 Mar 2014 16:14:45 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2PGDmkh655662
 for <kexec@lists.infradead.org>; Tue, 25 Mar 2014 16:13:48 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2PGDwdt022236
 for <kexec@lists.infradead.org>; Tue, 25 Mar 2014 10:13:59 -0600
Date: Tue, 25 Mar 2014 17:13:56 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH 1/2] makedumpfile: Fix zero checking of get_mm_sparsemem()
Message-ID: <20140325171356.6d06178c@holzheu>
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
Cc: d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org

Currently zero entries in the "mem_section" array and the section arrays
from the "mem_section" entries are not checked correctly. The problem
especially hits the s390x architecture because there the is_kvaddr()
function returns true for the first memory page.

So add missing zero checks and set "mem_map" to NOT_MEMMAP_ADDR for
all found zero entries.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
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
