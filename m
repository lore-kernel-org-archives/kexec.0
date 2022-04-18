From: HAGIO KAZUHITO=?unknown-8bit?b?6JCp5bC+IOS4gOS7gQ==?= <k-hagio-ab@nec.com>
Date: Mon, 18 Apr 2022 05:03:20 +0000
Subject: [ANNOUNCE] makedumpfile 1.7.1
Message-ID: <TYYPR01MB6777A55BFBD97F68B48880BEDDF39@TYYPR01MB6777.jpnprd01.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi,

I'm pleased to announce the release of makedumpfile 1.7.1.
Thank you everyone for your help to maintain this tool.

Download:
The latest makedumpfile can be downloaded from the following URL.
  https://github.com/makedumpfile/makedumpfile/releases

New features:
- Cycle detection for printk log_buf
- A lot of code hardening
- Support kernels up to v5.17 (x86_64)

Special thanks to Philipp Rudo (again), who has worked on hardening
makedumpfile.  This release contains the remainder of the work,
mainly removal of variable-length arrays.

Commits since v1.7.0
7684d26 [PATCH] Support newer kernels up to v5.17 (Kazuhito Hagio)
0ea9257 [PATCH] check that order of free pages falls within valid range (Alexander Egorenkov)
3318c51 [PATCH] omit unnecessary calls to print_progress() (Philipp Rudo)
5035c08 [PATCH] print error when reading with unsupported compression (Philipp Rudo)
68d120b [PATCH v2 3/3] use cycle detection when parsing the prink log_buf (Philipp Rudo)
e1d2e53 [PATCH v2 2/3] use pointer arithmetics for dump_dmesg (Philipp Rudo)
feae3d1 [PATCH v2 1/3] add generic cycle detection (Philipp Rudo)
64b1c7f [PATCH] Fixes for rpmbuild testing (Kazuhito Hagio)
2169de6 [PATCH v2] Simplify the generation of man pages (Leonidas Spyropoulos)
59b1726 [PATCH] sadump, kaslr: fix failure of calculating kaslr_offset (HATAYAMA Daisuke)
e459edc [PATCH] remove variable length array in get_machdep_info_x86_64() (Kazuhito Hagio)
d2ffef8 [PATCH 15/15] remove variable length array in writeout_multiple_dumpfiles() (Philipp Rudo)
704d5cb [PATCH 14/15] remove variable length array in write_kdump_pages_and_bitmap_cyclic() (Philipp Rudo)
1424682 [PATCH 13/15] remove variable length array in write_kdump_pages_cyclic() (Philipp Rudo)
c977617 [PATCH 12/15] remove variable length array in write_elf_load_segment() (Philipp Rudo)
e2134cd [PATCH 11/15] remove variable length array in copy_bitmap_file() (Philipp Rudo)
67f7a2b [PATCH 10/15] remove variable length array in __exclude_unnecessary_pages() (Philipp Rudo)
c556030 [PATCH 09/15] remove variable length array in exclude_zero_pages_cyclic() (Philipp Rudo)
be7ec0c [PATCH 08/15] remove variable length array in create_1st_bitmap_file() (Philipp Rudo)
26c061c [PATCH 07/15] remove variable length array in copy_1st_bitmap_from_memory() (Philipp Rudo)
b3a938f [PATCH 06/15] remove variable length array in check_and_modify_multiple_kdump_headers() (Philipp Rudo)
cc5392d [PATCH 05/15] remove variable length array in get_mm_discontigmem() (Philipp Rudo)
00a1b4d [PATCH 04/15] remove variable length array in readpage_kdump_compressed_parallel() (Philipp Rudo)
64b5b29 [PATCH 03/15] remove variable length array in readpage_kdump_compressed() (Philipp Rudo)
ffc64f0 [PATCH 02/15] remove variable length array in get_dom0_mapnr() (Philipp Rudo)
f68ac34 [PATCH 01/15] sadump: remove variable length array sadump_copy_1st_bitmap_from_memory() (Philipp Rudo)


Description of makedumpfile:
The makedumpfile is a tool for creating a dumpfile from /proc/vmcore
with filtering out unnecessary pages for analysis and compressing the
remaining pages, in order to shorten the size of the dumpfile and the
time of creating it.
https://github.com/makedumpfile/makedumpfile

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5754 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/kexec/attachments/20220418/8412e456/attachment-0001.p7s>
