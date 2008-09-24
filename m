Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp05.in.ibm.com ([59.145.155.5] helo=e28esmtp05.in.ibm.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KiSsB-00044M-Dh
	for kexec@lists.infradead.org; Wed, 24 Sep 2008 11:49:36 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28esmtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id m8OBnTnW016765
	for <kexec@lists.infradead.org>; Wed, 24 Sep 2008 17:19:29 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8OBnTJq1687598
	for <kexec@lists.infradead.org>; Wed, 24 Sep 2008 17:19:29 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id m8OBnTf5031210
	for <kexec@lists.infradead.org>; Wed, 24 Sep 2008 21:49:29 +1000
Received: from guara.in.ibm.com ([9.124.35.51])
	by d28av05.in.ibm.com (8.13.1/8.12.11) with ESMTP id m8OBnTpH030328
	for <kexec@lists.infradead.org>; Wed, 24 Sep 2008 21:49:29 +1000
From: Chandru <chandru@in.ibm.com>
Subject: [PATCH 1/3] kexec/kdump: read crash memory ranges from drconf memory
Date: Wed, 24 Sep 2008 17:19:07 +0530
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200809241719.07464.chandru@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Get the memory ranges of the 1st kernel excluding the memory reserved for 
kexec/kdump kernel in case of ibm,dynamic-reconfiguration-memory node of 
device tree 

Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com>
---

 kexec/arch/ppc64/crashdump-ppc64.c |  121 +++++++++++++++++++--------
 kexec/arch/ppc64/crashdump-ppc64.h |    3
 2 files changed, 90 insertions(+), 34 deletions(-)

--- kexec-tools-orig/kexec/arch/ppc64/crashdump-ppc64.c	2008-09-24 
14:46:55.000000000 +0530
+++ kexec-tools/kexec/arch/ppc64/crashdump-ppc64.c	2008-09-24 
14:34:38.000000000 +0530
@@ -84,6 +84,82 @@ mem_rgns_t usablemem_rgns = {0, NULL};
  */
 uint64_t saved_max_mem = 0;
 
+static unsigned long long cstart, cend;
+static int memory_ranges;
+
+/*
+ * Exclude the region that lies within crashkernel
+ */
+static void exclude_crash_region(uint64_t start, uint64_t end)
+{
+	if (cstart < end && cend > start) {
+		if (start < cstart && end > cend) {
+			crash_memory_range[memory_ranges].start = start;
+			crash_memory_range[memory_ranges].end = cstart;
+			crash_memory_range[memory_ranges].type = RANGE_RAM;
+			memory_ranges++;
+			crash_memory_range[memory_ranges].start = cend;
+			crash_memory_range[memory_ranges].end = end;
+			crash_memory_range[memory_ranges].type = RANGE_RAM;
+			memory_ranges++;
+		} else if (start < cstart) {
+			crash_memory_range[memory_ranges].start = start;
+			crash_memory_range[memory_ranges].end = cstart;
+			crash_memory_range[memory_ranges].type = RANGE_RAM;
+			memory_ranges++;
+		} else if (end > cend) {
+			crash_memory_range[memory_ranges].start = cend;
+			crash_memory_range[memory_ranges].end = end;
+			crash_memory_range[memory_ranges].type = RANGE_RAM;
+			memory_ranges++;
+		}
+	} else {
+		crash_memory_range[memory_ranges].start = start;
+		crash_memory_range[memory_ranges].end  = end;
+		crash_memory_range[memory_ranges].type = RANGE_RAM;
+		memory_ranges++;
+	}
+}
+
+static int get_dyn_reconf_crash_memory_ranges()
+{
+	uint64_t start, end;
+	char fname[128], buf[32];
+	FILE *file;
+	int i, n;
+
+	strcpy(fname, "/proc/device-tree/");
+	strcat(fname, "ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory");
+	if ((file = fopen(fname, "r")) == NULL) {
+		perror(fname);
+		return -1;
+	}
+
+	fseek(file, 4, SEEK_SET);
+	for (i = 0; i < num_of_lmbs; i++) {
+		if ((n = fread(buf, 1, 24, file)) < 0) {
+			perror(fname);
+			fclose(file);
+			return -1;
+		}
+		if (memory_ranges >= (max_memory_ranges + 1)) {
+			/* No space to insert another element. */
+				fprintf(stderr,
+				"Error: Number of crash memory ranges"
+				" excedeed the max limit\n");
+			return -1;
+		}
+
+		start = ((uint64_t *)buf)[0];
+		end = start + lmb_size;
+		if (start == 0 && end >= (BACKUP_SRC_END + 1))
+			start = BACKUP_SRC_END + 1;
+		exclude_crash_region(start, end);
+	}
+	fclose(file);
+	return 0;
+}
+
 /* Reads the appropriate file and retrieves the SYSTEM RAM regions for whom to
  * create Elf headers. Keeping it separate from get_memory_ranges() as
  * requirements are different in the case of normal kexec and crashdumps.
@@ -98,7 +174,6 @@ uint64_t saved_max_mem = 0;
 static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 {
 
-	int memory_ranges = 0;
 	char device_tree[256] = "/proc/device-tree/";
 	char fname[256];
 	char buf[MAXBYTES];
@@ -106,7 +181,7 @@ static int get_crash_memory_ranges(struc
 	FILE *file;
 	struct dirent *dentry, *mentry;
 	int i, n, crash_rng_len = 0;
-	unsigned long long start, end, cstart, cend;
+	unsigned long long start, end;
 	int page_size;
 
 	crash_max_memory_ranges = max_memory_ranges + 6;
@@ -129,7 +204,16 @@ static int get_crash_memory_ranges(struc
 		perror(device_tree);
 		goto err;
 	}
+
+	cstart = crash_base;
+	cend = crash_base + crash_size;
+
 	while ((dentry = readdir(dir)) != NULL) {
+		if (!strncmp(dentry->d_name,
+				"ibm,dynamic-reconfiguration-memory", 35)){
+			get_dyn_reconf_crash_memory_ranges();
+			continue;
+		}
 		if (strncmp(dentry->d_name, "memory@", 7) &&
 			strcmp(dentry->d_name, "memory"))
 			continue;
@@ -170,38 +254,7 @@ static int get_crash_memory_ranges(struc
 			if (start == 0 && end >= (BACKUP_SRC_END + 1))
 				start = BACKUP_SRC_END + 1;
 
-			cstart = crash_base;
-			cend = crash_base + crash_size;
-			/*
-			 * Exclude the region that lies within crashkernel
-			 */
-			if (cstart < end && cend > start) {
-				if (start < cstart && end > cend) {
-					crash_memory_range[memory_ranges].start = start;
-					crash_memory_range[memory_ranges].end = cstart;
-					crash_memory_range[memory_ranges].type = RANGE_RAM;
-					memory_ranges++;
-					crash_memory_range[memory_ranges].start = cend;
-					crash_memory_range[memory_ranges].end = end;
-					crash_memory_range[memory_ranges].type = RANGE_RAM;
-					memory_ranges++;
-				} else if (start < cstart) {
-					crash_memory_range[memory_ranges].start = start;
-					crash_memory_range[memory_ranges].end = cstart;
-					crash_memory_range[memory_ranges].type = RANGE_RAM;
-					memory_ranges++;
-				} else if (end > cend){
-					crash_memory_range[memory_ranges].start = cend;
-					crash_memory_range[memory_ranges].end = end;
-					crash_memory_range[memory_ranges].type = RANGE_RAM;
-					memory_ranges++;
-				}
-			} else {
-				crash_memory_range[memory_ranges].start = start;
-				crash_memory_range[memory_ranges].end  = end;
-				crash_memory_range[memory_ranges].type = RANGE_RAM;
-				memory_ranges++;
-			}
+			exclude_crash_region(start, end);
 			fclose(file);
 		}
 		closedir(dmem);
--- kexec-tools-orig/kexec/arch/ppc64/crashdump-ppc64.h	2008-09-24 
14:46:55.000000000 +0530
+++ kexec-tools/kexec/arch/ppc64/crashdump-ppc64.h	2008-09-16 
19:18:57.000000000 +0530
@@ -28,4 +28,7 @@ extern uint64_t crash_size;
 extern unsigned int rtas_base;
 extern unsigned int rtas_size;
 
+uint64_t lmb_size;
+unsigned int num_of_lmbs;
+
 #endif /* CRASHDUMP_PPC64_H */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
