Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KmrwM-0003Lh-Or
	for kexec@lists.infradead.org; Mon, 06 Oct 2008 15:24:07 +0000
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch] ia64: make PA() work for both physical identity-mapped
	virtual addresses
Date: Mon, 6 Oct 2008 09:24:03 -0600
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200810060924.04033.bjorn.helgaas@hp.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>, "Lombard,
	David N" <dnlombar@ichips.intel.com>

The EFI Runtime Services Table contains pointers to ia64 function
descriptors.  On existing, pre-Tiano, firmware, SetVirtualAddressMap()
converts *all* these pointers from physical to virtual.  On Tiano-based
firmware, the pointer to the SetVirtualAddressMap() function descriptor
is not converted, so it remains a physical pointer.

The ia64 kexec purgatory patches the SetVirtualAddressMap() function
descriptor so that when the new kernel calls SetVirtualAddressMap(), it
never reaches firmware.  Instead, it calls a dummy function that just
returns success.

Purgatory runs in physical mode, so it must convert the pointer from the
RuntimeServicesTable to a physical address.  This patch makes that
conversion work both for old firmware (where the pointer is an identity-
mapped virtual address) and new Tiano firmware (where the pointer is a
physical address).

Without this patch, kexec on Tiano firmware causes an MCA because
ia64_env_setup() subtracts PAGE_OFFSET from a physical address and ends
up with an invalid physical address.  Referencing that address causes
the MCA.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

diff --git a/purgatory/arch/ia64/purgatory-ia64.c b/purgatory/arch/ia64/purgatory-ia64.c
index b2fe6d4..acacb56 100644
--- a/purgatory/arch/ia64/purgatory-ia64.c
+++ b/purgatory/arch/ia64/purgatory-ia64.c
@@ -147,7 +147,7 @@ setup_arch(void)
 
 inline unsigned long PA(unsigned long addr)
 {
-	return addr - PAGE_OFFSET;
+	return addr & 0x0fffffffffffffffLL;
 }
 
 void

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
