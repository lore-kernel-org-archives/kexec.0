Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WckWK-0002md-3M
 for kexec@lists.infradead.org; Tue, 22 Apr 2014 23:54:37 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.193])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id s3MNs99x023300
 for <kexec@lists.infradead.org>; Wed, 23 Apr 2014 08:54:09 +0900 (JST)
Received: from mailsv4.nec.co.jp (imss61.nec.co.jp [10.7.69.156]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id s3MNs8e29150 for <kexec@lists.infradead.org>;
 Wed, 23 Apr 2014 08:54:08 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id s3MNs7nD018445
 for <kexec@lists.infradead.org>; Wed, 23 Apr 2014 08:54:08 +0900 (JST)
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: makedumpfile-1.5.6: Support linux-3.12 and linux-3.13.
Date: Tue, 22 Apr 2014 23:50:50 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9720A768@BPXM01GP.gisp.nec.co.jp>
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

makedumpfile version 1.5.6 is released.
Your comments/patches are welcome.

Main new feature:
o Support new kernels
 - The supported kernel is updated to 3.13 in this version.

Changelog:
o New feature
    - [PATCH] Add -p references where appropriate in "--help" output. (by Dave Anderson) 84b8a57
    - [PATCH v2] -v shows if lzo or snappy support enabled or not. (by WANG Chao) ab9908f
    - [PATCH] eppic: Add support to module data structures. (by Aravinda Prasad) f77be84
    - [PATCH 01/11] eppic: Scrub executable name for each user process. (by Aruna Balakrishnaiah) e9aa0a3
    - [PATCH 02/11] eppic: Scrub filenames of cached dentries. (by Aruna Balakrishnaiah) a1ca1c6
    - [PATCH 03/11] eppic: Scrub all entries in the keyring. (by Aruna Balakrishnaiah) cf59764
    - [PATCH 04/11] eppic: Clear the message data of all ap_bus requests. (by Aruna Balakrishnaiah) fa46fb5
    - [PATCH 05/11] eppic: Scrub data in tcp socket buffers. (by Aruna Balakrishnaiah) 38be4d8
    - [PATCH 06/11] eppic: Scrub data of udp socket buffers. (by Aruna Balakrishnaiah) d3ad960
    - [PATCH 07/11] eppic: Scrub data of unix socket buffers. (by Aruna Balakrishnaiah) 2fb6959
    - [PATCH 08/11] eppic: Scrub socket buffers of guest network I/O. (by Aruna Balakrishnaiah) 6790dff
    - [PATCH 09/11] eppic: Scrub buffers involved in guest block I/O. (by Aruna Balakrishnaiah) 12491a5
    - [PATCH 10/11] eppic: Add README for eppic scripts. (by Aruna Balakrishnaiah) 7aa4862
    - [PATCH 11/11] eppic: Install sample eppic scripts. (by Aruna Balakrishnaiah) 41e1ccf
    - [PATCH v2 2/3] build: Honor VPATH to support out-of-tree builds. (by Simon Kagstrom) 1d087e9
    - [PATCH v2 2/2] Get Dom0 max_pfn using pfn_mfn_frame_list if max_pfn unavailable. (by Petr Tesarik) bf1c602

o Bugfix
    - [PATCH] memset() in cyclic bitmap initialization introduce segment fault. (by WANG Chao) 4404368
    - [PATCH] --dump-dmesg characters printing fix. (by WANG Chao) c582335
    - [PATCH] Fix wrong report time for copying data. (by HATAYAMA Daisuke) 3c30771
    - [PATCH] eppic: Properly resolve structure members. (by Aravinda Prasad) d1bd9f9
    - [PATCH] Restrict the mmap range to avoid mmap() failure. (by Atsushi Kumagai) 2091af1
    - [PATCH 1/3] Fix string append in dump_log_entry(). (by Petr Tesarik) 4b2edb3
    - [PATCH 2/3] Prevent buffer overflow in dump_log_entry. (by Petr Tesarik) 6743671
    - [PATCH] Allow --dump-dmesg for Xen vmcores. (by Petr Tesarik) b94f0de
    - [PATCH v2 1/2] Fix zero checking of get_mm_sparsemem(). (by Michael Holzheu) e7f5e7e
    - [PATCH v2 2/2] Use max_pfn from mem_map array. (by Michael Holzheu) ebe2fa3
    - [PATCH v3] Fix a segment fault in dumping not aligned ELF segment. (by Jingbai Ma) 3961a44
    - [PATCH v2] Fix bitmap create for adjusted info->max_mapnr. (by Michael Holzheu) 5ec8eb6
    - [PATCH v2 1/2] Earlier initialization of dom0_mapnr. (by Petr Tesarik) 47f0078
    - [PATCH] Fix a div-by-zero problem. (by Wang Nan) 3828447
    - [PATCH] Inhibit predefined macros when cross building. (by Wang Nan) dc30853
    - [PATCH] Exclude small cycle regions wrongly. (by Atsushi Kumagai) e9177cd
    - [PATCH] eppic: Do not scrub buffer length if length is zero. (by Aruna Balakrishnaiah) ba8d62a
    - [PATCH] eppic: makedumpfile fails to recognise between global symbol and structure of the same name.
      (by Aruna Balakrishnaiah) 5198f32
    - [PATCH] Fix too much buffer allocation for ELF format. (by Atsushi Kumagai) 70632dc
    - [PATCH v3] Fix a segmentation fault when physical address exceeds 8TB boundary. (by Jingbai Ma) 881708b

o Cleanup
    - [PATCH v3 1/3] Introduce struct cycle to store the cyclic region. (by Baoquan He) cf8ff66
    - [PATCH v3 2/3] Use struct cycle to update cyclic region and clean up. (by Baoquan He) d89b23b
    - [PATCH v3 3/3] Remove member variables representing cyclic pfn region in struct DumpInfo. (by Baoquan He) 7a3d4a1
    - [PATCH v2] Optimize is_zero_page. (by Marc Milgram) a4a4c74
    - [PATCH v2 1/3] build: Derive objects from source files. (by Simon Kagstrom) 4ad78e5
    - [PATCH v2 3/3] build: Rename generic-sounding SRC -> SRC_BASE. (by Simon Kagstrom) 97e19f9
    - [PATCH 3/3] Optimize one-character output in dump_log_entry. (by Petr Tesarik) b367b67
    - [PATCH] Cleanup: Add a comment for the magic number in dump_log_entry(). (by Atsushi Kumagai) bc90c02
    - [PATCH v2] Cleanup: Reduce unnecessary memory copy. (by Jingbai Ma) 4b6a00a
    - [PATCH] Add a warning to detect wrong cycle iteration. (by Atsushi Kumagai) 6e2643f


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
