Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U5DOZ-0000wX-IH
 for kexec@lists.infradead.org; Tue, 12 Feb 2013 10:47:28 +0000
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 12 Feb 2013 20:41:31 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8CB342CE8051
 for <kexec@lists.infradead.org>; Tue, 12 Feb 2013 21:47:19 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1CAlHv365274098
 for <kexec@lists.infradead.org>; Tue, 12 Feb 2013 21:47:17 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1CAlI1E024309
 for <kexec@lists.infradead.org>; Tue, 12 Feb 2013 21:47:18 +1100
Subject: [PATCH v2 1/2] kexec: Respect memory limit while building crash
 memory ranges on ppc32.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 12 Feb 2013 16:17:16 +0530
Message-ID: <20130212104659.7781.44553.stgit@mars.in.ibm.com>
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
Cc: "Suzuki K. Poulose" <suzuki@in.ibm.com>, Ananth Narayan <ananth@in.ibm.com>, bhe@redhat.com

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

So far powerpc kernel never exported memory limit information which is
reflected by mem= kernel cmdline option. Hence, kexec-tools always used
to build ELF header for entire system RAM generating a dump bigger than
the actual memory used by the first kernel.

This patch now reads the memory limit information from device-tree file and
limits the crash memory ranges accordingly.

Suzuki tested this patch on ppc32(ppc440) with a kernel patch by Suzuki.

The following are the upstream kernel commits that exports memory limit
information through /proc/device-tree file:
  4bc77a5ed - powerpc: Export memory limit via device tree
  a84fcd468 - powerpc: Change memory_limit from phys_addr_t to unsigned
	      long long

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Tested-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---
 kexec/arch/ppc/crashdump-powerpc.c |   14 ++++++++--
 kexec/arch/ppc/crashdump-powerpc.h |    1 +
 kexec/arch/ppc/kexec-ppc.c         |   51 ++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
index 4c8c75d..d367643 100644
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
+				if (start >= memory_limit)
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
index 6075477..5a2966e 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -29,6 +29,7 @@
 
 unsigned long dt_address_cells = 0, dt_size_cells = 0;
 uint64_t rmo_top;
+uint64_t memory_limit;
 unsigned long long crash_base = 0, crash_size = 0;
 unsigned long long initrd_base = 0, initrd_size = 0;
 unsigned long long ramdisk_base = 0, ramdisk_size = 0;
@@ -384,6 +385,44 @@ static int get_base_ranges(void)
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
+	file = fopen(fname, "r");
+	if (file == NULL) {
+		if (errno != ENOENT) {
+			perror(fname);
+			return -1;
+		}
+		errno = 0;
+		/*
+		 * fall through. On older kernel this file
+		 * is not present. Hence return success.
+		 */
+	} else {
+		/* Memory limit property is of u64 type. */
+		if ((n = fread(&memory_limit, 1, sizeof(uint64_t), file)) < 0) {
+			perror(fname);
+			goto err_out;
+		}
+		if (n != sizeof(uint64_t)) {
+			fprintf(stderr, "%s node has invalid size: %d\n",
+						fname, n);
+			goto err_out;
+		}
+		fclose(file);
+	}
+	return 0;
+err_out:
+	fclose(file);
+	return -1;
+}
+
 /* Get devtree details and create exclude_range array
  * Also create usablemem_ranges for KEXEC_ON_CRASH
  */
@@ -511,6 +550,18 @@ static int get_devtree_details(unsigned long kexec_flags)
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
+			snprintf(fname, sizeof(fname), "%s%s%s", device_tree,
+				dentry->d_name, "/linux,memory-limit");
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
