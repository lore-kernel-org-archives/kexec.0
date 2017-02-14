Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cdkMc-0002v3-0g
 for kexec@lists.infradead.org; Tue, 14 Feb 2017 21:10:29 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v4 0/11] kexec: Add option to get crash kernel region size
Date: Tue, 14 Feb 2017 15:09:12 -0600
Message-Id: <1487106563-722-1-git-send-email-eric.devolder@oracle.com>
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
To: horms@verge.net.au, kexec@lists.infradead.org, andrew.cooper3@citrix.com, dyoung@redhat.com, panand@redhat.com
Cc: daniel.kiper@oracle.com, konrad.wilk@oracle.com

This is the fourth version of a patch series originally posted by
Daniel Kiper on December 5.

This version differs from the previous version based on feedback
received from the mailing list, as such:

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


 kexec/arch/arm/crashdump-arm.c     |  5 +++++
 kexec/arch/arm64/crashdump-arm64.c |  6 ++++++
 kexec/arch/cris/kexec-cris.c       |  6 ++++++
 kexec/arch/ia64/crashdump-ia64.c   |  5 +++++
 kexec/arch/m68k/kexec-m68k.c       |  6 ++++++
 kexec/arch/mips/crashdump-mips.c   |  4 ++++
 kexec/arch/ppc/crashdump-powerpc.c | 27 ++++++++++++++++++++++++++-
 kexec/arch/ppc/kexec-ppc.c         | 28 ++++++++++++++++++++++++++++
 kexec/arch/ppc/kexec-ppc.h         |  1 +
 kexec/arch/ppc64/crashdump-ppc64.c | 27 ++++++++++++++++++++++++++-
 kexec/arch/ppc64/kexec-ppc64.c     | 28 ++++++++++++++++++++++++++++
 kexec/arch/ppc64/kexec-ppc64.h     |  2 ++
 kexec/arch/s390/kexec-s390.c       |  5 +++++
 kexec/arch/sh/crashdump-sh.c       |  5 +++++
 kexec/kexec.8                      |  3 +++
 kexec/kexec.c                      | 19 +++++++++++++++++++
 kexec/kexec.h                      |  4 +++-
 17 files changed, 178 insertions(+), 3 deletions(-)

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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
