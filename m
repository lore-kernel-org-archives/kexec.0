Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C520D60A2611
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=l7FuO6uR;
	dkim=pass (2048-bit key, unprotected) header.d=cressey.dev header.i=@cressey.dev header.a=rsa-sha256 header.s=key1 header.b=Sn33619E
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:To:
	Subject:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=RyEZLtXdOEy6YUs0iF5WO14oNHotCxIJ28slgWaTiiU=; b=l7FuO6uRn7RoZz
	+Q7hqmLWY4PGsrj3m+/y356AbMaQZTHcDNYHS7uVIxV2dowhdCIhmbs+glB7Gqsei7eqtw+Sujn5J
	kx/UmidIJiJbdtzUJNppg+mSh1d+EAToqhp3ZcbdH/UcfYfuyPzTFqexu93e2SiM9KG7u1U2Tf3L1
	U3Tmlo5W50dFuuTxxEKE1mnDBRa3bW8SBGk3+mXkupQ/q5I97fuG1txpdRR42z93U7jumsMJkJ554
	PApNJiT8VKnU0jEKAC/AypnflmW8pD9gZjK13a5/iGeJxyJC3ZvALxgWEj24QHyFf0oWC5mwg1A5l
	gW42tAcIYLwaJncyGUoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRHiA-0000000889u-24m6;
	Wed, 11 Nov 2026 23:26:38 +0000
