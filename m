Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1boyvE-0000uI-GB
 for kexec@lists.infradead.org; Tue, 27 Sep 2016 20:24:12 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8RKMTE4043397
 for <kexec@lists.infradead.org>; Tue, 27 Sep 2016 16:23:51 -0400
Received: from e28smtp06.in.ibm.com ([125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25qsadkm03-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 27 Sep 2016 16:23:50 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 28 Sep 2016 01:53:48 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 497FA1258026
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:54:06 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8RKNiTW44695594
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:53:44 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8RKNhID002226
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:53:44 +0530
Subject: [PATCH 0/8] ppc64: Add support to understand Power ISA 3.0 based
 kernel
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 28 Sep 2016 01:53:42 +0530
MIME-Version: 1.0
Message-Id: <147500776701.31772.17117150096883318333.stgit@hbathini.in.ibm.com>
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
To: Kexec-ml <kexec@lists.infradead.org>
Cc: Ken'ichi <oomichi@mxs.nes.nec.co.jp>, Tachibana-san <tachibana@mxm.nes.nec.co.jp>, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>

With the introduction of radix MMU in Power ISA 3.0, there are changes
in kernel page table management accommodating that. This patch series
makes appropriate changes here to work for such kernels. This series
enables address translation support for radix MMU and also, fixes a
few bugs along the way.

---

Hari Bathini (8):
      ppc64: fix vtop page translation for 4K pages
      ppc64: Use kernel terminology for each level in 4-level page table
      ppc64: address changes in kernel v4.5
      ppc64: address change in _PAGE_PRESNT flag for PowerISA v3.0
      ppc64: use physical addresses and unfold pud for 64K page size
      ppc64: support big endian Linux page tables
      ppc64: use the same masked bit values for 4K and 64K pagesizes
      ppc64: enable address translation support for radix mmu


 arch/ppc64.c   |  231 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 makedumpfile.c |   11 +++
 makedumpfile.h |  107 +++++++++++++++++---------
 3 files changed, 280 insertions(+), 69 deletions(-)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
