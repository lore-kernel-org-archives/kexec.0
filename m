Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZrKID-0004Bp-IE
 for kexec@lists.infradead.org; Wed, 28 Oct 2015 06:33:06 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.197])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id t9S6WhxO023817
 for <kexec@lists.infradead.org>; Wed, 28 Oct 2015 15:32:43 +0900 (JST)
Received: from mailsv4.nec.co.jp (imss61.nec.co.jp [10.7.69.156]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id t9S6Wgg25482 for <kexec@lists.infradead.org>;
 Wed, 28 Oct 2015 15:32:42 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id t9S6Wgqe020925
 for <kexec@lists.infradead.org>; Wed, 28 Oct 2015 15:32:42 +0900 (JST)
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: makedumpfile-1.5.9: Introduce parallel compression processing.
Date: Wed, 28 Oct 2015 06:31:50 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DF7CC4@BPXM01GP.gisp.nec.co.jp>
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

makedumpfile version 1.5.9 is released.
Your comments/patches are welcome.

Main new feature:
o Parallel compression
 - Add the new option "--num-threads" to enable parallel compression
   for faster processing. This option intends parallel compression
   while --split intends parallel i/o, they try to solve different
   bottlenecks.

o Change the way to choose the non-cyclic mode
 - Add the new option "--work-dir" to specify the directory used to
   store the bitmap. This is the alternative to the combination of
   --non-cyclic and TMPDIR.

o Support new kernels
 - The supported kernel is updated to 4.1 in this version.
   At first I'm going to extend the supported version to 4.2, but
   I found an issue that makedumpfile seems to exclude necessary pages
   by mistake on linux 4.2. When crash-7.1.3 reads that filtered dump file,
   the following message is shown.

      crash: page excluded: kernel virtual address: f3fe0000  type: "fill_task_struct"

   This will be fixed in the next version.

Changelog:
o New feature
    - [PATCH] Support ARM64. (by Pratyush Anand) 94d47d1
    - [PATCH 1/2] Enable compressed dump formats for Xen. (by Petr Tesarik) 349a0ed
    - [PATCH 2/2] Remove notes about ELF being the only available format for Xen dumps.
      (by Petr Tesarik) 5cab480
    - [PATCH v5 01/10] Add readpage_kdump_compressed_parallel. (by Qiao Nuohan) 5fab021
    - [PATCH v5 02/10] Add mappage_elf_parallel. (by Qiao Nuohan) edca232
    - [PATCH v5 03/10] Add readpage_elf_parallel. (by Qiao Nuohan) 7f15b41
    - [PATCH v5 04/10] Add read_pfn_parallel. (by Qiao Nuohan) a7243fe
    - [PATCH v5 05/10] Add function to initial bitmap for parallel use. (by Qiao Nuohan) 56a6bc4
    - [PATCH v5 06/10] Add filter_data_buffer_parallel. (by Qiao Nuohan) 2a7cb9f
    - [PATCH v5 07/10] Add write_kdump_pages_parallel to allow parallel process. (by Qiao Nuohan) c2595d9
    - [PATCH v5 08/10] Initial and free data used for parallel process. (by Qiao Nuohan) 4538848
    - [PATCH v5 09/10] Make makedumpfile available to read and compress pages parallelly.
      (by Qiao Nuohan) b265102
    - [PATCH v5 10/10] Add usage and manual about multiple threads process. (by Qiao Nuohan) b18a8a6

o Bugfix
    - [PATCH] Correct vmap_area_list support for i386 and ppc32. (by Atsushi Kumagai) 4194d7b
    - [PATCH] Free pages aren't removed in non-cyclic mode. (by Atsushi Kumagai) d64cf7f
    - [PATCH v2] Fix a bug in generating incomplete kdump core. (by Zhou Wenjian) 9cee495
    - [PATCH] Remove the double free of sph. (by Chao Fan) 72dec41
    - [PATCH 1/2] sadump: Change bit order. (by HATAYAMA Daisuke) 5f15256
    - [PATCH 2/2] sadump: Perform explicit zero page filtering. (by HATAYAMA Daisuke) 19b3a91

o Cleanup
    - [PATCH 01/13] Organize bitmap structure for cyclic logic. (by Atsushi Kumagai) 5fc24bf
    - [PATCH 02/13] Add option to specify working directory for the bitmap. (by Atsushi Kumagai) 5c5a8b8
    - [PATCH 03/13] Integrate the entry point of is_dumpable(). (by Atsushi Kumagai) 5c8c680
    - [PATCH 04/13] Integrate the main logic of writing kdump file. (by Atsushi Kumagai) d18796d
    - [PATCH 05/13] Communalize the function for creating 1st bitmap. (by Atsushi Kumagai) b00a7b0
    - [PATCH 06/13] Remove the old logic of writing kdump pages. (by Atsushi Kumagai) 4d55542
    - [PATCH 07/13] Integrate filtering process for ELF path. (by Atsushi Kumagai) 679a818
    - [PATCH 08/13] Remove the old logic of writing ELF pages. (by Atsushi Kumagai) 672354b
    - [PATCH 09/13] Adjust --mem-usage path to the new code. (by Atsushi Kumagai) 57153b0
    - [PATCH 10/13] Adjust --split/--reassemble path to the new code. (by Atsushi Kumagai) 95435de
    - [PATCH 11/13] Adjust refiltering path to the new code. (by Atsushi Kumagai) c7fb41c
    - [PATCH 12/13] Adjust sadump path to the new code. (by Atsushi Kumagai) edd2bf2
    - [PATCH 13/13] Remove --non-cyclic option. (by Atsushi Kumagai) a117ae9
    - [PATCH] Optimise the function reserve_diskspace. (by Zhou Wenjian) 3605073
    - [PATCH v2] Add description of pages lost by ENOSPACE in IMPLEMENTATION. (by Zhou Wenjian) 0e20f33
    - [PATCH 1/2] Enable compressed dump formats for Xen. (by Petr Tesarik) 349a0ed
    - [PATCH 2/2] Remove notes about ELF being the only available format for Xen dumps.
      (by Petr Tesarik) 5cab480
    - [PATCH v2] Code changes to satisfy the coverity scan. (by Chao Fan) 0c65e38
    - [PATCH] Improve performance for parallel compression with zlib. (by Atsushi Kumagai) 3ef6629

Explanation of makedumpfile:
  To shorten the size of the dumpfile and the time of creating the
  dumpfile, makedumpfile copies only the necessary pages for analysis
  to the dumpfile from /proc/vmcore. You can specify the kind of
  unnecessary pages with dump_level. If you want to shorten the size
  further, enable the compression of the page data.

Download:
  You can download the latest makedumpfile from the following URL.
  Details of the change are written on the git page of the following site.
  https://sourceforge.net/projects/makedumpfile/

Method of installation:
  You can compile the makedumpfile command as follows;
  1. "tar -zxvf makedumpfile-x.y.z.tar.gz"
  2. "cd makedumpfile-x.y.z"
  3. "make; make install"

Usage:
  makedumpfile [-c] [-E] [-d dump_level] [-x vmlinux] dump_mem dump_file

Example:
  If you want to exclude pages filled by zero, cache pages, user pages
  and free pages and to enable compression, please execute the following
  command.	

  # makedumpfile -c -d 31 /proc/vmcore dumpfile


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
