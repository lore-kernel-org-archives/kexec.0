Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D970AC5DF89
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:In-Reply-To:References:Message-Id:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BpYJaQfkL/fXy91zs4mgPaYnWE9uvAuTxt0XGGUcMwU=; b=2Dh35QYp5PJwknfVypircfRifE
	VTqfWKqwQFa+iQBviqC0tkva1SSVYs/j6g5QcrXf8fGS4iZUmUQ5riiLvEoUTqbwC3KxRDnp3xume
	lNp7DT0tabNjVslVgpm1+jj9t72CpqEmLDDwJlcDFWerBNKpdY4fSXP2pZgCL04fyUWzggDdiJ+mA
	TNv4tawpH0MHRqCIkHlUCi7Ii71zD0EbbmCNPU0XSiLwUmAQZZJHdMQXN7Zydt2GQKvwJWVi0vSM6
	ri9b3TORQc6/LXLtY7WEPFCZJN9TxeTuFLq+aImdv/5ohX0sOmafJwMzJBQ3/3zlZBqOJRydCQZuE
	dIFUKajg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxPdd-0000000DSXt-3obV;
	Fri, 21 Aug 2026 13:50:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxPda-0000000DSVX-0HKe
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 13:50:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787320225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BpYJaQfkL/fXy91zs4mgPaYnWE9uvAuTxt0XGGUcMwU=;
	b=MngjC+i93mmh00AleOIZ4YaPNVtNJnjIYAWVJnJrcoxca3n73+sDM8+prwtqyvZrX3oWj4
	THuN0MYflQBDTVbdMfpHIY5k2uWCmewol06l1ruPDptmJx706LxyXjt8nVF9oS27ll/Ncn
	biSMWHUbMlRx+EefCcgNvb427f20MXU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-2Zp4ZUYKMkaw08sBwIWV0w-1; Fri, 21 Aug 2026 09:50:22 -0400
X-MC-Unique: 2Zp4ZUYKMkaw08sBwIWV0w-1
X-Mimecast-MFC-AGG-ID: 2Zp4ZUYKMkaw08sBwIWV0w_1787320222
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e25e4b41cso1156849a91.0
        for <kexec@lists.infradead.org>; Fri, 21 Aug 2026 06:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320221; x=1787925021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BpYJaQfkL/fXy91zs4mgPaYnWE9uvAuTxt0XGGUcMwU=;
        b=FD5z34MUGbpLJs5RdSLAq7FQ14O93NCEh89IPz7e8/OG1vldNOcVCbMk8cNUfO6vCX
         PilTfbgPu7TFCqnaVeidYzDiSSXz5aXqT5LA65qDPJxLRVMamAqiVmaAgy7jb4qp4NkX
         JXwHtn3vMAdQF4+vFGl5ZjmK+caHo7XqzhTYy7CunnTBvjlTIkI8KfvTOi/hV1EohT3F
         0jUGXrheNFzgRSrgOk+5BVIB38bQ12FsLKtieHMK3xwrgRPMoTgg8XjcXJ5x6kwuAlLc
         Re/PO1D8K8/NRsT90GEff2uqzh9SCoFnkCp23a3B2J3DOyPykaAV3AAy3dYG/H7G2dEm
         YrhA==
X-Forwarded-Encrypted: i=1; AHgh+RrXZQbP5dxxxLmHPms0DApYqao3T33wQ1R2KWBOofoQLQ4USpsCTg6FCCq2A4RqI7fk0Oa6Ig==@lists.infradead.org
X-Gm-Message-State: AFuF++k97yU6AREbRVy0M9tfsrSqPqlJ9YZrOec3DGmfCUrrvHmacQ7r
	/CJgxFPuuvmJFcqmDUTmJPZ01xSmDPAX9BYov554ZNJPbTyJaFn9FQpoP+tKY58E6LKKeSLFfIi
	BJs8NxRVxpk3w3uLGfTUMwlZIBGYUvS2MeqAf0PthhBhN/W/BC2QXtLGGAl+hAQ==
X-Gm-Gg: AR+sD11z4yWlcO3u+nXk1Vjwq0blznI0W3kAueDqaFXKJjZLvONgRZc8uVRHCrHX1Nk
	ZMgFHkcmlHHmEG2OcYm4832t94u7euZEZ4bRcaL8KdLuNIN0McSDBZiyAx8hdB8skuqZ7mS8XA+
	c8nxpQPpbDF4gceqH/md595+1QS4vzt1LiibcS3lg9eIS4TLYHYGbnt5UA1NAY3g4sR4YMQwKMx
	9hg0FpUkz/mpFoABpQxoLifmKCxJaYkVQbGlp5BuneNxfehkDk4P1aBlQob5QJ0l33QlTQNo33g
	lXmILCGuy1EHgnaJE87jjZoW//yyeQyBKYEUf1DgK6T00kQymtrSckMs9ZDMHlL4+kWP49W8I59
	RWrLN5njMAs62VL3yl6Qi77uTRZWC4FW+
X-Received: by 2002:a17:90b:384d:b0:393:19a3:4e5 with SMTP id 98e67ed59e1d1-395c386a056mr10527502a91.16.1787320221487;
        Fri, 21 Aug 2026 06:50:21 -0700 (PDT)
X-Received: by 2002:a17:90b:384d:b0:393:19a3:4e5 with SMTP id 98e67ed59e1d1-395c386a056mr10527444a91.16.1787320220942;
        Fri, 21 Aug 2026 06:50:20 -0700 (PDT)
