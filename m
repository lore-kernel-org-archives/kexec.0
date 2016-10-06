Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bs4jH-0008Cd-C1
 for kexec@lists.infradead.org; Thu, 06 Oct 2016 09:12:40 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [RESEND PATCH 0/8] makedumpfile: Add support to understand
 Power ISA 3.0 based kernel
Date: Thu, 6 Oct 2016 09:08:03 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E6DDC0@BPXM01GP.gisp.nec.co.jp>
References: <147503943620.1199.14586683563637783549.stgit@hbathini.in.ibm.com>
In-Reply-To: <147503943620.1199.14586683563637783549.stgit@hbathini.in.ibm.com>
Content-Language: ja-JP
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>

Hello Hari,

>SA 3.0 based kernel
>
>With the introduction of radix MMU in Power ISA 3.0, there are changes
>in kernel page table management accommodating that. This patch series
>makes appropriate changes here to work for such kernels. This series
>enables address translation support for radix MMU and also, fixes a
>few bugs along the way.
>
>Resending the patches:
>* by adding makedumpfile in subject to set this in context
>* adding right mail id of Atsushi Kumagai
>
>---
>
>Hari Bathini (8):
>      ppc64: fix vtop page translation for 4K pages
>      ppc64: Use kernel terminology for each level in 4-level page table
>      ppc64: address changes in kernel v4.5
>      ppc64: address change in _PAGE_PRESNT flag for PowerISA v3.0
>      ppc64: use physical addresses and unfold pud for 64K page size
>      ppc64: support big endian Linux page tables
>      ppc64: use the same masked bit values for 4K and 64K pagesizes
>      ppc64: enable address translation support for radix mmu

I've reviewed them and they look good to me.
I'll merge them into v1.6.1, thanks for your work.

Regards,
Atsushi Kumagai

>
> arch/ppc64.c   |  231 ++++++++++++++++++++++++++++++++++++++++++++++++--------
> makedumpfile.c |   11 +++
> makedumpfile.h |  107 +++++++++++++++++---------
> 3 files changed, 280 insertions(+), 69 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