Received: from out-170.mta0.migadu.com ([2001:41d0:1004:224b::aa] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRHi5-0000000886Z-37ut
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 23:26:37 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=Z+IeZxbPjIvbK3g0gOTsghY/BOFs/EzEtXZfgL4WUf8=;
 c=simple/simple; d=cressey.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794439591; v=1; x=1795044391;
 b=Sn33619EXcFGXCJK9LnzuueZXjZ9jbMi1mpw0G48KB9e2lRh9CHxJZP3OSp9X01dciXn80UK
 5zueYCDAo+Ky4oeq3N4IEd0zCdxK1lxYosEKo+Z88gl3driG7qIQ+LKae/JZscfJkOBk/juiZxq
 lV31+W1vYpD0MaXXOTDxOTCaCd7gTuvBNFkw/yMzStUtiTi/5bc6FfTZZ9NSx9Km10umlvGpl+O
 mC+u3ZH+MxOMreOEpahEhK+tf7aMp3y6P3n1kec9Oj8myFa7NHQbEznXAEgQBw7FTAV8k6W+JV5
 Ya+Oly/3jwGB/x1HysV0wgEMLlRF6egx5bUKSYXUJfARw==
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id fa50d89f0875e7b8;
	Wed, 11 Nov 2026 23:26:31 +0000
X-Mizu-Trace-ID: fa50d89f0875e7b8
X-Migadu-Flow: FLOW_OUT
From: Ben Cressey <ben@cressey.dev>
Subject: [PATCH v2 1/2] arm64: kexec: use a typed entry to fix kCFI oops
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Kees Cook <kees@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, kexec@lists.infradead.org, 
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>, 
 Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
 Jeson Gao <jeson.gao@unisoc.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Date: Wed, 11 Nov 2026 15:26:04 -0800
Message-Id: <20261111-arm64-kexec-nocfi-v2-1-ddf0c4aa326f@cressey.dev>
In-Reply-To: <20261111-arm64-kexec-nocfi-v2-0-ddf0c4aa326f@cressey.dev>
References: <20261111-arm64-kexec-nocfi-v2-0-ddf0c4aa326f@cressey.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_152636_431747_8151629C 
X-CRM114-Status: GOOD (  18.57  )
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

An arm64 Linux kernel built with CONFIG_CFI=y oopses after "Bye!" on
every kexec that relocates the image. Crash images load in place and are
not affected. The oops reproduces under QEMU:

 Unable to handle kernel paging request at virtual address 00000000544bfffc
 pc : machine_kexec+0x104/0x274
 Code: d5182008 d5033fdf aa1303e0 f9418a68 (b85fc110)

b85fc110 is "ldur w16, [x8, #-4]", the kCFI check's load of the type
hash in front of the callee. Commit efc2d0f20a9d ("arm64: kexec: keep
MMU enabled during kexec relocation") made machine_kexec() call the
control page's copy of arm64_relocate_new_kernel() indirectly, while
TTBR0 maps only that page. The copy starts at the page's first byte, so
the load faults. SYM_CODE_START() also gives the routine no hash.

SYM_TYPED_FUNC_START() emits the hash inside .kexec_relocate.text, and
machine_kexec_post_load() already copies that whole section, at most
4 KiB, to the page's start, so the mapped page holds both hash and
entry.

The ASSERT from commit dc4824faa265 ("arm64: avoid executing padding
bytes during kexec / hibernation") kept the entry first, since C
branched to the page's start. Relax it, so the entry need only be in the
section.

Fix by typing the routine with SYM_TYPED_FUNC_START() and a C prototype,
and entering the copy at the symbol's offset in the section.

The code is Kees Cook's, as posted in review, with two comments and the
ASSERT message reworded.

An LLM diagnosed the oops.

Fixes: efc2d0f20a9d ("arm64: kexec: keep MMU enabled during kexec relocation")
Cc: stable@vger.kernel.org
Suggested-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/linux-arm-kernel/202609241804.BB23BF10@keescook/
Signed-off-by: Ben Cressey <ben@cressey.dev>
---
 arch/arm64/include/asm/kexec.h      |  2 ++
 arch/arm64/kernel/machine_kexec.c   |  7 +++++--
 arch/arm64/kernel/relocate_kernel.S | 11 +++++++----
 arch/arm64/kernel/vmlinux.lds.S     |  5 +++--
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 892e5bebda95..0be042ec22c1 100644
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
index 48f343704cb5..24366b5b3259 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -147,9 +147,12 @@ int machine_kexec_post_load(struct kimage *kimage)
 	kimage->arch.ttbr1 = __pa(trans_pgd);
 	kimage->arch.zero_page = __pa_symbol(empty_zero_page);
 
+	/* Copy the whole section: a kCFI hash may precede the entry point */
 	reloc_size = __relocate_new_kernel_end - __relocate_new_kernel_start;
 	memcpy(reloc_code, __relocate_new_kernel_start, reloc_size);
-	kimage->arch.kern_reloc = __pa(reloc_code);
+	kimage->arch.kern_reloc = __pa(reloc_code) +
+		((unsigned long)arm64_relocate_new_kernel -
+		 (unsigned long)__relocate_new_kernel_start);
 	rc = trans_pgd_idmap_page(&info, &kimage->arch.ttbr0,
 				  &kimage->arch.t0sz, reloc_code);
 	if (rc)
@@ -204,7 +207,7 @@ void machine_kexec(struct kimage *kimage)
 		restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
 			0, 0);
 	} else {
-		void (*kernel_reloc)(struct kimage *kimage);
+		typeof(arm64_relocate_new_kernel) *kernel_reloc;
 
 		if (is_hyp_nvhe())
 			__hyp_set_vectors(kimage->arch.el2_vectors);
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 6cb4209f5dab..064db5856bba 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -8,6 +8,7 @@
  * Pasha Tatashin <pasha.tatashin@soleen.com>
  */
 
+#include <linux/cfi_types.h>
 #include <linux/kexec.h>
 #include <linux/linkage.h>
 
@@ -32,11 +33,13 @@
  * new image to its final location.  To assure that the
  * arm64_relocate_new_kernel routine which does that copy is not overwritten,
  * all code and data needed by arm64_relocate_new_kernel must be between the
- * symbols arm64_relocate_new_kernel and arm64_relocate_new_kernel_end.  The
- * machine_kexec() routine will copy arm64_relocate_new_kernel to the kexec
+ * symbols __relocate_new_kernel_start and __relocate_new_kernel_end.  The
+ * machine_kexec_post_load() routine will copy that whole region to the kexec
  * safe memory that has been set up to be preserved during the copy operation.
+ *
+ * Called indirectly by machine_kexec(), this routine needs a kCFI type hash.
  */
-SYM_CODE_START(arm64_relocate_new_kernel)
+SYM_TYPED_FUNC_START(arm64_relocate_new_kernel)
 	/*
 	 * The kimage structure isn't allocated specially and may be clobbered
 	 * during relocation. We must load any values we need from it prior to
@@ -98,4 +101,4 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	mov	x2, xzr
 	mov	x3, xzr
 	br	x28				/* Jumps from el1 */
-SYM_CODE_END(arm64_relocate_new_kernel)
+SYM_FUNC_END(arm64_relocate_new_kernel)
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 1869b44ae190..c95243a8b24e 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -440,6 +440,7 @@ ASSERT(swapper_pg_dir - tramp_pg_dir == TRAMP_SWAPPER_OFFSET,
 ASSERT(__relocate_new_kernel_end - __relocate_new_kernel_start <= SZ_4K,
        "kexec relocation code is bigger than 4 KiB")
 ASSERT(KEXEC_CONTROL_PAGE_SIZE >= SZ_4K, "KEXEC_CONTROL_PAGE_SIZE is broken")
-ASSERT(__relocate_new_kernel_start == arm64_relocate_new_kernel,
-       "kexec control page does not start with arm64_relocate_new_kernel")
+ASSERT(arm64_relocate_new_kernel >= __relocate_new_kernel_start &&
+       arm64_relocate_new_kernel < __relocate_new_kernel_end,
+       "kexec relocation code does not contain arm64_relocate_new_kernel")
 #endif

-- 
2.56.0


