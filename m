Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T9VPI-0000Id-HY
 for kexec@lists.infradead.org; Thu, 06 Sep 2012 06:17:42 +0000
Received: from mailgate4.nec.co.jp ([10.7.69.184])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q866HaNd027247
 for <kexec@lists.infradead.org>; Thu, 6 Sep 2012 15:17:36 +0900 (JST)
Received: (from root@localhost) by mailgate4.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q866Hat15881 for kexec@lists.infradead.org;
 Thu, 6 Sep 2012 15:17:36 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id q866HKck011613
 for <kexec@lists.infradead.org>; Thu, 6 Sep 2012 15:17:35 +0900 (JST)
Date: Thu, 6 Sep 2012 15:01:36 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: makedumpfile-1.5.0: Introduce cyclic mode to fix memory usage.
Message-Id: <20120906150136.e3127181293d85f414d32720@mxc.nes.nec.co.jp>
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

Hello,

makedumpfile version 1.5.0 is released.
Your comments/patches are welcome.

This version introduces the "cyclic mode" as a default running mode.

Before this version, makedumpfile uses the amount of memory depending 
on physical memory size, because it saves the analytical data for whole
memory at a time.

On the other hand, the cyclic mode uses fixed amount of memory regardless of
physical memory size, because this mode analyzes only constant region of
memory per cycle as below:

  [v1.4.7 or before]
    cycle                       1
                  +-----------------     -----+
    vmcore        |                  ...      | 
                  +-----------------     -----+

  [v1.5.0]
    cycle           1   2   3   4    ...    N
                  +-----------------     -----+
    vmcore        |   |   |   |   |  ...  |   | 
                  +-----------------     -----+

And, the number of cycles is represented as:
 
  N = physical memory size / (page size * bit per byte(8) * BUFSIZE_CYCLIC)

BUFSIZE_CYCLIC is the buffer size for analysis, default size is 1 Mbyte.

BTW, in v1.5.0, the cyclic mode may cause some slow down of filtering process
when N is large. 
I'm going to improve this issue with new filtering logic (called mem_map array logic)
in a future version.

At least in v1.5.0, if you feel the cyclic mode is slow, you can try 2 workarounds:

  1. Use old running mode with "--non-cyclic" option.

  2. Decrease the number of cycles by increasing BUFSIZE_CYCLIC with 
     "--cyclic-buffer" option.

Please refer to the manual page for how to use these options.


Notice:

  1. The cyclic mode doesn't support sadump format and refiltering kdump 
     compressed format, because they will be used in the 1st kernel
     and makedumpfile can allocate enough memory.

  2. The cyclic mode doesn't support Xen in this version, 
     but I'll support it in a future version.

  3. This version will show incorrect and many progress indicator in the cyclic mode.
     I'll fix it in a future version, but it doesn't affect main operation.

  4. I enhanced regression test for this version, and I found the issue
     in old elfutils, so please use elfutils-0.142 or later.
     If you use old elfutils, -g option might fail.

Changelog:
o New feature
   Commits related to "cyclic mode"
    - [PATCH v4 1/12] Introduce cyclic mode to keep memory usage constant. (by Atsushi Kumagai) 269b4f8
    - [PATCH v4 2/12] Prepare partial bitmap for cyclic mode. (by Atsushi Kumagai) d3c062e
    - [PATCH v4 3/12] Change the function related to excluding unnecessary pages. (by Atsushi Kumagai) 38bbc6e
    - [PATCH v4 4/12] Add function to update target region. (by Atsushi Kumagai) 7486ed2
    - [PATCH v4 5/12] Add function to get num_dumpable for cyclic mode. (by Atsushi Kumagai) 2ca2ce8
    - [PATCH v4 6/12] Implement the main routine of cyclic mode for kdump-compressed format. (by Atsushi Kumagai) 7819afa
    - [PATCH v4 7/12] Add function to get number of PT_LOAD for cyclic mode. (by Atsushi Kumagai) 1ff67e0
    - [PATCH v4 8/12] Implement the main routine of cyclic mode for ELF format. (by Atsushi Kumagai) 0310e0f
    - [PATCH v4 9/12] Enabling --split option with cyclic mode. (by Atsushi Kumagai) f6367b4
    - [PATCH v4 10/12] Change num_dumped value to global for debug messages. (by Atsushi Kumagai) db99bbe
    - [PATCH v4 11/12] Remove waste calculation to improve performance. (by Atsushi Kumagai) 253ed35
    - [PATCH v4 12/12] Add --cyclic-buffer option to specify buffer size for cyclic mode. (by Atsushi Kumagai) 79bce69

   Other commit
    - [PATCH] Update README for TODO. (by Atsushi Kumagai) 8c1614c
    - [PATCH] Support newer kernels. (by Atsushi Kumagai) f778363
    - [PATCH] Update necessary elfutils version. (by Atsushi Kumagai) ecafa76

o Bugfix
    - [PATCH] Generic search into anonymous members in search_member(). (by Stefan Bader) ecff242


Plan for v1.5.1:
  - Security key filtering enhancement (by Aravinda Prasad)
  - Add snappy compression support (by HATAYAMA Daisuke)
  - Support Xen-4.1 (by Petr Tesarik, Norbert Trapp)
  - Support for x86_64 1G pages (by Petr Tesarik)
  - keep dumpfile pages in a cache (by Petr Tesarik)
  - Add a missing return statement (by Petr Tesarik)

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
