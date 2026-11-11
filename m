Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD27060A383D
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 23:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FtkkwGLE;
	dkim=pass (2048-bit key, unprotected) header.d=cressey.dev header.i=@cressey.dev header.a=rsa-sha256 header.s=key1 header.b=YlEF5l7M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:To:Subject:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=ibaTJ8TCP6OWunZ7wZlURPIe35dSzkZ2HZ9fJtO8n3g=; b=FtkkwGLEI9WFvz0Ysi+9WRGDa5
	Ugr0q/FK8G44ZpeiZWYfD8FiLaha3JzcgjNVThIj/HXSA6NMdceOTFApzHI63r2nwGh9CbYE3yb+P
	YHLC+lMRkkltlEmvHy7dXJJPeimKsmiY/HOAL8w63b8o4o7YzYoRNHV+lbefYA10F0EUvXeVKocw8
	pNOduwG+04Md66pf/1SgZe/azMWWqKo8dFL2NThFzQeqXmw1srIjtT3pMl+JppUjJQlQ5/Frw/+my
	OV8grXP0rO1NfMtSLTJj/5YE+crZwvQqielrHoDQg2m44oAArlJXdODdWSCvj+4Y3izq3p1WPD24s
	rB4k5SEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRHiq-000000088V5-2I7p;
	Wed, 11 Nov 2026 23:27:20 +0000
