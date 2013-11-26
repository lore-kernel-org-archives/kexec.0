Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlBhQ-0000pS-Uu
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 06:00:41 +0000
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH v4 09/12] x86: add xloadflags bit for efi runtime support on
 kexec
Date: Tue, 26 Nov 2013 13:57:54 +0800
Message-Id: <1385445477-9665-10-git-send-email-dyoung@redhat.com>
In-Reply-To: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

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
 Documentation/x86/boot.txt            | 3 +++
 arch/x86/boot/header.S                | 9 ++++++++-
 arch/x86/include/uapi/asm/bootparam.h | 1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/boot.txt b/Documentation/x86/boot.txt
index f4f268c..cb81741d 100644
--- a/Documentation/x86/boot.txt
+++ b/Documentation/x86/boot.txt
@@ -608,6 +608,9 @@ Protocol:       2.12+
 	- If 1, the kernel supports the 64-bit EFI handoff entry point
           given at handover_offset + 0x200.
 
+  Bit 4 (read): XLF_EFI_KEXEC
+	- If 1, the kernel supports kexec EFI boot with EFI runtime support.
+
 Field name:	cmdline_size
 Type:		read
 Offset/size:	0x238/4
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 9ec06a1..ec3b8ba 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
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
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index ed6afc9..505eecf 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -24,6 +24,7 @@
 #define XLF_CAN_BE_LOADED_ABOVE_4G	(1<<1)
 #define XLF_EFI_HANDOVER_32		(1<<2)
 #define XLF_EFI_HANDOVER_64		(1<<3)
+#define XLF_EFI_KEXEC			(1<<4)
 
 #ifndef __ASSEMBLY__
 
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
