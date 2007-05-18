Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hp02M-0001OZ-AE
	for kexec@lists.infradead.org; Fri, 18 May 2007 06:50:32 -0400
Date: Fri, 18 May 2007 12:50:16 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] [makedumpfile] Add `holes' in bitmap
Message-ID: <20070518105016.GG16227@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

On a big SGI machine with more than one node I experienced the problem that the
remaining buffer was larger than PFN_BUFBITMAP which resulted in an error.

I think the cause is that the holes must be filled in the bitmap. This patch
implements this.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 makedumpfile.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3142,11 +3142,34 @@ create_dump_bitmap(struct DumpInfo *info
 	}
 
 	for (mm = 0; mm < info->num_mem_map; mm++) {
+		unsigned long long next_pfn_start;
+
 		mmd = &info->mem_map_data[mm];
 		pfn   = mmd->pfn_start;
 		paddr = pfn*info->page_size;
 		mem_map = mmd->mem_map;
 
+		/*
+		 * fill with zeros if start != 0
+		 */
+		if (mm == 0 && pfn != 0) {
+			int i;
+
+			for (;i < pfn; i++) {
+				set_bitmap(bm1.buf, i % BUFSIZE_BITMAP, 0);
+				set_bitmap(bm2.buf, i % BUFSIZE_BITMAP, 0);
+
+				if ((i % PFN_BUFBITMAP) == 0) {
+					bm1.buf_size = BUFSIZE_BITMAP;
+					bm2.buf_size = BUFSIZE_BITMAP;
+					if (!write_cache_bufsz(&bm1))
+						goto out;
+					if (!write_cache_bufsz(&bm2))
+						goto out;
+				}
+			}
+		}
+
 		if (mem_map == NOT_MEMMAP_ADDR)
 			not_found_mem_map = TRUE;
 		else
@@ -3291,6 +3314,34 @@ create_dump_bitmap(struct DumpInfo *info
 			 */
 			set_bitmap(bm2.buf, pfn%PFN_BUFBITMAP, val);
 		}
+
+		/*
+		 * fill the space between the memory maps with zeros
+		 */
+
+		if (mm != (info->num_mem_map - 1))
+			next_pfn_start = info->mem_map_data[mm+1].pfn_start;
+		else
+			next_pfn_start = info->max_mapnr;
+
+		for (; pfn < next_pfn_start; pfn++) {
+
+			/*
+			 * flush to disk
+			 */
+			if ((pfn % PFN_BUFBITMAP) == 0) {
+
+				bm1.buf_size = BUFSIZE_BITMAP;
+				bm2.buf_size = BUFSIZE_BITMAP;
+				if (!write_cache_bufsz(&bm1))
+					goto out;
+				if (!write_cache_bufsz(&bm2))
+					goto out;
+			}
+
+			set_bitmap(bm1.buf, pfn%PFN_BUFBITMAP, 0);
+			set_bitmap(bm2.buf, pfn%PFN_BUFBITMAP, 0);
+		}
 	}
 
 	/*

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
