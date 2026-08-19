Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A58C5DF88
	for <kexec@archiver.kernel.org>; Wed, 19 Aug 2026 17:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:In-Reply-To:References:Message-Id:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vmoIUhHXRYirfmXtPkyGTipOfc1IGodR0GKUD6MrhOE=; b=UsNXCj5ImrRsxEdPVyx/SQBwuQ
	gutNrehGU8fi6xwMd/1OIY09mbgJ4F9SwHjcPm7IVY+ouR2QGUC7H47ViDXqJpQJlifDFiAa74bpQ
	sdrY+0Z0yKBDYmMWo/uZp52mvzehWtCvPPf1CVy+EFalf+ZjiwXmqRMqGIlZ5h/PzCHNL+MVB8Vjr
	Smnk8Tdr+q7mQHpeWolzyodkUn1W+WisuAzY5BpKck3CJhL2gRs+YT4xIv/kq0cwtGrKW5toFlTCk
	KHuxQibqHrtwacwfhKX5sc43sJoXwxwNMDgmbMxJmrrZC5bsALqU1Ko1d8N81tWb6wUU9HDeaTSB0
	BnuENsCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwkOH-0000000AIxW-2CVS;
	Wed, 19 Aug 2026 17:47:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwkOD-0000000AIvM-0w37
	for kexec@lists.infradead.org;
	Wed, 19 Aug 2026 17:47:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787161668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vmoIUhHXRYirfmXtPkyGTipOfc1IGodR0GKUD6MrhOE=;
	b=gvX/9puvwZZSx6/WRW4YdhckXut9OLCSRSck9qz/OaINRI/Ygmo5Fgb3bvaAHFibcMa3yu
	HQgpxTdRkAlg6RnmmMIlcnZCByBBdC4m6mlRjjZmP09ZwKA8AasvMnJibIg3fKQic5jsvh
	fHdLm/DfzTUGMNfsLhqKZZikJxEARdQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-bDmmj6TZPHiR_tb0oiN8hQ-1; Wed, 19 Aug 2026 13:47:45 -0400
X-MC-Unique: bDmmj6TZPHiR_tb0oiN8hQ-1
X-Mimecast-MFC-AGG-ID: bDmmj6TZPHiR_tb0oiN8hQ_1787161664
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso1325729a91.1
        for <kexec@lists.infradead.org>; Wed, 19 Aug 2026 10:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787161664; x=1787766464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vmoIUhHXRYirfmXtPkyGTipOfc1IGodR0GKUD6MrhOE=;
        b=r0B+k22o4HWjP8aPyEEiXdCXRjo84EsY7hHBTeYvRkDN1gN8OmshQVu7TjcXQF4hIW
         gx2bPW6pAomavlZ0wc95nctlTfG7XWNJVFXocd0ecYH3Dx2+Tk0sX49ZcIBqXBfsu1XA
         0XMbWIsNjlpk8cKZQ9k40vtq6P0qDm423iCNN+kRMe+OdPdyj7pMHgfD5cwQpBHE523R
         zERhk6EJzHlJZPnXD9iMkXYH3vYrSVTMvKuCzOoDLmrzeWF29M4Mo/vv2XuebXC9wsOy
         Yw2dkpXILaHkj9k0RiYaB82U4Av5AAZx892iRwlNtHxFvxH9KnOozezGz6qtEaoHsdb8
         xIjg==
X-Forwarded-Encrypted: i=1; AHgh+RrOvKH+vjvgJgZV5+Izr4RDba7rKhT80fHiYB3UmM73f0R096IAHT+W6SyMxj1POdrJwBUK3g==@lists.infradead.org
X-Gm-Message-State: AFuF++mappKiiwDMfjJmxTzQ8xN6B10c+tgOtHSavHslXCj3jHp67X5E
	f+rWRHSL0iI7u2/a5BnhefWWuPkPjhzNk9tO3f99v/8hyjVCJZsmPNLuNjSxfElzAadjenfKcys
	LB+cenVJ+2gm90m74ezBxCMttEIGxhyM8IKx39J86bvqWGHs+cVj/XAth3pJ+IA==
X-Gm-Gg: AR+sD10/uLsKANTLNeWl+PR+bJtGfqidpCBAFdv09WqfWeo9UaA6sK3aCBzS9ffI+mO
	AMOJMW+Cqiq35rbw7QiKbVV5mx2o6Msnbs+/tD+oUjkqkOmRPdNlrvnR9Wh4+hXXK6i9t10ZWp/
	29wRGMJ5UXw3zDDO4CMmM5PUL4FA/0+7KDr+akd20EzQFDK5C2YhjQ28z6N4l/C4DgWUaNi4ZCj
	twJVK1dFhOjFqu9AAnq+tJzEEJycSkTPFK2v+NM07INM4bVckLN4SE3djOQOEqlKfV7jjmUAWvf
	ZqOaqh0jAvGoUdSkbHgLZe/oGPVV6NAPVoE73ayfaW/ofl56lUpPuZ0T8wUG3yNiSxiTYmCnPcx
	yyhInvI8xmuXEfTpwQ/MLfGhVRnGfDXaX
X-Received: by 2002:a17:90a:d604:b0:38e:97f0:aa4b with SMTP id 98e67ed59e1d1-3958127a5aamr12212208a91.13.1787161664053;
        Wed, 19 Aug 2026 10:47:44 -0700 (PDT)
X-Received: by 2002:a17:90a:d604:b0:38e:97f0:aa4b with SMTP id 98e67ed59e1d1-3958127a5aamr12212103a91.13.1787161663548;
        Wed, 19 Aug 2026 10:47:43 -0700 (PDT)
Received: from mpilaniy-mac.redhat.corp ([122.171.22.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f96ca41sm3319861a91.4.2026.08.19.10.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 10:47:43 -0700 (PDT)
From: Mukesh Pilaniya <mpilaniy@redhat.com>
Date: Wed, 19 Aug 2026 23:17:22 +0530
Subject: [PATCH v2 1/2] kexec: return -ENOEXEC from image probe functions
 on mismatch
MIME-Version: 1.0
Message-Id: <20260819-mpilaniy-v2-1-95e929ede0e5@redhat.com>
References: <20260819-mpilaniy-v2-0-95e929ede0e5@redhat.com>
In-Reply-To: <20260819-mpilaniy-v2-0-95e929ede0e5@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Noa5pc9220pxOZXlLS0z9LFDEdNijQHvpmIhKpPmgOA_1787161664
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_104749_349109_A4111419 
X-CRM114-Status: GOOD (  14.36  )
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


