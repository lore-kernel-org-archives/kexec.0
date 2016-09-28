Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bp7Au-0000js-OF
 for kexec@lists.infradead.org; Wed, 28 Sep 2016 05:12:57 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8S52p9w122920
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:12:35 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25qy5sb70c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:12:35 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 28 Sep 2016 15:12:33 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1F1A12CE8056
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 15:12:30 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8S5CT3X7864654
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 15:12:29 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8S5CTVS015889
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 15:12:29 +1000
Subject: [RESEND PATCH 0/8] makedumpfile: Add support to understand Power
 ISA 3.0 based kernel
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 28 Sep 2016 10:42:25 +0530
MIME-Version: 1.0
Message-Id: <147503943620.1199.14586683563637783549.stgit@hbathini.in.ibm.com>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>

With the introduction of radix MMU in Power ISA 3.0, there are changes
in kernel page table management accommodating that. This patch series
makes appropriate changes here to work for such kernels. This series
enables address translation support for radix MMU and also, fixes a
few bugs along the way.

Resending the patches:
* by adding makedumpfile in subject to set this in context
* adding right mail id of Atsushi Kumagai

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
