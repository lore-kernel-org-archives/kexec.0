Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eg1Lo-0003vE-9F
 for kexec@lists.infradead.org; Mon, 29 Jan 2018 04:47:26 +0000
Received: from mailgate02.nec.co.jp ([114.179.233.122])
 by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w0T4l9e3001313
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <kexec@lists.infradead.org>; Mon, 29 Jan 2018 13:47:09 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
 by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w0T4l9g0027624
 for <kexec@lists.infradead.org>; Mon, 29 Jan 2018 13:47:09 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w0T4k6dL022726
 for <kexec@lists.infradead.org>; Mon, 29 Jan 2018 13:47:09 +0900
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: makedumpfile-1.6.3: Extend supported kernel to 4.14.8
Date: Mon, 29 Jan 2018 04:45:25 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701F41858@BPXM01GP.gisp.nec.co.jp>
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
Cc: Keiichirou Suzuki <kei-suzuki@xr.jp.nec.com>

Hello,

makedumpfile version 1.6.3 is released.
Your comments/patches are welcome.

This is my last work for makedumpfile, thank you so much for everything.
My co-workers will take over the maintainer role, so there is no need to
change your way of contribution. (See "BUG REPORT" in README for new maintainers)

Main new feature:
o Support new kernels
 - The supported kernel is updated to 4.14.8 in this version.
   4.14.9 and later can't be filtered correctly due to inappropriate VMCOREINFO,
   it will be resolved in kernel 4.15.

Changelog:
o New feature
    - [PATCH v2] x86_64: Take care of init_level4_pgt rename in kernel (by Pratyush Anand) 64bd5db
    - [PATCH v2] Fix SECTION_MAP_MASK for kernel >= v.13 (by Pratyush Anand) 4bf4f2b
    - [PATCH v2] book3s/ppc64: Lower the max real address to 53 bits for kernels >= v4.11
      (by Bhupesh Sharma) 6c83e74
    - [PATCH v3 1/4] Support symbol __cpu_online_mask (by Takao Indoh) 3b11c00
    - [PATCH] ppc64: update hash page table geometry (by Hari Bathini) 3c39f13
    - [PATCH] handle renamed init_level4_pgt -> init_top_pgt (by Jeff Mahoney) 5e54d53

o Bugfix
    - [PATCH v2] arm64: Fix page table walk of 1GB section (by Bradley Bolen) 27508f1
    - [PATCH v2 1/2] ppc64: set page_offset in get_versiondep_info_ppc64() (by Pingfan Liu) 52319d2
    - [PATCH v2 2/2] ppc64: get the info of mem reserved for crashkernel (by Pingfan Liu) c7fcbbc
    - [PATCH v3 3/4] sadump: Fix a KASLR problem of sadump (by Takao Indoh) b4f7d95
    - [PATCH v3 4/4] sadump: Fix a KASLR problem of sadump while kdump is working (by Takao Indoh) 13d3059
    - [PATCH 2/2] Fix 'kernel_version' variable being uninitialized & introduce minor reorganization
      (by Bhupesh Sharma) d1ffe82
    - [PATCH 1/2] Fix off-by-one errors in exclude_segment() (by Petr Tesarik) 590f35e
    - [PATCH 2/2] Fix physical-to-virtual conversion in exclude_segment() (by Petr Tesarik) 6c1bf2a

o Cleanup
    - [PATCH] Fix formatting problems in header file (by Eric DeVolder) cefea9e
    - [PATCH v3 2/4] Introduce vtop4_x86_64_pagetable (by Takao Indoh) 6de5d37
    - [PATCH 1/2] Fix compilation warnings on ppc64/ppc64le platforms (by Bhupesh Sharma) 0df157a
    - [PATCH] Make good use of is_cyclic_region() (by Atsushi Kumagai) 6bfd7a3
    - [PATCH] Fix the regression about getting kernel version (by Atsushi Kumagai) 254c116
    - [PATCH] Update maintainers (by Atsushi Kumagai) 9d3147e

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
  makedumpfile [-c|-l|-p] [-E] [-d dump_level] [-x vmlinux] dump_mem dump_file

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
