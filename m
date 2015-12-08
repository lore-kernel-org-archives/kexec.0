Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a6QHe-0001ZD-3P
 for kexec@lists.infradead.org; Tue, 08 Dec 2015 21:58:55 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 00/14] kexec: Add option to get crash kernel region size
Date: Tue,  8 Dec 2015 22:57:33 +0100
Message-Id: <1449611867-15672-1-git-send-email-daniel.kiper@oracle.com>
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: andrew.cooper3@citrix.com, horms@verge.net.au, keir@xen.org, david.vrabel@citrix.com, konrad.wilk@oracle.com

Crash kernel region size is available via sysfs on Linux running on
bare metal. However, this does not work when Linux runs as Xen dom0.
In this case Xen crash kernel region size should be established using
__HYPERVISOR_kexec_op hypercall (Linux kernel kexec functionality does
not make a lot of sense in Xen dom0). Sadly hypercalls are not easily
accessible using shell scripts or something like that. Potentially we
can check "xl dmesg" output for crashkernel option but this is not nice.
So, let's add this functionality, for Linux running on bare metal and
as Xen dom0, to kexec-tools. This way kdump scripts may establish crash
kernel region size in one way regardless of platform. All burden of
platform detection lies on kexec-tools.

Figure (and unit) displayed by this new kexec-tools functionality is
the same as one taken from /sys/kernel/kexec_crash_size.

First three patches are fixes and cleanups. The rest provides above
described functionality for all supported platforms.

Daniel

 kexec/arch/arm/crashdump-arm.c     |   10 ++++++++++
 kexec/arch/cris/kexec-cris.c       |    5 +++++
 kexec/arch/i386/crashdump-x86.c    |   18 +++++++++++++++++-
 kexec/arch/ia64/crashdump-ia64.c   |   10 ++++++++++
 kexec/arch/m68k/kexec-m68k.c       |    5 +++++
 kexec/arch/mips/crashdump-mips.c   |    9 +++++++++
 kexec/arch/ppc/crashdump-powerpc.c |    4 ++++
 kexec/arch/ppc64/crashdump-ppc64.c |    5 +++++
 kexec/arch/s390/kexec-s390.c       |   10 ++++++++++
 kexec/arch/sh/crashdump-sh.c       |   10 ++++++++++
 kexec/crashdump.h                  |    1 -
 kexec/kexec.8                      |    3 +++
 kexec/kexec.c                      |    6 +++++-
 kexec/kexec.h                      |    5 ++++-
 purgatory/Makefile                 |    2 +-
 15 files changed, 98 insertions(+), 5 deletions(-)

Daniel Kiper (14):
      purgatory: Add purgatory.map and purgatory.ro.sym to clean recipe
      kexec: Remove redundant space from help message
      crashdump: Remove stray get_crashkernel_region() declaration
      crashdump/x86: Add print_crashkernel_region_size() function
      crashdump/arm: Add print_crashkernel_region_size() function
      crashdump/cris: Add print_crashkernel_region_size() function
      crashdump/ia64: Add print_crashkernel_region_size() function
      crashdump/m68k: Add print_crashkernel_region_size() function
      crashdump/mips: Add print_crashkernel_region_size() function
      crashdump/ppc: Add print_crashkernel_region_size() function
      crashdump/ppc64: Add print_crashkernel_region_size() function
      crashdump/s390: Add print_crashkernel_region_size() function
      crashdump/sh: Add print_crashkernel_region_size() function
      kexec: Add option to get crash kernel region size


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
