Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEF6C5DF81
	for <kexec@archiver.kernel.org>; Wed, 19 Aug 2026 18:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:In-Reply-To:Subject:CC:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=BxnW8xTe/GUg/okReI0ZUTX8lPXwU0KqEEY1BznrYFQ=; b=Z6jEu8BrRa9+H9TLJ2zdeokc3G
	GINZ/0SozynbUCpti2J/m/PBSRv9qSsugplBFA+wKkpbo/uUJBV3uWtcAc8WmUKuTqg5HYDLnu2Ix
	z43j2OANwfig0UmKAkHPyhzqf2oKB8yL1aq6SgYES0SU5JmW2WwOVclX6fTwkj/K3Nh/s9s5F0Bjq
	bQuOCBDF8+yAWcSlKzI56BpzEQN7iHcpAd0+hYlrzOBRliTdgDWJX7dbQ1r+M2+oZ7VRBdEXwejAn
	JmAscseWbKD1boc8sJO3BxcEV6Sv2Zl9PurxVSVXvQoxZ1ZIKNVO5LWZFiLV+Ez2PaYSaU8Yu0SnV
	UB6oaynA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwl6H-0000000ANcH-43PX;
	Wed, 19 Aug 2026 18:33:21 +0000
Received: from latitanza.investici.org ([185.218.207.228])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwl6F-0000000ANb1-1bkx;
	Wed, 19 Aug 2026 18:33:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787164394;
	bh=BxnW8xTe/GUg/okReI0ZUTX8lPXwU0KqEEY1BznrYFQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=ribwPyRn+LH1F9A7EcB0DgsCpO4YlE+W4B7sMWptzOdv9HbwxbE2gSDVkkAoJx/7Z
	 3ipIsQyfMGHdVkh1ij6tRVVllP1O+ZnvPYjkOWd3qtCz9l2NylxuLKo7QF+pEJk6p6
	 2AlSFPZca9TqbKlG+uiDUlbU6ro915a0i4gk313w=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4hQFZ23NQrzGpD4;
	Wed, 19 Aug 2026 18:33:14 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4hQFZ20qN3zGpD1;
	Wed, 19 Aug 2026 18:33:14 +0000 (UTC)
Date: Wed, 19 Aug 2026 19:33:13 +0100
From: Bradley Morgan <include@grrlz.net>
To: mpilaniy@redhat.com
CC: akpm@linux-foundation.org, alex@ghiti.fr, aou@eecs.berkeley.edu,
 baoquan.he@linux.dev, catalin.marinas@arm.com, chenhuacai@kernel.org,
 kernel@xen0n.name, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, ltao@redhat.com,
 mark.rutland@arm.com, palmer@dabbelt.com, pasha.tatashin@soleen.com,
 pjw@kernel.org, pratyush@kernel.org, prudo@redhat.com, rppt@kernel.org,
 will@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/2=5D_kexec=3A_return_-ENOEXE?=
 =?US-ASCII?Q?C_from_image_probe_functions_on_mismatch?=
In-Reply-To: <20260819-mpilaniy-v2-1-95e929ede0e5@redhat.com>
Message-ID: <B5D12BAE-2701-46EC-8458-3716F856703D@grrlz.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_113319_862661_F1823D9D 
X-CRM114-Status: GOOD (  10.97  )
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

On 19 August 2026 18:47:22 BST, Mukesh Pilaniya <mpilaniy@redhat.com>
wrote:
>Several kexec_file_load() image probe functions return -EINVAL when
>they do not recognize the image format.  A probe function that rejects
>an image should return -ENOEXEC to indicate that the image is not a
>recognized executable format.  -EINVAL implies a problem with the
>syscall parameters, not with image recognition.
>
>kexec_image_probe_default() iterates through registered loaders and
>returns the last probe's error code to the caller.  That error
>propagates as the kexec_file_load() return value to userspace.
>Returning -EINVAL from a probe when no loader matches is semantically
>incorrect and misleads userspace about the nature of the failure.
>
>Return -ENOEXEC from all probe functions and their helpers when the
>image format is not recognized.
>
>Signed-off-by: Mukesh Pilaniya <mpilaniy@redhat.com>
>Reviewed-by: Philipp Rudo <prudo@redhat.com>
>Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Bradley Morgan <include@grrlz.net>

