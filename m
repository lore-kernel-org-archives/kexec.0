Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F82CA0EFA
	for <kexec@archiver.kernel.org>; Tue, 26 Aug 2025 14:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BY3Dc5+127jmRxKleLM8tokdDatFE2dPfa5pg+X+c/c=; b=gXNptEAzjdfgToDs7z+78PpNA2
	FhWgvlqRDZjFg3ec6VDwfuxxTE6Qt4VwyelbJp1HxZOQmpkBdTrT2OmXKZeTzcYFEFfK3fJB6sxlF
	6DEwLQ4GPHohdYRR+WaWp8kSPMpuvsbboKQMLnM2tuEKcuLGxirzZ9m9BF0pdpBlQ6Ay1prjArMck
	Xa+MqsEOXbGyNqzP1cTvJ2F1b0T+O4Eo6cewJJH52GwvZ9aNEsGsa1/tQtRFh1hDEX6JU6QK/6KAX
	gtJLM2V2viWEj7MeNyHUQN2MzdWu1YYz+0vzfpbbWoTqsWHOSWHH+/KtcO1JQOapQJH3qM3EA1xUq
	hbyyj+Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uquvo-0000000CJZ5-4Agl;
	Tue, 26 Aug 2025 14:45:52 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uquqZ-0000000CIc7-3WEC;
	Tue, 26 Aug 2025 14:40:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D29D169E;
	Tue, 26 Aug 2025 07:40:18 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD3203F694;
	Tue, 26 Aug 2025 07:40:24 -0700 (PDT)
Date: Tue, 26 Aug 2025 15:40:22 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bhe@redhat.com, oxu@redhat.com, berrange@redhat.com,
	kernel-team@meta.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] arm64: kexec: Initialize kexec_buf struct in image_load()
Message-ID: <aK3HVqt6I5KxoHia@J2N7QTR9R3>
References: <20250826-akpm-v1-1-3c831f0e3799@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826-akpm-v1-1-3c831f0e3799@debian.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_074027_977502_6A205EB4 
X-CRM114-Status: GOOD (  21.98  )
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

On Tue, Aug 26, 2025 at 05:08:51AM -0700, Breno Leitao wrote:
> The kexec_buf structure was previously declared without initialization
> in image_load(). This led to a UBSAN warning when the structure was
> expanded and uninitialized fields were accessed [1].

Just to check my understanding, is that only a problem for new fields
(e.g. the 'random' field added in [1]), or do we have UBSAN warnigns for
any existing fields? I assume there's no problem with existing fields
today.

> Zero-initializing kexec_buf at declaration ensures all fields are
> cleanly set, preventing future instances of uninitialized memory being
> used.
> 
> Andrew Morton suggested that this function is only called 3x a week[2],
> thus, the memset() cost is inexpressive.
> 
> Link: https://lore.kernel.org/all/oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3/ [1]
> Link: https://lore.kernel.org/all/20250825180531.94bfb86a26a43127c0a1296f@linux-foundation.org/ [2]
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

This looks fine to me, but I reckon it should be added to the series
which extends kexec_buf, unless there's some reason to avoid that?

> ---
>  arch/arm64/kernel/kexec_image.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

IIUC arch/arm64/kernel/machine_kexec_file.c would need the same
treatment in load_other_segments().

If other architectures need this, it'd probably make sense to clean that
up treewide in one go. It looks like at least riscv and s390 need that
from a quick grep:

| [mark@lakrids:~/src/linux]% git grep -w 'struct kexec_buf .*;'
| arch/arm64/kernel/kexec_image.c:        struct kexec_buf kbuf;
| arch/arm64/kernel/machine_kexec_file.c: struct kexec_buf kbuf;
| arch/powerpc/include/asm/kexec.h:int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
| arch/powerpc/include/asm/kexec.h:                                 struct kexec_buf *kbuf);
| arch/riscv/kernel/elf_kexec.c:  struct kexec_buf kbuf;
| arch/riscv/kernel/elf_kexec.c:  struct kexec_buf kbuf;
| arch/riscv/kernel/elf_kexec.c:  struct kexec_buf kbuf;
| arch/s390/kernel/kexec_elf.c:   struct kexec_buf buf;
| arch/s390/kernel/kexec_image.c: struct kexec_buf buf;
| arch/s390/kernel/machine_kexec_file.c:  struct kexec_buf buf;
| arch/s390/kernel/machine_kexec_file.c:  struct kexec_buf buf;
| arch/s390/kernel/machine_kexec_file.c:  struct kexec_buf buf;
| include/linux/kexec.h:int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
| include/linux/kexec.h:extern int kexec_add_buffer(struct kexec_buf *kbuf);
| include/linux/kexec.h:int kexec_locate_mem_hole(struct kexec_buf *kbuf);
| kernel/kexec_file.c:    struct kexec_buf *kbuf = (struct kexec_buf *)arg;

Mark.

> 
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index 532d72ea42ee8..b70f4df15a1ae 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -41,7 +41,7 @@ static void *image_load(struct kimage *image,
>  	struct arm64_image_header *h;
>  	u64 flags, value;
>  	bool be_image, be_kernel;
> -	struct kexec_buf kbuf;
> +	struct kexec_buf kbuf = {};
>  	unsigned long text_offset, kernel_segment_number;
>  	struct kexec_segment *kernel_segment;
>  	int ret;
> 
> ---
> base-commit: 7a77c6b5ce68a71b9102760a988a4564ff6d4106
> change-id: 20250826-akpm-18a57e3a39fd
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 
> 

