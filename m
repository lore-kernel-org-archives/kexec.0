Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43D9C5B572
	for <kexec@archiver.kernel.org>; Thu, 13 Aug 2026 07:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Message-Id:MIME-Version:Subject:Date:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JiBEcYiE+KLh8+0hM55F9Ni/cU6OIiWXkgr39dKJ+1Q=; b=Hmi5ekc6GpjEf1pybNYWbWNEFr
	gA/cTIE9ojWF7GM8tSGvi1ztsRg+XUc3R5RHx8FIpM4IaNNB5wB0AtlHf/sdbqDXw0FxtUEkMfDkD
	WGpwVA21fv0YjAx5UCbHKePUIYYJ5ipXjfQhA/OjJ69PD6HWsF9pGarOXPtVzeog9MFNG3Ap1ut6h
	rro7RaYJPYlP9W93E8aTzh8Gn+oHnHnfQemWl1HUUVn9bp89/KQeDpQpKBwT3cpSvO2Yl8RfpjS7K
	CxrGG4MZyTuR6xxm+nNaMiszXE09gY5QA2epnU7lkJf2WwPJsZN998m5HBQoNyQi73xgDnGMNckS0
	JkxA9EXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuPX1-0000000HYy2-1rnJ;
	Thu, 13 Aug 2026 07:07:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuPWx-0000000HYwV-2bzh
	for kexec@lists.infradead.org;
	Thu, 13 Aug 2026 07:07:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786604829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JiBEcYiE+KLh8+0hM55F9Ni/cU6OIiWXkgr39dKJ+1Q=;
	b=TnNuaafElWVYHCDAM7L+/RujLtS3yIv/FAEoDYpXVaor3Qc+GGING/AVqUTKmsgt8N8+59
	KiyT45y96SaRpcqfrFSpguSbyDYwzcQhz+hWtDm4AFUoa5A27JgqN6DEL5UaD0vM3XiJWS
	CAS9amGJl6dIwkn1ep6RlqOJm1/wijU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-9zU392TBM4q0GqhUAFOj5Q-1; Thu, 13 Aug 2026 03:07:07 -0400
X-MC-Unique: 9zU392TBM4q0GqhUAFOj5Q-1
X-Mimecast-MFC-AGG-ID: 9zU392TBM4q0GqhUAFOj5Q_1786604826
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cccfa32670so6757805ad.2
        for <kexec@lists.infradead.org>; Thu, 13 Aug 2026 00:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786604826; x=1787209626;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JiBEcYiE+KLh8+0hM55F9Ni/cU6OIiWXkgr39dKJ+1Q=;
        b=Hy8Rwi+qu+Le4ZCVyrWPuyh52h8+c0yzE5kiQkTxxY5ptPIxY3hm9TXXzrUp5lEsT4
         U2Es0B7kv/vNkduJAEoQTVC5EUjYquSxzRsCCIQi1hau7ZUI2JaavrlSE5uZ0lSR05eP
         weyQeC/9p5YkDeJp/b1wV+ln3GKxlJ6WvhuLxTpcu/BfahMJTHziOTy++SGrcHhc5waG
         1yP4//MRMOzp/YlCbdgbS3vzIjXfXTR8QsDW9NbTLLNNLHSC/a5iZv77qik+TMxFWHHy
         3EMEPtKwSrHv/krqydpp1ibzhd16YJce7sORR/ACXqflL7/ClAXHKg4M7BOSVJjac35f
         8cEA==
X-Forwarded-Encrypted: i=1; AHgh+RryZRzDcCLG6d7PxpRwsnR5dy5fMu+hLwYXCiDUKsAX5wbwBjTcOon9LBKoEygpupkj7V9O+A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw/FcIOJBrz3Gm14grUQ0usD522ZfQ2vQP9sMPEyXtzMvs7VBen
	50SRlWzCm8K0o+LgJZil9N8N55eJ9EiUfMVsbIZDwp9+N6pt9ws0ehnHI35KcVn2vUMy1TT7Wf6
	xlvjjVgflFMGBtxCvADKxyLHM6kwUJcvxsGRjJpuxT8cGpH+2Xf2QhiDwb8KeyA==
X-Gm-Gg: AR+sD11PGhLI4WeoXA8IotjnTe4c58eyYxo9ncywqqZ7lNLjFSzStKmHn5rKai7L5DC
	uH3ZHIhOKTvNTk135HJIBb8J5TCAMrtZRUU5BKilGKtxr37Q2Q5dkHb8UmeP75zB/eCoECpG6bs
	pylfB7fHn24EioXNCwfb4ws34J69RNWCSLlIL/7AXcdpDxvI5eepCFdFGTeIvl88gaDUISjiZlu
	qJi8WS6f6WFyiP2LuXVQxSJO2iCUxmlS5P8gva0CJgG9r8R+S0q8eceg8hzXY+JGRI+R9hGGa1J
	wVjA/cK22KSHuFxex/YxuCygpCKdH+/Z73b+KaVDaJ4EqMEXHlOx7BL43uSkaycBJEsRuESA6TH
	ZfuxFQ/NwdKNzU+wW
X-Received: by 2002:a17:903:234a:b0:2ca:d975:5bbd with SMTP id d9443c01a7336-2d37e8a4f49mr38123825ad.20.1786604826427;
        Thu, 13 Aug 2026 00:07:06 -0700 (PDT)
X-Received: by 2002:a17:903:234a:b0:2ca:d975:5bbd with SMTP id d9443c01a7336-2d37e8a4f49mr38123275ad.20.1786604825987;
        Thu, 13 Aug 2026 00:07:05 -0700 (PDT)
Received: from [127.0.0.1] ([115.110.157.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c48e438sm4877315ad.60.2026.08.13.00.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 00:07:05 -0700 (PDT)
From: Mukesh Pilaniya <mpilaniy@redhat.com>
Date: Thu, 13 Aug 2026 12:36:29 +0530
Subject: [PATCH] kexec: return -ENOEXEC from image probe functions on
 mismatch
MIME-Version: 1.0
Message-Id: <20260813-mpilaniy-v1-1-777d4d0e30f7@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0Nj3dyCzJzEvMxK3bS0JIPkZEujZGNDYyWg8oKi1LTMCrBR0bEQfnF
 pUlZqcglIv1JtLQC+l4AzbAAAAA==
X-Change-ID: 20260813-mpilaniy-ffb0cc92c313
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
 kexec@lists.infradead.org, Mukesh Pilaniya <mpilaniy@redhat.com>
X-Mailer: b4 0.15.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4lqmLSpdJOsKUwBbLDNM8p-iUg6j51CWDQRNsk3Ba9w_1786604826
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_000711_761240_C639AA32 
X-CRM114-Status: GOOD (  13.57  )
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
---
branch: next-20260812
base commit: 28d012efb4327f9c75d5e042a7c91e9a542efa98
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

---
base-commit: 28d012efb4327f9c75d5e042a7c91e9a542efa98
change-id: 20260813-mpilaniy-ffb0cc92c313

Best regards,
--  
Mukesh Pilaniya <mpilaniy@redhat.com>


