Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410048.outbound.protection.outlook.com
 ([40.107.141.48] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mjte3-00FG5h-P1
 for kexec@lists.infradead.org; Mon, 08 Nov 2021 01:40:25 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: [ANNOUNCE] makedumpfile 1.7.0
Date: Mon, 8 Nov 2021 01:40:13 +0000
Message-ID: <TYYPR01MB67777664799956E4E3CCF7C7DD919@TYYPR01MB6777.jpnprd01.prod.outlook.com>
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

Hi,

I'm pleased to announce the release of makedumpfile 1.7.0.
Thank you everyone for your help to maintain the tool.

Download:
The latest makedumpfile can be downloaded from the following URL.
  https://github.com/makedumpfile/makedumpfile/releases

New features:
- Zstandard (zstd) compression support
- New -L option to limit output file size
- Support of kernels up to v5.15 (x86_64)

Special thanks to Philipp Rudo, who has been working on hardening
makedumpfile.  This release contains a part of the work, such as
buffer overflow fix, removal of strcpy() and etc.  We will continue
to do this also for the next release.
Note that due to some reasons the work has been done internally,
please check out the commits if you have interest.

Commits since v1.6.9:
06ef8e2 [v1.7.0] Update version (Kazuhito Hagio)
4541b18 [PATCH] Support newer kernels up to v5.15 (Kazuhito Hagio)
a32da03 [PATCH 14/14] fix type mismatch in parse_line() (Philipp Rudo)
d155b76 [PATCH 13/14] fix out of range comparison in count_bits() (Philipp Rudo)
247afd6 [PATCH 12/14] fix potential dereference of NULL in is_cyclic_region() (Philipp Rudo)
2651d57 [PATCH 11/14] fix memory leak in init_xen_crash_info() (Philipp Rudo)
4577898 [PATCH 10/14] fix compiler warning in ordinal() (Philipp Rudo)
35e31db [PATCH 09/14] remove use of strcpy() in __load_module_symbol() (Philipp Rudo)
faea305 [PATCH 08/14] remove use of strcpy() in strip_beginning_whitespace() (Philipp Rudo)
cc11fcd [PATCH 07/14] remove use of strcpy() in eta_to_human_short() (Philipp Rudo)
a854064 [PATCH 06/14] remove use of strcpy() in open_dump_bitmap() (Philipp Rudo)
6b69167 [PATCH 05/14] make sure sc.sc_buf is initalized (Philipp Rudo)
d813c3d [PATCH 04/14] fix buffer overflow in init_save_control() (Philipp Rudo)
38c1428 [PATCH 03/14] fix buffer overflow in DumpInfo in read_vmcoreinfo_basic_info() (Philipp Rudo)
d5c95fc [PATCH 02/14] fix buffer overflow on stack in copy_vmcoreinfo() (Philipp Rudo)
4ce9d2c [PATCH 01/14] Makefile: add DEBUG option (Philipp Rudo)
afd0a6d [PATCH] Add Zstandard compression support (Tao Liu)
bccc39c [PATCH v2] support --partial-dmesg on 5.10+ kernels (Ivan Delalande)
5684d4c [PATCH 2/2] Fix --dry-run for incomplete dumps (Philipp Rudo)
6e53b9d [PATCH 1/2] Fix bad file descriptor error when using --dry-run (Philipp Rudo)
efef023 [PATCH] Cleanup: Remove verbose names and code in calculate_log_buf_len() (Kazuhito Hagio)
f0cfa86 [PATCH v2 3/3] Add -L option to limit output file size (Benjamin Poirier)
2f5697e [PATCH v2 2/3] Make --dump-dmesg option use write_and_check_space() (Benjamin Poirier)
047b921 [PATCH v2 1/3] Fix off-by-one error when checking cache_size (Benjamin Poirier)
9df519d [PATCH] arm: fix page_offset determination (Grzegorz Jaszczyk)
9a6f589 [PATCH] check for invalid physical address of /proc/kcore when making ELF dumpfile (Tao Liu)
38d921a [PATCH] check for invalid physical address of /proc/kcore when finding max_paddr (Coiby Xu)
6464568 [PATCH] Increase SECTION_MAP_LAST_BIT to 5 (Kazuhito Hagio)
0bb2f15 [PATCH] Mark start of 1.7.0 development phase with version 1.6.9++ (Kazuhito Hagio)

Description of makedumpfile:
The makedumpfile is a tool for creating a dumpfile from /proc/vmcore
with filtering out unnecessary pages for analysis and compressing the
remaining pages, in order to shorten the size of the dumpfile and the
time of creating it.
https://github.com/makedumpfile/makedumpfile

Thanks,
Kazu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
