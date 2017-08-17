Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1diJyN-0001vZ-Rv
 for kexec@lists.infradead.org; Thu, 17 Aug 2017 12:32:30 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7HCVtfF111933
 for <kexec@lists.infradead.org>; Thu, 17 Aug 2017 08:32:03 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cd6uxns9t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 17 Aug 2017 08:32:03 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 17 Aug 2017 22:32:00 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7HCVw6Q35389586
 for <kexec@lists.infradead.org>; Thu, 17 Aug 2017 22:31:58 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7HCVn8X011653
 for <kexec@lists.infradead.org>; Thu, 17 Aug 2017 22:31:49 +1000
Subject: [PATCH] kexec-tools: ppc64: avoid adding coherent memory regions to
 crash memory ranges
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Thu, 17 Aug 2017 18:01:51 +0530
MIME-Version: 1.0
Message-Id: <150297311110.25328.11468130779639120510.stgit@hbathini.in.ibm.com>
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
Cc: Ankit Kumar <ankit@linux.vnet.ibm.com>, Anshuman Khandual <khandual@linux.vnet.ibm.com>, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Alistair Popple <alistair@popple.id.au>

Accelerator devices like GPU and FPGA cards contain onboard memory. This
onboard memory is represented as a memory only NUMA node, integrating it
with core memory subsystem. Since, the link through which these devices
are integrated to core memory goes down after a system crash and they are
meant for user workloads, avoid adding coherent device memory regions to
crash memory ranges. Without this change, makedumpfile tool tries to save
unaccessible coherent device memory regions, crashing the system.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 kexec/arch/ppc64/crashdump-ppc64.c |   64 +++++++++++++++++++++++++++++++++++-
 kexec/arch/ppc64/kexec-ppc64.h     |    1 +
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index 13995bf..7ea3983 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -181,6 +181,53 @@ static int get_dyn_reconf_crash_memory_ranges(void)
 	return 0;
 }
 
+/*
+ * For a given memory node, check if it is mapped to system RAM or
+ * to onboard memory on accelerator device like GPU card or such.
+ */
+static int is_coherent_device_mem(const char *fname)
+{
+	char fpath[PATH_LEN];
+	char buf[32];
+	DIR *dmem;
+	FILE *file;
+	struct dirent *mentry;
+	int cnt, ret = 0;
+
+	strcpy(fpath, fname);
+	if ((dmem = opendir(fpath)) == NULL) {
+		perror(fpath);
+		return -1;
+	}
+
+	while ((mentry = readdir(dmem)) != NULL) {
+		if (strcmp(mentry->d_name, "compatible"))
+			continue;
+
+		strcat(fpath, "/compatible");
+		if ((file = fopen(fpath, "r")) == NULL) {
+			perror(fpath);
+			ret = -1;
+			break;
+		}
+		if ((cnt = fread(buf, 1, 32, file)) < 0) {
+			perror(fpath);
+			fclose(file);
+			ret = -1;
+			break;
+		}
+		if (!strncmp(buf, "ibm,coherent-device-memory", 26)) {
+			ret = 1;
+			break;
+		}
+		fclose(file);
+	}
+
+	closedir(dmem);
+	return ret;
+}
+
+
 /* Reads the appropriate file and retrieves the SYSTEM RAM regions for whom to
  * create Elf headers. Keeping it separate from get_memory_ranges() as
  * requirements are different in the case of normal kexec and crashdumps.
@@ -196,12 +243,12 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 {
 
 	char device_tree[256] = "/proc/device-tree/";
-	char fname[256];
+	char fname[PATH_LEN];
 	char buf[MAXBYTES];
 	DIR *dir, *dmem;
 	FILE *file;
 	struct dirent *dentry, *mentry;
-	int n, crash_rng_len = 0;
+	int n, ret, crash_rng_len = 0;
 	unsigned long long start, end;
 	int page_size;
 
@@ -240,6 +287,19 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 			continue;
 		strcpy(fname, device_tree);
 		strcat(fname, dentry->d_name);
+
+		ret = is_coherent_device_mem(fname);
+		if (ret == -1) {
+			closedir(dir);
+			goto err;
+		} else if (ret == 1) {
+			/*
+			 * Avoid adding this memory region as it is not
+			 * mapped to system RAM.
+			 */
+			continue;
+		}
+
 		if ((dmem = opendir(fname)) == NULL) {
 			perror(fname);
 			closedir(dir);
diff --git a/kexec/arch/ppc64/kexec-ppc64.h b/kexec/arch/ppc64/kexec-ppc64.h
index 633ae77..434b4bf 100644
--- a/kexec/arch/ppc64/kexec-ppc64.h
+++ b/kexec/arch/ppc64/kexec-ppc64.h
@@ -1,6 +1,7 @@
 #ifndef KEXEC_PPC64_H
 #define KEXEC_PPC64_H
 
+#define PATH_LEN 256
 #define MAXBYTES 128
 #define MAX_LINE 160
 #define CORE_TYPE_ELF32 1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
