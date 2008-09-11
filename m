Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kdshu-0006Et-Ix
	for kexec@lists.infradead.org; Thu, 11 Sep 2008 20:24:02 +0000
Received: from g5t0029.atlanta.hp.com (g5t0029.atlanta.hp.com [16.228.8.141])
	by g1t0028.austin.hp.com (Postfix) with ESMTP id 459471C3A8
	for <kexec@lists.infradead.org>; Thu, 11 Sep 2008 20:24:01 +0000 (UTC)
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: SetVirtualAddressMap() on Tiano EFI firmware
Date: Thu, 11 Sep 2008 14:23:58 -0600
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200809111423.58814.bjorn.helgaas@hp.com>
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

Has kexec been tested on x86 with EFI firmware?

I'm testing it on ia64 with Tiano-based EFI firmware, and I
tripped over an issue with SetVirtualAddressMap().  I would
expect a similar problem to happen on x86, but I don't see
any code to deal with it.

The EFI SetVirtualAddressMap() interface is only supposed to
be called once.  Linux calls it once at boot-time, and if we
kexec a new Linux kernel, the new kernel calls it again.

The EFI spec suggests that if it *is* called twice,
SetVirtualAddressMap() should return EFI_UNSUPPORTED.  But
we go to great pains in purgatory (ia64_env_setup()) to patch
the function descriptor so that the new kernel's call never
even makes it to the EFI routine.  I don't know whether this
is because SetVirtualAddressMap() blows up if we call it again,
or whether we just didn't want to change Linux to ignore an
EFI_UNSUPPORTED return value.

On ia64, the SetVirtualAddressMap entry in the EFI Runtime
Services Table points to a function descriptor, and ia64_env_setup()
patches the code address in the descriptor so that when the new
kernel thinks it's calling SetVirtualAddressMap(), it's instead
calling a dummy function that immediately returns success.

In most current ia64 EFI implementations, SetVirtualAddressMap()
converts all pointers in the EFI Runtime Services Table from
physical to virtual, including the SetVirtualAddressMap pointer
itself.  ia64_env_setup() (running in physical mode) converts
the SetVirtualAddressMap pointer from virtual to physical by
subtracting PAGE_OFFSET.

But new Tiano-based EFI implementations do *not* convert the
SetVirtualAddressMap pointer to virtual -- they leave it as physical.
So when ia64_env_setup() subtracts PAGE_OFFSET from the physical
address, it ends up with garbage, and patching the function
descriptor causes an MCA.

The following patch makes kexec-tools work on either old or new
firmware.  Masking out the top nibble of either a physical address
or a virtual address in region 7 results in a physical address.

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
