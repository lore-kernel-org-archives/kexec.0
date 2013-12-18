Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vt52h-0007YH-9i
 for kexec@lists.infradead.org; Wed, 18 Dec 2013 00:31:17 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.195])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id rBI0UmNf012867
 for <kexec@lists.infradead.org>; Wed, 18 Dec 2013 09:30:48 +0900 (JST)
Received: from mailsv3.nec.co.jp (imss62.nec.co.jp [10.7.69.157]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id rBI0UmZ02838 for <kexec@lists.infradead.org>;
 Wed, 18 Dec 2013 09:30:48 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id rBI0Um3s006081
 for <kexec@lists.infradead.org>; Wed, 18 Dec 2013 09:30:48 +0900 (JST)
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: makedumpfile-1.5.5: --dump-dmesg is available also for kernel 3.11.
Date: Wed, 18 Dec 2013 00:29:26 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971D3673@BPXM01GP.gisp.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

makedumpfile version 1.5.5 is released.
Your comments/patches are welcome.

NOTE:
1. I was going to merge the patch set below to address mmap() issues
   as I said in this thread:
   http://lists.infradead.org/pipermail/kexec/2013-November/010354.html

    1. Fix the fractional page issue
    2. Introduce fall back path
    3. Add --non-mmap option

  However, the first one is under testing now and more time is needed,
  so I decided to postpone it to v1.5.6. I think it's OK because
  v1.5.5 can avoid the fractional page issue with the second patch.

2. At first, the supported kernel will be updated to 3.12, but I
   found an issue while testing for v1.5.5, which seems that the page
   filtering works wrongly on kernel 3.12. I couldn't investigate this
   yet and it will take some time to finish it.
   Therefore, the latest supported kernel version is 3.11 in v1.5.5.

Changelog:
o New feature
    - [PATCH v2] Add support to module data structures. (by Aruna Balakrishnaiah) 7dc6cb6
    - [PATCH] makedumpfile header to show LZO/snappy/zlib. (by Dave Anderson) 3205967
    - [PATCH] Add --non-mmap option to disable mmap() manually. (by Atsushi Kumagai) a895dc8

o Bugfix
    - [PATCH v3 1/7] xen: Improve calculation of beginning of virtual address space. 
      (by Daniel Kiper) 8c7c55e
    - [PATCH v3 2/7] elf: Properly check buf size in get_pt_note_info(). (by Daniel Kiper) fea1406
    - [PATCH v3 3/7] xen: Take into account new frame table address since Xen 4.3. 
      (by Daniel Kiper) f20f281
    - [PATCH v3 4/7] xen: Enforce page size when it could not be established by other means.
      (by Daniel Kiper) f40c0fe
    - [PATCH v2] calculate cyclic buffer size according to info->num_dumpfile. (by Maxim Uvarov) 3f1ec1e
    - [PATCH] Add vmap_area_list definition for ppc/ppc64. (by Baoquan He) 150b58e
    - [PATCH v2] dump-dmesg: Understand >= v3.11-rc4 dmesg. (by Lubomir Rintel) a01b663
    - [PATCH v5] Support to filter dump for kernels that use CONFIG_SPARSEMEM_VMEMMAP. 
      (by Hari Bathini) bcdba92
    - [PATCH v2 1/3] Add cache_init() call to initial_xen(). (by Daniel Kiper) 4225ee8
    - [PATCH v2 2/3] Disable cyclic mode for every Xen crash dump. (by Daniel Kiper) 587cc88
    - [PATCH v2 3/3] Move cyclic mode check from initial() to initial_xen(). (by Daniel Kiper) 00ec61f
    - [PATCH] Update pfn_cyclic when the cyclic buffer size is corrected. (by Atsushi Kumagai) a785fa7
    - [PATCH] Use divideup() to calculate maximum required bitmap size. (by HATAYAMA Daisuke) f8c8218
    - [PATCH 1/2] sadump: correct buffer size for GUID EFI text representation. 
      (by HATAYAMA Daisuke) 1437b20
    - [PATCH 2/2] sadump: convert the first three fields of EFI GUID from little-endian into big-endian.
      (by HATAYAMA Daisuke) 6f9b722
    - [PATCH 1/2] cache: Allocate buffers at initialization to detect malloc() failure. 
      (by HATAYAMA Daisuke) 92563d7
    - [PATCH 2/2] cache: Reuse entry in pending list. (by HATAYAMA Daisuke) e23dc0a
    - [PATCH] Fall back to read() when mmap() fails. (by Atsushi Kumagai) 7c770ed
    - [PATCH] Add a existence check of symbols for --dump-dmesg. (by Atsushi Kumagai) e1b2913
    - [PATCH] Fix the installation directory in spec file. (by Atsushi Kumagai) 9ccac12

o Cleanup
    - [PATCH v3 5/7] Do not break progress messages. (by Daniel Kiper) 74da476
    - [PATCH v3 6/7] Mute some compiler warnings. (by Daniel Kiper) c16532e
    - [PATCH v3 7/7] Use elf_getshdrstrndx() instead of elf_getshstrndx(). (by Daniel Kiper) 16ae98a
    - [PATCH 1/2] Assign non-printable value as short options. (by Baoquan He) bd67c1d
    - [PATCH 2/2] Add help and man message for '--help'. (by Baoquan He) eb708ce
    - [PATCH v2] "make install" assumes directories exist. (by Nick Bartos) b0e1f0e
    - [PATCH] Cleanup: Mute some warnings about snappy. (by Atsushi Kumagai) f7a5099
    - [PATCH] Cleanup: Add a comment for unused diskdump flag. (by Atsushi Kumagai) 1623a05
    - [PATCH v2] Improve progress information for huge memory system. (by HATAYAMA Daisuke) 20ecc08
    - [PATCH v2 1/2] Use memset() to improve the 1st bitmap initialization performance.
      (by HATAYAMA Daisuke) 72d9d06
    - [PATCH v2 2/2] Write out a whole part of the 1st bitmap before entering cyclic process. 
      (by HATAYAMA Daisuke) 363d5
    - [PATCH] Enhance bitmap writting function in reassemble mode. (by Jingbai Ma) 6f6eb40

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
