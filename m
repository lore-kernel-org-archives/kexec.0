Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cAF55-0003vq-Kz
 for kexec@lists.infradead.org; Fri, 25 Nov 2016 11:54:17 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAPBmxq2031665
 for <kexec@lists.infradead.org>; Fri, 25 Nov 2016 06:53:54 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26xh7rp6ug-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 25 Nov 2016 06:53:54 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 25 Nov 2016 21:53:51 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 70A5C2BB0059
 for <kexec@lists.infradead.org>; Fri, 25 Nov 2016 22:53:49 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAPBrnjG22282360
 for <kexec@lists.infradead.org>; Fri, 25 Nov 2016 22:53:49 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAPBrmrU015073
 for <kexec@lists.infradead.org>; Fri, 25 Nov 2016 22:53:49 +1100
Subject: [PATCH v2 0/5] kexec/fadump: remove dependency with CONFIG_KEXEC
 and reuse crashkernel parameter for fadump
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 25 Nov 2016 17:23:40 +0530
MIME-Version: 1.0
Message-Id: <148007477669.1053.4107773905913128028.stgit@hbathini.in.ibm.com>
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
To: linux-kernel@vger.kernel.org
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, ebiederm@xmission.com, Michael Ellerman <mpe@ellerman.id.au>, dyoung@redhat.com, vgoyal@redhat.com

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


Changes from v1:
* Moved arch specify code to seperate patches. Introduced one patch for IA64 arch
  and another patch for powerpc in the process.

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
 arch/powerpc/Kconfig                             |   10 
 arch/powerpc/include/asm/fadump.h                |    2 
 arch/powerpc/kernel/crash.c                      |    2 
 arch/powerpc/kernel/fadump.c                     |   57 +--
 arch/powerpc/kernel/setup-common.c               |    5 
 include/linux/crash_core.h                       |   75 ++++
 include/linux/kexec.h                            |   63 ---
 kernel/Makefile                                  |    1 
 kernel/crash_core.c                              |  450 ++++++++++++++++++++++
 kernel/kexec_core.c                              |  435 ---------------------
 13 files changed, 575 insertions(+), 574 deletions(-)
 create mode 100644 include/linux/crash_core.h
 create mode 100644 kernel/crash_core.c


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
