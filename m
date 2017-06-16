Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bl2nam02on0061.outbound.protection.outlook.com
 ([104.47.38.61] helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dLwLy-0000o6-Ul
 for kexec@lists.infradead.org; Fri, 16 Jun 2017 18:52:20 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v7 11/36] x86/mm: Add SME support for read_cr3_pa()
Date: Fri, 16 Jun 2017 13:51:55 -0500
Message-ID: <20170616185154.18967.71073.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
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
To: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, xen-devel@lists.xen.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, "Michael S. Tsirkin" <mst@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, Paolo Bonzini <pbonzini@redhat.com>

The cr3 register entry can contain the SME encryption mask that indicates
the PGD is encrypted.  The encryption mask should not be used when
creating a virtual address from the cr3 register, so remove the SME
encryption mask in the read_cr3_pa() function.

During early boot SME will need to use a native version of read_cr3_pa(),
so create native_read_cr3_pa().

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/processor-flags.h |    3 ++-
 arch/x86/include/asm/processor.h       |    5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor-flags.h b/arch/x86/include/asm/processor-flags.h
index 79aa2f9..cb6999c 100644
--- a/arch/x86/include/asm/processor-flags.h
+++ b/arch/x86/include/asm/processor-flags.h
@@ -2,6 +2,7 @@
 #define _ASM_X86_PROCESSOR_FLAGS_H
 
 #include <uapi/asm/processor-flags.h>
+#include <linux/mem_encrypt.h>
 
 #ifdef CONFIG_VM86
 #define X86_VM_MASK	X86_EFLAGS_VM
@@ -33,7 +34,7 @@
  */
 #ifdef CONFIG_X86_64
 /* Mask off the address space ID bits. */
-#define CR3_ADDR_MASK 0x7FFFFFFFFFFFF000ull
+#define CR3_ADDR_MASK __sme_clr(0x7FFFFFFFFFFFF000ull)
 #define CR3_PCID_MASK 0xFFFull
 #else
 /*
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 8010c97..ab878bd 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -240,6 +240,11 @@ static inline unsigned long read_cr3_pa(void)
 	return __read_cr3() & CR3_ADDR_MASK;
 }
 
+static inline unsigned long native_read_cr3_pa(void)
+{
+	return __native_read_cr3() & CR3_ADDR_MASK;
+}
+
 static inline void load_cr3(pgd_t *pgdir)
 {
 	write_cr3(__sme_pa(pgdir));


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
