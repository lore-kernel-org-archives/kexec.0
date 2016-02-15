Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aV9eA-00046O-8w
 for kexec@lists.infradead.org; Mon, 15 Feb 2016 03:16:23 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: Regression in makedumpfile-1.5.9
Date: Mon, 15 Feb 2016 03:11:21 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E1EC16@BPXM01GP.gisp.nec.co.jp>
References: <20160209183656.355f7c8d@hananiah.suse.cz>
In-Reply-To: <20160209183656.355f7c8d@hananiah.suse.cz>
Content-Language: ja-JP
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Petr Tesarik <ptesarik@suse.cz>
Cc: kexec mailing list <kexec@lists.infradead.org>

Hello Petr,

>Hello Kumagai,
>
>while testing my changes for ELF file reading, I found a regression in
>makedumpfile. It now segfaults on me when creating an ELF file. I
>bisected the regression to this commit:
>
>commit d18796d090623d18f46c8dc608dcad9960fbbe9b
>Author: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
>Date:   Mon May 11 14:25:47 2015 +0900
>
>    [PATCH 04/13] Integrate the main logic of writing kdump file.
>
>I run my command as:
>
>    makedumpfile -E -d31 vmcore-reloc.elf vmcore-reloc.d31.elf
>
>This is the backtrace:
>
>#0  memset () at ../sysdeps/x86_64/memset.S:80
>#1  0x00000000004328b4 in initialize_bitmap (bitmap=0x7fffffffda30) at makedumpfile.c:3389
>#2  0x00000000004328f4 in initialize_2nd_bitmap (bitmap=0x7fffffffda30) at makedumpfile.c:3403
>#3  0x000000000043765c in exclude_zero_pages () at makedumpfile.c:4778
>#4  0x0000000000000000 in ?? ()
>
>And this is the output from valgrind:
>
>==5092== Conditional jump or move depends on uninitialised value(s)
>==5092==    at 0x4C2F8EC: memset (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
>==5092==    by 0x4328B3: initialize_bitmap (makedumpfile.c:3389)
>==5092==    by 0x4328F3: initialize_2nd_bitmap (makedumpfile.c:3403)
>==5092==    by 0x43765B: exclude_zero_pages (makedumpfile.c:4778)
>==5092==    by 0x438F63: create_2nd_bitmap (makedumpfile.c:5277)
>==5092==    by 0x43B2EE: get_num_dumpable_cyclic (makedumpfile.c:6087)
>==5092==    by 0x439666: create_dump_bitmap (makedumpfile.c:5417)
>==5092==    by 0x4440BF: create_dumpfile (makedumpfile.c:8700)
>==5092==    by 0x4499FD: main (makedumpfile.c:10103)
>==5092==
>==5092== Use of uninitialised value of size 8
>==5092==    at 0x4C2F957: memset (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
>==5092==    by 0x4328B3: initialize_bitmap (makedumpfile.c:3389)
>==5092==    by 0x4328F3: initialize_2nd_bitmap (makedumpfile.c:3403)
>==5092==    by 0x43765B: exclude_zero_pages (makedumpfile.c:4778)
>==5092==    by 0x438F63: create_2nd_bitmap (makedumpfile.c:5277)
>==5092==    by 0x43B2EE: get_num_dumpable_cyclic (makedumpfile.c:6087)
>==5092==    by 0x439666: create_dump_bitmap (makedumpfile.c:5417)
>==5092==    by 0x4440BF: create_dumpfile (makedumpfile.c:8700)
>==5092==    by 0x4499FD: main (makedumpfile.c:10103)
>==5092==
>==5092== Conditional jump or move depends on uninitialised value(s)
>==5092==    at 0x4C2F95D: memset (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
>==5092==    by 0x4328B3: initialize_bitmap (makedumpfile.c:3389)
>==5092==    by 0x4328F3: initialize_2nd_bitmap (makedumpfile.c:3403)
>==5092==    by 0x43765B: exclude_zero_pages (makedumpfile.c:4778)
>==5092==    by 0x438F63: create_2nd_bitmap (makedumpfile.c:5277)
>==5092==    by 0xFFEFFFA5F: ???
>==5092==    by 0xFFEFFFA5F: ???
>==5092==    by 0xFFEFFFA9F: ???
>==5092==    by 0x43B2EE: get_num_dumpable_cyclic (makedumpfile.c:6087)
>==5092==
>==5092== Invalid write of size 8
>==5092==    at 0x4C2F957: memset (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
>==5092==    by 0x4328B3: initialize_bitmap (makedumpfile.c:3389)
>==5092==    by 0x4328F3: initialize_2nd_bitmap (makedumpfile.c:3403)
>==5092==    by 0x43765B: exclude_zero_pages (makedumpfile.c:4778)
>==5092==  Address 0xfff001000 is not stack'd, malloc'd or (recently) free'd
>
>I think the bitmap is not initialized properly, but I have no time now
>to research further. Is the above information sufficient, or do you
>need more info from me?

You are right, the 2nd bitmap is released by mistake:

   6881 int
   6882 create_dump_bitmap(void)
   6883 {
   ...
   6891         if (info->flag_cyclic) {
   6892                 if (!prepare_bitmap2_buffer())
   6893                         goto out;
   6894
   6895                 info->num_dumpable = get_num_dumpable_cyclic();
   6896
   6897                 if (!info->flag_elf_dumpfile)
   6898                         free_bitmap2_buffer();      // should be kept in ELF case, but
   ...
   6917 out:
   6918         /* Should keep the buffer in the 1-cycle case. */
   6919         if (info->flag_cyclic)
   6920                 free_bitmap_buffer();               // released anytime
   6921
   6922         return ret;
   6923 }

Thanks for your report.

Thanks,
Atsushi Kumagai

--------------------------------------------------------------
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Date: Mon, 15 Feb 2016 10:52:05 +0900
Subject: [PATCH] Fix bitmap buffer release code.

For writing ELF dump, there is no need to release the bitmap
buffer during processing, but the current code does it by
mistake.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 makedumpfile.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index b802446..d464cce 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6915,8 +6915,7 @@ create_dump_bitmap(void)
 
 	ret = TRUE;
 out:
-	/* Should keep the buffer in the 1-cycle case. */
-	if (info->flag_cyclic)
+	if (ret == FALSE)
 		free_bitmap_buffer();
 
 	return ret;
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
