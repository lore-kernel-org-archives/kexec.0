Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp03.in.ibm.com ([59.145.155.3] helo=e28esmtp03.in.ibm.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K7DZv-0007G5-VY
	for kexec@lists.infradead.org; Fri, 13 Jun 2008 18:01:01 +0000
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id m5DI0Js2015887
	for <kexec@lists.infradead.org>; Fri, 13 Jun 2008 23:30:19 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5DI02LT1437756
	for <kexec@lists.infradead.org>; Fri, 13 Jun 2008 23:30:02 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id m5DI0IW3019690
	for <kexec@lists.infradead.org>; Fri, 13 Jun 2008 23:30:18 +0530
From: Chandru <chandru@in.ibm.com>
Subject: [RFC][PATCH 2/3] kexec-tools: add support for dynamic reconfiguration
	memory
Date: Fri, 13 Jun 2008 23:30:12 +0530
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200806132330.13198.chandru@in.ibm.com>
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

Changes to kexec-ppc64.c

Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com
---

--- kexec/arch/ppc64/kexec-ppc64.c.orig	2008-06-12 06:27:39.000000000 -0400
+++ kexec/arch/ppc64/kexec-ppc64.c	2008-06-13 13:28:31.000000000 -0400
@@ -96,6 +96,49 @@ err1:
 
 }
 
+static int count_dyn_reconf_memory_ranges(void)
+{
+	char device_tree[] = "/proc/device-tree/";
+	char fname[128];
+	char buf[32];
+	FILE *file;
+
+	strcpy(fname, device_tree);
+	strcat(fname, "ibm,dynamic-reconfiguration-memory/ibm,lmb-size");
+	if ((file = fopen(fname, "r")) == NULL) {
+		perror(fname);
+		return -1;
+	}
+
+	if (fread(buf, 1, 8, file) < 0) {
+		perror(fname);
+		fclose(file);
+		return -1;
+	}
+
+	lmb_size = ((unsigned long long *)buf)[0];
+	fclose(file);
+
+	/* Get number of lmbs from ibm,dynamic-memory */
+	strcpy(fname, device_tree);
+	strcat(fname, "ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory");
+	if ((file = fopen(fname, "r")) == NULL) {
+		perror(fname);
+		return -1;
+	}
+	/*
+	 * first 4 bytes provide number of entries(lmbs)
+	 */
+	if (fread(buf, 1, 4, file) < 0) {
+		perror(fname);
+		fclose(file);
+		return -1;
+	}
+	num_of_lmbs = ((unsigned int *)buf)[0];
+	max_memory_ranges += num_of_lmbs;
+	fclose(file);
+}
+
 /*
  * Count the memory nodes under /proc/device-tree and populate the
  * max_memory_ranges variable. This variable replaces MAX_MEMORY_RANGES
@@ -113,6 +156,12 @@ static int count_memory_ranges(void)
 	}
 
 	while ((dentry = readdir(dir)) != NULL) {
+		if (!strncmp(dentry->d_name,
+				"ibm,dynamic-reconfiguration-memory", 35)){
+			count_dyn_reconf_memory_ranges();
+			continue;
+		}
+
 		if (strncmp(dentry->d_name, "memory@", 7) &&
 			strcmp(dentry->d_name, "memory") &&
 			strncmp(dentry->d_name, "pci@", 4))
@@ -128,7 +177,52 @@ static int count_memory_ranges(void)
 
 	return 0;
 }
+static void add_base_memory_range(uint64_t start, uint64_t end)
+{
+	base_memory_range[nr_memory_ranges].start = start;
+	base_memory_range[nr_memory_ranges].end  = end;
+	base_memory_range[nr_memory_ranges].type = RANGE_RAM;
+	nr_memory_ranges++;
+
+	dbgprintf("%016llx-%016llx : %x\n",
+		base_memory_range[nr_memory_ranges-1].start,
+		base_memory_range[nr_memory_ranges-1].end,
+		base_memory_range[nr_memory_ranges-1].type);
+}
+
+static int get_dyn_reconf_base_ranges(void)
+{
+	uint64_t start, end;
+	char fname[128], buf[32];
+	FILE *file;
+	int i, n;
 
+
+	strcpy(fname, "/proc/device-tree/");
+	strcat(fname,
+		"ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory");
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
+		if (nr_memory_ranges >= max_memory_ranges)
+			return -1;
+
+		start = ((uint64_t *)buf)[0];
+		end = start + lmb_size;
+		add_base_memory_range(start, end);
+	}
+	fclose(file);
+	return 0;
+}
 /* Sort the base ranges in memory - this is useful for ensuring that our
  * ranges are in ascending order, even if device-tree read of memory nodes
  * is done differently. Also, could be used for other range coalescing later
@@ -156,7 +250,7 @@ static int sort_base_ranges(void)
 /* Get base memory ranges */
 static int get_base_ranges(void)
 {
-	int local_memory_ranges = 0;
+	uint64_t start, end;
 	char device_tree[256] = "/proc/device-tree/";
 	char fname[256];
 	char buf[MAXBYTES];
@@ -170,6 +264,11 @@ static int get_base_ranges(void)
 		return -1;
 	}
 	while ((dentry = readdir(dir)) != NULL) {
+		if (!strncmp(dentry->d_name,
+				"ibm,dynamic-reconfiguration-memory", 35)) {
+			get_dyn_reconf_base_ranges();
+			continue;
+		}
 		if (strncmp(dentry->d_name, "memory@", 7) &&
 			strcmp(dentry->d_name, "memory"))
 			continue;
@@ -197,27 +296,18 @@ static int get_base_ranges(void)
 				closedir(dir);
 				return -1;
 			}
