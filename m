Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U5DOu-00010u-VO
 for kexec@lists.infradead.org; Tue, 12 Feb 2013 10:47:50 +0000
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 12 Feb 2013 20:43:56 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3E4F32BB0050
 for <kexec@lists.infradead.org>; Tue, 12 Feb 2013 21:47:40 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1CAlckk38338572
 for <kexec@lists.infradead.org>; Tue, 12 Feb 2013 21:47:38 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1CAld60024537
 for <kexec@lists.infradead.org>; Tue, 12 Feb 2013 21:47:39 +1100
Subject: [PATCH v2 2/2] kexec: Respect memory limit while building crash
 memory ranges on ppc64
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 12 Feb 2013 16:17:37 +0530
Message-ID: <20130212104724.7781.67322.stgit@mars.in.ibm.com>
In-Reply-To: <20130212104624.7781.32716.stgit@mars.in.ibm.com>
References: <20130212104624.7781.32716.stgit@mars.in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, Kexec-ml <kexec@lists.infradead.org>
Cc: Suzuki Poulose <suzuki@in.ibm.com>, Ananth Narayan <ananth@in.ibm.com>, bhe@redhat.com

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Fix it on ppc64 also. This patch now reads the memory limit information
from device-tree file and limits the crash memory ranges accordingly.

Tested this patch on ppc64 with upstream kernel version 3.8.0-rc4

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 kexec/arch/ppc64/crashdump-ppc64.c |   11 ++++++++++-
 kexec/arch/ppc64/crashdump-ppc64.h |    1 +
 kexec/arch/ppc64/kexec-ppc64.c     |   27 +++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index 30ef443..b8a63bd 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -84,10 +84,19 @@ static unsigned long long cstart, cend;
 static int memory_ranges;
 
 /*
- * Exclude the region that lies within crashkernel
+ * Exclude the region that lies within crashkernel and above the memory
+ * limit which is reflected by mem= kernel option.
  */
 static void exclude_crash_region(uint64_t start, uint64_t end)
 {
+	/* If memory_limit is set then exclude the memory region above it. */
+	if (memory_limit) {
+		if (start >= memory_limit)
+			return;
+		if (end > memory_limit)
+			end = memory_limit;
+	}
+
 	if (cstart < end && cend > start) {
 		if (start < cstart && end > cend) {
 			crash_memory_range[memory_ranges].start = start;
diff --git a/kexec/arch/ppc64/crashdump-ppc64.h b/kexec/arch/ppc64/crashdump-ppc64.h
index be02213..739c61f 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.h
+++ b/kexec/arch/ppc64/crashdump-ppc64.h
@@ -27,6 +27,7 @@ void add_usable_mem_rgns(unsigned long long base, unsigned long long size);
 
 extern uint64_t crash_base;
 extern uint64_t crash_size;
+extern uint64_t memory_limit;
 extern unsigned int rtas_base;
 extern unsigned int rtas_size;
 
diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index 2f12907..389741a 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -39,6 +39,7 @@ static struct memory_range *memory_range = NULL;
 static struct memory_range *base_memory_range = NULL;
 static uint64_t rmo_top;
 uint64_t memory_max = 0;
+uint64_t memory_limit;
 static int nr_memory_ranges, nr_exclude_ranges;
 uint64_t crash_base, crash_size;
 unsigned int rtas_base, rtas_size;
@@ -408,6 +409,32 @@ static int get_devtree_details(unsigned long kexec_flags)
 				add_usable_mem_rgns(0, crash_base + crash_size);
 				reserve(KDUMP_BACKUP_LIMIT, crash_base-KDUMP_BACKUP_LIMIT);
 			}
+			/*
+			 * Read the first kernel's memory limit.
+			 * If the first kernel is booted with mem= option then
+			 * it would export "linux,memory-limit" file
+			 * reflecting value for the same.
+			 */
+			memset(fname, 0, sizeof(fname));
+			strcpy(fname, device_tree);
+			strcat(fname, dentry->d_name);
+			strcat(fname, "/linux,memory-limit");
+			if ((file = fopen(fname, "r")) == NULL) {
+				if (errno != ENOENT) {
+					perror(fname);
+					goto error_opencdir;
+				}
+				errno = 0;
+				/*
+				 * File not present.
+				 * fall through. On older kernel this file
+				 * is not present.
+				 */
+			} else if (fread(&memory_limit, sizeof(uint64_t), 1,
+								file) != 1) {
+				perror(fname);
+				goto error_openfile;
+			}
 
 			memset(fname, 0, sizeof(fname));
 			strcpy(fname, device_tree);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
