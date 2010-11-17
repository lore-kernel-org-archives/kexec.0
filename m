Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PIWOy-0008F9-TK
	for kexec@lists.infradead.org; Wed, 17 Nov 2010 01:01:34 +0000
Date: Wed, 17 Nov 2010 09:37:22 +0900
From: Masayuki Igawa <igawa@mxs.nes.nec.co.jp>
Subject: makedumpfile-1.3.7: Support ARM and s390x.
Message-Id: <20101117093722.f7bb72e4.igawa@mxs.nes.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: mahesh@linux.vnet.ibm.com, caiqian@redhat.com, ext-mika.1.westerberg@nokia.com

Hi,

makedumpfile version 1.3.7 is released.
Your comments/patches are welcome.

Changelog:
o New feature
  - Add ARM crashdump support. (by Mika Westerberg)
  - Add s390x crashdump support. (by Mahesh J Salgaonkar, Ken'ichi Ohmichi)
  - Add linux-2.6.35 - 2.6.36 support. (by Ken'ichi Ohmichi)
  - Print the execution times of each step. (by Ken'ichi Ohmichi)
    Example)
      # makedumpfile --message-level 16 -c -d31 /proc/vmcore dump.cd31
      STEP [Checking for memory holes  ] : 0.000015984 seconds
      STEP [Excluding unnecessary pages] : 3.000708797 seconds
      STEP [Excluding free pages       ] : 0.000030380 seconds
      STEP [Copying data               ] : 9.000603782 seconds
  - (Speed up) Don't search struct page(s) for excluding cache/cache private
    /user data, if unnecessary. (by Ken'ichi Ohmichi)

o Bugfix
  - Use ARCH_PFN_OFFSET for pfn_to_paddr/paddr_to_pfn translations. (by Mika Westerberg)
  - Use ULONGLONG_MAX to for invalid pfn. (by Mika Westerberg)
  - Add missing options to the --help output. (by CAI Qian)
  - Fix "Copying data" step by including the write time for zero_page. (by Ken'ichi Ohmichi)
  - Fix right nr_cpus in kdump main header. (by Ken'ichi Ohmichi)
  - Fix the size of "log_end" which has been changed since linux-2.6.25. (by Ken'ichi Ohmichi)

o Code Cleanup
  - Fix 'ERROR: do not use assignment in if condition' by checkpatch.pl. (by Masayuki Igawa)
  - Merge the almost same codes which print an execution time. (by Ken'ichi Ohmichi)
  - Print the offset value if a lseek error happens in readmem(). (by Ken'ichi Ohmichi)


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
Masayuki Igawa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
