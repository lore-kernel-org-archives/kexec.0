Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eo8kQ-0004iL-9n
 for kexec@lists.infradead.org; Tue, 20 Feb 2018 14:18:23 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1KEBasJ118306
 for <kexec@lists.infradead.org>; Tue, 20 Feb 2018 09:18:09 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g8j70081f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 20 Feb 2018 09:18:09 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Tue, 20 Feb 2018 14:18:06 -0000
Subject: [PATCH 1/2] kexec: add a helper function to add ranges
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Tue, 20 Feb 2018 19:48:00 +0530
MIME-Version: 1.0
Message-Id: <151913628039.8893.12994971144990413141.stgit@hbathini.in.ibm.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: Geoff Levand <geoff@infradead.org>, Kexec-ml <kexec@lists.infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, nfont@linux.vnet.ibm.com

Add a helper function for adding ranges to avoid duplicating code.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 kexec/fs2dt.c |  115 ++++++++++++++++++++++++++-------------------------------
 1 file changed, 53 insertions(+), 62 deletions(-)

diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index 79aa0f3..550eca9 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -169,6 +169,50 @@ static unsigned propnum(const char *name)
 	return offset;
 }
 
+/*
+ * Add ranges by comparing 'base' and 'end' addresses with usable
+ * memory ranges. Returns the number of ranges added. Each range added
+ * increments 'idx' by 2.
+ */
+static uint64_t add_ranges(uint64_t **ranges, int *ranges_size, int idx,
+			   uint64_t base, uint64_t end)
+{
+	uint64_t loc_base, loc_end, rngs_cnt = 0;
+	size_t range;
+	int add = 0;
+
+	for (range = 0; range < usablemem_rgns.size; range++) {
+		loc_base = usablemem_rgns.ranges[range].start;
+		loc_end = usablemem_rgns.ranges[range].end;
+		if (loc_base >= base && loc_end <= end) {
+			add = 1;
+		} else if (base < loc_end && end > loc_base) {
+			if (loc_base < base)
+				loc_base = base;
+			if (loc_end > end)
+				loc_end = end;
+			add = 1;
+		}
+
+		if (add) {
+			if (idx >= ((*ranges_size) - 2)) {
+				(*ranges_size) += MEM_RANGE_CHUNK_SZ;
+				*ranges = realloc(*ranges, (*ranges_size)*8);
+				if (!(*ranges))
+					die("unrecoverable error: can't realloc"
+					    "%d bytes for ranges.\n",
+					    (*ranges_size)*8);
+			}
+			(*ranges)[idx++] = cpu_to_be64(loc_base);
+			(*ranges)[idx++] = cpu_to_be64(loc_end - loc_base);
+
+			rngs_cnt++;
+		}
+	}
+
+	return rngs_cnt;
+}
+
 #ifdef HAVE_DYNAMIC_MEMORY
 static void add_dyn_reconf_usable_mem_property__(int fd)
 {
@@ -176,8 +220,8 @@ static void add_dyn_reconf_usable_mem_property__(int fd)
 	uint64_t buf[32];
 	uint64_t *ranges;
 	int ranges_size = MEM_RANGE_CHUNK_SZ;
-	uint64_t base, end, loc_base, loc_end;
-	size_t i, rngs_cnt, range;
+	uint64_t base, end, rngs_cnt;
+	size_t i;
 	int rlen = 0;
 	int tmp_indx;
 
@@ -210,36 +254,8 @@ static void add_dyn_reconf_usable_mem_property__(int fd)
 
 		tmp_indx = rlen++;
 
-		rngs_cnt = 0;
-		for (range = 0; range < usablemem_rgns.size; range++) {
-			int add = 0;
-			loc_base = usablemem_rgns.ranges[range].start;
-			loc_end = usablemem_rgns.ranges[range].end;
-			if (loc_base >= base && loc_end <= end) {
-				add = 1;
-			} else if (base < loc_end && end > loc_base) {
-				if (loc_base < base)
-					loc_base = base;
-				if (loc_end > end)
-					loc_end = end;
-				add = 1;
-			}
-
-			if (add) {
-				if (rlen >= (ranges_size-2)) {
-					ranges_size += MEM_RANGE_CHUNK_SZ;
-					ranges = realloc(ranges, ranges_size*8);
-					if (!ranges)
-						die("unrecoverable error: can't"
-						    " realloc %d bytes for"
-						    " ranges.\n",
-						    ranges_size*8);
-				}
-				ranges[rlen++] = cpu_to_be64(loc_base);
-				ranges[rlen++] = cpu_to_be64(loc_end - loc_base);
-				rngs_cnt++;
-			}
-		}
+		rngs_cnt = add_ranges(&ranges, &ranges_size, rlen,
+				      base, end);
 		if (rngs_cnt == 0) {
 			/* We still need to add a counter for every LMB because
 			 * the kernel parsing code is dumb.  We just have
@@ -261,7 +277,8 @@ static void add_dyn_reconf_usable_mem_property__(int fd)
 			}
 		} else {
 			/* Store the count of (base, size) duple */
-			ranges[tmp_indx] = cpu_to_be64((uint64_t) rngs_cnt);
+			ranges[tmp_indx] = cpu_to_be64(rngs_cnt);
+			rlen += rngs_cnt * 2;
 		}
 	}
 		
@@ -294,8 +311,7 @@ static void add_usable_mem_property(int fd, size_t len)
 	uint64_t buf[2];
 	uint64_t *ranges;
 	int ranges_size = MEM_RANGE_CHUNK_SZ;
-	uint64_t base, end, loc_base, loc_end;
-	size_t range;
+	uint64_t base, end, rngs_cnt;
 	int rlen = 0;
 
 	strcpy(fname, pathname);
@@ -326,33 +342,8 @@ static void add_usable_mem_property(int fd, size_t len)
 		die("unrecoverable error: can't alloc %zu bytes for ranges.\n",
 		    ranges_size * sizeof(*ranges));
 
-	for (range = 0; range < usablemem_rgns.size; range++) {
-		int add = 0;
-		loc_base = usablemem_rgns.ranges[range].start;
-		loc_end = usablemem_rgns.ranges[range].end;
-		if (loc_base >= base && loc_end <= end) {
-			add = 1;
-		} else if (base < loc_end && end > loc_base) {
-			if (loc_base < base)
-				loc_base = base;
-			if (loc_end > end)
-				loc_end = end;
-			add = 1;
-		}
-		if (add) {
-			if (rlen >= (ranges_size-2)) {
-				ranges_size += MEM_RANGE_CHUNK_SZ;
-				ranges = realloc(ranges, ranges_size *
-						 sizeof(*ranges));
-				if (!ranges)
-					die("unrecoverable error: can't realloc"
-					    "%zu bytes for ranges.\n",
-					    ranges_size*sizeof(*ranges));
-			}
-			ranges[rlen++] = cpu_to_be64(loc_base);
-			ranges[rlen++] = cpu_to_be64(loc_end - loc_base);
-		}
-	}
+	rngs_cnt = add_ranges(&ranges, &ranges_size, rlen, base, end);
+	rlen += rngs_cnt * 2;
 
 	if (!rlen) {
 		/*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
