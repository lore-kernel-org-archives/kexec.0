Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-by2nam01on0076.outbound.protection.outlook.com
 ([104.47.34.76] helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dTTXa-0007Mi-9N
 for kexec@lists.infradead.org; Fri, 07 Jul 2017 13:43:27 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v9 26/38] x86/CPU/AMD: Make the microcode level available
 earlier in the boot
Date: Fri, 07 Jul 2017 08:42:58 -0500
Message-ID: <20170707134258.29711.87816.stgit@tlendack-t1.amdoffice.net>
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

Move the setting of the cpuinfo_x86.microcode field from amd_init() to
early_amd_init() so that it is available earlier in the boot process. This
avoids having to read MSR_AMD64_PATCH_LEVEL directly during early boot.

Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/cpu/amd.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 5bdcbd4..fdcf305 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -547,8 +547,12 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 
 static void early_init_amd(struct cpuinfo_x86 *c)
 {
+	u32 dummy;
+
 	early_init_amd_mc(c);
 
+	rdmsr_safe(MSR_AMD64_PATCH_LEVEL, &c->microcode, &dummy);
+
 	/*
 	 * c->x86_power is 8000_0007 edx. Bit 8 is TSC runs at constant rate
 	 * with P/T states and does not stop in deep C-states
@@ -746,8 +750,6 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
 
 static void init_amd(struct cpuinfo_x86 *c)
 {
-	u32 dummy;
-
 	early_init_amd(c);
 
 	/*
@@ -809,8 +811,6 @@ static void init_amd(struct cpuinfo_x86 *c)
 	if (c->x86 > 0x11)
 		set_cpu_cap(c, X86_FEATURE_ARAT);
 
-	rdmsr_safe(MSR_AMD64_PATCH_LEVEL, &c->microcode, &dummy);
-
 	/* 3DNow or LM implies PREFETCHW */
 	if (!cpu_has(c, X86_FEATURE_3DNOWPREFETCH))
 		if (cpu_has(c, X86_FEATURE_3DNOW) || cpu_has(c, X86_FEATURE_LM))


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
