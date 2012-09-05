Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9E1s-00022O-Rh
 for kexec@lists.infradead.org; Wed, 05 Sep 2012 11:44:22 +0000
From: Matthew Leach <matthew.leach@arm.com>
Subject: [RFC PATCH 0/4]  Add device-tree support to kexec-tools for ARM
Date: Wed,  5 Sep 2012 12:43:59 +0100
Message-Id: <1346845443-32242-1-git-send-email-matthew.leach@arm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Matthew Leach <matthew.leach@arm.com>, will.deacon@arm.com

Hi all,

Running a kexec() on newer ARM platforms has become an issue as
information about the platform that is presented via device-tree is
required to boot a new kernel.

The ATAGs kernel code is re-used, replacing the ATAGs with a
device-tree blob so that only kexec-tools needs to be changed. There
are two options for generating a dtb to be passed to the kernel from
kexec-tools: 1) Read in the device-tree that is exposed in
/proc/device-tree and flatten this out into a dtb.  2) Allow the user
to specify a dtb file on the command line.  These blobs are then
loaded into memory before the kernel image and the address passed
through to r2, as stated in the ARM booting documentation.

All comments welcome,
Matt

Matthew Leach (4):
  Fix an overflow bug with address comparison
  Move libfdt to a generic location
  Add the dtc for device-tree manipulation
  Add device tree support to the ARM platform

 kexec/arch/arm/Makefile                            |  10 +
 kexec/arch/arm/include/arch/options.h              |   6 +-
 kexec/arch/arm/kexec-zImage-arm.c                  | 140 ++++-
 kexec/arch/ppc/Makefile                            |   8 +-
 kexec/kexec.c                                      |   2 +-
 util_lib/Makefile                                  |   2 +
 util_lib/dtc/Makefile.dtc                          |   9 +
 util_lib/dtc/data.c                                | 321 ++++++++++
 util_lib/dtc/dtc.c                                 |  44 ++
 util_lib/dtc/dtc.h                                 | 244 ++++++++
 util_lib/dtc/flattree.c                            | 649 +++++++++++++++++++++
 util_lib/dtc/fstree.c                              |  91 +++
 util_lib/dtc/livetree.c                            | 579 ++++++++++++++++++
 util_lib/dtc/srcpos.c                              | 252 ++++++++
 util_lib/dtc/srcpos.h                              |  87 +++
 util_lib/dtc/util.c                                |  59 ++
 util_lib/dtc/util.h                                |  56 ++
 util_lib/dtc/version_gen.h                         |   1 +
 .../arch/ppc => util_lib}/libfdt/Makefile.libfdt   |   8 +-
 {kexec/arch/ppc => util_lib}/libfdt/TODO           |   0
 {kexec/arch/ppc => util_lib}/libfdt/fdt.c          |   0
 {kexec/arch/ppc => util_lib}/libfdt/fdt.h          |   0
 {kexec/arch/ppc => util_lib}/libfdt/fdt_ro.c       |   0
 {kexec/arch/ppc => util_lib}/libfdt/fdt_rw.c       |   0
 {kexec/arch/ppc => util_lib}/libfdt/fdt_strerror.c |   0
 {kexec/arch/ppc => util_lib}/libfdt/fdt_sw.c       |   0
 {kexec/arch/ppc => util_lib}/libfdt/fdt_wip.c      |   0
 {kexec/arch/ppc => util_lib}/libfdt/libfdt.h       |   0
 {kexec/arch/ppc => util_lib}/libfdt/libfdt_env.h   |   0
 .../arch/ppc => util_lib}/libfdt/libfdt_internal.h |   0
 30 files changed, 2553 insertions(+), 15 deletions(-)
 create mode 100644 util_lib/dtc/Makefile.dtc
 create mode 100644 util_lib/dtc/data.c
 create mode 100644 util_lib/dtc/dtc.c
 create mode 100644 util_lib/dtc/dtc.h
 create mode 100644 util_lib/dtc/flattree.c
 create mode 100644 util_lib/dtc/fstree.c
 create mode 100644 util_lib/dtc/livetree.c
 create mode 100644 util_lib/dtc/srcpos.c
 create mode 100644 util_lib/dtc/srcpos.h
 create mode 100644 util_lib/dtc/util.c
 create mode 100644 util_lib/dtc/util.h
 create mode 100644 util_lib/dtc/version_gen.h
 rename {kexec/arch/ppc => util_lib}/libfdt/Makefile.libfdt (60%)
 rename {kexec/arch/ppc => util_lib}/libfdt/TODO (100%)
 rename {kexec/arch/ppc => util_lib}/libfdt/fdt.c (100%)
 rename {kexec/arch/ppc => util_lib}/libfdt/fdt.h (100%)
 rename {kexec/arch/ppc => util_lib}/libfdt/fdt_ro.c (100%)
 rename {kexec/arch/ppc => util_lib}/libfdt/fdt_rw.c (100%)
 rename {kexec/arch/ppc => util_lib}/libfdt/fdt_strerror.c (100%)
 rename {kexec/arch/ppc => util_lib}/libfdt/fdt_sw.c (100%)
 rename {kexec/arch/ppc => util_lib}/libfdt/fdt_wip.c (100%)
 rename {kexec/arch/ppc => util_lib}/libfdt/libfdt.h (100%)
 rename {kexec/arch/ppc => util_lib}/libfdt/libfdt_env.h (100%)
 rename {kexec/arch/ppc => util_lib}/libfdt/libfdt_internal.h (100%)

-- 
1.7.12


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
