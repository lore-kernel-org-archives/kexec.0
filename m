Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D5BC5DF94
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 16:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ujreQuq/VbmIvSks87pTDL9ws/ca+3fQw+q8D7dPgig=; b=x1dWvQOmbf0g5AILA3oxrwX8ZO
	TAawagXZ8AylLd1BUopCE0NaSW7FdlWv0gEhHZlsW4dPjbHAts8m2+YGPSLXYmL1inT3FMDLRu7Rf
	g4XApVV061m9cxHzjUvc+8L1er1opjH0heiCQ+eQJGb05YIr/80KlUGid8Ad9zUpkmMcFRQ4CHU9M
	Hz/c4uXLHj4JY0nNzCxUl7x5GJq2s1dHEPjua3+C/L15fDeqKP4CRQRlLjO1wXYWKRkb0/Kkk27g/
	jl6PT2oBubVMJ5GqkXK80Yc2KnHnDuziK50VaTOzVZGq9Y4Co8EGTMWs0LCz40/uz2EuXfBAnhq/s
	KVlmqrHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxSLf-0000000DqNB-14AK;
	Fri, 21 Aug 2026 16:44:07 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxSLc-0000000DqMg-1dbj
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 16:44:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=ujreQuq/VbmIvSks87pTDL9ws/ca+3fQw+q8D7dPgig=; b=P/gO3+OXjKhdklMG70E4d9i1Pv
	CTtOyI7PTR1PUPuVw5nC9U8ZjLepIYCzm58FlRYPQE9FCZOapdf7XZ7JFcU4z/+/nzKPP0geDGkbA
	vkbBZayX61CN3UmI7yXulNL7qsEmI/lbaPowvDacKmuCYmQM+tQBme1JhhlOmpkcHInMUiDw6cuq3
	gEDuvuNXW9ZS+qluH8M8vSYdyab8wzGX5wpNR7ZsrFyTLtnXLrLggMTPZMxR1Gme4QQYwBtYQX//5
	Ar6oAAK9X34bZCPBrnt3mY/YnES6I92rb4yIJxHbQJSoidhzxWQ1tbrOXyWPeBdNKWPyDzfSREq+y
	yaBnCfpQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wxSLG-00BTcG-28;
	Fri, 21 Aug 2026 16:43:43 +0000
Date: Fri, 21 Aug 2026 09:43:37 -0700
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
Message-ID: <aoh-3XJw82O8SmsA@gmail.com>
References: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
 <20260821-hwpoison-kho-v2-6-5743791e48e6@debian.org>
 <aog_uH5fTsJzXjjx@thinkstation>
 <aohIF6MmjiQpbz5j@gmail.com>
 <aohldTtzE2GJ76md@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aohldTtzE2GJ76md@thinkstation>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_094404_431124_5387C758 
X-CRM114-Status: GOOD (  17.49  )
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

On Fri, Aug 21, 2026 at 03:53:32PM +0100, Kiryl Shutsemau wrote:
> On Fri, Aug 21, 2026 at 07:03:06AM -0700, Breno Leitao wrote:
> > On Fri, Aug 21, 2026 at 01:13:55PM +0100, Kiryl Shutsemau wrote:
> > > On Fri, Aug 21, 2026 at 03:06:06AM -0700, Breno Leitao wrote:
> > > > +	/* Reserve the table itself so it survives a further kexec. */
> > > > +	memblock_reserve(PAGE_ALIGN_DOWN(ppm),
> > > > +			 PAGE_ALIGN(ppm + sizeof(*pm) + bitmap_size) -
> > > > +			 PAGE_ALIGN_DOWN(ppm));
> > > 
> > > Hm. I don't think it is enough.
> > > 
> > > On x86, kernel doesn't keep memblock around after boot (see
> > > CONFIG_ARCH_KEEP_MEMBLOCK). Reserving in memblock exclude the memory
> > > from page allocator. But kexec can place the image there.
> > 
> > You mean the third kexec?
> > 
> > 1) Kernel A hits an ECC error and marks page X poisoned.
> > 2) Kernel A kexecs into kernel B, which won't use that page since
> >    it's in EFI_POISONED_PAGE and memblock-reserved.
> > 3) Kernel B kexecs into kernel C, which doesn't respect
> >    EFI_POISONED_PAGE.
> > 
> > Is this the scenario you mean?
> 
> No. I think nothing prevents kernel B from putting kernel C image into
> the reserved space in !CONFIG_ARCH_KEEP_MEMBLOCK case.
> 
> Kernel B excludes poisoned memory from buddy allocator, but kexec
> doesn't care about this when look for placement for the next image.

Right, that is exactly the case I meant above — sorry for not being
clearer.

Agreed, this is a gap.

Can we keep it separate for now and address it as a follow-up? Similar
to the one covered the initial issue [1] first.

Link: https://lore.kernel.org/all/20260812-kexec_posioned-v6-0-e477887086f0@debian.org/ [1]