>---
> arch/arm64/kernel/kexec_image.c   | 4 ++--
> arch/loongarch/kernel/kexec_efi.c | 4 ++--
> arch/riscv/kernel/kexec_image.c   | 4 ++--
> kernel/kexec_elf.c                | 4 ++--
> 4 files changed, 8 insertions(+), 8 deletions(-)
>
>diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
>index b70f4df15a1a..101259874d44 100644
>--- a/arch/arm64/kernel/kexec_image.c
>+++ b/arch/arm64/kernel/kexec_image.c
>@@ -25,10 +25,10 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
> 		(const struct arm64_image_header *)(kernel_buf);
> 
> 	if (!h || (kernel_len < sizeof(*h)))
>-		return -EINVAL;
>+		return -ENOEXEC;
> 
> 	if (memcmp(&h->magic, ARM64_IMAGE_MAGIC, sizeof(h->magic)))
>-		return -EINVAL;
>+		return -ENOEXEC;
> 
> 	return 0;
> }
>diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/kexec_efi.c
>index 5ee78ebb1546..28a1d0420ba3 100644
>--- a/arch/loongarch/kernel/kexec_efi.c
>+++ b/arch/loongarch/kernel/kexec_efi.c
>@@ -24,12 +24,12 @@ static int efi_kexec_probe(const char *kernel_buf, unsigned long kernel_len)
> 
> 	if (!h || (kernel_len < sizeof(*h))) {
> 		kexec_dprintk("No LoongArch image header.\n");
>-		return -EINVAL;
>+		return -ENOEXEC;
> 	}
> 
> 	if (!loongarch_header_check_dos_sig(h)) {
> 		kexec_dprintk("No LoongArch PE image header.\n");
>-		return -EINVAL;
>+		return -ENOEXEC;
> 	}
> 
> 	return 0;
>diff --git a/arch/riscv/kernel/kexec_image.c b/arch/riscv/kernel/kexec_image.c
>index 51dc89259f16..963a25f5b55b 100644
>--- a/arch/riscv/kernel/kexec_image.c
>+++ b/arch/riscv/kernel/kexec_image.c
>@@ -20,7 +20,7 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
> 	const struct riscv_image_header *h = (const struct riscv_image_header *)kernel_buf;
> 
> 	if (!h || kernel_len < sizeof(*h))
>-		return -EINVAL;
>+		return -ENOEXEC;
> 
> 	/* According to Documentation/arch/riscv/boot-image-header.rst,
> 	 * use "magic2" field to check when version >= 0.2.
>@@ -28,7 +28,7 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
> 
> 	if (h->version >= RISCV_HEADER_VERSION &&
> 	    memcmp(&h->magic2, RISCV_IMAGE_MAGIC2, sizeof(h->magic2)))
>-		return -EINVAL;
>+		return -ENOEXEC;
> 
> 	return 0;
> }
>diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
>index 3a5c25b2adc9..89a444a00693 100644
>--- a/kernel/kexec_elf.c
>+++ b/kernel/kexec_elf.c
>@@ -172,7 +172,7 @@ static int elf_read_ehdr(const char *buf, size_t len, struct elfhdr *ehdr)
> 
> 	default:
> 		pr_debug("Unknown ELF class.\n");
>-		return -EINVAL;
>+		return -ENOEXEC;
> 	}
> 
> 	return elf_is_ehdr_sane(ehdr, len) ? 0 : -ENOEXEC;
>@@ -236,7 +236,7 @@ static int elf_read_phdr(const char *buf, size_t len,
> 
> 	default:
> 		pr_debug("Unknown ELF class.\n");
>-		return -EINVAL;
>+		return -ENOEXEC;
> 	}
> 
> 	return elf_is_phdr_sane(phdr, len) ? 0 : -ENOEXEC;
>
>

Thanks!

