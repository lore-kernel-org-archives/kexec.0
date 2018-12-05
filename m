Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUa5x-0003h3-2u
 for kexec@lists.infradead.org; Wed, 05 Dec 2018 16:32:19 +0000
Received: from mailgate01.nec.co.jp ([114.179.233.122])
 by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id wB5GW3Kr012217
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <kexec@lists.infradead.org>; Thu, 6 Dec 2018 01:32:03 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
 by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id wB5GW3qU010026
 for <kexec@lists.infradead.org>; Thu, 6 Dec 2018 01:32:03 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wB5GW2WF013823
 for <kexec@lists.infradead.org>; Thu, 6 Dec 2018 01:32:03 +0900
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: [ANNOUNCE] makedumpfile 1.6.5 is released
Date: Wed, 5 Dec 2018 16:31:24 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03564216@BPXM09GP.gisp.nec.co.jp>
Content-Language: en-US
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
To: Kexec-ml <kexec@lists.infradead.org>

Hi,

I'm pleased to announce the release of makedumpfile-1.6.5.
Your comments/patches are welcome.

Main new features:
o Improve support for arm64 system with KASLR
  - The -x option and --mem-usage option are supported.

o Support new kernels
  - The supported kernel is updated to 4.19.4 in this version.

Changelog:
o New feature
  - [PATCH 1/2] Use monotonic clock to calculate ETA and stats (Petr Tesarik) 0f4e25c
  - [PATCH 2/2] Check if clock_gettime() requires -lrt (Petr Tesarik) aec51ef
  - [PATCH] arm64: Get 'info->page_offset' from PT_LOAD segments to support KASLR boot cases
      (Bhupesh Sharma) 94c97db
  - [PATCH] arm64: Add runtime kaslr offset if it exists (Bhupesh Sharma) 616c98d
  - [PATCH] ppc64: increase MAX_PHYSMEM_BITS to 128TB (Hari Bathini) 1ce0987
  - [PATCH] x86_64: fix failure of getting kcore vmcoreinfo on kernel 4.19
      (Kazuhito Hagio) 1ea989b

o Bugfix
  - [PATCH v3] when refiltering, initialize refiltered bitmap2 from the kdump file's bitmap2
      (Pingfan Liu) 3adf612
  - [PATCH] Fix failure of detection of SPARSEMEM EXTREME in case of -x VMLINUX
      (Hatayama, Daisuke) 208124d
  - [PATCH] sadump: fix failure of reading 640 KB backup region if at over 4GB location
      (Hatayama, Daisuke) d015e6d
  - [PATCH] arm64: restore info->page_offset and implement paddr_to_vaddr_arm64()
      (Kazuhito Hagio) bc8b3bb
  - [PATCH] x86_64: fix an unnecessary message with --mem-usage option (Kazuhito Hagio) 53cf783

o Cleanup
  - [PATCH] Update help text to indicate --mem-usage is supported on archs other than x86_64
      (Bhupesh Sharma) 29dbb59
  - [PATCH] Prepare paddr_to_vaddr() for arch-specific p2v conversion (Kazuhito Hagio) 9eb5a31
  - [PATCH] Fix some compilation warnings with gcc-8.1.1 (Kazuhito Hagio) ec85943

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
  makedumpfile [-c|-l|-p|-E] [-d dump_level] [-x vmlinux] dump_mem dump_file

Example:
  If you want to exclude pages filled by zero, cache pages, user pages
  and free pages and to enable compression, please execute the following
  command.

  # makedumpfile -l -d 31 /proc/vmcore dumpfile


Thanks,
Kazu


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
