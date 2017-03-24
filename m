Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1crN0e-0008EO-8K
 for kexec@lists.infradead.org; Fri, 24 Mar 2017 11:03:58 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2OAx5tY017175
 for <kexec@lists.infradead.org>; Fri, 24 Mar 2017 07:03:35 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29cg2rj5cj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 24 Mar 2017 07:03:34 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 24 Mar 2017 21:03:32 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2OB3K0Z38207668
 for <kexec@lists.infradead.org>; Fri, 24 Mar 2017 22:03:28 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2OB2tUw028711
 for <kexec@lists.infradead.org>; Fri, 24 Mar 2017 22:02:56 +1100
Subject: [RESEND PATCH v4 0/5] kexec/fadump: remove dependency with
 CONFIG_KEXEC and reuse crashkernel parameter for fadump
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 24 Mar 2017 16:32:30 +0530
MIME-Version: 1.0
Message-Id: <149035332237.6881.9486330442785822384.stgit@hbathini.in.ibm.com>
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
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, dyoung@redhat.com, vgoyal@redhat.com

Traditionally, kdump is used to save vmcore in case of a crash. Some
architectures like powerpc can save vmcore using architecture specific
support instead of kexec/kdump mechanism. Such architecture specific
support also needs to reserve memory, to be used by dump capture kernel.
crashkernel parameter can be a reused, for memory reservation, by such
architecture specific infrastructure.

This patchset removes dependency with CONFIG_KEXEC for crashkernel parameter
and vmcoreinfo related code as it can be reused without kexec support. Also,
crashkernel parameter is reused instead of fadump_reserve_mem to reserve
memory for fadump.

The first patch moves crashkernel parameter parsing and vmcoreinfo related
code under CONFIG_CRASH_CORE instead of CONFIG_KEXEC_CORE. The second patch
reuses the definitions of append_elf_note() & final_note() functions under
CONFIG_CRASH_CORE in IA64 arch code. The third patch removes dependency on
CONFIG_KEXEC for firmware-assisted dump (fadump) in powerpc. The next patch
reuses crashkernel parameter for reserving memory for fadump, instead of the
fadump_reserve_mem parameter. This has the advantage of using all syntaxes
crashkernel parameter supports, for fadump as well. The last patch updates
fadump kernel documentation about use of crashkernel parameter.

---

Hari Bathini (5):
      crash: move crashkernel parsing and vmcore related code under CONFIG_CRASH_CORE
      ia64: reuse append_elf_note() and final_note() functions
      powerpc/fadump: remove dependency with CONFIG_KEXEC
      powerpc/fadump: reuse crashkernel parameter for fadump memory reservation
      powerpc/fadump: update documentation about crashkernel parameter reuse


 Documentation/powerpc/firmware-assisted-dump.txt |   23 +
 arch/Kconfig                                     |    4 
 arch/ia64/kernel/crash.c                         |   22 -
 arch/powerpc/Kconfig                             |   10 -
 arch/powerpc/include/asm/fadump.h                |    2 
 arch/powerpc/kernel/crash.c                      |    2 
 arch/powerpc/kernel/fadump.c                     |   57 +--
 arch/powerpc/kernel/setup-common.c               |    5 
 include/linux/crash_core.h                       |   69 +++
 include/linux/elf.h                              |    2 
 include/linux/kexec.h                            |   57 ---
 include/linux/printk.h                           |    4 
 kernel/Makefile                                  |    1 
 kernel/crash_core.c                              |  439 ++++++++++++++++++++++
 kernel/kexec_core.c                              |  431 ----------------------
 kernel/ksysfs.c                                  |    8 
 kernel/printk/printk.c                           |    6 
 17 files changed, 572 insertions(+), 570 deletions(-)
 create mode 100644 include/linux/crash_core.h
 create mode 100644 kernel/crash_core.c


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
