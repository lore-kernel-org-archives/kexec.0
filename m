Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mercury.realtime.net ([205.238.132.86])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1LKu5L-0005CV-IP
	for kexec@lists.infradead.org; Thu, 08 Jan 2009 12:34:03 +0000
Subject: [PATCH kexec-tools v2] ppc64: always check number of ranges when
	adding them
From: Milton Miller <miltonm@bga.com>
References: <kexec-29-1-1r.miltonm@bga.com>
	<1231296172.8292.20.camel@localhost>
In-Reply-To: <1231296172.8292.20.camel@localhost>
Date: Thu, 08 Jan 2009 06:33:50 -0600
Message-ID: <1231418030_141769@mercury.realtime.net>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org, "M. Mohan Kumar" <mohan@in.ibm.com>, kexec@lists.infradead.org


make the idom "always call realloc_memory_ranges when filling a range entry"

kexec was core dumping after using 5 exclude_range pairs when only 3
were allocated.

also delcare realloc_memory_ranges to take void.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
v2:  compare variable j not i in a spot noticed by  Michael Ellerman

Index: kexec-tools/kexec/arch/ppc64/kexec-ppc64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/kexec-ppc64.c	2009-01-08 01:21:43.000000000 -0600
+++ kexec-tools/kexec/arch/ppc64/kexec-ppc64.c	2009-01-08 01:22:33.000000000 -0600
@@ -96,7 +96,7 @@ err1:
 
 }
 
-static int realloc_memory_ranges()
+static int realloc_memory_ranges(void)
 {
 	size_t memory_range_len;
 
@@ -469,6 +469,8 @@ static int get_devtree_details(unsigned 
 				exclude_range[i].start = initrd_start;
 				exclude_range[i].end = initrd_end;
 				i++;
+				if (i >= max_memory_ranges)
+					realloc_memory_ranges();
 			}
 		} /* chosen */
 
@@ -581,6 +583,8 @@ static int get_devtree_details(unsigned 
 			exclude_range[i].start = tce_base;
 			exclude_range[i].end = tce_base + tce_size;
 			i++;
+			if (i >= max_memory_ranges)
+				realloc_memory_ranges();
 			if (kexec_flags & KEXEC_ON_CRASH)
 				add_usable_mem_rgns(tce_base, tce_size);
 			closedir(cdir);
@@ -634,6 +638,8 @@ int setup_memory_ranges(unsigned long ke
 				memory_range[j].end = exclude_range[i].start - 1;
 				memory_range[j].type = RANGE_RAM;
 				j++;
+				if (j >= max_memory_ranges)
+					realloc_memory_ranges();
 			}
 		} /* i == 0 */
 		/* If the last exclude range does not end at memory_max, include
@@ -646,6 +652,8 @@ int setup_memory_ranges(unsigned long ke
 				memory_range[j].end = memory_max;
 				memory_range[j].type = RANGE_RAM;
 				j++;
+				if (j >= max_memory_ranges)
+					realloc_memory_ranges();
 				/* Limit the end to rmo_top */
 				if (memory_range[j-1].start >= rmo_top) {
 					j--;
@@ -666,6 +674,8 @@ int setup_memory_ranges(unsigned long ke
 		memory_range[j].end = exclude_range[i+1].start - 1;
 		memory_range[j].type = RANGE_RAM;
 		j++;
+		if (j >= max_memory_ranges)
+			realloc_memory_ranges();
 		/* Limit range to rmo_top */
 		if (memory_range[j-1].start >= rmo_top) {
 			j--;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
