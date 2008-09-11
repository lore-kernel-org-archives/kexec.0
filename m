Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kdo1P-0005g8-Pd
	for kexec@lists.infradead.org; Thu, 11 Sep 2008 15:23:52 +0000
Date: Thu, 11 Sep 2008 17:23:47 +0200
Subject: [patch] [PATCH] Fix memory leaks
Message-ID: <20080911152347.GA13656@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
From: bwalle@suse.de (Bernhard Walle)
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
To: oomichi@mxs.nes.nec.co.jp
Cc: kexec@lists.infradead.org

This memory leaks appear in valigrind run:

    makedumpfile Completed.
    ==6024== 
    ==6024== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 2 from 1)
    ==6024== malloc/free: in use at exit: 8,838 bytes in 5 blocks.
    ==6024== malloc/free: 80 allocs, 75 frees, 192,858 bytes allocated.
    ==6024== For counts of detected errors, rerun with: -v
    ==6024== searching for pointers to 5 not-freed blocks.
    ==6024== checked 70,864 bytes.
    ==6024== 
    ==6024== 
    ==6024== 22 bytes in 1 blocks are definitely lost in loss record 2 of 5
    ==6024==    at 0x4C2560E: malloc (in /usr/lib64/valgrind/amd64-linux/vgpreload_memcheck.so)
    ==6024==    by 0x416955: initial (makedumpfile.c:3318)
    ==6024==    by 0x418954: create_dumpfile (makedumpfile.c:6000)
    ==6024==    by 0x4191AA: main (makedumpfile.c:6299)
    ==6024== 
    ==6024== 
    ==6024== 4,120 bytes in 1 blocks are definitely lost in loss record 4 of 5
    ==6024==    at 0x4C2560E: malloc (in /usr/lib64/valgrind/amd64-linux/vgpreload_memcheck.so)
    ==6024==    by 0x409F72: prepare_dump_bitmap (makedumpfile.c:4338)
    ==6024==    by 0x4187D8: create_dump_bitmap (makedumpfile.c:4361)
    ==6024==    by 0x41886C: create_dumpfile (makedumpfile.c:6005)
    ==6024==    by 0x4191AA: main (makedumpfile.c:6299)
    ==6024== 
    ==6024== 
    ==6024== 4,120 bytes in 1 blocks are definitely lost in loss record 5 of 5
    ==6024==    at 0x4C2560E: malloc (in /usr/lib64/valgrind/amd64-linux/vgpreload_memcheck.so)
    ==6024==    by 0x409F51: prepare_dump_bitmap (makedumpfile.c:4333)
    ==6024==    by 0x4187D8: create_dump_bitmap (makedumpfile.c:4361)
    ==6024==    by 0x41886C: create_dumpfile (makedumpfile.c:6005)
    ==6024==    by 0x4191AA: main (makedumpfile.c:6299)
    ==6024== 
    ==6024== LEAK SUMMARY:
    ==6024==    definitely lost: 8,262 bytes in 3 blocks.
    ==6024==      possibly lost: 0 bytes in 0 blocks.
    ==6024==    still reachable: 576 bytes in 2 blocks.
    ==6024==         suppressed: 0 bytes in 0 blocks.
    ==6024== Reachable blocks (those to which a pointer was found) are not shown.
    ==6024== To see them, rerun with: --leak-check=full --show-reachable=yes

Although it's not strictly necessary to free memory at the end of program run since
it gets freed automatically, it still makes sense to have a clean valgrind run to be
able to check the program for "real" memory leaks with valgrind.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 makedumpfile.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5268,6 +5268,14 @@ close_dump_bitmap(void)
 		ERRMSG("Can't close the bitmap file(%s). %s\n",
 		    info->name_bitmap, strerror(errno));
 	free(info->name_bitmap);
+
+	/* free 1st bitmap */
+	free(info->bitmap1);
+	info->bitmap1 = NULL;
+
+	/* free 2nd bitmap */
+	free(info->bitmap2);
+	info->bitmap2 = NULL;
 }
 
 void
@@ -5332,6 +5340,10 @@ close_files_for_creating_dumpfile(void)
 	else if (info->dump_level > DL_EXCLUDE_ZERO)
 		close_kernel_file();
 
+	/* free name for vmcoreinfo */
+	free(info->name_vmcoreinfo);
+	info->name_vmcoreinfo = NULL;
+
 	close_dump_memory();
 
 	close_dump_file();

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
