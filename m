Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hRdFq-0006VZ-D7
 for kexec@lists.infradead.org; Fri, 17 May 2019 13:50:35 +0000
Date: Fri, 17 May 2019 15:50:30 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] x86/boot: Call get_rsdp_addr() after console_init()
Message-ID: <20190517135030.GB13482@zn.tnic>
References: <20190424092944.30481-2-bhe@redhat.com>
 <20190429002318.GA25400@MiWiFi-R3L-srv>
 <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic>
 <20190513080653.GD16774@MiWiFi-R3L-srv>
 <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
 <20190517134159.GA13482@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190517134159.GA13482@zn.tnic>
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
To: Dave Young <dyoung@redhat.com>
Cc: fanc.fnst@cn.fujitsu.com, kasong@redhat.com, Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, j-nomura@ce.jp.nec.com, tglx@linutronix.de

And now as a proper patch:

---
From: Borislav Petkov <bp@suse.de>

... so that early debugging output from the RSDP parsing code can be
visible and collected.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Baoquan He <bhe@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Cc: Kairui Song <kasong@redhat.com>
Cc: kexec@lists.infradead.org
Cc: x86@kernel.org
---
 arch/x86/boot/compressed/misc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index c0d6c560df69..24e65a0f756d 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -351,9 +351,6 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	/* Clear flags intended for solely in-kernel use. */
 	boot_params->hdr.loadflags &= ~KASLR_FLAG;
 
-	/* Save RSDP address for later use. */
-	boot_params->acpi_rsdp_addr = get_rsdp_addr();
-
 	sanitize_boot_params(boot_params);
 
 	if (boot_params->screen_info.orig_video_mode == 7) {
@@ -368,6 +365,14 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	cols = boot_params->screen_info.orig_video_cols;
 
 	console_init();
+
+	/*
+	 * Save RSDP address for later use. Have this after console_init()
+	 * so that early debugging output from the RSDP parsing code can be
+	 * collected.
+	 */
+	boot_params->acpi_rsdp_addr = get_rsdp_addr();
+
 	debug_putstr("early console in extract_kernel\n");
 
 	free_mem_ptr     = heap;	/* Heap */
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
