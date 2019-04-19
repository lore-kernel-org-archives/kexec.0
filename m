Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hHUN7-00015I-HB
 for kexec@lists.infradead.org; Fri, 19 Apr 2019 14:20:11 +0000
Date: Fri, 19 Apr 2019 16:19:52 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] x86/boot: Disable RSDP parsing temporarily
Message-ID: <20190419141952.GE10324@zn.tnic>
References: <20190419101733.GA10324@zn.tnic>
 <20190419105014.GE11060@MiWiFi-R3L-srv>
 <CACPcB9fwvxmVcD4ttP8p9X0=J+Oev9RUrgNzuu6LZFQCZ7AS1w@mail.gmail.com>
 <20190419113413.GC10324@zn.tnic>
 <CACPcB9emLPEWCvpdExGvD_S_b3RWrrgK2uCx07HZjj5yUh6Y_g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACPcB9emLPEWCvpdExGvD_S_b3RWrrgK2uCx07HZjj5yUh6Y_g@mail.gmail.com>
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
To: Kairui Song <kasong@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, indou.takao@jp.fujitsu.com, Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, msys.mizuma@gmail.com, Dave Young <dyoung@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Ok,

thinking about this more, we believe it is too late in the release cycle
to keep experimenting so the only thing left to do is the below.

This should bring the situation back to what it was before, at 5.0
times, and we'll have plenty of time now to address and properly fix all
the outstanding issues.

---
From: Borislav Petkov <bp@suse.de>

The original intention to move RDSP parsing very early, before KASLR
does its ranges selection, was to accommodate movable memory regions
machines (CONFIG_MEMORY_HOTREMOVE) to still be able to do memory
hotplug.

However, that broke kexec'ing a kernel on EFI machines because depending
on where the EFI systab was mapped, on at least one machine it isn't
present in the kexec mapping of the second kernel, leading to a triple
fault in the early code.

Fixing this properly requires significantly involved surgery and we
cannot allow ourselves to do that, that close to the merge window.

So disable the RSDP parsing code temporarily until it is fixed properly
in the next release cycle.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: indou.takao@jp.fujitsu.com
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: kasong@redhat.com
Cc: Kees Cook <keescook@chromium.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: msys.mizuma@gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
---
 arch/x86/boot/compressed/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index c0d6c560df69..5a237e8dbf8d 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -352,7 +352,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	boot_params->hdr.loadflags &= ~KASLR_FLAG;
 
 	/* Save RSDP address for later use. */
-	boot_params->acpi_rsdp_addr = get_rsdp_addr();
+	/* boot_params->acpi_rsdp_addr = get_rsdp_addr(); */
 
 	sanitize_boot_params(boot_params);
 
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
