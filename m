Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D9CCD98CF
	for <kexec@archiver.kernel.org>; Thu, 11 Jun 2026 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vilZoDQISoe1jlePuvDDEKBItD7TBlXWXWHI2v7ALUU=; b=DSlprMM0ec422S80EzKHlprE+/
	TjSWF1dZ9EoNV1J88TwtAGNMH8wyT72BNuPiY9lroEiWa+qHQv13v3eXGGEXDBzL6zFZVDblX8xJB
	iV+SVVNWymKpn5WUFHmBB9Agw0Rc2MEXOiBRHQ5dnqwQMgrQb1ZXFKmo6cAwHcIqe2Pq/98zu1joA
	penZ1u0JtlobD4BnP+NJmawrknGcb79Ki4f0rnOY290j2M3MFLTgcCr8x3q5VjDO9bSHziTYo2Ya6
	3YMelC5j8EZAeKRiDMjiGBCUdMH9XouJIRBqj2r02kVKIGWw8AqGXOEbZQoIczmac/TzUVbnObxxp
	R/KaLZZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXgOy-00000009aWi-0r5t;
	Thu, 11 Jun 2026 14:29:00 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXgOx-00000009aWa-0M49
	for kexec@lists.infradead.org;
	Thu, 11 Jun 2026 14:28:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2C8DB600AA;
	Thu, 11 Jun 2026 14:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754091F00893;
	Thu, 11 Jun 2026 14:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781188137;
	bh=vilZoDQISoe1jlePuvDDEKBItD7TBlXWXWHI2v7ALUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IisiybxOoGQs9Wo+hB/KOZUyBLt+NgYjVM4mvhXQBQC17BlI3E/2ywsHXeARxYD+I
	 HWseCM+NPPqlBpteLd+pE9e7Ak2d62iN48+RojGh3QpXhwSQKUPhcqezEgseYge7XX
	 qeoDRsE/9l0+RR+v2C+nekuULwqCcaegZ8eY6+pGTgjUnpl9bQmK/1Ww9qWmwmfVVq
	 ucfNUNGAzSxoxg61LYDYvnFBlylzrwx/zPNBbaS7lzxz1ojen3wJw+jZvJndhAB8ol
	 iDWjS5h3d56vh6cgBswDE7dfXZ2aBkH7eqhtXiQXZx3JS/2niwrFYf+9+8uJ8NCLdT
	 aQ3EUajXXtwZg==
Date: Thu, 11 Jun 2026 17:28:50 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Tarun Sahu <tarunsahu@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/memfd_luo: validate serialized_data before conversion
Message-ID: <airGIioUmTtU9326@kernel.org>
References: <c2478f79207b10a13282d917c961261d17b86a15.1781173768.git.tarunsahu@google.com>
 <aiqso7rkpX6oMer7@kernel.org>
 <2vxzmrx1qjuf.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzmrx1qjuf.fsf@kernel.org>
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

On Thu, Jun 11, 2026 at 03:37:12PM +0200, Pratyush Yadav wrote:
> On Thu, Jun 11 2026, Mike Rapoport wrote:
> 
> > On Thu, Jun 11, 2026 at 10:30:03AM +0000, Tarun Sahu wrote:
> >> In memfd_luo_finish() and memfd_luo_retrieve(), phys_to_virt() was called
> >> on args->serialized_data before checking if the physical address is valid.
> >> Since physical address 0 does not map to virtual NULL (due to direct
> >> mapping offsets), the subsequent check 'if (!ser)' was ineffective at
> >> catching a missing serialized_data, leading to unsafe dereferences later.
> >> 
> >> Validate that args->serialized_data is non-zero before calling
> >> phys_to_virt().
> >> 
> >> Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
> >> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> >> ---
> >>  mm/memfd_luo.c | 10 ++++++----
> >>  1 file changed, 6 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> >> index 59de210bee5f..10f3983b0060 100644
> >> --- a/mm/memfd_luo.c
> >> +++ b/mm/memfd_luo.c
> >> @@ -397,10 +397,11 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
> >>  	if (args->retrieve_status)
> >>  		return;
> >>  
> >> -	ser = phys_to_virt(args->serialized_data);
> >> -	if (!ser)
> >> +	if (!args->serialized_data)
> >
> > We really should make args->serialized_data a KHOSER_PTR
> 
> Hmm, that would also be a good idea. I suppose then it would be a better
> to directly convert to using KHOSER_PTR() instead of this patch?

Makes sense.
 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

