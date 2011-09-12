Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R2whk-00046I-Ru
	for kexec@lists.infradead.org; Mon, 12 Sep 2011 02:57:06 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.197])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id p8C2uvJu000629
	for <kexec@lists.infradead.org>; Mon, 12 Sep 2011 11:56:57 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
	(8.11.7/3.7W-MAILGATE-NEC)
	id p8C2uul06736 for kexec@lists.infradead.org;
	Mon, 12 Sep 2011 11:56:56 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
	by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id p8C2uuur019538
	for <kexec@lists.infradead.org>; Mon, 12 Sep 2011 11:56:56 +0900 (JST)
Date: Mon, 12 Sep 2011 10:35:55 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: makedumpfile-1.4.0: Filter out kernel data from vmcore.
Message-Id: <20110912103555.a13021c4.kumagai-atsushi@mxc.nes.nec.co.jp>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi,

makedumpfile version 1.4.0 is released.
Your comments/patches are welcome.

Mahesh Salgaonkar made a lot of effort to implement "Filter out kernel
data from vmcore" feature. Thanks, Mahesh.

o The explanation about a new feature "Filter out kernel data from vmcore":
  This feature filters out desired kernel symbol data and it's members from
  vmcore file. The data to be filtered out is poisoned with character 'X'
  (0x58 in Hex) or ' '(0x00 in Hex).

  This feature will be very useful for the customers who wants to erase the
  customer sensitive data like security keys and other confidential data, in
  dumpfile before sending it to support team for analysis.

  This feature introduces a filter config file where, using filter commands,
  user can specify desired kernel data symbols and it's members that need
  to be filtered out while creating o/p dumpfile. The Syntax for filter
  commands are provided in the makedumpfile.conf(8) man page.

  Ex. Erase 'modules' and 'cred_jar.name' data from a dumpfile:
    # cat makedumpfile.conf
    erase modules
    erase cred_jar.name size 10
    #
    # makedumpfile -d 31 /proc/vmcore dump.orig
    [..]
    #
    # makedumpfile -x /boot/vmlinux --config makedumpfile.conf dump.orig dump.erase
    [..]
    #

  Note: To implement this feature, we need elfutils-0.137 or later.


Changelog:
o New feature
  Commits related to "Filter out kernel data from vmcore"
    - [PATCH v2 1/8] Add '--config' option to specify filter config file. (by Mahesh Salgaonkar) 3ded8ff
    - [PATCH v2 2/8] Apply relocation while loading module debuginfo. (by Mahesh Salgaonkar) 9e4ab3e
    - [PATCH v2 3/8] Load the module symbol data from vmcore. (by Mahesh Salgaonkar) d83f295
    - [PATCH v2 4/8] Introduce routines to get type name from debuginfo. (by Mahesh Salgaonkar) 94b2d0e
    - [PATCH v2 5/8] Read and process filter commands from config file. (by Mahesh Salgaonkar) 0f9fe7c
    - [PATCH v2 6/8] Read and process 'for' command from config file. (by Mahesh Salgaonkar) dc34687
    - [PATCH v2 7/8] Add erased information in compressed kdump file (by Mahesh Salgaonkar) 745bb42
    - [UPDATED PATCH v2 8/8] Add erase information in ELF formatted dumpfile (by Mahesh Salgaonkar) 7d4f298
    - [PATCH] Update necessary elfutils version. (by Ken'ichi Ohmichi) 01ac6c9
    - [PATCH] Use the same format as erase commands for eraseinfo data. (by Mahesh Salgaonkar) 894680e
    - [PATCH] Fix array traversal for array of structure and char type. (by Mahesh Salgaonkar) 6a78de7
    - [PATCH] Cleanup: Revert unnecessary change about writing sub header. (by Ken'ichi Ohmichi) 4edcbc5
    - [PATCH] Identify eraseinfo without NT_ERASE_INFO. (by Ken'ichi Ohmichi) 389e1c8
    - [PATCH] Bugfix: Avoid a SIGSEGV at the memset() of write_cache_zero(). (by Ken'ichi Ohmichi) 40c5772
    - [PATCH] Bugfix: Avoid writting offset_eraseinfo in kdump_sub_header if not containing eraseinfo. (by Ken'ichi Ohmichi) de50b06
    - [PATCH] Bugfix: set kdump_sub_header data with --reassemble option. (by Ken'ichi Ohmichi) bb646d8
    - [PATCH] Fix some warning messages on i386 machine. (by Ken'ichi Ohmichi) e83654b
    - [PATCH] Add free() and use CONFIG_SKIP_SECTION. (by Ken'ichi Ohmichi) 706ab0b
    - [PATCH] Move debuginfo search to set_dwarf_debuginfo() routine. (by Mahesh Salgaonkar) af54031
    - [PATCH] Cleanup: Reduce indents in extract_filter_info(). (by Ken'ichi Ohmichi) 18f1ac4
    - [PATCH] Cleanup: Get a pointer size by sizeof(void   -). (by Ken'ichi Ohmichi) d07bc64
    - [PATCH] Cleanup: Add __load_module_symbol() for shrinking function size. (by Ken'ichi Ohmichi) 91f3696
    - [PATCH] Cleanup: Output error message if mod_st.num_modules is 0. (by Ken'ichi Ohmichi) e80c858
    - [PATCH] Cleanup: Make the call of dwfl_report_offline() clear. (by Ken'ichi Ohmichi) 2536dd9
    - [PATCH] Cleanup: Fix return values of get_symbol_addr, etc. (by Ken'ichi Ohmichi) c20e415
    - [PATCH] Cleanup: Remove unnecessary arguments "dwarfd". (by Ken'ichi Ohmichi) 6d6d7b5
    - [PATCH] Use dwarf_formref_die() instead of deprecated dwarf_formref(). (by Ken'ichi Ohmichi) 23ff64f
  Other commit
    - [PATCH] Support line mode terminals. (by Michael Holzheu) 714d177
  
o Bugfix
  - [PATCH] Bugfix: Write both vmcoreinfo and pt_note when reassembling. (by Ken'ichi Ohmichi) 3a93bbb
  - [PATCH] Bugfix: Skip writing PT_LOAD segment not having real data. (by Ken'ichi Ohmichi) e3ac177

o Code Cleanup
  - [PATCH] Cleanup: Add common.h file for shrinking makedumpfile.h. (by Ken'ichi Ohmichi) 568dc0f
  - [PATCH] Cleanup: Add print_info.h/.c for reducing makedumpfile.h/.c (by Ken'ichi Ohmichi) 377ba81
  - [PATCH] Cleanup: Add elf_info.c for reducing makedumpfile.c (by Ken'ichi Ohmichi) 5c81428
  - [PATCH] Cleanup: Add erase_info.c for reducing makedumpfile.c (by Ken'ichi Ohmichi) fb93932
  - [PATCH] Cleanup: Add dwarf_info.c for reducing makedumpfile.c (by Ken'ichi Ohmichi) d307789
  - [PATCH] Cleanup: Move architecture dependant files to "arch" directory. (by Ken'ichi Ohmichi) 2f19359
  - [PATCH] Cleanup: Add debug messages for printing kdump compressed info. (by Ken'ichi Ohmichi) 6063020
  - [PATCH] Cleanup: Add including-gaurds to some header files. (by Ken'ichi Ohmichi) d363bb1


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

  # makedumpfile -c -d 31 -x vmlinux /proc/vmcore dumpfile


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
