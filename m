Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VkrsB-0007V0-3g
 for kexec@lists.infradead.org; Mon, 25 Nov 2013 08:50:27 +0000
Message-Id: <20131125084811.395808573@dhcp-16-126.nay.redhat.com>
Date: Mon, 25 Nov 2013 16:47:10 +0800
From: dyoung@redhat.com
Subject: reserve setup_data ranges late after parsing memmap cmdline
References: <20131125084659.182036023@dhcp-16-126.nay.redhat.com>
Content-Disposition: inline; filename=11-reserve-setup-data-late.patch
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

Kdump kernel using memmap=exactmap, move e820_reserve_setup_data after
parsing early params so they can be set reserved finally. Or kdump kernel
will warn about ioremap a normal ram range.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/kernel/setup.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- efi.orig/arch/x86/kernel/setup.c
+++ efi/arch/x86/kernel/setup.c
@@ -927,8 +927,6 @@ void __init setup_arch(char **cmdline_p)
 	iomem_resource.end = (1ULL << boot_cpu_data.x86_phys_bits) - 1;
 	setup_memory_map();
 	parse_setup_data();
-	/* update the e820_saved too */
-	e820_reserve_setup_data();
 
 	copy_edd();
 
@@ -990,6 +988,8 @@ void __init setup_arch(char **cmdline_p)
 		early_dump_pci_devices();
 #endif
 
+	/* update the e820_saved too */
+	e820_reserve_setup_data();
 	finish_e820_parsing();
 
 	if (efi_enabled(EFI_BOOT))


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
