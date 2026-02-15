Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86C3EF586B
	for <kexec@archiver.kernel.org>; Sun, 15 Feb 2026 06:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2l7h6AZgsCQNAFoeKxysvqrlTHtQeTpw/FXQJGzkYTE=; b=yMT9CShIAzF3P9lIvdBviCmSme
	SDS59nEOnO8R1vA3R/KKZ6zr/cC/YmWGX06YHvLQ/FBO6jmu2D7i/aDMQ2rPdH7GTj0SnH+7+tguE
	LBolcSNfYY5fbOQvHxNsxuL1WZlqqo6XJDUTIXqVFvgQ56gMvmY7RCHrfALxc6HS7t78u5J834Bjb
	FcFkRujm9pppkOPWTIcBUgjy+dpZHsD4giMb/tFGuMuULVD1KUcMwdFirMWjbZR7srVRIs6zQSsvA
	bWLe9ol/YJZs+SeOsvENENQklumS8WHKfvEj6V/u+iNYmwtjVH/MuRtx2PHyMJhunRJvbdmr2OdjC
	EfoDBIGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrVup-00000005DZT-1gdo;
	Sun, 15 Feb 2026 06:47:35 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrVuk-00000005DYx-0QXJ
	for kexec@lists.infradead.org;
	Sun, 15 Feb 2026 06:47:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DB86D6001D;
	Sun, 15 Feb 2026 06:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93C7C4CEF7;
	Sun, 15 Feb 2026 06:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771138048;
	bh=Li2C5wEg3QVoAnSKgUm9f8v7M+2VmXqH7O8tRmrVvtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pd5ZgntW4T22oD9B6EVv91jD12lpMZXLWz+cL8hG1AwF19lPGgfkoXUoXbhlDIU27
	 tAPOQpRHxN715E4CEr8c9gxYCJJ7FkcPZtB5byjVGSvmnBoO2hLDU97+48+eXWr/UF
	 bdZ9KeBJxHaZ1GaOyMjUiM/qoOCuyu6cGjNdr+pvajgoJhIrXQknnRbsxpP+RAmvXi
	 9ewgdGFvs/CKyDlHXHAWVR83pRwObf3SwpvOU8074MeIWxyKdC+OdvsXMDe6zEV+O8
	 /0Xa+/cYWEsn8ihgTIVOR6/3RAMWVkEcUAqgbUhi6rpEym0K5O+vXmYu9EFOAWoOE/
	 piw17Eq1Vwg7Q==
Date: Sun, 15 Feb 2026 08:47:21 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com
Subject: Re: [PATCH] kho: validate order in deserialize_bitmap()
Message-ID: <aZFr-TvaWn-KbA1u@kernel.org>
References: <20260214010013.3027519-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214010013.3027519-1-elver@google.com>
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

Hi Marco,

On Sat, Feb 14, 2026 at 01:57:51AM +0100, Marco Elver wrote:
> The function deserialize_bitmap() calculates the reservation size using:
> 
>     int sz = 1 << (order + PAGE_SHIFT);
> 
> If a corrupted KHO image provides an order >= 20 (on systems with 4KB
> pages), the shift amount becomes >= 32, which overflows the 32-bit
> integer. This results in a zero-size memory reservation.
> 
> Furthermore, the physical address calculation:
> 
>     phys_addr_t phys = elm->phys_start + (bit << (order + PAGE_SHIFT));
> 
> can also overflow and wrap around if the order is large. This allows a
> corrupt KHO image to cause out-of-bounds updates to page->private of
> arbitrary physical pages during early boot.
> 
> Fix this by adding a bounds check for the order field.
> 
> Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index b851b09a8e99..ec353e4b68a6 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -463,6 +463,11 @@ static void __init deserialize_bitmap(unsigned int order,
>  	struct kho_mem_phys_bits *bitmap = KHOSER_LOAD_PTR(elm->bitmap);
>  	unsigned long bit;
>  
> +	if (order > MAX_PAGE_ORDER) {

Preserved order can be larger than MAX_PAGE_ORDER. 
Let's make 'sz' unsigned long and add checks that calculations won't
overflow.

> +		pr_warn("invalid order %u for preserved bitmap\n", order);
> +		return;
> +	}
> +
>  	for_each_set_bit(bit, bitmap->preserve, PRESERVE_BITS) {
>  		int sz = 1 << (order + PAGE_SHIFT);
>  		phys_addr_t phys =
> -- 
> 2.53.0.335.g19a08e0c02-goog

-- 
Sincerely yours,
Mike.

