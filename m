Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB79C5DF7D
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 14:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F32vh1cW82UZDB5HN9KvxKsrYdAwaYCJf4XRNKjoE0k=; b=zucllyKkiNEiZbr9m8Dd4RbA7S
	ElYuqGdTI0G85HJJxXg++bEG135YRav0+oGFBF9NmQ04vzNUI7+CY8t/HgMQUkXkJgAghCKZ2V1me
	yJN+bOp2LNnpMq2G37qqQhkrrg8KPBTDKztpzDiIEIq49AzRvfOJtCpT25qzm9bBqvV7E+7wiraEn
	yVOSDszyzceHMhmpQX4czilR1/XhnAzoKVOGiGz76oCw25XyGMRYN8dGu3nJm4X/vp1/aWExXzkad
	3y3SeVkPSxF/X0XL5BfgxpYZZElSName1jhEp582eSTuUowAWUQI5239fja8ygmEOPNFfK85Oz/x1
	Xhlq+zxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxPqV-0000000DUac-122x;
	Fri, 21 Aug 2026 14:03:47 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxPqU-0000000DUaE-3omF
	for kexec@bombadil.infradead.org;
	Fri, 21 Aug 2026 14:03:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F32vh1cW82UZDB5HN9KvxKsrYdAwaYCJf4XRNKjoE0k=; b=qSukYxU6LrMBzobGllFwbFeSe+
	z/T0q81Aj4tBwPrz3qKy5Mt71ynn/ZpKoKtd9eOTfHKK039/wgpc3Rip3jZa8opPAQyg8Ahh7Or76
	fTqd1M2HNkxiro6tg4jDvLlB12M9VLoTf25D3gBPN/INgvujU3lm/VdpudZ6sWh4UzEIE+V0pZb9f
	Oj7SXOtLNHpItClBv1ZkbleDunX4jjSRkzYUm49zW6+R3KOzuuDYG0y5U5gnZdFaGBvHk9EkbSpXx
	E/hKMlprSUHfY19j1q0VTbmbsUPnXVxhU3l15YLqD/RDC0uKuRpCHjz6X+ajGrd7nM6VHyrKwnlPf
	9NOUpZ/A==;
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wxPqP-00000003oip-2UgJ
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 14:03:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F32vh1cW82UZDB5HN9KvxKsrYdAwaYCJf4XRNKjoE0k=; b=v4t1fRjU+hHjijXSBFO1sRJvkK
	oNEaUfynGiwy3mvwySfb6wmBhB535/V1dlFfhVZQH8XmuvHnIUL5t+RcaPLZEoL5wMwqO0PLjpsq8
	O64R4Wy6JTsXXT1plbPyI9oHzfxLd0TJ16c6SQ1cNDojZa69mcnQSzY5G9RKDGp8ndWWVDOFo+s2z
	PiQseMLGdmzrhXrgmU1Ft01i7UR08O/6c5NOyNklVfbEQsBDKyx3Ganv8AHFbOLZvD3LdUrp8QjCM
	cU6q9MJot6cWTCwGZHATXDkxh7/TrZxB+8Z4g0LP2TQKQdCCr5NCiH6p6QjMPvMurGwGnExILcNXJ
	v2j39dYg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wxPpv-00BOEL-2E;
	Fri, 21 Aug 2026 14:03:12 +0000
Date: Fri, 21 Aug 2026 07:03:06 -0700
From: Breno Leitao <leitao@debian.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rmikey@meta.com, riel@surriel.com, kexec@lists.infradead.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 6/6] efi: respect the poisoned pages coming from
 previous kernel
Message-ID: <aohIF6MmjiQpbz5j@gmail.com>
References: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
 <20260821-hwpoison-kho-v2-6-5743791e48e6@debian.org>
 <aog_uH5fTsJzXjjx@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aog_uH5fTsJzXjjx@thinkstation>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_150343_108950_86B3C4C0 
X-CRM114-Status: GOOD (  14.34  )
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

On Fri, Aug 21, 2026 at 01:13:55PM +0100, Kiryl Shutsemau wrote:
> On Fri, Aug 21, 2026 at 03:06:06AM -0700, Breno Leitao wrote:
> > +	/* Reserve the table itself so it survives a further kexec. */
> > +	memblock_reserve(PAGE_ALIGN_DOWN(ppm),
> > +			 PAGE_ALIGN(ppm + sizeof(*pm) + bitmap_size) -
> > +			 PAGE_ALIGN_DOWN(ppm));
> 
> Hm. I don't think it is enough.
> 
> On x86, kernel doesn't keep memblock around after boot (see
> CONFIG_ARCH_KEEP_MEMBLOCK). Reserving in memblock exclude the memory
> from page allocator. But kexec can place the image there.

You mean the third kexec?

1) Kernel A hits an ECC error and marks page X poisoned.
2) Kernel A kexecs into kernel B, which won't use that page since
   it's in EFI_POISONED_PAGE and memblock-reserved.
3) Kernel B kexecs into kernel C, which doesn't respect
   EFI_POISONED_PAGE.

Is this the scenario you mean?

If so, the config table, once installed, persists forever, right?

So kernel C will see the poisoned pages, but could still step into
one during the kexec itself?

> For !CONFIG_ARCH_KEEP_MEMBLOCK, kexec uses walk_system_ram_res() that
> looks into iomem_resource. And memblock does nothing to exclude the
> memory from iomem_resource.

Maybe we need something similar to "efi: mm/memory-failure: keep
hardware-poisoned pages out of the next kexec"[1], but checking
EFI_POISONED_PAGE instead?

Link: https://lore.kernel.org/all/20260812-kexec_posioned-v6-0-e477887086f0@debian.org/ [1]

Thanks for the review,
--breno

