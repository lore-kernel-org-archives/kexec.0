Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KFgod-0002kz-45
	for kexec@lists.infradead.org; Mon, 07 Jul 2008 02:50:59 +0000
Message-Id: <48718477.3020406@mxs.nes.nec.co.jp>
Date: Mon, 07 Jul 2008 11:50:31 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] Use progress bar also for bitmap creation
References: <20080626143721.GA12486@suse.de>
	<4864B595.8040205@mxs.nes.nec.co.jp>
In-Reply-To: <4864B595.8040205@mxs.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1331565372=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: jlan@sgi.com, kexec@lists.infradead.org

--===============1331565372==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Ken'ichi Ohmichi wrote:
> Hi Bernhard,
> 
> Thank you for your patch.
> I like this idea :-)
> 
> I am busy now, and I will consider the patch well the next week.

Thank you for the patch, and sorry for my late response.

I added the progress bar for excluding free pages to your patch.
Could you please check the attached patch ?
If there is no problem in the attached patch, I will release the
next release with this patch.


Thanks
Ken'ichi Ohmichi


Signed-off-by: Bernhard Walle <bwalle@suse.de>
Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
---
diff -puN makedumpfile.org/makedumpfile.c makedumpfile/makedumpfile.c
--- makedumpfile.org/makedumpfile.c	2008-07-07 10:48:18.000000000 +0900
+++ makedumpfile/makedumpfile.c	2008-07-07 11:30:04.000000000 +0900
@@ -32,6 +32,18 @@ int message_level;
 /*
  * Forward declarations
  */
+void print_progress(const char 		*msg,
+		    unsigned long 	current,
+		    unsigned long 	end);
+
+/*
+ * Message texts
+ */
+#define PROGRESS_COPY   	"Copying data"
+#define PROGRESS_UNN_PAGES 	"Excluding unnecessary pages"
+#define PROGRESS_FREE_PAGES 	"Excluding free pages"
+#define PROGRESS_ZERO_PAGES 	"Excluding zero pages"
+#define PROGRESS_MAXLEN		"35"
 
 /*
  * The numbers of the excluded pages
@@ -3917,6 +3929,8 @@ _exclude_free_page()
 	}
 	for (num_nodes = 1; num_nodes <= vt.numnodes; num_nodes++) {
 
+		print_progress(PROGRESS_FREE_PAGES, num_nodes - 1, vt.numnodes);
+
 		node_zones = pgdat + OFFSET(pglist_data.node_zones);
 
 		if (!readmem(VADDR, pgdat + OFFSET(pglist_data.nr_zones),
@@ -3948,6 +3962,12 @@ _exclude_free_page()
 			}
 		}
 	}
+
+	/*
+	 * print [100 %]
+	 */
+	print_progress(PROGRESS_FREE_PAGES, vt.numnodes, vt.numnodes);
+
 	return TRUE;
 }
 
@@ -4062,6 +4082,9 @@ exclude_zero_pages()
 	}
 	for (pfn = paddr = 0; pfn < info->max_mapnr;
 	    pfn++, paddr += info->page_size) {
+
+		print_progress(PROGRESS_ZERO_PAGES, pfn, info->max_mapnr);
+
 		if (!is_in_segs(paddr))
 			continue;
 
@@ -4073,6 +4096,12 @@ exclude_zero_pages()
 			pfn_zero++;
 		}
 	}
+
+	/*
+	 * print [100 %]
+	 */
+	print_progress(PROGRESS_ZERO_PAGES, info->max_mapnr, info->max_mapnr);
+
 	ret = TRUE;
 out:
 	if (buf != NULL)
@@ -4100,6 +4129,8 @@ exclude_unnecessary_pages()
 		goto out;
 	}
 	for (mm = 0; mm < info->num_mem_map; mm++) {
+		print_progress(PROGRESS_UNN_PAGES, mm, info->num_mem_map);
+
 		mmd = &info->mem_map_data[mm];
 		pfn   = mmd->pfn_start;
 		paddr = pfn*info->page_size;
@@ -4160,6 +4191,12 @@ exclude_unnecessary_pages()
 			}
 		}
 	}
+
+	/*
+	 * print [100 %]
+	 */
+	print_progress(PROGRESS_UNN_PAGES, info->num_mem_map, info->num_mem_map);
+
 	if (info->dump_level & DL_EXCLUDE_FREE)
 		if (!exclude_free_page())
 			goto out;
@@ -4670,7 +4707,7 @@ write_kdump_header()
 }
 
 void
-print_progress(unsigned long current, unsigned long end)
+print_progress(const char *msg, unsigned long current, unsigned long end)
 {
 	int progress;
 	time_t tm;
@@ -4686,7 +4723,7 @@ print_progress(unsigned long current, un
 		progress = 100;
 
 	PROGRESS_MSG("\r");
-	PROGRESS_MSG("[%3d %%]", progress);
+	PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%] ", msg, progress);
 }
 
 int
@@ -4912,7 +4949,7 @@ write_elf_pages()
 
 			while (bufsz_remain > 0) {
 				if ((num_dumped % per) == 0)
-					print_progress(num_dumped, num_dumpable);
+					print_progress(PROGRESS_COPY, num_dumped, num_dumpable);
 
 				if (bufsz_remain >= page_size)
 					bufsz_write = page_size;
@@ -5009,7 +5046,7 @@ write_elf_pages()
 
 		while (bufsz_remain > 0) {
 			if ((num_dumped % per) == 0)
-				print_progress(num_dumped, num_dumpable);
+				print_progress(PROGRESS_COPY, num_dumped, num_dumpable);
 
 			if (bufsz_remain >= page_size)
 				bufsz_write = page_size;
@@ -5038,7 +5075,7 @@ write_elf_pages()
 	if (!write_cache_bufsz(&cd_seg))
 		goto out;
 
-	print_progress(num_dumpable, num_dumpable);
+	print_progress(PROGRESS_COPY, num_dumpable, num_dumpable);
 	PROGRESS_MSG("\n");
 
 	ret = TRUE;
@@ -5247,7 +5284,7 @@ write_kdump_pages()
 	for (pfn = 0; pfn < info->max_mapnr; pfn++) {
 
 		if ((num_dumped % per) == 0)
-			print_progress(num_dumped, num_dumpable);
+			print_progress(PROGRESS_COPY, num_dumped, num_dumpable);
 
 		if ((pfn % PFN_BUFBITMAP) == 0) {
 			if (info->len_bitmap - bm2.offset < BUFSIZE_BITMAP)
@@ -5325,7 +5362,7 @@ write_kdump_pages()
 	/*
 	 * Print the progress of the end.
 	 */
-	print_progress(num_dumpable, num_dumpable);
+	print_progress(PROGRESS_COPY, num_dumpable, num_dumpable);
 	PROGRESS_MSG("\n");
 
 	ret = TRUE;


--===============1331565372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1331565372==--
