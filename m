Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B24606A31B
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AhhaIlb8;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=hTjBjR+s
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=zx81mJCQGymu1OZlc3jNrPjZqmEatAtALfsBDY/sthM=; b=AhhaIlb8LGplTCsQE6hW7DPy/+
	0SzajNuBQfRwAWUpPtCSqk0vvZkZJRaVOM3PB5EPFdeLEuqTRKA4LaBWnXb9peyyJ0ZB2pctMIjjv
	P+44AKJEn+PzRGXsRsVzhfn9ZBeGodXsDbhZEDO79Pu82giVP/w1JxSkemquNjLAf+pELZrtXhJLa
	wB/gWqIV9GRWZ0XbEvjkFVGxh+vVDmUh1riiUVYdOgt/FFaJ9rLgledu0oLkPPRHaEXSHHzlNBuWx
	YayUU/CknIMuOykfZeOXNMXqgXDJ9SVYhTNU/tVW5nnefrWYaiExd0YVKY/+nSCvXOHx8mpgtznPV
	HseSQEHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK85k-0000000FXM3-2g5K;
	Fri, 23 Oct 2026 05:45:24 +0000
Received: from mail-dl1-x1248.google.com ([2607:f8b0:4864:20::1248])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK85i-0000000FXLT-2eif
	for kexec@lists.infradead.org;
	Fri, 23 Oct 2026 05:45:23 +0000
Received: by mail-dl1-x1248.google.com with SMTP id a92af1059eb24-151ba226e1bso1308401c88.0
        for <kexec@lists.infradead.org>; Thu, 22 Oct 2026 22:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792734321; x=1793339121; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zx81mJCQGymu1OZlc3jNrPjZqmEatAtALfsBDY/sthM=;
        b=hTjBjR+s328gjUFnh70D77XT0ezz0sx0ca6X4OD6YkuyBgOuGBXnIxSXeCHgGG1r4g
         qZP0UXkcgNwyFWzCrQfXTxsOvuZnNhsoL+NXxXZjECknO9+dNx2hx57wcKLTAosFdgVE
         PLWtRY01JQybF1PHk3w0XbEKBGGTLPE4sxwQ+la+L7u3OUmzuMREBrs+8GJkfdBSB2Rd
         vInha3qOhpPjmUp3bu5iv1mIG5RkLH/wZko98+ycoYxXnNjNJtsUg1nsgsZyjYY55wJa
         TMFtsYipS6yzmIO8ft/ZJUkTj+5tnkrggg90lqpeX6Q2wO736dxxqFmftyDC2ENWHodJ
         AB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792734321; x=1793339121;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zx81mJCQGymu1OZlc3jNrPjZqmEatAtALfsBDY/sthM=;
        b=2SXcFb9pXLjyLcoW5yGppmjF5ZXIGQhbhU58ZX7xldptm/v/f48zoB7P5HrJy/Yied
         xLSzIDDxd8Fgcq8P8bnmH67Q7Fl0jQ3L4HcjPMK15ojMk14+FkVi9oGNXNz5eipT7qeL
         656eeukbr6WIulo7dSErbjZMK1vzLS9x6DorBVhOQW66EjNsh9h0eYT+1vaxnW+7+xDQ
         yobaM6CTCVVAstpoVcGsJ3IekRhlVFT9IzrPNhOV3oj92ZGABdMcLIIJaVtcNHsYwgU9
         FUGg9DsQkoETUdQcIJahL0D8RFqI8pRPiO1hDgM8JZ6bjp44ZFLWYzYtXVGFQ3fLLkdS
         D+dw==
X-Forwarded-Encrypted: i=1; AKwUvBwZEATWw1KMNWe8Y9Y7NNRU5P6k8upIOBEKnMpxKEuHIsvCttXGQmbuQ3Y4bqlHNpxyCyukWg==@lists.infradead.org
X-Gm-Message-State: AFq9FYLONw9sd3BthqATZ1XEx7gqbgrKxyGYI1+LXoguTf2xKWXJP1gJ
	ygtVfpoVtxG5vTPVTpGx4b+urhF5kPNlZ/6EsttNZg60KAD9ZJEzm7K+I844m3Ta5ndN5AlAuTr
	+uCm+VRmRQA==
X-Received: from dly16-n1.prod.google.com ([2002:a05:701b:2050:10b0:14a:84ec:bd53])
 (user=gthelen job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:28a:b0:18e:355b:f6b3
 with SMTP id a92af1059eb24-195c6e0b80amr1891111c88.23.1792734320663; Thu, 22
 Oct 2026 22:45:20 -0700 (PDT)
Date: Thu, 22 Oct 2026 22:45:18 -0700
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261023054518.3258350-1-gthelen@google.com>
Subject: [PATCH] kho: check fdt_phys in is_kho_boot()
From: Greg Thelen <gthelen@google.com>
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Evangelos Petrongonas <epetron@amazon.de>, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_224522_689861_2395E802 
X-CRM114-Status: GOOD (  10.02  )
X-Spam-Score: -9.5 (---------)
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
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

During arm64 setup_arch(), efi_init() -> reserve_regions() calls
is_kho_boot() before arm64_memblock_init() initializes memstart_addr.
At this point memstart_addr still holds its initial sentinel value (-1).

When booting via kexec with KHO enabled, kho_populate() sets
kho_in.fdt_phys from the /chosen FDT node. Calling is_kho_boot() ->
kho_get_fdt() invokes phys_to_virt(kho_in.fdt_phys), which evaluates
PHYS_OFFSET and triggers VM_BUG_ON(memstart_addr & 1) on arm64 kernels
built with CONFIG_DEBUG_VM=y:

  kernel BUG at ./arch/arm64/include/asm/memory.h:377!
  Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
  Call trace:
   is_kho_boot+0x2c/0x38 (P)
   efi_init+0x94/0xf8
   setup_arch+0xf0/0x240
   start_kernel+0x84/0x490
   __primary_switched+0x88/0x98

Check kho_in.fdt_phys directly in is_kho_boot() instead of calling
kho_get_fdt() so that early boot callers do not invoke phys_to_virt()
before the linear map offset is initialized.

Fixes: d6d511639185 ("kexec: introduce is_kho_boot()")
Assisted-by: Gemini:gemini-3.8-flash
Signed-off-by: Greg Thelen <gthelen@google.com>
---
 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 7c4d86daf86d..d81baa38497f 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1630,7 +1630,7 @@ EXPORT_SYMBOL_GPL(kho_restore_free);
  */
 bool is_kho_boot(void)
 {
-	return !!kho_get_fdt();
+	return !!kho_in.fdt_phys;
 }
 EXPORT_SYMBOL_GPL(is_kho_boot);
 
-- 
2.56.0.257.gf7497c7d27-goog


