Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mercury.realtime.net ([205.238.132.86])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1LIr7r-0002Lr-0T
	for kexec@lists.infradead.org; Fri, 02 Jan 2009 21:00:11 +0000
From: Milton Miller <miltonm@bga.com>
Message-Id: <kexec-29-1-1.miltonm@bga.com>
In-Reply-To: <kexec-29-1.miltonm@bga.com>
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
To: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org, "M. Mohan Kumar" <mohan@in.ibm.com>

Subject [PATCH kexec-tools 1/5] ppc64: always check number of ranges when adding
Date: Fri, 02 Jan 2009 14:43:49 -0600
Subject: (No subject header)
X-Originating-IP: 205.232.218.102

make the idom "always call realloc_memory_ranges when filling a range entry"

kexec was core dumping after using 5 exclude_range pairs when only 3
were allocated.

also delcare realloc_memory_ranges to take no arguments.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: kexec-tools/kexec/arch/ppc64/kexec-ppc64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/kexec-ppc64.c	2009-01-02 02:08:58.000000000 -0600
+++ kexec-tools/kexec/arch/ppc64/kexec-ppc64.c	2009-01-02 02:09:08.000000000 -0600
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
+		if (i >= max_memory_ranges)
+			realloc_memory_ranges();
 		/* Limit range to rmo_top */
 		if (memory_range[j-1].start >= rmo_top) {
 			j--;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
