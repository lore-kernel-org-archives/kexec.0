Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UcggZ-0007rk-LS
 for kexec@lists.infradead.org; Wed, 15 May 2013 18:44:25 +0000
Subject: [PATCH] makedumpfile: message on non-mmap kernels
Message-Id: <E1UcggB-0005hX-L1@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Wed, 15 May 2013 13:43:59 -0500
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp

From: Cliff Wickman <cpw@sgi.com>

If the crash kernel does not support mmap(2) of /proc/vmcore, make
makedumpfile fall back to using reads with a non-alarming message.

Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 makedumpfile.c |   37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

Index: makedumpfile.mmap/makedumpfile.c
===================================================================
--- makedumpfile.mmap.orig/makedumpfile.c
+++ makedumpfile.mmap/makedumpfile.c
@@ -239,7 +239,7 @@ read_page_desc(unsigned long long paddr,
 }
 
 static int
-update_mmap_range(off_t offset) {
+update_mmap_range(off_t offset, int initial) {
 	off_t start_offset;
 	off_t map_size;
 	off_t max_offset = get_max_file_offset();
@@ -258,10 +258,11 @@ update_mmap_range(off_t offset) {
 				     info->fd_memory, start_offset);
 
 	if (info->mmap_buf == MAP_FAILED) {
-		ERRMSG("Can't map [%llx-%llx] with mmap()\n %s",
-		       (ulonglong)start_offset,
-		       (ulonglong)(start_offset + map_size),
-		       strerror(errno));
+		if (!initial)
+			ERRMSG("Can't map [%llx-%llx] with mmap()\n %s",
+				(ulonglong)start_offset,
+				(ulonglong)(start_offset + map_size),
+				strerror(errno));
 		return FALSE;
 	}
 
@@ -285,7 +286,7 @@ is_mapped_with_mmap(off_t offset) {
 int
 initialize_mmap(void) {
 	info->mmap_buf = MAP_FAILED;
-	if (!update_mmap_range(0))
+	if (!update_mmap_range(0, 1))
 		return FALSE;
 
 	return TRUE;
@@ -298,7 +299,7 @@ read_with_mmap(off_t offset, void *bufpt
 next_region:
 
 	if (!is_mapped_with_mmap(offset)) {
-		if (!update_mmap_range(offset))
+		if (!update_mmap_range(offset, 0))
 			return FALSE;
 	}
 
@@ -2984,14 +2985,20 @@ out:
 	if (info->dump_level & DL_EXCLUDE_FREE)
 		setup_page_is_buddy();
 
-	if (info->mmap_region_size > 0 && initialize_mmap()) {
-		/*
-		 * The map size is specified as Kbyte with
-		 * --map-size <size> option.
-		 */
-		info->mmap_region_size <<= 10;
-		info->flag_usemmap = TRUE;
-		DEBUG_MSG("read %s with mmap()\n", info->name_memory);
+	if (info->mmap_region_size > 0) {
+		if (!initialize_mmap()) {
+			/* this kernel does not support mmap of vmcore */
+			ERRMSG("Kernel can't mmap vmcore, using reads.\n");
+			info->flag_usemmap = FALSE;
+		} else {
+			/*
+			 * The map size is specified as Kbyte with
+			 * --map-size <size> option.
+			 */
+			info->mmap_region_size <<= 10;
+			info->flag_usemmap = TRUE;
+			DEBUG_MSG("read %s with mmap()\n", info->name_memory);
+		}
 	} else {
 		info->flag_usemmap = FALSE;
 		DEBUG_MSG("read %s with read()\n", info->name_memory);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
