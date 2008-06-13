Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp05.au.ibm.com ([202.81.18.174])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K7DZd-00079G-3P
	for kexec@lists.infradead.org; Fri, 13 Jun 2008 18:00:30 +0000
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id m5DHxaZ6007400
	for <kexec@lists.infradead.org>; Sat, 14 Jun 2008 03:59:36 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5DI0BIW074466
	for <kexec@lists.infradead.org>; Sat, 14 Jun 2008 04:00:12 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5DI0B5i019556
	for <kexec@lists.infradead.org>; Sat, 14 Jun 2008 04:00:11 +1000
From: Chandru <chandru@in.ibm.com>
Subject: [RFC][PATCH 1/3] kexec-tools: add support for dynamic reconfiguration
	memory
Date: Fri, 13 Jun 2008 23:30:04 +0530
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200806132330.04465.chandru@in.ibm.com>
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
Cc: bwalle@suse.de, vgoyal@redhat.com, maneesh@in.ibm.com

Power6 machines have most of their memory represented 
in /proc/device-tree/ibm,dynamic-reconfiguration-memory node. kexec-tools 
currently read  memory@ nodes of device-tree.  Following changes are made to 
kexec-tools to accommodate dynamic reconfiguration memory node of device 
tree.  There are changes required in kernel as well in 
arch/powerpc/kernel/prom.c and arch/powerpc/mm/numa.c 
for 'linux,usable-memory' property.  Since there are many memory regions 
represented under one node ( ibm,dynamic-reconfiguration-memory) , I have 
appended the region entry number from ibm,dynamic-memory as a string 
to 'linux,usable-memory' string to take care of usable-memory properties. 
Part of the patch here is re-organization of the existing kexec-tools code 
and part of it is code for dynamic reconfiguration memory.

Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com
---

--- kexec/arch/ppc64/crashdump-ppc64.c.orig	2008-06-12 
06:27:09.000000000 -0400
+++ kexec/arch/ppc64/crashdump-ppc64.c	2008-06-13 13:07:34.000000000 -0400
@@ -84,6 +84,83 @@ mem_rgns_t usablemem_rgns = {0, NULL};
  */
 unsigned long saved_max_mem = 0;
 
+
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
 /* Reads the appropriate file and retrieves the SYSTEM RAM regions for whom 
to
  * create Elf headers. Keeping it separate from get_memory_ranges() as
  * requirements are different in the case of normal kexec and crashdumps.
@@ -98,7 +175,6 @@ unsigned long saved_max_mem = 0;
 static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 {
 
-	int memory_ranges = 0;
 	char device_tree[256] = "/proc/device-tree/";
 	char fname[256];
 	char buf[MAXBYTES];
@@ -106,7 +182,7 @@ static int get_crash_memory_ranges(struc
 	FILE *file;
 	struct dirent *dentry, *mentry;
 	int i, n, crash_rng_len = 0;
-	unsigned long long start, end, cstart, cend;
+	unsigned long long start, end;
 	int page_size;
 
 	crash_max_memory_ranges = max_memory_ranges + 6;
@@ -129,7 +205,16 @@ static int get_crash_memory_ranges(struc
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
@@ -167,41 +252,11 @@ static int get_crash_memory_ranges(struc
 
 			start = ((unsigned long long *)buf)[0];
 			end = start + ((unsigned long long *)buf)[1];
-			if (start == 0 && end >= (BACKUP_SRC_END + 1))
+			if (start == 0 && end >= (BACKUP_SRC_END + 1)){
 				start = BACKUP_SRC_END + 1;
-
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
 			}
+
+			exclude_crash_region(start, end);
 			fclose(file);
 		}
 		closedir(dmem);
--- kexec/arch/ppc64/crashdump-ppc64.h.orig	2008-06-12 
06:27:18.000000000 -0400
+++ kexec/arch/ppc64/crashdump-ppc64.h	2008-06-05 13:48:24.000000000 -0400
@@ -28,4 +28,7 @@ extern uint64_t crash_size;
 extern unsigned int rtas_base;
 extern unsigned int rtas_size;
 
+unsigned long lmb_size;
+unsigned int num_of_lmbs;
+
 #endif /* CRASHDUMP_PPC64_H */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