-			if (local_memory_ranges >= max_memory_ranges) {
+			if (nr_memory_ranges >= max_memory_ranges) {
 				fclose(file);
 				break;
 			}
-			base_memory_range[local_memory_ranges].start =
-				((uint64_t *)buf)[0];
-			base_memory_range[local_memory_ranges].end  =
-				base_memory_range[local_memory_ranges].start +
-				((uint64_t *)buf)[1];
-			base_memory_range[local_memory_ranges].type = RANGE_RAM;
-			local_memory_ranges++;
-			dbgprintf("%016llx-%016llx : %x\n",
-				base_memory_range[local_memory_ranges-1].start,
-				base_memory_range[local_memory_ranges-1].end,
-				base_memory_range[local_memory_ranges-1].type);
+			start = ((uint64_t *)buf)[0];
+			end = start + ((uint64_t *)buf)[1];
+			add_base_memory_range(start, end);
 			fclose(file);
 		}
 		closedir(dmem);
 	}
 	closedir(dir);
-	nr_memory_ranges = local_memory_ranges;
 	sort_base_ranges();
 	memory_max = base_memory_range[nr_memory_ranges - 1].end;
 #ifdef DEBUG
@@ -276,7 +366,9 @@ static int get_devtree_details(unsigned 
 			strncmp(dentry->d_name, "memory@", 7) &&
 			strcmp(dentry->d_name, "memory") &&
 			strncmp(dentry->d_name, "pci@", 4) &&
-			strncmp(dentry->d_name, "rtas", 4))
+			strncmp(dentry->d_name, "rtas", 4) &&
+			strncmp(dentry->d_name,
+				"ibm,dynamic-reconfiguration-memory", 35))
 			continue;
 		strcpy(fname, device_tree);
 		strcat(fname, dentry->d_name);
@@ -474,6 +566,29 @@ static int get_devtree_details(unsigned 
 			closedir(cdir);
 		} /* memory */
 
+		if (!strncmp(dentry->d_name,
+				"ibm,dynamic-reconfiguration-memory", 35)) {
+			unsigned int k;
+			strcat(fname, "/ibm,dynamic-memory");
+			if ((file = fopen(fname, "r")) == NULL) {
+				perror(fname);
+				goto error_opencdir;
+			}
+			fseek(file, 4, SEEK_SET);
+			for (k = 0; k < num_of_lmbs; k++) {
+				if ((n = fread(buf, 1, 24, file)) < 0) {
+					perror(fname);
+					goto error_openfile;
+				}
+				rmo_base = ((unsigned long long *)buf)[0];
+				rmo_top = rmo_base + lmb_size;
+				if (rmo_top > 0x30000000UL)
+					rmo_top = 0x30000000UL;
+			}
+			fclose(file);
+			closedir(cdir);
+		} /* ibm,dynamic-reconfiguration-memory */
+
 		if (strncmp(dentry->d_name, "pci@", 4) == 0) {
 			strcat(fname, "/linux,tce-base");
 			if ((file = fopen(fname, "r")) == NULL) {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
