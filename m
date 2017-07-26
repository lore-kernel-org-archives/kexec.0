Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1daPys-0002ha-QR
 for kexec@lists.infradead.org; Wed, 26 Jul 2017 17:20:21 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6QHJKNB020388
 for <kexec@lists.infradead.org>; Wed, 26 Jul 2017 13:19:56 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bxwujmunj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 26 Jul 2017 13:19:56 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 27 Jul 2017 03:19:53 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6QHJpnO26935452
 for <kexec@lists.infradead.org>; Thu, 27 Jul 2017 03:19:51 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6QHJoO0030156
 for <kexec@lists.infradead.org>; Thu, 27 Jul 2017 03:19:51 +1000
Subject: [PATCH] kexec-tools: ppc64: fix how RMA top is deduced
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 26 Jul 2017 22:49:41 +0530
MIME-Version: 1.0
Message-Id: <150108958197.31071.13359341334422395062.stgit@hbathini.in.ibm.com>
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
To: Simon Horman <horms@verge.net.au>, Kexec-ml <kexec@lists.infradead.org>
Cc: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Ankit Kumar <ankit@linux.vnet.ibm.com>

Hang was observed, in purgatory, on a machine configured with
single LPAR. This was because one of the segments was loaded
outside the actual Real Memory Area (RMA) due to wrongly
deduced RMA top value.

Currently, top of real memory area, which is crucial for loading
kexec/kdump kernel, is obtained by iterating through mem nodes
and setting its value based on the base and size values of the
last mem node in the iteration. That can't always be correct as
the order of iteration may not be same and RMA base & size are
always based on the first memory property. Fix this by setting
RMA top value based on the base and size values of the memory
node that has the smallest base value (first memory property)
among all the memory nodes.

Also, correct the misnomers rmo_base and rmo_top to rma_base
and rma_top respectively.

While how RMA top is deduced was broken for sometime, the issue
may not have been seen so far, for couple of possible reasons:

    1. Only one mem node was available.
    2. First memory property has been the last node in
       iteration when multiple mem nodes were present.

Fixes: 02f4088ffded ("kexec fix ppc64 device-tree mem node")
Reported-by: Ankit Kumar <ankit@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Geoff Levand <geoff@infradead.org>
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 kexec/arch/ppc64/kexec-ppc64.c |   35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index 6e8c175..a7d708b 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -38,7 +38,7 @@
 static struct memory_range *exclude_range = NULL;
 static struct memory_range *memory_range = NULL;
 static struct memory_range *base_memory_range = NULL;
-static uint64_t rmo_top;
+static uint64_t rma_top;
 uint64_t memory_max = 0;
 uint64_t memory_limit;
 static int nr_memory_ranges, nr_exclude_ranges;
@@ -385,7 +385,7 @@ int get_devtree_value(const char *fname, unsigned long long *value)
  */
 static int get_devtree_details(unsigned long kexec_flags)
 {
-	uint64_t rmo_base;
+	uint64_t rma_base = -1, base;
 	uint64_t tce_base;
 	unsigned int tce_size;
 	uint64_t htab_base, htab_size;
@@ -696,10 +696,13 @@ static int get_devtree_details(unsigned long kexec_flags)
 				perror(fname);
 				goto error_openfile;
 			}
-			rmo_base = be64_to_cpu(((uint64_t *)buf)[0]);
-			rmo_top = rmo_base + be64_to_cpu(((uint64_t *)buf)[1]);
-			if (rmo_top > 0x30000000UL)
-				rmo_top = 0x30000000UL;
+			base = be64_to_cpu(((uint64_t *)buf)[0]);
+			if (base < rma_base) {
+				rma_base = base;
+				rma_top = base + be64_to_cpu(((uint64_t *)buf)[1]);
+				if (rma_top > 0x30000000UL)
+					rma_top = 0x30000000UL;
+			}
 
 			fclose(file);
 			closedir(cdir);
@@ -811,14 +814,14 @@ int setup_memory_ranges(unsigned long kexec_flags)
 				j++;
 				if (j >= max_memory_ranges)
 					realloc_memory_ranges();
-				/* Limit the end to rmo_top */
-				if (memory_range[j-1].start >= rmo_top) {
+				/* Limit the end to rma_top */
+				if (memory_range[j-1].start >= rma_top) {
 					j--;
 					break;
 				}
-				if ((memory_range[j-1].start < rmo_top) &&
-				(memory_range[j-1].end >= rmo_top)) {
-					memory_range[j-1].end = rmo_top;
+				if ((memory_range[j-1].start < rma_top) &&
+				(memory_range[j-1].end >= rma_top)) {
+					memory_range[j-1].end = rma_top;
 					break;
 				}
 				continue;
@@ -833,14 +836,14 @@ int setup_memory_ranges(unsigned long kexec_flags)
 		j++;
 		if (j >= max_memory_ranges)
 			realloc_memory_ranges();
-		/* Limit range to rmo_top */
-		if (memory_range[j-1].start >= rmo_top) {
+		/* Limit range to rma_top */
+		if (memory_range[j-1].start >= rma_top) {
 			j--;
 			break;
 		}
-		if ((memory_range[j-1].start < rmo_top) &&
-			(memory_range[j-1].end >= rmo_top)) {
-			memory_range[j-1].end = rmo_top;
+		if ((memory_range[j-1].start < rma_top) &&
+			(memory_range[j-1].end >= rma_top)) {
+			memory_range[j-1].end = rma_top;
 			break;
 		}
 	}


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
