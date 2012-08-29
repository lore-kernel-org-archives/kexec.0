Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6dci-0007uX-D3
 for kexec@lists.infradead.org; Wed, 29 Aug 2012 08:27:41 +0000
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 29 Aug 2012 18:26:27 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7T8ITpa25559248
 for <kexec@lists.infradead.org>; Wed, 29 Aug 2012 18:18:30 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7T8RSfd021577
 for <kexec@lists.infradead.org>; Wed, 29 Aug 2012 18:27:29 +1000
Subject: [PATCH 0/2] kexec: Limit the crash memory ranges according to first
 kernel's memory limit.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 29 Aug 2012 13:54:35 +0530
Message-ID: <20120829082201.19391.15191.stgit@mars.in.ibm.com>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Suzuki Poulose <suzuki@in.ibm.com>

So far powerpc kernel never exported memory limit information which is
reflected by mem= kernel cmdline option. Hence, kexec-tools always use
to build ELF header for entire system RAM generating a dump bigger than
the actual memory used by the first kernel.

The proposed upstream kernel patch at
https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-August/100500.html
now exports memory limit information through /proc/device-tree file.
The above patch is still in discussion.

This patch series now reads the memory limit information from
device-tree file if present and limits the crash memory ranges accordingly.

Tested these patches on ppc32(ppc440) and ppc64 with a kernel patch by Suzuki.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Tested-by: Suzuki K. Poulose <suzuki@in.ibm.com>

---

Mahesh Salgaonkar (2):
      kexec: Respect memory limit while building crash memory ranges on ppc32.
      kexec: Respect memory limit while building crash memory ranges on ppc64


 kexec/arch/ppc/crashdump-powerpc.c |   14 ++++++++---
 kexec/arch/ppc/crashdump-powerpc.h |    1 +
 kexec/arch/ppc/kexec-ppc.c         |   48 ++++++++++++++++++++++++++++++++++++
 kexec/arch/ppc64/crashdump-ppc64.c |   11 ++++++++
 kexec/arch/ppc64/crashdump-ppc64.h |    1 +
 kexec/arch/ppc64/kexec-ppc64.c     |   28 +++++++++++++++++++++
 6 files changed, 99 insertions(+), 4 deletions(-)

-- 
-Mahesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
