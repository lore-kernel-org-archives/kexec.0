Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hp02A-0001OM-0x
	for kexec@lists.infradead.org; Fri, 18 May 2007 06:50:09 -0400
Date: Fri, 18 May 2007 12:50:04 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] [makedumpfile] Fix problem with `half' pages
Message-ID: <20070518105003.GE16227@suse.de>
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

We have a system here with following memory map:

/proc/iomem:
4ffe14000-4ffe7ffff : reserved
4ffe80000-4fffb5fff : System RAM
4fffb6000-4ffffffff : reserved

max_pfn = 1310720

In that case, the last page of the "System RAM" is not full in 16K page size
configuration. That leads to an error in makedumpfile when it checks if that's
a zero page. It's because it tries to read the whole page and the read()
fails because it's after the end of the dump file.

That patch fixes this problem.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 makedumpfile.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3155,6 +3155,7 @@ create_dump_bitmap(struct DumpInfo *info
 		for (; pfn < mmd->pfn_end;
 		    pfn++, mem_map += SIZE(page),
 		    paddr += info->page_size) {
+			int page_mem_size = info->page_size;
 
 			if ((pfn != 0) && (pfn%PFN_BUFBITMAP) == 0) {
 				/*
@@ -3190,6 +3191,14 @@ create_dump_bitmap(struct DumpInfo *info
 				val = 0;
 
 			/*
+			 * check for pages that are not complete pages and
+			 * decrease the page size here
+			 */
+			if (val == 1 && !is_in_segs(info, paddr + info->page_size))
+				while (!is_in_segs(info, paddr + page_mem_size))
+					page_mem_size--;
+
+			/*
 			 * Set the 1st-bitmap.
 			 *  val  1: not memory hole
 			 *       0: memory hole
@@ -3223,13 +3232,13 @@ create_dump_bitmap(struct DumpInfo *info
 					    info->name_memory, strerror(errno));
 					goto out;
 				}
-				if (read(info->fd_memory, buf, info->page_size)
-				    != info->page_size) {
+				if (read(info->fd_memory, buf, page_mem_size)
+				    != page_mem_size) {
 					ERRMSG("Can't read the dump memory(%s). %s\n",
 					    info->name_memory, strerror(errno));
 					goto out;
 				}
-				if (is_zero_page(buf, info->page_size))
+				if (is_zero_page(buf, page_mem_size))
 					val = 0;
 			}
 			if ((info->dump_level <= DL_EXCLUDE_ZERO)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
