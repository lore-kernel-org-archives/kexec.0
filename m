Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D1F60A5BD0
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QPlqJPrq;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHn0uj+s
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fX75Z40RlddIrDkoWsoAk3U6fOiHoJGDsJ5/Aw5b1AE=; b=QPlqJPrqxNdWr6Oo8Ug+Lit+2f
	x3H2gVU+AVzwaGzwxg/s9wyyoz0jMY03Akesx19P/ewkyOJHLg+RROeyRy+8bw1eNnTpQR8wgXQHa
	O2DDjKNZ3KuYLKuoVd4/idn6RFB2+4zZAh+t9MrUHAcJJdPkFaS3ummasinBI5sdkuJYBvVUticsf
	oljDYRkrfYTg+hR6CXTDRo2xXuoWUsIT0+z2Y3TOcj2PYxtCIdz1Q86pEcQj1NCbGfR8JHG/gW++A
	pgzzFskqR1SwXbZ0TuP7kHW/tm6fy3KMIaq1yTMSkwDiO2arv9THEbMTI9UeJUb3w1oNYmidyf8UA
	+xBLqDvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQp7m-00000004bkO-2A15;
	Tue, 10 Nov 2026 16:55:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQp7k-00000004bk0-3Tv8
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 16:55:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 75F5247298;
	Tue, 10 Nov 2026 16:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEFF1F008A1;
	Tue, 10 Nov 2026 16:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329708;
	bh=fX75Z40RlddIrDkoWsoAk3U6fOiHoJGDsJ5/Aw5b1AE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=UHn0uj+sFtGKGaLst/9muipxKqjAxKUpZ+JoQnL+duqe8G78dsi/abK5ag6CP9hJm
	 OP5wzOYOlDurhfr842HXp3hCAWB8YDNogKdbp/kzN6pDU7wNgpzn5749pSO1boCZlt
	 6wKejwWgFp+/su6c8JaDG20/CEgau226J8buSe7UDs9TKi6Sya0uZAbn2NkUxGa0fo
	 Et6Ef7UU2hOmBhoAKI5VBA2QYe5TXWmSOwZBsfBCWaIAh+OEfwpcnPN03mNODB/uDY
	 ZVJy6DuuviuuIuoQaLsxRS67TEQW/x2dI791szWv2aYwJ9hb0qxQUwxo47LjbLxQwd
	 9MBtuukDIdtTw==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chen Pei <cp0613@linux.alibaba.com>,  George
 Guo <guodongtai@kylinos.cn>,  Kexin Liu <liukexin@kylinos.cn>,  Sourabh
 Jain <sourabhjain@linux.ibm.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] kho: skip zero-sized lowmem and global bootmem
 areas
In-Reply-To: <20261104-kho-bootmem-sizing-v2-2-b0d1a834780f@kernel.org> (Mike
	Rapoport's message of "Wed, 04 Nov 2026 18:50:10 +0200")
References: <20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org>
	<20261104-kho-bootmem-sizing-v2-2-b0d1a834780f@kernel.org>
Date: Tue, 10 Nov 2026 17:55:04 +0100
Message-ID: <2vxzy0b0hbiv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04 2026, Mike Rapoport (Microsoft) wrote:

> The lowmem and the global bootmem areas can have zero size, for example
> when none or all of the memory is below ARCH_LOW_ADDRESS_LIMIT, or when
> either of those areas is explicitly set to zero with kho_bootmem=.
>
> For a zero-sized allocation memblock returns an address without reserving
> anything, and that empty area is recorded in kho_bootmem. If there is no
> memory below ARCH_LOW_ADDRESS_LIMIT, allocation of the empty lowmem area
> fails and KHO gets disabled.
>
> Extract a helper that checks for zero size and allocates memory from
> memblock, and use it to skip empty areas the same way as empty per-node
> areas are skipped.
>
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Reported-by: Chen Pei <cp0613@linux.alibaba.com>
> Closes: https://lore.kernel.org/all/20261026131851.9942-1-cp0613@linux.alibaba.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

