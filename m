Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6dcl-0007vD-75
 for kexec@lists.infradead.org; Wed, 29 Aug 2012 08:27:44 +0000
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 29 Aug 2012 18:26:13 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7T8RboM27328764
 for <kexec@lists.infradead.org>; Wed, 29 Aug 2012 18:27:37 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7T8RZox023804
 for <kexec@lists.infradead.org>; Wed, 29 Aug 2012 18:27:36 +1000
Subject: [PATCH 1/2] kexec: Respect memory limit while building crash memory
 ranges on ppc32.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 29 Aug 2012 13:54:42 +0530
Message-ID: <20120829082442.19391.81588.stgit@mars.in.ibm.com>
In-Reply-To: <20120829082201.19391.15191.stgit@mars.in.ibm.com>
References: <20120829082201.19391.15191.stgit@mars.in.ibm.com>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Suzuki K. Poulose" <suzuki@in.ibm.com>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

So far powerpc kernel never exported memory limit information which is
reflected by mem= kernel cmdline option. Hence, kexec-tools always used
to build ELF header for entire system RAM generating a dump bigger than
the actual memory used by the first kernel.

This patch now reads the memory limit information from device-tree file and
limits the crash memory ranges accordingly.

Suzuki tested this patch on ppc32(ppc440) with a kernel patch by Suzuki.

The proposed upstream kernel patch at
https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-August/100500.html
now exports memory limit information through /proc/device-tree file.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Tested-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---
 kexec/arch/ppc/crashdump-powerpc.c |   14 ++++++++---
 kexec/arch/ppc/crashdump-powerpc.h |    1 +
 kexec/arch/ppc/kexec-ppc.c         |   48 ++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
index 4c8c75d..7313660 100644
--- a/kexec/arch/ppc/crashdump-powerpc.c
+++ b/kexec/arch/ppc/crashdump-powerpc.c
@@ -132,8 +132,9 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 				goto err;
 			}
 			n = read_memory_region_limits(fd, &start, &end);
+			/* We are done with fd, close it. */
+			close(fd);
 			if (n != 0) {
-				close(fd);
 				closedir(dmem);
 				closedir(dir);
 				goto err;
@@ -153,8 +154,16 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 			cstart = crash_base;
 			cend = crash_base + crash_size;
 			/*
-			 * Exclude the region that lies within crashkernel
+			 * Exclude the region that lies within crashkernel.
+			 * If memory limit is set then exclude memory region
+			 * above it.
 			 */
+			if (memory_limit) {
+				if (start > memory_limit)
+					continue;
+				if (end > memory_limit)
+					end = memory_limit;
+			}
 			if (cstart < end && cend > start) {
 				if (start < cstart && end > cend) {
 					crash_memory_range[memory_ranges].start
@@ -195,7 +204,6 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 					= RANGE_RAM;
 				memory_ranges++;
 			}
-			close(fd);
 		}
 		closedir(dmem);
 	}
diff --git a/kexec/arch/ppc/crashdump-powerpc.h b/kexec/arch/ppc/crashdump-powerpc.h
index a377146..84a73aa 100644
--- a/kexec/arch/ppc/crashdump-powerpc.h
+++ b/kexec/arch/ppc/crashdump-powerpc.h
@@ -42,5 +42,6 @@ extern unsigned long long crash_base;
 extern unsigned long long crash_size;
 extern unsigned int rtas_base;
 extern unsigned int rtas_size;
+extern uint64_t memory_limit;
 
 #endif /* CRASHDUMP_POWERPC_H */
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index 6075477..de99c6a 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -29,6 +29,7 @@
 
 unsigned long dt_address_cells = 0, dt_size_cells = 0;
 uint64_t rmo_top;
+uint64_t memory_limit = 0;
 unsigned long long crash_base = 0, crash_size = 0;
 unsigned long long initrd_base = 0, initrd_size = 0;
 unsigned long long ramdisk_base = 0, ramdisk_size = 0;
@@ -384,6 +385,41 @@ static int get_base_ranges(void)
 	return 0;
 }
 
+static int read_kernel_memory_limit(char *fname, char *buf)
+{
+	FILE *file;
+	int n;
+
+	if (!fname || !buf)
+		return -1;
+
+	if ((file = fopen(fname, "r")) == NULL) {
+		if (errno != ENOENT) {
+			perror(fname);
+			return -1;
+		}
+		errno = 0;
+		/*
+		 * fall through. On older kernel this file
+		 * is not present.
+		 */
+	}
+	else {
+		/* Memory limit property is of u64 type. */
+		if ((n = fread(&memory_limit, 1, sizeof(uint64_t), file)) < 0) {
+			perror(fname);
+			return -1;
+		}
+		if (n != sizeof(uint64_t)) {
+			fprintf(stderr, "%s node has invalid size: %d\n",
+						fname, n);
+			return -1;
+		}
+		fclose(file);
+	}
+	return 0;
+}
+
 /* Get devtree details and create exclude_range array
  * Also create usablemem_ranges for KEXEC_ON_CRASH
  */
@@ -511,6 +547,18 @@ static int get_devtree_details(unsigned long kexec_flags)
 				add_usable_mem_rgns(crash_base, crash_size);
 #endif
 			}
+			/*
+			 * Read the first kernel's memory limit.
+			 * If the first kernel is booted with mem= option then
+			 * it would export "linux,memory-limit" file
+			 * reflecting value for the same.
+			 */
+			memset(fname, 0, sizeof(fname));
+			sprintf(fname, "%s%s%s", device_tree, dentry->d_name,
+				"/linux,memory-limit");
+			if (read_kernel_memory_limit(fname, buf) < 0)
+				goto error_opencdir;
+				
 			/* reserve the initrd_start and end locations. */
 			memset(fname, 0, sizeof(fname));
 			sprintf(fname, "%s%s%s",


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
