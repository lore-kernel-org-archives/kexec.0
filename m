Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cerKt-0001xC-9l
 for kexec@lists.infradead.org; Fri, 17 Feb 2017 22:49:12 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v5 00/11] kexec: Add option to get crash kernel region size
Date: Fri, 17 Feb 2017 16:47:14 -0600
Message-Id: <1487371645-8299-1-git-send-email-eric.devolder@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, horms@verge.net.au, andrew.cooper3@citrix.com
Cc: daniel.kiper@oracle.com, konrad.wilk@oracle.com

This is the fifth version of a patch series originally posted by
Daniel Kiper on December 5.

This version differs from the previous version based on feedback
received from the mailing list, as such:

v5: Incorporated feedback:
    - for ppc/ppc64, slight enhancement to get_devtree_value()
    - fix indentation in print_crash_kernel_load_range()
    - additional changes for coding convention and formatting
v4: Incorporated feedback:
    - additional changes for coding convention and formatting
v3: Incorporated feedback:
    - changes for coding convention and formatting
    - restructured to introduce get_crash_kernel_load_range() for each
      architecture, and then a single function in kexec/kexec.c to call
      the per-architecture get_crash_kernel_load_range() and print the
      result.
v2: Incorporated feedback:
    - utilize the is_crashkernel_mem_reserved() function common in all archs
    - for ppc and ppc64, utilize device-tree values to print size
    - for unsupported architectures, print appropriate message
v1: Posted to kexec-tools mailing list

Eric


Daniel Kiper (10):
  crashdump/arm: Add get_crash_kernel_load_range() function
  crashdump/cris: Add get_crash_kernel_load_range() function
  crashdump/ia64: Add get_crash_kernel_load_range() function
  crashdump/m68k: Add get_crash_kernel_load_range() function
  crashdump/mips: Add get_crash_kernel_load_range() function
  crashdump/ppc: Add get_crash_kernel_load_range() function
  crashdump/ppc64: Add get_crash_kernel_load_range() function
  crashdump/s390: Add get_crash_kernel_load_range() function
  crashdump/sh: Add get_crash_kernel_load_range() function
  kexec: Add option to get crash kernel region size

Eric DeVolder (1):
  crashdump/arm64: Add get_crash_kernel_load_range() function

 kexec/arch/arm/crashdump-arm.c     |  5 +++++
 kexec/arch/arm64/crashdump-arm64.c |  6 ++++++
 kexec/arch/cris/kexec-cris.c       |  6 ++++++
 kexec/arch/ia64/crashdump-ia64.c   |  5 +++++
 kexec/arch/m68k/kexec-m68k.c       |  6 ++++++
 kexec/arch/mips/crashdump-mips.c   |  4 ++++
 kexec/arch/ppc/crashdump-powerpc.c | 22 +++++++++++++++++++++-
 kexec/arch/ppc/kexec-ppc.c         | 24 ++++++++++++++++++++++++
 kexec/arch/ppc/kexec-ppc.h         |  1 +
 kexec/arch/ppc64/crashdump-ppc64.c | 22 +++++++++++++++++++++-
 kexec/arch/ppc64/kexec-ppc64.c     | 24 ++++++++++++++++++++++++
 kexec/arch/ppc64/kexec-ppc64.h     |  2 ++
 kexec/arch/s390/kexec-s390.c       |  5 +++++
 kexec/arch/sh/crashdump-sh.c       |  5 +++++
 kexec/kexec.8                      |  3 +++
 kexec/kexec.c                      | 16 ++++++++++++++++
 kexec/kexec.h                      |  4 +++-
 17 files changed, 157 insertions(+), 3 deletions(-)

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
