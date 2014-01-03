Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vyvsl-0006vn-OH
 for kexec@lists.infradead.org; Fri, 03 Jan 2014 03:57:12 +0000
Date: Fri, 3 Jan 2014 11:56:49 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH tip/efi-kexec] x86: setup.c build fix
Message-ID: <20140103035648.GA5291@darkstar.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: matt@console-pimps.org, hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org

In case without CONFIG_EFI, there will be below build error:
   arch/x86/built-in.o: In function `setup_arch':
>> (.init.text+0x9dc): undefined reference to `parse_efi_setup'

Thus fix it by adding blank inline function in asm/efi.h
Also remove an unused declaration for variable efi_data_len.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/include/asm/efi.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: tip/arch/x86/include/asm/efi.h
===================================================================
--- tip.orig/arch/x86/include/asm/efi.h
+++ tip/arch/x86/include/asm/efi.h
@@ -142,8 +142,6 @@ struct efi_setup_data {
 };
 
 extern u64 efi_setup;
-extern u32 efi_data_len;
-extern void parse_efi_setup(u64 phys_addr, u32 data_len);
 
 #ifdef CONFIG_EFI
 
@@ -153,7 +151,7 @@ static inline bool efi_is_native(void)
 }
 
 extern struct console early_efi_console;
-
+extern void parse_efi_setup(u64 phys_addr, u32 data_len);
 #else
 /*
  * IF EFI is not configured, have the EFI calls return -ENOSYS.
@@ -165,6 +163,7 @@ extern struct console early_efi_console;
 #define efi_call4(_f, _a1, _a2, _a3, _a4)		(-ENOSYS)
 #define efi_call5(_f, _a1, _a2, _a3, _a4, _a5)		(-ENOSYS)
 #define efi_call6(_f, _a1, _a2, _a3, _a4, _a5, _a6)	(-ENOSYS)
+static inline void parse_efi_setup(u64 phys_addr, u32 data_len) {}
 #endif /* CONFIG_EFI */
 
 #endif /* _ASM_X86_EFI_H */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
