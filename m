Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U5DOF-0000uM-6w
 for kexec@lists.infradead.org; Tue, 12 Feb 2013 10:47:09 +0000
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 12 Feb 2013 20:39:55 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1196D3578023
 for <kexec@lists.infradead.org>; Tue, 12 Feb 2013 21:46:55 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1CAYij466978004
 for <kexec@lists.infradead.org>; Tue, 12 Feb 2013 21:34:44 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1CAksAa024032
 for <kexec@lists.infradead.org>; Tue, 12 Feb 2013 21:46:54 +1100
Subject: [PATCH v2 0/2] kexec: Limit the crash memory ranges according to
 first kernel's memory limit.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 12 Feb 2013 16:16:50 +0530
Message-ID: <20130212104624.7781.32716.stgit@mars.in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, Kexec-ml <kexec@lists.infradead.org>
Cc: Suzuki Poulose <suzuki@in.ibm.com>, Ananth Narayan <ananth@in.ibm.com>, bhe@redhat.com

So far powerpc kernel never exported memory limit information which is
reflected by mem= kernel cmdline option. Hence, kexec-tools always use
to build ELF header for entire system RAM generating a dump bigger than
the actual memory used by the first kernel.

The following upstream kernel commits now exports memory limit information
through /proc/device-tree file:
  4bc77a5ed - powerpc: Export memory limit via device tree
  a84fcd468 - powerpc: Change memory_limit from phys_addr_t to unsigned
	      long long

This patch series now reads the memory limit information from
device-tree file if present and limits the crash memory ranges accordingly.

Tested these patches on ppc32(ppc440) and ppc64 with a kernel patch by Suzuki.

Changes in v2:
- Fixed few formatting and coding style issues.
- Fixed error handling path and possible buffer overflow issue in patch 1/2.
- Fixed an issue where an additional PT_LOAD section, representing zero size
  memory segment (with start address == memory_limit), was getting added to ELF
  section.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Tested-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---

Mahesh Salgaonkar (2):
      kexec: Respect memory limit while building crash memory ranges on ppc32.
      kexec: Respect memory limit while building crash memory ranges on ppc64


 kexec/arch/ppc/crashdump-powerpc.c |   14 ++++++++--
 kexec/arch/ppc/crashdump-powerpc.h |    1 +
 kexec/arch/ppc/kexec-ppc.c         |   51 ++++++++++++++++++++++++++++++++++++
 kexec/arch/ppc64/crashdump-ppc64.c |   11 +++++++-
 kexec/arch/ppc64/crashdump-ppc64.h |    1 +
 kexec/arch/ppc64/kexec-ppc64.c     |   27 +++++++++++++++++++
 6 files changed, 101 insertions(+), 4 deletions(-)

-- 
-Mahesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
