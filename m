Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wi5JQ-00030e-Bn
 for kexec@lists.infradead.org; Wed, 07 May 2014 17:07:21 +0000
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH v3 2/2] Get rid of overrun adjustments
Date: Wed,  7 May 2014 19:06:43 +0200
Message-Id: <1399482403-3656-3-git-send-email-ptesarik@suse.cz>
In-Reply-To: <1399482403-3656-1-git-send-email-ptesarik@suse.cz>
References: <1399482403-3656-1-git-send-email-ptesarik@suse.cz>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org

Thanks to the previous commit, __exclude_unnecessary_pages does not
require any specific size of the cycle.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
---
 makedumpfile.c | 59 ----------------------------------------------------------
 1 file changed, 59 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index a3498e4..9a36856 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -88,7 +88,6 @@ do { \
 		*ptr_long_table = value; \
 } while (0)
 
-static void check_cyclic_buffer_overrun(void);
 static void setup_page_is_buddy(void);
 
 void
@@ -3254,9 +3253,6 @@ out:
 		    !sadump_generate_elf_note_from_dumpfile())
 			return FALSE;
 
-		if (info->flag_cyclic && info->dump_level & DL_EXCLUDE_FREE)
-			check_cyclic_buffer_overrun();
-
 	} else {
 		if (!get_mem_map_without_mm())
 			return FALSE;
@@ -4280,61 +4276,6 @@ exclude_free_page(struct cycle *cycle)
 }
 
 /*
- * Let C be a cyclic buffer size and B a bitmap size used for
- * representing maximum block size managed by buddy allocator.
- *
- * For some combinations of C and B, clearing operation can overrun
- * the cyclic buffer. Let's consider three cases.
- *
- *   - If C == B, this is trivially safe.
- *
- *   - If B > C, overrun can easily happen.
- *
- *   - In case of C > B, if C mod B != 0, then there exist n > m > 0,
- *     B > b > 0 such that n x C = m x B + b. This means that clearing
- *     operation overruns cyclic buffer (B - b)-bytes in the
- *     combination of n-th cycle and m-th block.
- *
- *     Note that C mod B != 0 iff (m x C) mod B != 0 for some m.
- *
- * If C == B, C mod B == 0 always holds. Again, if B > C, C mod B != 0
- * always holds. Hence, it's always sufficient to check the condition
- * C mod B != 0 in order to determine whether overrun can happen or
- * not.
- *
- * The bitmap size used for maximum block size B is calculated from
- * MAX_ORDER as:
- *
- *   B := DIVIDE_UP((1 << (MAX_ORDER - 1)), BITS_PER_BYTE)
- *
- * Normally, MAX_ORDER is 11 at default. This is configurable through
- * CONFIG_FORCE_MAX_ZONEORDER.
- */
-static void
-check_cyclic_buffer_overrun(void)
-{
-	int max_order = ARRAY_LENGTH(zone.free_area);
-	int max_order_nr_pages = 1 << (max_order - 1);
-	unsigned long max_block_size = divideup(max_order_nr_pages, BITPERBYTE);
-
-	if (info->bufsize_cyclic % max_block_size) {
-		unsigned long bufsize;
-
-		if (max_block_size > info->bufsize_cyclic) {
-			MSG("WARNING: some free pages are not filtered.\n");
-			return;
-		}
-
-		bufsize = info->bufsize_cyclic;
-		info->bufsize_cyclic = round(bufsize, max_block_size);
-		info->pfn_cyclic = info->bufsize_cyclic * BITPERBYTE;
-
-		MSG("cyclic buffer size has been changed: %lu => %lu\n",
-		    bufsize, info->bufsize_cyclic);
-	}
-}
-
-/*
  * For the kernel versions from v2.6.17 to v2.6.37.
  */
 static int
-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
