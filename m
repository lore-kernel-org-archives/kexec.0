Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D642FC9831E
	for <kexec@archiver.kernel.org>; Fri, 25 Sep 2026 02:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4NZMBuFlBSPtFWQr/+9V5+/tkqwiVb2mT8iCwcDe+8A=; b=rP/8MA9gDWSpR4GqM+eBlJLywj
	KFXYzpx93MYXQ4OLLsgaibACV5dNk/52NCzDdyJ4OrMOTKlIyRNVO0uxsa81SngSxytQO9lMIbma2
	eQJEpGJqflAjo45cwfH2weHEdZyR2EBAi34O3oUmfbkmOAAQCn1lU6Fa9Mq/mV30PkAn4p1SEcO3X
	xFTwDP4FBub4PYV/o27Ol4cROz77tQNzEIASO6kmV6DwB/PjwCOQ6VzPmAaEraIrkzvx1S0RpZ+JT
	KUvmjKWIfdsJ6aZW+dIeR+BEVaXZ6WjGYg1j5dT/s0vDZP+n3uaSklqhI5lPluMuAAaT41IkT5g/y
	JjYEn84w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9vSh-0000000CX9R-1MhR;
	Fri, 25 Sep 2026 02:14:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9vSf-0000000CX9I-2YAc;
	Fri, 25 Sep 2026 02:14:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C0CD640940;
	Fri, 25 Sep 2026 02:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09A71F000FF;
	Fri, 25 Sep 2026 02:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790302492;
	bh=4NZMBuFlBSPtFWQr/+9V5+/tkqwiVb2mT8iCwcDe+8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RtZfvI+0S4V+OekP5WBn1nVIUqDPiXLFh3fdRqN8ZDUwVce/S4asXsblhu3wC7DOE
	 GbAIh9/C07mr0GF0tbofTmf5Vh0QKmJfWlUDUQKZbx5gDAAcqcXWxm0sgLQc//ypHv
	 jO9CmqTIYSTr9t9weTOjL/NCQbH2O/ONs0pTwsy/iCX3GdEjutOGBw8JIjznuZF3M5
	 L9mY4BtABZcPbuC7nChFNUEdrvwSCyUvTACaL1efLT9QKt6flCrcCxo6cKHwv7vxLo
	 laFfSlVsH6bLZ+kmYF9DAgd+zE2yBn9b2RxyvFW9ozMp74Cn8CBLnSECJFK8Jp0Lj3
	 67LYDZ+gM9l5Q==
Date: Thu, 24 Sep 2026 19:14:52 -0700
From: Kees Cook <kees@kernel.org>
To: Ben Cressey <ben@cressey.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>,
	David Woodhouse <dwmw@amazon.co.uk>, kexec@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: kexec: mark machine_kexec() __nocfi
Message-ID: <202609241804.BB23BF10@keescook>
References: <20260924-arm64-kexec-nocfi-v1-1-bbae2e2eadc8@cressey.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924-arm64-kexec-nocfi-v1-1-bbae2e2eadc8@cressey.dev>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Sep 24, 2026 at 10:42:30PM +0000, Ben Cressey wrote:
> With CONFIG_CFI=y the kCFI check on this call loads a type hash from
> kern_reloc - 4. arm64_relocate_new_kernel is SYM_CODE_START and carries
> no hash. Its copy also sits at the start of the control page, which is
> all that TTBR0 maps at this point, so the load faults and the kernel
> oopses after "Bye!" instead of entering the new kernel:
> [...]
> arm64_relocate_new_kernel cannot be given a type hash, since the linker
> script asserts that the relocation code starts at that symbol and a
> hash would have to precede it. Mark machine_kexec() __nocfi instead, as
> commit e2f8216ca2d8 ("arm64: Set __nocfi on swsusp_arch_resume()") did
> for the same pattern on the hibernate path and commit 2114796ca041
> ("x86/kexec: Mark machine_kexec() with __nocfi") did on x86.

I think e2f8216ca2d8 made a mistake here; using SYM_TYPED_FUNC_START
wouldn't have been tautological: the defense is making sure that the
indirect call itself can't be used with a bad pointer. Fixing this
correctly isn't so bad: it just needs to decouple the entrypoint from
the page address.

But, barring that, what I don't like here (and with x86) is that it
covers the entire function, so _all_ indirect calls go unprotected.

Can you pull the call out into an inline helper so that the other
indirect call (cpu_soft_restart) doesn't lose coverage?

-Kees

P.S.

Doing the whole SYM_TYPED_FUNC_START change (below, only build tested)
is larger, but maybe things besides KCFI will want things before the
entry point?

 arch/arm64/include/asm/kexec.h      |    2 ++
 arch/arm64/kernel/machine_kexec.c   |   13 +++++++++++--
 arch/arm64/kernel/relocate_kernel.S |   14 +++++++++-----
 arch/arm64/kernel/vmlinux.lds.S     |    5 +++--
 4 files changed, 25 insertions(+), 9 deletions(-)


diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 892e5bebda957..0be042ec22c1f 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -100,6 +100,8 @@ void cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
 		      unsigned long arg0, unsigned long arg1,
 		      unsigned long arg2);
 
+void arm64_relocate_new_kernel(struct kimage *kimage);
+
 int machine_kexec_post_load(struct kimage *image);
 #define machine_kexec_post_load machine_kexec_post_load
 #endif
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 8f9bc2327dc85..1cf4cb135ee2b 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -136,9 +136,18 @@ int machine_kexec_post_load(struct kimage *kimage)
 	kimage->arch.ttbr1 = __pa(trans_pgd);
 	kimage->arch.zero_page = __pa_symbol(empty_zero_page);
 
+	/*
+	 * The whole .kexec_relocate.text section is copied to the control
+	 * page, but arm64_relocate_new_kernel is not required to be the first
+	 * thing in it. Allow for whatever precedes it (e.g. a landing pad,
+	 * a kCFI type hash, etc) by carrying its offset within the section
+	 * across the copy.
+	 */
 	reloc_size = __relocate_new_kernel_end - __relocate_new_kernel_start;
 	memcpy(reloc_code, __relocate_new_kernel_start, reloc_size);
-	kimage->arch.kern_reloc = __pa(reloc_code);
+	kimage->arch.kern_reloc = __pa(reloc_code) +
+		((unsigned long)arm64_relocate_new_kernel -
+		 (unsigned long)__relocate_new_kernel_start);
 	rc = trans_pgd_idmap_page(&info, &kimage->arch.ttbr0,
 				  &kimage->arch.t0sz, reloc_code);
 	if (rc)
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index af1d720209764..81540c09a3db8 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -432,6 +432,7 @@ ASSERT(swapper_pg_dir - tramp_pg_dir == TRAMP_SWAPPER_OFFSET,
 ASSERT(__relocate_new_kernel_end - __relocate_new_kernel_start <= SZ_4K,
        "kexec relocation code is bigger than 4 KiB")
 ASSERT(KEXEC_CONTROL_PAGE_SIZE >= SZ_4K, "KEXEC_CONTROL_PAGE_SIZE is broken")
-ASSERT(__relocate_new_kernel_start == arm64_relocate_new_kernel,
-       "kexec control page does not start with arm64_relocate_new_kernel")
+ASSERT(arm64_relocate_new_kernel >= __relocate_new_kernel_start &&
+       arm64_relocate_new_kernel < __relocate_new_kernel_end,
+       "kexec relocation entry point is outside the copied region")
 #endif
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 1cf4cb135ee2b..90302efebb426 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -202,7 +202,7 @@ void machine_kexec(struct kimage *kimage)
 		restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
 			0, 0);
 	} else {
-		void (*kernel_reloc)(struct kimage *kimage);
+		typeof(arm64_relocate_new_kernel) *kernel_reloc;
 
 		if (is_hyp_nvhe())
 			__hyp_set_vectors(kimage->arch.el2_vectors);
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 6cb4209f5dab5..e3e575c57fe12 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -8,6 +8,7 @@
  * Pasha Tatashin <pasha.tatashin@soleen.com>
  */
 
+#include <linux/cfi_types.h>
 #include <linux/kexec.h>
 #include <linux/linkage.h>
 
@@ -32,11 +33,14 @@
  * new image to its final location.  To assure that the
  * arm64_relocate_new_kernel routine which does that copy is not overwritten,
  * all code and data needed by arm64_relocate_new_kernel must be between the
- * symbols arm64_relocate_new_kernel and arm64_relocate_new_kernel_end.  The
- * machine_kexec() routine will copy arm64_relocate_new_kernel to the kexec
- * safe memory that has been set up to be preserved during the copy operation.
+ * symbols __relocate_new_kernel_start and __relocate_new_kernel_end.  The
+ * machine_kexec() routine will copy that whole region to the kexec safe
+ * memory that has been set up to be preserved during the copy operation,
+ * and enter it at arm64_relocate_new_kernel's offset within it.
+ *
+ * It is called indirectly, through the copy, so it needs a kCFI type hash.
  */
-SYM_CODE_START(arm64_relocate_new_kernel)
+SYM_TYPED_FUNC_START(arm64_relocate_new_kernel)
 	/*
 	 * The kimage structure isn't allocated specially and may be clobbered
 	 * during relocation. We must load any values we need from it prior to
@@ -98,4 +102,4 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	mov	x2, xzr
 	mov	x3, xzr
 	br	x28				/* Jumps from el1 */
-SYM_CODE_END(arm64_relocate_new_kernel)
+SYM_FUNC_END(arm64_relocate_new_kernel)


-- 
Kees Cook

