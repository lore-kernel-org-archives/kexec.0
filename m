Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S2v3H-0004Kf-Ij
 for kexec@lists.infradead.org; Thu, 01 Mar 2012 01:43:29 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.160])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q211h7PQ011463
 for <kexec@lists.infradead.org>; Thu, 1 Mar 2012 10:43:07 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q211h7j22028 for kexec@lists.infradead.org;
 Thu, 1 Mar 2012 10:43:07 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id q211h6Ia005128
 for <kexec@lists.infradead.org>; Thu, 1 Mar 2012 10:43:06 +0900 (JST)
Date: Thu, 1 Mar 2012 10:40:49 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: makedumpfile-1.4.3: Support for PPC32 architecture.
Message-Id: <20120301104049.01ce685f.kumagai-atsushi@mxc.nes.nec.co.jp>
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

Hi,

makedumpfile version 1.4.3 is released.
Your comments/patches are welcome.

Suzuki implemented "Support for PPC32" feature. Thanks, Suzuki.


Changelog:
o New feature
   Commits related to "Support for PPC32"
    - [PATCH v1 1/3] Support for cross building. (by Suzuki K. Poulose) 96f24dc
    - [PATCH v1 2/3][ppc64] Rename the __powerpc__ macro to __powerpc64__ for PPC64. (by Suzuki K. Poulose) 3d8b733
    - [PATCH v1 3/3] Add support for PPC32. (by Suzuki K. Poulose) 9cfcdae
   Other commit
    - [PATCH] Support newer kernels. (by Atsushi Kumagai) 029ebaf

o Bugfix
    - [PATCH] Fix segmentation fault for makedumpfile -x/--split. (by Aruna Balakrishnaiah) 8bc7d44
    - [PATCH] Fix VtoP method for x86 remap allocator. (by Petr Tesarik) 3812217

o TODO
    - Send the patch to the LKML to store some symbols in VMCOREINFO.
      (VtoP method for x86 remap allocator needs some symbols that
       relate to remap allocator.)
    - Support newer kernels (Especially DISCONTIGMEM).


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