Received: from mpilaniy-mac.redhat.corp ([122.171.22.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4c194d2sm3300502a91.15.2026.08.21.06.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:50:20 -0700 (PDT)
From: Mukesh Pilaniya <mpilaniy@redhat.com>
Date: Fri, 21 Aug 2026 19:19:57 +0530
Subject: [PATCH v3 1/2] kexec: return -ENOEXEC from image probe functions
 on mismatch
MIME-Version: 1.0
Message-Id: <20260821-mpilaniy-v3-1-76b355399d2e@redhat.com>
References: <20260821-mpilaniy-v3-0-76b355399d2e@redhat.com>
In-Reply-To: <20260821-mpilaniy-v3-0-76b355399d2e@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Tao Liu <ltao@redhat.com>, 
 Philipp Rudo <prudo@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
 kexec@lists.infradead.org, Mukesh Pilaniya <mpilaniy@redhat.com>, 
 Bradley Morgan <include@grrlz.net>
X-Mailer: b4 0.15.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -z70Ah67zI1AL4BG9X98lh307UZPkFofAhizvk_ySWA_1787320222
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_065026_198674_7E61B5CC 
X-CRM114-Status: GOOD (  13.56  )
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

Several kexec_file_load() image probe functions return -EINVAL when
they do not recognize the image format.  A probe function that rejects
an image should return -ENOEXEC to indicate that the image is not a
recognized executable format.  -EINVAL implies a problem with the
syscall parameters, not with image recognition.

kexec_image_probe_default() iterates through registered loaders and
returns the last probe's error code to the caller.  That error
propagates as the kexec_file_load() return value to userspace.
Returning -EINVAL from a probe when no loader matches is semantically
incorrect and misleads userspace about the nature of the failure.

Return -ENOEXEC from all probe functions and their helpers when the
image format is not recognized.

Signed-off-by: Mukesh Pilaniya <mpilaniy@redhat.com>
Reviewed-by: Philipp Rudo <prudo@redhat.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Bradley Morgan <include@grrlz.net>
---
 arch/arm64/kernel/kexec_image.c   | 4 ++--
 arch/loongarch/kernel/kexec_efi.c | 4 ++--
 arch/riscv/kernel/kexec_image.c   | 4 ++--
 kernel/kexec_elf.c                | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index b70f4df15a1a..101259874d44 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -25,10 +25,10 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
 		(const struct arm64_image_header *)(kernel_buf);
 
 	if (!h || (kernel_len < sizeof(*h)))
-		return -EINVAL;
+		return -ENOEXEC;
 
 	if (memcmp(&h->magic, ARM64_IMAGE_MAGIC, sizeof(h->magic)))
-		return -EINVAL;
+		return -ENOEXEC;
 
 	return 0;
 }
diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/kexec_efi.c
index 5ee78ebb1546..28a1d0420ba3 100644
--- a/arch/loongarch/kernel/kexec_efi.c
+++ b/arch/loongarch/kernel/kexec_efi.c
@@ -24,12 +24,12 @@ static int efi_kexec_probe(const char *kernel_buf, unsigned long kernel_len)
 
 	if (!h || (kernel_len < sizeof(*h))) {
 		kexec_dprintk("No LoongArch image header.\n");
-		return -EINVAL;
+		return -ENOEXEC;
 	}
 
 	if (!loongarch_header_check_dos_sig(h)) {
 		kexec_dprintk("No LoongArch PE image header.\n");
-		return -EINVAL;
+		return -ENOEXEC;
 	}
 
 	return 0;
diff --git a/arch/riscv/kernel/kexec_image.c b/arch/riscv/kernel/kexec_image.c
index 51dc89259f16..963a25f5b55b 100644
--- a/arch/riscv/kernel/kexec_image.c
+++ b/arch/riscv/kernel/kexec_image.c
@@ -20,7 +20,7 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
 	const struct riscv_image_header *h = (const struct riscv_image_header *)kernel_buf;
 
 	if (!h || kernel_len < sizeof(*h))
-		return -EINVAL;
+		return -ENOEXEC;
 
 	/* According to Documentation/arch/riscv/boot-image-header.rst,
 	 * use "magic2" field to check when version >= 0.2.
@@ -28,7 +28,7 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
 
 	if (h->version >= RISCV_HEADER_VERSION &&
 	    memcmp(&h->magic2, RISCV_IMAGE_MAGIC2, sizeof(h->magic2)))
-		return -EINVAL;
+		return -ENOEXEC;
 
 	return 0;
 }
diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
index 3a5c25b2adc9..89a444a00693 100644
--- a/kernel/kexec_elf.c
+++ b/kernel/kexec_elf.c
@@ -172,7 +172,7 @@ static int elf_read_ehdr(const char *buf, size_t len, struct elfhdr *ehdr)
 
 	default:
 		pr_debug("Unknown ELF class.\n");
-		return -EINVAL;
+		return -ENOEXEC;
 	}
 
 	return elf_is_ehdr_sane(ehdr, len) ? 0 : -ENOEXEC;
@@ -236,7 +236,7 @@ static int elf_read_phdr(const char *buf, size_t len,
 
 	default:
 		pr_debug("Unknown ELF class.\n");
-		return -EINVAL;
+		return -ENOEXEC;
 	}
 
 	return elf_is_phdr_sane(phdr, len) ? 0 : -ENOEXEC;

-- 
Git-155)


