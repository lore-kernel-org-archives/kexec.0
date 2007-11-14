Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1IsCSG-000168-FY
	for kexec@lists.infradead.org; Wed, 14 Nov 2007 02:14:39 -0500
Message-Id: <473AA06E.50907@mxs.nes.nec.co.jp>
Date: Wed, 14 Nov 2007 16:14:54 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: makedumpfile-1.2.3: Add the filtering feature for free_pages of
	linux-2.6.24
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1060523090=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec-ml <kexec@lists.infradead.org>
Cc: Simon Horman <horms@verge.net.au>, "Huang, Ying" <ying.huang@intel.com>

--===============1060523090==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi,

makedumpfile version 1.2.3 is released.
Please test it. Your opinions/comments are welcome.

Changelog:
o Add the filtering feature for free_pages of linux-2.6.24.
  A new makedumpfile can exclude all the free pages of linux-2.6.24
  by searching the array "free_area.free_list[]".
  In 2.6.24-rc1 or later, the free_area.free_list is an array which
  has one list for each migrate types instead of a single list.
  This patch was provided by Huang Ying. Thanks Huang.

  linux-2.6.23/include/linux/mmzone.h:
    struct free_area {
            struct list_head        free_list;
            unsigned long           nr_free;
    };

  linux-2.6.24-rc2/include/linux/mmzone.h:
    #define MIGRATE_TYPES         5
    struct free_area {
            struct list_head        free_list[MIGRATE_TYPES];
            unsigned long           nr_free;
    };

Note:
  If executing makedumpfile on the following environment, please specify
  the "--elf64-core-headers" option for the kexec command to preload
  2nd-kernel, or apply the following patch to the kexec command.
  Without the above workarounds, makedumpfile command aborts by invalid
  ELF header in /proc/vmcore.
  - Environment:
    CPU         : i386
    Memory      : 4GB or larger
    kernel      : i386 PAE
    kexec-tools : v20071030

  - Patch:
    "[PATCH] Fix the feature determining ELF32/ELF64 automatically"
    http://lists.infradead.org/pipermail/kexec/2007-November/000967.html

Explanation of makedumpfile:
  To shorten the size of the dumpfile and the time of creating the
  dumpfile, makedumpfile copies only the necessary pages for analysis
  to the dumpfile from /proc/vmcore. You can specify the kind of
  unnecessary pages with dump_level. If you want to shorten the size
  further, enable the compression of the page data.

Download:
  You can download the latest makedumpfile(ver. 1.2.3) from the following URL.
  Details of the change are written on the CVS page of the following site.
  https://sourceforge.net/projects/makedumpfile/

Method of installation:
  You can compile the makedumpfile command as follows;
  1. "tar -zxvf makedumpfile-1.2.3.tar.gz"
  2. "cd makedumpfile"
  3. "make; make install"

Usage:
  makedumpfile [-c] [-E] [-d dump_level] [-x vmlinux] dump_mem dump_file

Example:
  If you want to exclude pages filled by zero, cache pages, user pages
  and free pages and to enable compression, please execute the following
  command.

  # makedumpfile -c -d 31 -x vmlinux /proc/vmcore dumpfile


Thanks
Ken'ichi Ohmichi


--===============1060523090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1060523090==--
