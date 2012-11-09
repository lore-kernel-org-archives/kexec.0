Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TWils-00038n-80
 for kexec@lists.infradead.org; Fri, 09 Nov 2012 07:12:57 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.193])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id qA97CshC005053
 for <kexec@lists.infradead.org>; Fri, 9 Nov 2012 16:12:54 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id qA97CsD23995 for kexec@lists.infradead.org;
 Fri, 9 Nov 2012 16:12:54 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id qA97Cc5P017514
 for <kexec@lists.infradead.org>; Fri, 9 Nov 2012 16:12:53 +0900 (JST)
Date: Fri, 9 Nov 2012 16:04:00 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 2/3] Calculate the size of cyclic buffer automatically.
Message-Id: <20121109160400.74835a9eb31a58e07d670554@mxc.nes.nec.co.jp>
In-Reply-To: <20121109160214.afe15ee1a047ff7354471ba0@mxc.nes.nec.co.jp>
References: <20121109160214.afe15ee1a047ff7354471ba0@mxc.nes.nec.co.jp>
Mime-Version: 1.0
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
To: kexec@lists.infradead.org

The size of cyclic buffer is set to DEFAULT_BUFSIZE_CYCLIC(1MB) when
the size isn't specified. But 1MB is too small for large memory machine
and the number of cycle will be so large. As a result, a lot of time
will be spend for dump filtering.

To resolve the issue above, I add calculate_cyclic_buffer_size() to
calculate the buffer size as needed.
Concretely, the logic is to choose the lesser value of the two below
as the size of cyclic buffer:

  a. the size enough for storing the 1st/2nd bitmap for the whole of vmcore
  b. 80% of free memory (as safety limit)

calculate_cyclic_buffer_size() uses max_mapnr, so it needs to be done
after get_max_mapnr().

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c | 70 +++++++++++++++++++++++++++++++++++++++-------------------
 makedumpfile.h |  6 +----
 2 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 73a466e..f784400 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2573,29 +2573,6 @@ initial(void)
 	}
 #endif
 
-	if (info->flag_cyclic) {
-		/*
-		 * buffer size is specified as Kbyte
-		 */
-		if (info->bufsize_cyclic == 0)
-			info->bufsize_cyclic = DEFAULT_BUFSIZE_CYCLIC;
-		else
-			info->bufsize_cyclic <<= 10;
-	
-		/*
-		 * Max buffer size is 100 MB
-		 */
-		if (info->bufsize_cyclic > (100 << 20)) {
-			MSG("Specified buffer size is too large, ");
-			MSG("The buffer size for the cyclic mode will be truncated to 100 MB.\n");
-			info->bufsize_cyclic = (100 << 20);
-		}
-		info->pfn_cyclic = info->bufsize_cyclic * BITPERBYTE;
-
-		DEBUG_MSG("\n");
-		DEBUG_MSG("Buffer size for the cyclic mode: %ld\n", info->bufsize_cyclic);
-	}
-
 	if (info->flag_exclude_xen_dom) {
 		if(info->flag_cyclic) {
 			info->flag_cyclic = FALSE;
@@ -2737,6 +2714,30 @@ out:
 	if (!get_max_mapnr())
 		return FALSE;
 
+	if (info->flag_cyclic) {
+		/*
+		 * buffer size is specified as Kbyte
+		 */
+		if (info->bufsize_cyclic == 0) {
+			if (!calculate_cyclic_buffer_size())
+				return FALSE;
+		} else
+			info->bufsize_cyclic <<= 10;
+
+		/*
+		 * Max buffer size is 100 MB
+		 */
+		if (info->bufsize_cyclic > (100 << 20)) {
+			MSG("Specified buffer size is too large, ");
+			MSG("The buffer size for the cyclic mode will be truncated to 100 MB.\n");
+			info->bufsize_cyclic = (100 << 20);
+		}
+		info->pfn_cyclic = info->bufsize_cyclic * BITPERBYTE;
+
+		DEBUG_MSG("\n");
+		DEBUG_MSG("Buffer size for the cyclic mode: %ld\n", info->bufsize_cyclic);
+	}
+
 	if (debug_info) {
 		if (info->flag_sadump)
 			(void) sadump_virt_phys_base();
@@ -8006,6 +8007,29 @@ out:
 	return free_size;
 }
 
+
+/*
+ * Choose the lesser value of the two below as the size of cyclic buffer.
+ *  - the size enough for storing the 1st/2nd bitmap for the whole of vmcore
+ *  - 80% of free memory
+ */
+int
+calculate_cyclic_buffer_size(void) {
+	unsigned long long free_size, needed_size;
+
+	if (info->max_mapnr <= 0) {
+		ERRMSG("Invalid max_mapnr(%llu).\n", info->max_mapnr);
+		return FALSE;
+	}
+
+	free_size = get_free_memory_size() * 0.8;
+	needed_size = (info->max_mapnr * 2) / BITPERBYTE;
+
+	info->bufsize_cyclic = (free_size <= needed_size) ? free_size : needed_size;
+
+	return TRUE;
+}
+
 static struct option longopts[] = {
 	{"split", no_argument, NULL, 's'}, 
 	{"reassemble", no_argument, NULL, 'r'},
diff --git a/makedumpfile.h b/makedumpfile.h
index c91b4e9..8ffef76 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -199,11 +199,6 @@ isAnon(unsigned long mapping)
 #define FILENAME_STDOUT		"STDOUT"
 
 /*
- * For cyclic processing
- */
-#define DEFAULT_BUFSIZE_CYCLIC         (1024 * 1024)
-
-/*
  * Minimam vmcore has 2 ProgramHeaderTables(PT_NOTE and PT_LOAD).
  */
 #define MIN_ELF32_HEADER_SIZE \
@@ -1612,5 +1607,6 @@ unsigned long long get_num_dumpable_cyclic(void);
 int get_loads_dumpfile_cyclic(void);
 int initial_xen(void);
 unsigned long long get_free_memory_size(void);
+int calculate_cyclic_buffer_size(void);
 
 #endif /* MAKEDUMPFILE_H */
-- 
1.7.11

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
