Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221ECC5CFEB
	for <kexec@archiver.kernel.org>; Thu, 13 Aug 2026 13:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DOuw/x5y8phWuHZmwxpOm62fWFsgmbUws0VrhfcWz1w=; b=1NyA/HKF5uy7efAsaJT9xiHjaS
	T3XWVKxPmwX7TI3VZ4hI3/GymsoKv0qNlY6K51S791yCELTmm/pcNm2OhrlgLPerdFdItADFmZH4F
	4+E9Eh8kOJYXlbGXaSWTicPphhLJmKotXBlbS4tpY41FL02tnvd9Gi0Akqvy/naTEh98JHPJvYXRk
	JYxUyF8iVPTtQcJVLW5931C4bHyskweVJztB821nmXiJnMo7Hi/rV1JPKBo6mYhF0DKoymM0Ygj4H
	+K794H+lE8t9p5eQko3SMa0ujFAVKdYu5HzxnIxjuusGdUcSH1OXwk3cgOjZyTBzyV9L5v5QgaV0e
	QppQ4fUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuVHc-00000000ipw-3WwF;
	Thu, 13 Aug 2026 13:15:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuVHZ-00000000ioq-3YV0
	for kexec@lists.infradead.org;
	Thu, 13 Aug 2026 13:15:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786626940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOuw/x5y8phWuHZmwxpOm62fWFsgmbUws0VrhfcWz1w=;
	b=V5a80HtvSZLXaU00kpV4xF4DQUT1FNmd/qmyiyxO+9UcpgxRBlp4adg7w0R1dXBF1kVtNl
	KQaid+tS8WjxhjAOF3aCJmuQiVpkcIMgy9glgNhTd0tBIUW5ebamDUwHNUWFUZT8QJaPbp
	8RFSpAo2o/KPpQw/Tswi8bIuy7n3X+M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-wVZqRQZXOBq7fw6lCFkMXQ-1; Thu,
 13 Aug 2026 09:14:09 -0400
X-MC-Unique: wVZqRQZXOBq7fw6lCFkMXQ-1
X-Mimecast-MFC-AGG-ID: wVZqRQZXOBq7fw6lCFkMXQ_1786626847
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA3AF195609E;
	Thu, 13 Aug 2026 13:14:05 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.44.48.151])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90FD11800348;
	Thu, 13 Aug 2026 13:13:57 +0000 (UTC)
Date: Thu, 13 Aug 2026 15:13:50 +0200
From: Philipp Rudo <prudo@redhat.com>
To: Mukesh Pilaniya <mpilaniy@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Andrew Morton
 <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, Mike
 Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Tao Liu <ltao@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 kexec@lists.infradead.org
Subject: Re: [PATCH] kexec: return -ENOEXEC from image probe functions on
 mismatch
Message-ID: <20260813151350.6b511155@rotkaeppchen>
In-Reply-To: <20260813-mpilaniy-v1-1-777d4d0e30f7@redhat.com>
References: <20260813-mpilaniy-v1-1-777d4d0e30f7@redhat.com>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: GOcYb52hdPnvy01fpU5BZ1DcPRF7RCa6z6_XKYKXOs8_1786626847
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_061541_967651_EC71DF8D 
X-CRM114-Status: GOOD (  24.48  )
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

Hi Mukesh,

the patch looks good to me.

