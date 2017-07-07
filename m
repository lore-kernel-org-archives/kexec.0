Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-by2nam01on0054.outbound.protection.outlook.com
 ([104.47.34.54] helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dTTTn-00029J-1c
 for kexec@lists.infradead.org; Fri, 07 Jul 2017 13:39:34 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v9 05/38] x86/CPU/AMD: Handle SME reduction in physical
 address size
Date: Fri, 07 Jul 2017 08:39:00 -0500
Message-ID: <20170707133900.29711.29533.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <20170707133804.29711.1616.stgit@tlendack-t1.amdoffice.net>
References: <20170707133804.29711.1616.stgit@tlendack-t1.amdoffice.net>
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

When System Memory Encryption (SME) is enabled, the physical address
space is reduced. Adjust the x86_phys_bits value to reflect this
reduction.

Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/cpu/amd.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index c47ceee..5bdcbd4 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -613,15 +613,19 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 		set_cpu_bug(c, X86_BUG_AMD_E400);
 
 	/*
-	 * BIOS support is required for SME. If BIOS has not enabled SME
-	 * then don't advertise the feature (set in scattered.c)
+	 * BIOS support is required for SME. If BIOS has enabld SME then
+	 * adjust x86_phys_bits by the SME physical address space reduction
+	 * value. If BIOS has not enabled SME then don't advertise the
+	 * feature (set in scattered.c).
 	 */
 	if (cpu_has(c, X86_FEATURE_SME)) {
 		u64 msr;
 
 		/* Check if SME is enabled */
 		rdmsrl(MSR_K8_SYSCFG, msr);
-		if (!(msr & MSR_K8_SYSCFG_MEM_ENCRYPT))
+		if (msr & MSR_K8_SYSCFG_MEM_ENCRYPT)
+			c->x86_phys_bits -= (cpuid_ebx(0x8000001f) >> 6) & 0x3f;
+		else
 			clear_cpu_cap(c, X86_FEATURE_SME);
 	}
 }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