Received: from out-195.mta0.migadu.com ([2001:41d0:1004:224b::c3] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRHin-000000088U8-3aNC
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 23:27:19 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=CWD1v7MEPnp/d6fyb0l0aAU6Shc6s8sYA1kH4JoyyVM=;
 c=simple/simple; d=cressey.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794439635; v=1; x=1795044435;
 b=YlEF5l7MuoJB7IMWXmZD4EcQLWviYVcchvOXjgxzUAR3iBb//dWsEcUaWEjUR5dm+/BzewZg
 UbyYgtdiZ/qi2dswprlmlL+AkTfWdDK2Kd6Ulux/v9/XxK27YeWdOamQWnUAZQ+kBNxIIeOxQcr
 AQnjYZ/ll3KT1/2vp+uIP8DuwQVxcoLgkqp8ppOmYmapwxubCQcTI0Svy/GouWyfLR+/f1STx2t
 WN/DRf7yNqHkWx/9Zira+cjXCUMUiKU36XBXjKaKhzpqEYjqvB+YtKEFbAHlfIAbfeq+mVmhALd
 fFrfFXG3xFX1rFm2t1/6oN9mCC/jF6k7df75uXFa0B6cg==
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id c31d66e627087ea2;
	Wed, 11 Nov 2026 23:27:15 +0000
X-Mizu-Trace-ID: c31d66e627087ea2
X-Migadu-Flow: FLOW_OUT
From: Ben Cressey <ben@cressey.dev>
Subject: [PATCH] x86/kexec: Type relocate_kernel() to drop __nocfi
X-Change-ID: 20261111-x86-kexec-kcfi-5b2b437413d2
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 kexec@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>
X-Mailer: b4 0.15.2
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Date: Wed, 11 Nov 2026 15:26:59 -0800
Message-Id: <20261111-x86-kexec-kcfi-v1-1-b4d41ea14deb@cressey.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_152718_043809_75A4231C 
X-CRM114-Status: GOOD (  19.89  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

machine_kexec() calls the control page's copy of relocate_kernel()
indirectly. The routine has no kCFI type, so all of machine_kexec() is
exempt since commit 2114796ca041 ("x86/kexec: Mark machine_kexec() with
__nocfi"), and ANNOTATE_NOCFI_SYM() silences objtool.

No other call there loses its check today, but one added later would.
Review of that mark on arm64 preferred a typed entry, and objected to
covering a whole function, on x86 too [1].

Typing the routine was set aside in 2025 as not worth it [2]: a type
from the caller cannot catch a prototype that drifts, and
machine_kexec() seemed unlikely to follow a stray pointer.

Type the routine with SYM_TYPED_START(), emit an ENDBR only under
CONFIG_FINEIBT, whose boot-time rewrite skips a function without one,
and drop both exemptions, along with kexec as a valid use in annotate.h.

The check guards only the pointer, and not reliably under plain FineIBT,
which checks in the callee with IBT off. A failed check panics or hangs
with no CFI report, since load_segments() has reset GS.

Link: https://lore.kernel.org/202609241804.BB23BF10@keescook # [1]
Link: https://lore.kernel.org/9c41ab61efc573e3ab5a75b6e4031f81db84a846.camel@infradead.org # [2]
Signed-off-by: Ben Cressey <ben@cressey.dev>
---
This follows Kees Cook's review [1] of the arm64 kexec fix, which goes
separately. It is not a security fix, and nothing faults here today.
The copy gains a type hash and, with CONFIG_FINEIBT=y, an ENDBR, bare
under cfi=kcfi or cfi=off. SYM_TYPED_FUNC_START() is not used, since it
would put an ENDBR in every IBT build. Code built with CONFIG_CFI=n is
unchanged. A failed check stops crash kexec too.

An LLM wrote the patch and drafted the changelog. Tested on v7.4-rc1,
defconfig plus CFI, under cfi=off, cfi=kcfi and cfi=fineibt, the last
with and without paranoid and bhi. kexec_file_load(2), kexec_load(2),
crash kexec and a preserve-context round trip pass under QEMU TCG, so
functional only. They also pass in KVM guests on Ice Lake, which has no
IBT, with small loaders in place of kexec-tools. The KHO selftest
passes under TCG, not run with bhi. A pointer of another type is
stopped in all but cfi=off, one to code with no preamble only under
kcfi and paranoid. objtool is silent with clang, CFI on and off, and
GCC 13.3. Bare-metal kexec, IBT hardware, GCC's kCFI and LTO are
untested.
---
 arch/x86/kernel/machine_kexec_64.c   |  6 +-----
 arch/x86/kernel/relocate_kernel_64.S | 17 ++++++++++++++++-
 include/linux/annotate.h             |  5 ++---
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index c3f4a389992d..c15dfbd574cb 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -381,7 +381,7 @@ void machine_kexec_cleanup(struct kimage *image)
  * Do not allocate memory (or fail in any way) in machine_kexec().
  * We are past the point of no return, committed to rebooting now.
  */
-void __nocfi machine_kexec(struct kimage *image)
+void machine_kexec(struct kimage *image)
 {
 	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
 	relocate_kernel_fn *relocate_kernel_ptr;
@@ -463,10 +463,6 @@ void __nocfi machine_kexec(struct kimage *image)
 
 	__ftrace_enabled_restore(save_ftrace_enabled);
 }
-/*
- * Handover to the next kernel, no CFI concern.
- */
-ANNOTATE_NOCFI_SYM(machine_kexec);
 
 /* arch-dependent functionality related to kexec file-based syscall */
 
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index eaeb77464c06..86e1b1c655d1 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -5,6 +5,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <linux/stringify.h>
 #include <asm/alternative.h>
 #include <asm/page_types.h>
@@ -59,9 +60,23 @@ SYM_DATA_END(kexec_debug_idt)
 
 	.section .text..relocate_kernel,"ax";
 	.code64
-SYM_CODE_START_NOALIGN(relocate_kernel)
+/*
+ * The kCFI preamble in front of this entry is copied to the control page
+ * with the code, in the form boot-time patching left it, so it must stay
+ * position independent. FineIBT+BHI adds a CALL to a preamble only if it
+ * records arguments, and __CFI_TYPE() records none whatever the prototype.
+ */
+SYM_TYPED_START(relocate_kernel, SYM_L_GLOBAL, SYM_A_NONE)
 	UNWIND_HINT_END_OF_STACK
+#ifdef CONFIG_FINEIBT
+	/*
+	 * IBT is off by now, see cet_disable(), but FineIBT only rewrites the
+	 * preamble of a function that starts with ENDBR.
+	 */
+	ENDBR
+#else
 	ANNOTATE_NOENDBR
+#endif
 	/*
 	 * %rdi indirection_page
 	 * %rsi pa_control_page
diff --git a/include/linux/annotate.h b/include/linux/annotate.h
index 2f1599c9e573..8e9a7e17e64a 100644
--- a/include/linux/annotate.h
+++ b/include/linux/annotate.h
@@ -96,9 +96,8 @@
  */
 #define ANNOTATE_REACHABLE(label)	ASM_ANNOTATE_LABEL(label, ANNOTYPE_REACHABLE)
 /*
- * This should not be used; it annotates away CFI violations. There are a few
- * valid use cases like kexec handover to the next kernel image, and there is
- * no security concern there.
+ * This should not be used; it annotates away CFI violations. The valid use
+ * case is a test that violates CFI on purpose, like LKDTM.
  *
  * There are also a few real issues annotated away, like EFI because we can't
  * control the EFI code.

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261111-x86-kexec-kcfi-5b2b437413d2