There is also a corresponding kexec-tools patch, which was accidentally
opened as a Github PR (https://github.com/horms/kexec-tools/pull/12).
It will be sent to kexec@lists.infradead.org shortly.

Thanks

Reviewed-by: Philipp Rudo <prudo@redhat.com>

On Thu, 13 Aug 2026 12:36:29 +0530
Mukesh Pilaniya <mpilaniy@redhat.com> wrote:

> Several kexec_file_load() image probe functions return -EINVAL when
> they do not recognize the image format.  A probe function that rejects
> an image should return -ENOEXEC to indicate that the image is not a
> recognized executable format.  -EINVAL implies a problem with the
> syscall parameters, not with image recognition.
> 
> kexec_image_probe_default() iterates through registered loaders and
> returns the last probe's error code to the caller.  That error
> propagates as the kexec_file_load() return value to userspace.
> Returning -EINVAL from a probe when no loader matches is semantically
> incorrect and misleads userspace about the nature of the failure.
> 
> Return -ENOEXEC from all probe functions and their helpers when the
> image format is not recognized.
> 
> Signed-off-by: Mukesh Pilaniya <mpilaniy@redhat.com>
> ---
> branch: next-20260812
> base commit: 28d012efb4327f9c75d5e042a7c91e9a542efa98
> ---
>  arch/arm64/kernel/kexec_image.c   | 4 ++--
>  arch/loongarch/kernel/kexec_efi.c | 4 ++--
>  arch/riscv/kernel/kexec_image.c   | 4 ++--
>  kernel/kexec_elf.c                | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index b70f4df15a1a..101259874d44 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -25,10 +25,10 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
>  		(const struct arm64_image_header *)(kernel_buf);
>  
>  	if (!h || (kernel_len < sizeof(*h)))
> -		return -EINVAL;
> +		return -ENOEXEC;
>  
>  	if (memcmp(&h->magic, ARM64_IMAGE_MAGIC, sizeof(h->magic)))
> -		return -EINVAL;
> +		return -ENOEXEC;
>  
>  	return 0;
>  }
> diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/kexec_efi.c
> index 5ee78ebb1546..28a1d0420ba3 100644
> --- a/arch/loongarch/kernel/kexec_efi.c
> +++ b/arch/loongarch/kernel/kexec_efi.c
> @@ -24,12 +24,12 @@ static int efi_kexec_probe(const char *kernel_buf, unsigned long kernel_len)
>  
>  	if (!h || (kernel_len < sizeof(*h))) {
>  		kexec_dprintk("No LoongArch image header.\n");
> -		return -EINVAL;
> +		return -ENOEXEC;
>  	}
>  
>  	if (!loongarch_header_check_dos_sig(h)) {
>  		kexec_dprintk("No LoongArch PE image header.\n");
> -		return -EINVAL;
> +		return -ENOEXEC;
>  	}
>  
>  	return 0;
> diff --git a/arch/riscv/kernel/kexec_image.c b/arch/riscv/kernel/kexec_image.c
> index 51dc89259f16..963a25f5b55b 100644
> --- a/arch/riscv/kernel/kexec_image.c
> +++ b/arch/riscv/kernel/kexec_image.c
> @@ -20,7 +20,7 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
>  	const struct riscv_image_header *h = (const struct riscv_image_header *)kernel_buf;
>  
>  	if (!h || kernel_len < sizeof(*h))
> -		return -EINVAL;
> +		return -ENOEXEC;
>  
>  	/* According to Documentation/arch/riscv/boot-image-header.rst,
>  	 * use "magic2" field to check when version >= 0.2.
> @@ -28,7 +28,7 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
>  
>  	if (h->version >= RISCV_HEADER_VERSION &&
>  	    memcmp(&h->magic2, RISCV_IMAGE_MAGIC2, sizeof(h->magic2)))
> -		return -EINVAL;
> +		return -ENOEXEC;
>  
>  	return 0;
>  }
> diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
> index 3a5c25b2adc9..89a444a00693 100644
> --- a/kernel/kexec_elf.c
> +++ b/kernel/kexec_elf.c
> @@ -172,7 +172,7 @@ static int elf_read_ehdr(const char *buf, size_t len, struct elfhdr *ehdr)
>  
>  	default:
>  		pr_debug("Unknown ELF class.\n");
> -		return -EINVAL;
> +		return -ENOEXEC;
>  	}
>  
>  	return elf_is_ehdr_sane(ehdr, len) ? 0 : -ENOEXEC;
> @@ -236,7 +236,7 @@ static int elf_read_phdr(const char *buf, size_t len,
>  
>  	default:
>  		pr_debug("Unknown ELF class.\n");
> -		return -EINVAL;
> +		return -ENOEXEC;
>  	}
>  
>  	return elf_is_phdr_sane(phdr, len) ? 0 : -ENOEXEC;
> 
> ---
> base-commit: 28d012efb4327f9c75d5e042a7c91e9a542efa98
> change-id: 20260813-mpilaniy-ffb0cc92c313
> 
> Best regards,
> --  
> Mukesh Pilaniya <mpilaniy@redhat.com>
> 


