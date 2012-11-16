Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZE4Q-0006KP-8V
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 05:02:27 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id D11E93EE0AE
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:24 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id B7B9F45DE56
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:24 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9783145DE54
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:24 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 8859A1DB803C
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:24 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 352611DB803A
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:24 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 10/10] Warn cyclic buffer overrun and correct it if possible
Date: Fri, 16 Nov 2012 14:02:23 +0900
Message-ID: <20121116050223.8280.12865.stgit@localhost6.localdomain6>
In-Reply-To: <20121116050108.8280.14861.stgit@localhost6.localdomain6>
References: <20121116050108.8280.14861.stgit@localhost6.localdomain6>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

Clearling bits on cyclic buffer can overrun the cyclic buffer
according to some combination of MAX_ORDER and cyclic buffer size.

The cyclic buffer size is corrected if possible.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 70 insertions(+), 1 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 65b9fd7..18a1e0a 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -58,6 +58,7 @@ do { \
 		*ptr_long_table = value; \
 } while (0)
 
+static void check_cyclic_buffer_overrun(void);
 static void setup_page_is_buddy(void);
 
 void
@@ -2832,6 +2833,9 @@ out:
 		    !sadump_generate_elf_note_from_dumpfile())
 			return FALSE;
 
+		if (info->flag_cyclic && info->dump_level & DL_EXCLUDE_FREE)
+			check_cyclic_buffer_overrun();
+
 	} else {
 		if (!get_mem_map_without_mm())
 			return FALSE;
@@ -3669,6 +3673,61 @@ exclude_free_page(void)
 }
 
 /*
+ * Let C be a cyclic buffer size and B a bitmap size used for
+ * representing maximum block size managed by buddy allocator.
+ *
+ * For some combinations of C and B, clearing operation can overrun
+ * the cyclic buffer. Let's consider three cases.
+ *
+ *   - If C == B, this is trivially safe.
+ *
+ *   - If B > C, overrun can easily happen.
+ *
+ *   - In case of C > B, if C mod B != 0, then there exist n > m > 0,
+ *     B > b > 0 such that n x C = m x B + b. This means that clearing
+ *     operation overruns cyclic buffer (B - b)-bytes in the
+ *     combination of n-th cycle and m-th block.
+ *
+ *     Note that C mod B != 0 iff (m x C) mod B != 0 for some m.
+ *
+ * If C == B, C mod B == 0 always holds. Again, if B > C, C mod B != 0
+ * always holds. Hence, it's always sufficient to check the condition
+ * C mod B != 0 in order to determine whether overrun can happen or
+ * not.
+ *
+ * The bitmap size used for maximum block size B is calculated from
+ * MAX_ORDER as:
+ *
+ *   B := DIVIDE_UP((1 << (MAX_ORDER - 1)), BITS_PER_BYTE)
+ *
+ * Normally, MAX_ORDER is 11 at default. This is configurable through
+ * CONFIG_FORCE_MAX_ZONEORDER.
+ */
+static void
+check_cyclic_buffer_overrun(void)
+{
+	int max_order = ARRAY_LENGTH(zone.free_area);
+	int max_order_nr_pages = 1 << (max_order - 1);
+	unsigned long max_block_size = roundup(max_order_nr_pages, BITPERBYTE);
+
+	if (info->bufsize_cyclic %
+	    roundup(max_order_nr_pages, BITPERBYTE)) {
+		unsigned long bufsize;
+
+		if (max_block_size > info->bufsize_cyclic) {
+			MSG("WARNING: some free pages are not filtered.\n");
+			return;
+		}
+
+		bufsize = info->bufsize_cyclic;
+		info->bufsize_cyclic = round(bufsize, max_block_size);
+
+		MSG("cyclic buffer size has been changed: %lu => %lu\n",
+		    bufsize, info->bufsize_cyclic);
+	}
+}
+
+/*
  * For the kernel versions from v2.6.15 to v2.6.17.
  */
 static int
@@ -4013,8 +4072,18 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		    && info->page_is_buddy(flags, _mapcount, private, _count)) {
 			int i;
 
-			for (i = 0; i < (1 << private); ++i)
+			for (i = 0; i < (1 << private); ++i) {
+				/*
+				 * According to combination of
+				 * MAX_ORDER and size of cyclic
+				 * buffer, this clearing bit operation
+				 * can overrun the cyclic buffer.
+				 *
+				 * See check_cyclic_buffer_overrun()
+				 * for the detail.
+				 */
 				clear_bit_on_2nd_bitmap_for_kernel(pfn + i);
+			}
 			pfn_free += i;
 		}
 		/*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
