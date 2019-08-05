Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1huYTJ-0008Dh-5g
 for kexec@lists.infradead.org; Mon, 05 Aug 2019 08:36:02 +0000
Date: Mon, 5 Aug 2019 16:35:53 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH] do not clean dummy variable in kexec path
Message-ID: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: linux-efi@vger.kernel.org, ard.biesheuvel@linaro.org
Cc: matthewgarrett@google.com, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

kexec reboot fails randomly in UEFI based kvm guest.  The firmware
just reset while calling efi_delete_dummy_variable();  Unfortunately
I don't know how to debug the firmware, it is also possible a potential
problem on real hardware as well although nobody reproduced it.

The intention of efi_delete_dummy_variable is to trigger garbage collection
when entering virtual mode.  But SetVirtualAddressMap can only run once
for each physical reboot, thus kexec_enter_virtual_mode is not necessarily
a good place to clean dummy object.

Drop efi_delete_dummy_variable so that kexec reboot can work.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/platform/efi/efi.c |    3 ---
 1 file changed, 3 deletions(-)

--- linux-x86.orig/arch/x86/platform/efi/efi.c
+++ linux-x86/arch/x86/platform/efi/efi.c
@@ -894,9 +894,6 @@ static void __init kexec_enter_virtual_m
 
 	if (efi_enabled(EFI_OLD_MEMMAP) && (__supported_pte_mask & _PAGE_NX))
 		runtime_code_page_mkexec();
-
-	/* clean DUMMY object */
-	efi_delete_dummy_variable();
 #endif
 }
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
