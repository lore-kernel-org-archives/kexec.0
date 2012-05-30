Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SZaNg-0001XE-WC
 for kexec@lists.infradead.org; Wed, 30 May 2012 04:19:36 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.193])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q4U4JBwk000885
 for <kexec@lists.infradead.org>; Wed, 30 May 2012 13:19:11 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q4U4JBj27782 for kexec@lists.infradead.org;
 Wed, 30 May 2012 13:19:11 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id q4U4JACZ024190
 for <kexec@lists.infradead.org>; Wed, 30 May 2012 13:19:10 +0900 (JST)
Date: Wed, 30 May 2012 13:16:44 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: makedumpfile-1.4.4: Support for LZO compression.
Message-Id: <20120530131644.9548f784.kumagai-atsushi@mxc.nes.nec.co.jp>
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

makedumpfile version 1.4.4 is released.
Your comments/patches are welcome.

HATAYAMA-san implemented "Support for LZO compression" feature. 
Thanks, HATAYAMA-san.

This feature allows you to compress dump data by each page using 
lzo instead of zlib.

This feature is optional, the user has to prepare lzo library to use
it. Please see the README for more information.


Changelog:
o New feature
   Commits related to "Support for LZO compression"
    - [PATCH v3 1/4] Add LZO Support. (by HATAYAMA Daisuke) 7d6c0cb
    - [PATCH v3 2/4] Avoid LONG_MAX/ULONG_MAX redefinitions. (by HATAYAMA Daisuke) ab9c60b
    - [PATCH v3 3/4] Add help and manual messages about LZO compression support. 
      (by HATAYAMA Daisuke) 5e01993
    - [PATCH v3 4/4] Add build condition for LZO support. (by HATAYAMA Daisuke) b722ff7
   Other commit
    - [PATCH] Support newer kernels. (by Atsushi Kumagai) 4f39edb

o Bugfix
    - [PATCH] sadump: Check if given cpu is online in per-cpu related helper functions. 
      (by HATAYAMA Daisuke) 7844436

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
