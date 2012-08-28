Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T6H0W-00072T-0m
 for kexec@lists.infradead.org; Tue, 28 Aug 2012 08:18:45 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 0/7] Generic DT handling and DT support for ARM
Date: Tue, 28 Aug 2012 17:18:23 +0900
Message-Id: <1346141910-8214-1-git-send-email-horms@verge.net.au>
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
Cc: Magnus Damm <magnus.damm@gmail.com>

Hi,

the primary purpose of this series is to add devices tree (DT) support to ARM
which is as close as possible to the behaviour provided for 32 and 64 bit
powerpc.

In order to try to move away from one dt implementation per
architecture this series, patches 1-3 of this series attempt to
provide some generic dt code.

[PATCH 1/7] libfdt: Move from kexec/arch/ppc/libfdt/ to
[PATCH 2/7] kexec-elf.h: Include headers for types used
[PATCH 3/7] fs2dt: Add a generic copy of fs2dt

Patches 4 and 5 of the series migrate 32 and 64 bit powerpc, currently the
only providers of DT support in kexec, to use the generic code.

**** Patches 4 and 5 is compile tested only ***
**** I would value some testing on powerpc hardware ***

[PATCH 4/7] ppc64: Move 64bit powerpc to use generic fs2dt code
[PATCH 5/7] powerpc: Move 32bit powerpc to use generic fs2dt code

Patches 6 and 7 make use of the generic DT code to provide DT support for ARM.

[PATCH 6/7] arm: Make use of memory_ranges
[PATCH 7/7] arm: Add Device Tree support


Overall Diffstat
----------------

 kexec/Makefile                        |    6 
 kexec/arch/arm/Makefile               |    8 
 kexec/arch/arm/crashdump-arm.c        |   45 -
 kexec/arch/arm/crashdump-arm.h        |    2 
 kexec/arch/arm/include/arch/options.h |    4 
 kexec/arch/arm/kexec-arm.h            |    7 
 kexec/arch/arm/kexec-zImage-arm.c     |  100 ++-
 kexec/arch/ppc/Makefile               |    7 
 kexec/arch/ppc/crashdump-powerpc.c    |    2 
 kexec/arch/ppc/crashdump-powerpc.h    |    2 
 kexec/arch/ppc/fs2dt.c                |  450 -------------
 kexec/arch/ppc/kexec-elf-ppc.c        |    2 
 kexec/arch/ppc/kexec-ppc.h            |   26 
 kexec/arch/ppc/kexec-uImage-ppc.c     |    3 
 kexec/arch/ppc64/Makefile             |    7 
 kexec/arch/ppc64/crashdump-ppc64.c    |    3 
 kexec/arch/ppc64/crashdump-ppc64.h    |    4 
 kexec/arch/ppc64/fs2dt.c              |  744 ----------------------
 kexec/arch/ppc64/kexec-elf-ppc64.c    |    4 
 kexec/arch/ppc64/kexec-ppc64.c        |    1 
 kexec/arch/ppc64/kexec-ppc64.h        |   29 
 kexec/arch_reuse_initrd.c             |    2 
 kexec/fs2dt.c                         |  781 ++++++++++++++++++++++++
 kexec/fs2dt.h                         |   37 +
 kexec/kexec-elf.h                     |    3 
 kexec/kexec.h                         |    5 
 26 files changed, 1012 insertions(+), 1272 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
