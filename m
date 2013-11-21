Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjNcM-0001dv-PH
 for kexec@lists.infradead.org; Thu, 21 Nov 2013 06:19:59 +0000
Message-Id: <20131121061756.482263617@dhcp-16-126.nay.redhat.com>
Date: Thu, 21 Nov 2013 14:17:12 +0800
From: dyoung@redhat.com
Subject: [patch 8/9 v3] x86: add xloadflags bit for efi runtime support on
 kexec
References: <20131121061704.363730447@dhcp-16-126.nay.redhat.com>
Content-Disposition: inline;
 filename=08-add-xloadflags-for-kexec-efi-runtime-feature.patch
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

Old kexec-tools can not load new kernel. The reason is previously kexec-tools
do not fill efi_info in x86 setup header thus efi init fail and switch
to noefi boot. In new kexec-tools it will by default fill efi_info and
pass other efi required infomation to 2nd kernel so kexec kernel efi
initialization will success finally.

To prevent from breaking userspace, add a new xloadflags bit so kexec-tools
will check the flag and switch to old logic.

changelog:
Matt: +&& defined(CONFIG_KEXEC)
HPA: document the flag.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 Documentation/x86/boot.txt            |    3 +++
 arch/x86/boot/header.S                |    9 ++++++++-
 arch/x86/include/uapi/asm/bootparam.h |    1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

--- efi.orig/arch/x86/boot/header.S
+++ efi/arch/x86/boot/header.S
@@ -391,7 +391,14 @@ xloadflags:
 #else
 # define XLF23 0
 #endif
-			.word XLF0 | XLF1 | XLF23
+
+#if defined(CONFIG_X86_64) && defined(CONFIG_EFI) && defined(CONFIG_KEXEC)
+# define XLF4 XLF_EFI_KEXEC
+#else
+# define XLF4 0
+#endif
+
+			.word XLF0 | XLF1 | XLF23 | XLF4
 
 cmdline_size:   .long   COMMAND_LINE_SIZE-1     #length of the command line,
                                                 #added with boot protocol
--- efi.orig/arch/x86/include/uapi/asm/bootparam.h
+++ efi/arch/x86/include/uapi/asm/bootparam.h
@@ -24,6 +24,7 @@
 #define XLF_CAN_BE_LOADED_ABOVE_4G	(1<<1)
 #define XLF_EFI_HANDOVER_32		(1<<2)
 #define XLF_EFI_HANDOVER_64		(1<<3)
+#define XLF_EFI_KEXEC			(1<<4)
 
 #ifndef __ASSEMBLY__
 
--- efi.orig/Documentation/x86/boot.txt
+++ efi/Documentation/x86/boot.txt
@@ -608,6 +608,9 @@ Protocol:       2.12+
 	- If 1, the kernel supports the 64-bit EFI handoff entry point
           given at handover_offset + 0x200.
 
+  Bit 4 (read): XLF_EFI_KEXEC
+	- If 1, the kernel supports kexec EFI boot with EFI runtime support.
+
 Field name:	cmdline_size
 Type:		read
 Offset/size:	0x238/4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
