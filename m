Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eo8ka-0004je-Nr
 for kexec@lists.infradead.org; Tue, 20 Feb 2018 14:18:34 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1KEF89b042248
 for <kexec@lists.infradead.org>; Tue, 20 Feb 2018 09:18:20 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g8n8m07fh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 20 Feb 2018 09:18:19 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Tue, 20 Feb 2018 14:18:15 -0000
Subject: [PATCH 2/2] kexec/ppc64: add support to parse ibm,
 dynamic-memory-v2 property
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Tue, 20 Feb 2018 19:48:09 +0530
In-Reply-To: <151913628039.8893.12994971144990413141.stgit@hbathini.in.ibm.com>
References: <151913628039.8893.12994971144990413141.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Message-Id: <151913628939.8893.17231490402797441078.stgit@hbathini.in.ibm.com>
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

Add support to parse the new 'ibm,dynamic-memory-v2' property in the
'ibm,dynamic-reconfiguration-memory' node. This replaces the old
'ibm,dynamic-memory' property and is enabled in the kernel with a
patch series that starts with commit 0c38ed6f6f0b ("powerpc/pseries:
Enable support of ibm,dynamic-memory-v2"). All LMBs that share the same
flags and are adjacent are grouped together in the newer version of the
property making it compact to represent larger memory configurations.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 kexec/arch/ppc64/crashdump-ppc64.c |   23 +++++++--
 kexec/arch/ppc64/crashdump-ppc64.h |   16 +++++-
 kexec/arch/ppc64/kexec-ppc64.c     |   35 ++++++++++----
 kexec/fs2dt.c                      |   92 ++++++++++++++++++++++--------------
 4 files changed, 112 insertions(+), 54 deletions(-)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index bc9f948..50e3853 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -39,6 +39,10 @@
 #define DEVTREE_CRASHKERNEL_BASE "/proc/device-tree/chosen/linux,crashkernel-base"
 #define DEVTREE_CRASHKERNEL_SIZE "/proc/device-tree/chosen/linux,crashkernel-size"
 
+unsigned int num_of_lmb_sets;
+unsigned int is_dyn_mem_v2;
+uint64_t lmb_size;
+
 static struct crash_elf_info elf_info64 =
 {
 	class: ELFCLASS64,
@@ -127,6 +131,7 @@ static int get_dyn_reconf_crash_memory_ranges(void)
 {
 	uint64_t start, end;
 	uint64_t startrange, endrange;
+	uint64_t size;
 	char fname[128], buf[32];
 	FILE *file;
 	unsigned int i;
@@ -135,6 +140,8 @@ static int get_dyn_reconf_crash_memory_ranges(void)
 
 	strcpy(fname, "/proc/device-tree/");
 	strcat(fname, "ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory");
+	if (is_dyn_mem_v2)
+		strcat(fname, "-v2");
 	if ((file = fopen(fname, "r")) == NULL) {
 		perror(fname);
 		return -1;
@@ -142,8 +149,9 @@ static int get_dyn_reconf_crash_memory_ranges(void)
 
 	fseek(file, 4, SEEK_SET);
 	startrange = endrange = 0;
-	for (i = 0; i < num_of_lmbs; i++) {
-		if ((n = fread(buf, 1, 24, file)) < 0) {
+	size = lmb_size;
+	for (i = 0; i < num_of_lmb_sets; i++) {
+		if ((n = fread(buf, 1, LMB_ENTRY_SIZE, file)) < 0) {
 			perror(fname);
 			fclose(file);
 			return -1;
@@ -156,8 +164,15 @@ static int get_dyn_reconf_crash_memory_ranges(void)
 			return -1;
 		}
 
-		start = be64_to_cpu(((uint64_t *)buf)[DRCONF_ADDR]);
-		end = start + lmb_size;
+		/*
+		 * If the property is ibm,dynamic-memory-v2, the first 4 bytes
+		 * tell the number of sequential LMBs in this entry.
+		 */
+		if (is_dyn_mem_v2)
+			size = be32_to_cpu(((unsigned int *)buf)[0]) * lmb_size;
+
+		start = be64_to_cpu(*((uint64_t *)&buf[DRCONF_ADDR]));
+		end = start + size;
 		if (start == 0 && end >= (BACKUP_SRC_END + 1))
 			start = BACKUP_SRC_END + 1;
 
diff --git a/kexec/arch/ppc64/crashdump-ppc64.h b/kexec/arch/ppc64/crashdump-ppc64.h
index 42ccc31..87beb39 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.h
+++ b/kexec/arch/ppc64/crashdump-ppc64.h
@@ -34,10 +34,18 @@ extern unsigned int rtas_size;
 extern uint64_t opal_base;
 extern uint64_t opal_size;
 
-uint64_t lmb_size;
-unsigned int num_of_lmbs;
-
-#define DRCONF_ADDR	0
+/*
+ * In case of ibm,dynamic-memory-v2 property, this is the number of LMB
+ * sets where each set represents a group of sequential LMB entries. In
+ * case of ibm,dynamic-memory property, the number of LMB sets is nothing
+ * but the total number of LMB entries.
+ */
+extern unsigned int num_of_lmb_sets;
+extern unsigned int is_dyn_mem_v2;
+extern uint64_t lmb_size;
+
+#define LMB_ENTRY_SIZE	24
+#define DRCONF_ADDR	(is_dyn_mem_v2 ? 4 : 0)
 #define DRCONF_FLAGS	20
 
 #endif /* CRASHDUMP_PPC64_H */
diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index a7d708b..4e70b13 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -149,6 +149,7 @@ static void add_base_memory_range(uint64_t start, uint64_t end)
 static int get_dyn_reconf_base_ranges(void)
 {
 	uint64_t start, end;
+	uint64_t size;
 	char fname[128], buf[32];
 	FILE *file;
 	unsigned int i;
@@ -166,29 +167,35 @@ static int get_dyn_reconf_base_ranges(void)
 		return -1;
 	}
 	/*
-	 * lmb_size, num_of_lmbs(global variables) are
+	 * lmb_size, num_of_lmb_sets(global variables) are
 	 * initialized once here.
 	 */
-	lmb_size = be64_to_cpu(((uint64_t *)buf)[0]);
+	size = lmb_size = be64_to_cpu(((uint64_t *)buf)[0]);
 	fclose(file);
 
 	strcpy(fname, "/proc/device-tree/");
 	strcat(fname,
 		"ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory");
 	if ((file = fopen(fname, "r")) == NULL) {
-		perror(fname);
-		return -1;
+		strcat(fname, "-v2");
+		if ((file = fopen(fname, "r")) == NULL) {
+			perror(fname);
+			return -1;
+		}
+
+		is_dyn_mem_v2 = 1;
 	}
-	/* first 4 bytes tell the number of lmbs */
+
+	/* first 4 bytes tell the number of lmb set entries */
 	if (fread(buf, 1, 4, file) != 4) {
 		perror(fname);
 		fclose(file);
 		return -1;
 	}
-	num_of_lmbs = be32_to_cpu(((unsigned int *)buf)[0]);
+	num_of_lmb_sets = be32_to_cpu(((unsigned int *)buf)[0]);
 
-	for (i = 0; i < num_of_lmbs; i++) {
-		if ((n = fread(buf, 1, 24, file)) < 0) {
+	for (i = 0; i < num_of_lmb_sets; i++) {
+		if ((n = fread(buf, 1, LMB_ENTRY_SIZE, file)) < 0) {
 			perror(fname);
 			fclose(file);
 			return -1;
@@ -196,13 +203,21 @@ static int get_dyn_reconf_base_ranges(void)
 		if (nr_memory_ranges >= max_memory_ranges)
 			return -1;
 
-		start = be64_to_cpu(((uint64_t *)buf)[0]);
-		end = start + lmb_size;
+		/*
+		 * If the property is ibm,dynamic-memory-v2, the first 4 bytes
+		 * tell the number of sequential LMBs in this entry.
+		 */
+		if (is_dyn_mem_v2)
+			size = be32_to_cpu(((unsigned int *)buf)[0]) * lmb_size;
+
+		start = be64_to_cpu(*((uint64_t *)&buf[DRCONF_ADDR]));
+		end = start + size;
 		add_base_memory_range(start, end);
 	}
 	fclose(file);
 	return 0;
 }
+
 /* Sort the base ranges in memory - this is useful for ensuring that our
  * ranges are in ascending order, even if device-tree read of memory nodes
  * is done differently. Also, could be used for other range coalescing later
diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index 550eca9..07a5e2f 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -217,11 +217,12 @@ static uint64_t add_ranges(uint64_t **ranges, int *ranges_size, int idx,
 static void add_dyn_reconf_usable_mem_property__(int fd)
 {
 	char fname[MAXPATH], *bname;
-	uint64_t buf[32];
+	char buf[32];
+	uint32_t lmbs_in_set = 1;
 	uint64_t *ranges;
 	int ranges_size = MEM_RANGE_CHUNK_SZ;
 	uint64_t base, end, rngs_cnt;
-	size_t i;
+	size_t i, j;
 	int rlen = 0;
 	int tmp_indx;
 
@@ -242,43 +243,61 @@ static void add_dyn_reconf_usable_mem_property__(int fd)
 		    ranges_size*8);
 
 	rlen = 0;
-	for (i = 0; i < num_of_lmbs; i++) {
-		if (read(fd, buf, 24) < 0)
+	for (i = 0; i < num_of_lmb_sets; i++) {
+		if (read(fd, buf, LMB_ENTRY_SIZE) < 0)
 			die("unrecoverable error: error reading \"%s\": %s\n",
 				pathname, strerror(errno));
 
-		base = be64_to_cpu((uint64_t) buf[0]);
-		end = base + lmb_size;
-		if (~0ULL - base < end)
-			die("unrecoverable error: mem property overflow\n");
-
-		tmp_indx = rlen++;
-
-		rngs_cnt = add_ranges(&ranges, &ranges_size, rlen,
-				      base, end);
-		if (rngs_cnt == 0) {
-			/* We still need to add a counter for every LMB because
-			 * the kernel parsing code is dumb.  We just have
-			 * a zero in this case, with no following base/len.
-			 */
-			ranges[tmp_indx] = 0;
-			/* rlen is already just tmp_indx+1 as we didn't write
-			 * anything.  Check array size here, as we'll probably
-			 * go on for a while writing zeros now.
-			 */
-			if (rlen >= (ranges_size-1)) {
-				ranges_size += MEM_RANGE_CHUNK_SZ;
-				ranges = realloc(ranges, ranges_size*8);
-				if (!ranges)
-					die("unrecoverable error: can't"
-					    " realloc %d bytes for"
-					    " ranges.\n",
-					    ranges_size*8);
+		/*
+		 * If the property is ibm,dynamic-memory-v2, the first 4 bytes
+		 * tell the number of sequential LMBs in this entry. Else, if
+		 * the property is ibm,dynamic-memory, each entry represents
+		 * one LMB. Make sure to add an entry for each LMB as kernel
+		 * looks for a counter for every LMB.
+		 */
+		if (is_dyn_mem_v2)
+			lmbs_in_set = be32_to_cpu(((unsigned int *)buf)[0]);
+
+		base = be64_to_cpu(*((uint64_t *)&buf[DRCONF_ADDR]));
+		for (j = 0; j < lmbs_in_set; j++) {
+			end = base + lmb_size;
+			if (~0ULL - base < end) {
+				die("unrecoverable error: mem property"
+				    " overflow\n");
 			}
-		} else {
-			/* Store the count of (base, size) duple */
-			ranges[tmp_indx] = cpu_to_be64(rngs_cnt);
-			rlen += rngs_cnt * 2;
+
+			tmp_indx = rlen++;
+
+			rngs_cnt = add_ranges(&ranges, &ranges_size, rlen,
+					      base, end);
+			if (rngs_cnt == 0) {
+				/* We still need to add a counter for every LMB
+				 * because the kernel parsing code is dumb. We
+				 * just have a zero in this case, with no
+				 * following base/len.
+				 */
+				ranges[tmp_indx] = 0;
+
+				/* rlen is already just tmp_indx+1 as we didn't
+				 * write anything. Check array size here, as we
+				 * will probably go on writing zeros for a while
+				 */
+				if (rlen >= (ranges_size-1)) {
+					ranges_size += MEM_RANGE_CHUNK_SZ;
+					ranges = realloc(ranges, ranges_size*8);
+					if (!ranges)
+						die("unrecoverable error: can't"
+						    " realloc %d bytes for"
+						    " ranges.\n",
+						    ranges_size*8);
+				}
+			} else {
+				/* Store the count of (base, size) duple */
+				ranges[tmp_indx] = cpu_to_be64(rngs_cnt);
+				rlen += rngs_cnt * 2;
+			}
+
+			base = end;
 		}
 	}
 		
@@ -298,7 +317,8 @@ static void add_dyn_reconf_usable_mem_property__(int fd)
 
 static void add_dyn_reconf_usable_mem_property(struct dirent *dp, int fd)
 {
-	if (!strcmp(dp->d_name, "ibm,dynamic-memory") && usablemem_rgns.size)
+	if ((!strcmp(dp->d_name, "ibm,dynamic-memory-v2") ||
+	    !strcmp(dp->d_name, "ibm,dynamic-memory")) && usablemem_rgns.size)
 		add_dyn_reconf_usable_mem_property__(fd);
 }
 #else


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
